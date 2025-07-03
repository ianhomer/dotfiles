return {
  "olimorris/codecompanion.nvim",
  opts = {
    opts = {
      system_prompt = function(opts)
        return "Please enter absolute mode. Eliminate emojis, fillers and conversational transitions. No questions, no offers, no suggestions, no transitional phrasing, no explations, no inferred motivational content. Terminate each reply immediately after the information or requested material is delivered — no appendixes, no soft closures."
      end,
    },

    adapters = {
      ollama = function()
        return require("codecompanion.adapters").extend("ollama", {
          schema = {
            model = {
              default = "llama3.2:1b",
              -- default = "granite-code:3b",
            },
          },
          system_prompt = function(opts)
            return "Please enter absolute mode. Eliminate emojis, fillers and conversational transitions."
          end,
        })
      end,
    },

    strategies = {
      chat = {
        adapter = {
          name = "ollama",
          -- model = "deepseek-r1:1.5b",
          -- model = "granite-code:3b",
          -- model = "granite-code:8b",
          -- model = "gemma3:1b",
          model = "llama3.2:1b",
          -- model = "llama3.2:3b",
          --
          system_prompt = function(opts)
            return "Please enter absolute mode. Eliminate emojis, fillers and conversational transitions."
          end,
        },
      },
      inline = {
        adapter = "ollama",
      },
    },
    -- mappings = {
    --   open_chat = "<leader>cc",
    --   clear_chat = "<leader>cz",
    --   send_selection = "<leader>cs",
    -- },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}
