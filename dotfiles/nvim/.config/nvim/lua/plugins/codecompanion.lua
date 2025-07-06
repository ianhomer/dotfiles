return {
  "olimorris/codecompanion.nvim",
  opts = {
    opts = {
      -- Can override system prompt if we want
      -- system_prompt = function(opts)
      --   return "Please enter absolute mode. Eliminate emojis, fillers and conversational transitions. No questions, no offers, no suggestions, no transitional phrasing, no explations, no inferred motivational content. Terminate each reply immediately after the information or requested material is delivered — no appendixes, no soft closures."
      -- end,
    },

    adapters = {
      -- Local agent with ollama
      -- Start up with ollama serve before using
      ollama = function()
        return require("codecompanion.adapters").extend("ollama", {
          schema = {
            model = {
              default = "llama3.2:1b",
              -- default = "granite-code:3b",
              -- default = "deepseek-r1:1.5b",
              -- default = "granite-code:3b",
              -- default = "granite-code:8b",
              -- default = "gemma3:1b",
              -- default = "llama3.2:1b",
              -- default = "llama3.2:3b",
            },
          },
          -- system_prompt = function(opts)
          --   return "Please enter absolute mode. Eliminate emojis, fillers and conversational transitions."
          -- end,
        })
      end,
      -- Google gemini
      -- See usage at https://aistudio.google.com/app/u/1/usage
      gemini = function()
        return require("codecompanion.adapters").extend("gemini", {
          env = {
            api_key = "cmd:get-pass ai:google-ai-key",
          },
        })
      end,
    },

    strategies = {
      chat = {
        -- Default to ollama, pick another agent with "ga"
        adapter = "ollama",
      },
      inline = {
        adapter = "ollama",
      },
    },
  },

  keys = {
    { "<leader>cc", "<cmd>CodeCompanionChat<CR>", desc = "Agent Chat" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}
