---@diagnostic disable: undefined-global, unused-local, unused-function, lowercase-global
-- Convert markdown cheats files to navi format
--
-- Test with
--    cat docs/cheats/vim.md | pandoc -t src/pandoc/navi.lua

local stringify = (require "pandoc.utils").stringify

-- The global variable PANDOC_DOCUMENT contains the full AST of
-- the document which is going to be written. It can be used to
-- configure the writer.
local meta = PANDOC_DOCUMENT.meta

-- Chose the image format based on the value of the
-- `image_format` meta value.
local image_format = meta.image_format
  and stringify(meta.image_format)
  or "png"
local image_mime_type = ({
    jpeg = "image/jpeg",
    jpg = "image/jpeg",
    gif = "image/gif",
    png = "image/png",
    svg = "image/svg+xml",
  })[image_format]
  or error("unsupported image format `" .. image_format .. "`")

-- Character escaping
local function escape(s, in_attribute)
  return s:gsub("[<>&\"']",
    function(x)
      if x == '<' then
        return '&lt;'
      elseif x == '>' then
        return '&gt;'
      elseif x == '"' then
        return '&quot;'
      elseif x == "'" then
        return '&#39;'
      else
        return x
      end
    end)
end

-- Helper function to convert an attributes table into
-- a string that can be put into HTML tags.
local function attributes(attr)
  local attr_table = {}
  for x,y in pairs(attr) do
    if y and y ~= "" then
      table.insert(attr_table, ' ' .. x .. '="' .. escape(y,true) .. '"')
    end
  end
  return table.concat(attr_table)
end

-- Blocksep is used to separate block elements.
function Blocksep()
  return "\n\n"
end

local function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

local context = {}

-- This function is called once for the whole document. Parameters:
-- body is a string, metadata is a table, variables is a table.
-- This gives you a fragment.  You could use the metadata table to
-- fill variables in a custom lua template.  Or, pass `--template=...`
-- to pandoc, and pandoc will do the template processing as usual.
function Doc(body, metadata, variables)
  local tags = {'auto'}
  if not metadata['title'] == nil then
    table.insert(tags, metadata['title'])
  end
  context['tags'] = table.concat(tags, ',')
  local buffer = {}
  local function add(s)
    table.insert(buffer, s)
  end
  add(body)

  return '; ' .. dump(metadata) .. '\n' ..
    '; ' .. dump(variables) .. '\n' ..
    '; ' .. dump(context) .. '\n' ..
    table.concat(buffer,'\n') .. '\n'
end

-- The functions that follow render corresponding pandoc elements.
-- s is always a string, attr is always a table of attributes, and
-- items is always an array of strings (the items in a list).
-- Comments indicate the types of other variables.

function Str(s)
  return escape(s)
end

function Space()
  return " "
end

function SoftBreak()
  return ''
end

function LineBreak()
  return ''
end

function Emph(s)
  return s
end

function Strong(s)
  return s
end

function Subscript(s)
  return s
end

function Superscript(s)
  return s
end

function SmallCaps(s)
  return s
end

function Strikeout(s)
  return s
end

function Link(s, src, tit, attr)
  return s
end

function Image(s, src, tit, attr)
  return src
end

function Code(s, attr)
  return s
end

function InlineMath(s)
  return s
end

function DisplayMath(s)
  return s
end

function SingleQuoted(s)
  return s
end

function DoubleQuoted(s)
  return s
end

function Note(s)
  return ''
end

function Span(s, attr)
  return ''
end

function RawInline(format, str)
  return ''
end

function Cite(s, cs)
  return ''
end

function Plain(s)
  return s
end

function Para(s)
  return ''
end

function Header(lev, s, attr)
  return "% " .. s .. "\n"
end

function BlockQuote(s)
  return ''
end

function HorizontalRule()
  return "; ---"
end

function LineBlock(ls)
  return table.concat(ls, '\n')
end

function CodeBlock(s, attr)
  return ''
end

function BulletList(items)
  local buffer = {}
  for _, item in pairs(items) do
    table.insert(buffer, "; - " .. item .. "\n")
  end
  return "\n" .. table.concat(buffer, "\n") .. "\n"
end

function OrderedList(items)
  local buffer = {}
  for _, item in pairs(items) do
    table.insert(buffer, "; * " .. item .. "\n")
  end
  return "\n" .. table.concat(buffer, "\n") .. "\n"
end

function DefinitionList(items)
  local buffer = {}
  for _,item in pairs(items) do
    local k, v = next(item)
    table.insert(buffer, "# " .. table.concat(v, "\n") .. "\n" ..
                   k .. "\n")
  end
  return "\n" .. table.concat(buffer, "\n") .. "\n"
end

-- Convert pandoc alignment to something HTML can use.
-- align is AlignLeft, AlignRight, AlignCenter, or AlignDefault.
function html_align(align)
  if align == 'AlignLeft' then
    return 'left'
  elseif align == 'AlignRight' then
    return 'right'
  elseif align == 'AlignCenter' then
    return 'center'
  else
    return 'left'
  end
end

function CaptionedImage(src, tit, caption, attr)
   return caption
end

function Table(caption, aligns, widths, headers, rows)
  local buffer = {}
  local function add(s)
    table.insert(buffer, s)
  end
  -- Table assumed to have definition in second column
  -- and command in first
  for _, row in pairs(rows) do
    add('# '.. row[2])
    add(row[1])
  end
  return table.concat(buffer,'\n') ..'\n'
end

function RawBlock(format, str)
  return ''
end

function Div(s, attr)
  return ''
end

-- The following code will produce runtime warnings when you haven't defined
-- all of the functions you need for the custom writer, so it's useful
-- to include when you're working on a writer.
local extraMeta = {}
extraMeta.__index =
  function(_, key)
    io.stderr:write(string.format("WARNING: Undefined function '%s'\n",key))
    return function() return "" end
  end
setmetatable(_G, extraMeta)

