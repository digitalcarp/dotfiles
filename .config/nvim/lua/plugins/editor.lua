return {
  -- Indentation
  { 
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      indent = {
        char = "|",
        tab_char = "|"
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "lazy",
          "lazyterm",
          "trouble"
        }
      }
    },
    main = "ibl"
  },

  -- Commenting
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {
      mappings = { extra = false }
    }
  },

  -- Enhanced textobjects
  { "nvim-mini/mini.ai", event = "VeryLazy" },

  -- Classic tpope plugins
  {
    "tpope/vim-endwise",
    event = "InsertEnter"
  },
  { "tpope/vim-surround", event = "VeryLazy" },

  -- Undo Enhancement
  {
    "mbbill/undotree",
    keys = {
      { "<F5>", "<cmd>UndotreeToggle<CR>", desc = "Undo Tree" }
    }
  },

  -- Automatic parenthesis/brace insertion
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter"
  }
}
