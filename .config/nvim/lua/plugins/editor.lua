local function setup_nvim_autopairs()
  local npairs = require("nvim-autopairs")

  local Rule = require('nvim-autopairs.rule')
  local cond = require('nvim-autopairs.conds')

  local opts = {}

  local rules = {
    -- Type `{};` to start a block with trailing `;`
    Rule("{};", "")
      :end_wise(cond.is_end_line())
      :replace_endpair(function(opts)
        return "<BS><BS><BS><CR>};"
      end),
    -- Type `{},` to start a block with trailing `,`
    Rule("{},", "")
      :end_wise(cond.is_end_line())
      :replace_endpair(function(opts)
        return "<BS><BS><BS><CR>},"
      end),
  }

  npairs.setup(opts)
  npairs.add_rules(rules)
end

return {
  -- Indentation
  { 
    "lukas-reineke/indent-blankline.nvim",
    event = "BufEnter",
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
    event = {"BufRead", "BufWritePost"},
    opts = {
      mappings = { extra = false }
    }
  },

  -- Enhanced textobjects
  {
    "nvim-mini/mini.ai",
    event = "VeryLazy",
    opts = {}
  },

  -- Classic tpope plugins
  {
    "tpope/vim-endwise",
    event = "InsertEnter"
  },
  { "tpope/vim-surround", event = {"BufRead", "BufWritePost"} },

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
    event = "InsertEnter",
    config = setup_nvim_autopairs
  }
}
