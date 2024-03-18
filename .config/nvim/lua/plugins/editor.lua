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
    lazy = false,
    init = function()
      require("Comment").setup()
    end,
    opts = {
      mappings = { extra = false }
    }
  },

  -- Undo Enhancement
  {
    "mbbill/undotree",
    event = "VeryLazy",
    keys = {
      { "<F5>", "<cmd>UndotreeToggle<CR>", desc = "Undo Tree" },
    }
  }
}
