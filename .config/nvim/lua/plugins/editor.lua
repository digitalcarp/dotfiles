local function noop_cr(opts)
  return ""
end

local function setup_nvim_autopairs()
  local npairs = require("nvim-autopairs")

  local Rule = require("nvim-autopairs.rule")
  local cond = require("nvim-autopairs.conds")

  local opts = {}

  local rules = {
    -- Type `{ <CR>` to start a block
    Rule("{ ", "")
      :only_cr(cond.is_end_line())
      :replace_map_cr(function (opts)
        return "<C-g>u<BS><CR>}<C-c>O"
      end),
    -- Type `{;<CR>` to start a block with trailing `;`
    Rule("{;", "")
      :only_cr(cond.is_end_line())
      :replace_map_cr(function (opts)
        return "<C-g>u<BS><CR>};<C-c>O"
      end),
    -- Type `{,<CR>` to start a block with trailing `,`
    Rule("{,", "")
      :only_cr(cond.is_end_line())
      :replace_map_cr(function (opts)
        return "<C-g>u<BS><CR>},<C-c>O"
      end)
  }

  npairs.setup(opts)
  npairs.remove_rule('{')
  npairs.add_rules(rules)
end

return {
  -- Indentation
  { 
    "lukas-reineke/indent-blankline.nvim",
    lazy = false,
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
  {
    "nvim-mini/mini.ai",
    event = "VeryLazy",
    opts = {}
  },

  -- Surround
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
    event = "InsertEnter",
    config = setup_nvim_autopairs
  }
}
