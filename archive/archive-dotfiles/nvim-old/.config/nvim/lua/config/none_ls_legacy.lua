-- To navigate through https://github.com/nvimtools/none-ls.nvim/issues/58
-- expecting to remove this once that transition has settled.

local h = require("null-ls.helpers")
local methods = require("null-ls.methods")
local cmd_resolver = require("null-ls.helpers.command_resolver")
local u = require("null-ls.utils")

local FORMATTING = methods.internal.FORMATTING
local DIAGNOSTICS = methods.internal.DIAGNOSTICS
local CODE_ACTION = methods.internal.CODE_ACTION
local api = vim.api

local custom_end_col = {
  end_col = function(entries, line)
    if not line then
      return
    end

    local start_col = entries["col"]
    local message = entries["message"]
    local code = entries["code"]

    -- highlights only first character on error line, if not specified otherwise
    local default_position = start_col + 1

    local pattern = nil
    local trimmed_line = line:sub(start_col, -1)

    if code == "F841" or code == "F823" then
      pattern = [[local variable %'(.*)%']]
    elseif code == "F821" or code == "F822" then
      pattern = [[undefined name %'(.*)%']]
    elseif code == "F831" then
      pattern = [[duplicate argument %'(.*)%']]
    elseif code == "F401" then
      pattern = [[%'(.*)%' imported]]
    end

    if not pattern then
      return default_position
    end

    local results = message:match(pattern)
    local _, end_col = trimmed_line:find(results, 1, true)

    if not end_col then
      return default_position
    end

    end_col = end_col + start_col
    if end_col > tonumber(start_col) then
      return end_col
    end

    return default_position
  end,
}

local handle_eslint_output = function(params)
  params.messages = params.output and params.output[1] and params.output[1].messages or {}
  if params.err then
    table.insert(params.messages, { message = params.err })
  end

  local parser = h.diagnostics.from_json({
    attributes = {
      _fix = "fix",
      severity = "severity",
    },
    severities = {
      h.diagnostics.severities["warning"],
      h.diagnostics.severities["error"],
    },
    adapters = {
      {
        user_data = function(entries)
          return { fixable = not not entries._fix }
        end,
      },
    },
  })

  return parser({ output = params.messages })
end

local diagnostics_eslint = h.make_builtin({
  name = "eslint",
  meta = {
    url = "https://github.com/eslint/eslint",
    description = "A linter for the JavaScript ecosystem.",
  },
  method = DIAGNOSTICS,
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
  generator_opts = {
    command = "eslint",
    args = { "-f", "json", "--stdin", "--stdin-filename", "$FILENAME" },
    to_stdin = true,
    format = "json_raw",
    check_exit_code = function(code)
      return code <= 1
    end,
    use_cache = true,
    on_output = handle_eslint_output,
    dynamic_command = cmd_resolver.from_node_modules(),
    cwd = h.cache.by_bufnr(function(params)
      return u.cosmiconfig("eslint", "eslintConfig")(params.bufname)
    end),
  },
  factory = h.generator_factory,
})

local get_offset_positions = function(content, start_offset, end_offset)
  -- ESLint uses character offsets, so convert to byte indexes to handle multibyte characters
  local to_string = table.concat(content, "\n")
  start_offset = vim.str_byteindex(to_string, start_offset + 1)
  end_offset = vim.str_byteindex(to_string, end_offset + 1)

  -- NOTE: These functions return 1-indexed lines
  local row = vim.fn.byte2line(start_offset)
  local end_row = vim.fn.byte2line(end_offset)

  local col = start_offset - vim.fn.line2byte(row)
  local end_col = end_offset - vim.fn.line2byte(end_row)
  return col + 1, row, end_col + 1, end_row
end

local is_fixable = function(problem, row)
  if not problem or not problem.line then
    return false
  end

  if problem.endLine then
    return problem.line <= row and problem.endLine >= row
  end

  if problem.fix then
    return problem.line - 1 == row
  end

  return false
end

local get_message_range = function(problem)
  -- 1-indexed
  local row = problem.line or 1
  local col = problem.column or 1
  local end_row = problem.endLine or 1
  local end_col = problem.endColumn or 1

  return { row = row, col = col, end_row = end_row, end_col = end_col }
end

local get_fix_range = function(problem, params)
  local offset = problem.fix.range[1]
  local end_offset = problem.fix.range[2]
  local col, row, end_col, end_row = get_offset_positions(params.content, offset, end_offset)

  return { row = row, col = col, end_row = end_row, end_col = end_col }
end

local generate_edit_action = function(title, new_text, range, params)
  return {
    title = title,
    action = function()
      -- 0-indexed
      api.nvim_buf_set_text(
        params.bufnr,
        range.row - 1,
        range.col - 1,
        range.end_row - 1,
        range.end_col - 1,
        vim.split(new_text, "\n")
      )
    end,
  }
end

local generate_edit_line_action = function(title, new_text, row, params)
  return {
    title = title,
    action = function()
      -- 0-indexed
      api.nvim_buf_set_lines(params.bufnr, row - 1, row - 1, false, { new_text })
    end,
  }
end

local generate_suggestion_action = function(suggestion, message, params)
  local title = suggestion.desc
  local new_text = suggestion.fix.text
  local range = get_message_range(message)

  return generate_edit_action(title, new_text, range, params)
end

local generate_fix_action = function(message, params)
  local title = "Apply suggested fix for ESLint rule " .. message.ruleId
  local new_text = message.fix.text
  local range = get_fix_range(message, params)

  return generate_edit_action(title, new_text, range, params)
end

local generate_disable_actions = function(message, indentation, params)
  local rule_id = message.ruleId

  local actions = {}
  local line_title = "Disable ESLint rule " .. rule_id .. " for this line"
  local line_new_text = indentation .. "// eslint-disable-next-line " .. rule_id
  table.insert(actions, generate_edit_line_action(line_title, line_new_text, message.line, params))

  local file_title = "Disable ESLint rule " .. rule_id .. " for the entire file"
  local file_new_text = "/* eslint-disable " .. rule_id .. " */"
  table.insert(actions, generate_edit_line_action(file_title, file_new_text, 1, params))

  return actions
end

local code_action_handler = function(params)
  local row = params.row
  local indentation = params.content[row]:match("^%s+") or ""

  local rules, actions = {}, {}
  for _, message in ipairs(params.messages) do
    if is_fixable(message, row) then
      if message.suggestions then
        for _, suggestion in ipairs(message.suggestions) do
          table.insert(actions, generate_suggestion_action(suggestion, message, params))
        end
      end

      if message.fix then
        table.insert(actions, generate_fix_action(message, params))
      end

      if message.ruleId and not rules[message.ruleId] then
        rules[message.ruleId] = true
        vim.list_extend(actions, generate_disable_actions(message, indentation, params))
      end
    end
  end

  return actions
end

local code_actions_eslint = h.make_builtin({
  name = "eslint",
  meta = {
    url = "https://github.com/eslint/eslint",
    description = "Injects actions to fix ESLint issues or ignore broken rules.",
  },
  method = CODE_ACTION,
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
  generator_opts = {
    command = "eslint",
    format = "json_raw",
    args = { "-f", "json", "--stdin", "--stdin-filename", "$FILENAME" },
    to_stdin = true,
    check_exit_code = { 0, 1 },
    use_cache = true,
    on_output = function(params)
      local output = params.output

      if not (output and output[1] and output[1].messages) then
        return
      end

      params.messages = output[1].messages
      return code_action_handler(params)
    end,
    dynamic_command = cmd_resolver.from_node_modules(),
    cwd = h.cache.by_bufnr(function(params)
      return u.cosmiconfig("eslint", "eslintConfig")(params.bufname)
    end),
  },
  factory = h.generator_factory,
})

return {
  code_actions = code_actions_eslint.with({
    name = "eslint_d",
    command = "eslint_d",
    meta = {
      url = "https://github.com/mantoni/eslint_d.js",
      description = "Injects actions to fix ESLint issues or ignore broken rules. Like ESLint, but faster.",
      notes = {
        "Once spawned, the server will continue to run in the background. This is normal and not related to null-ls. You can stop it by running `eslint_d stop` from the command line.",
      },
    },
  }),
  formatting = {
    eslint_d = h.make_builtin({
      name = "eslint_d",
      meta = {
        url = "https://github.com/mantoni/eslint_d.js/",
        description = "Like ESLint, but faster.",
        notes = {
          "Once spawned, the server will continue to run in the background. This is normal and not related to null-ls. You can stop it by running `eslint_d stop` from the command line.",
        },
      },
      method = FORMATTING,
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
      },
      generator_opts = {
        command = "eslint_d",
        args = { "--fix-to-stdout", "--stdin", "--stdin-filename", "$FILENAME" },
        to_stdin = true,
      },
      factory = h.formatter_factory,
    }),
    rustfmt = h.make_builtin({
      name = "rustfmt",
      meta = {
        url = "https://github.com/rust-lang/rustfmt",
        description = "A tool for formatting rust code according to style guidelines.",
        notes = {
          "`--edition` defaults to `2015`. To set a different edition, use `extra_args`.",
          "See [the wiki](https://github.com/nvimtools/none-ls.nvim/wiki/Source-specific-Configuration#rustfmt) for other workarounds.",
        },
      },
      method = FORMATTING,
      filetypes = { "rust" },
      generator_opts = {
        command = "rustfmt",
        args = { "--emit=stdout" },
        to_stdin = true,
      },
      factory = h.formatter_factory,
    }),
    trim_whitespace = h.make_builtin({
      name = "trim_whitespace",
      meta = {
        description = "A simple wrapper around `awk` to remove trailing whitespace.",
      },
      method = FORMATTING,
      filetypes = {},
      generator_opts = {
        command = "awk",
        args = { '{ sub(/[ \t]+$/, ""); print }' },
        to_stdin = true,
      },
      factory = h.formatter_factory,
    }),
  },
  diagnostics = {
    eslint_d = diagnostics_eslint.with({
      name = "eslint_d",
      meta = {
        url = "https://github.com/mantoni/eslint_d.js/",
        description = "Like ESLint, but faster.",
        notes = {
          "Once spawned, the server will continue to run in the background. This is normal and not related to null-ls. You can stop it by running `eslint_d stop` from the command line.",
        },
      },
      command = "eslint_d",
    }),
    flake8 = h.make_builtin({
      name = "flake8",
      meta = {
        url = "https://github.com/PyCQA/flake8",
        description = "flake8 is a python tool that glues together pycodestyle, pyflakes, mccabe, and third-party plugins to check the style and quality of Python code.",
      },
      method = DIAGNOSTICS,
      filetypes = { "python" },
      generator_opts = {
        command = "flake8",
        to_stdin = true,
        from_stderr = true,
        args = { "--format", "default", "--stdin-display-name", "$FILENAME", "-" },
        format = "line",
        check_exit_code = function(code)
          return code == 0 or code == 255
        end,
        on_output = h.diagnostics.from_pattern(
          [[:(%d+):(%d+): ((%u)%w+) (.*)]],
          { "row", "col", "code", "severity", "message" },
          {
            adapters = {
              custom_end_col,
            },
            severities = {
              E = h.diagnostics.severities["error"],
              W = h.diagnostics.severities["warning"],
              F = h.diagnostics.severities["information"],
              D = h.diagnostics.severities["information"],
              R = h.diagnostics.severities["warning"],
              S = h.diagnostics.severities["warning"],
              I = h.diagnostics.severities["warning"],
              C = h.diagnostics.severities["warning"],
              B = h.diagnostics.severities["warning"], -- flake8-bugbear
              N = h.diagnostics.severities["information"], -- pep8-naming
            },
          }
        ),
        cwd = h.cache.by_bufnr(function(params)
          return u.root_pattern(
            -- https://flake8.pycqa.org/en/latest/user/configuration.html
            ".flake8",
            "setup.cfg",
            "tox.ini"
          )(params.bufname)
        end),
      },
      factory = h.generator_factory,
    }),
  },
}
