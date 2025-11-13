local function noop_cr(opts)
  return ""
end

local function setup_nvim_autopairs()
  local npairs = require("nvim-autopairs")

  local Rule = require("nvim-autopairs.rule")
  local cond = require("nvim-autopairs.conds")

  local opts = {}

  local rules = {
    -- Allow cursor move on <CR> inside pre-existing {}
    Rule("{", "}"):only_cr(),
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
    opts = {
      custom_textobjects = {
        -- Use neovim's built-in mapping for {.
        --
        -- This essentially forces search_method=cover for { which aligns with
        -- the more frequent use case of selecting the current scope under the
        -- cursor. Also, long scopes outside of mini.ai's n_lines search range
        -- won't fail.
        ["{"] = false
      }
    }
  },

  -- Surround
  {
    "nvim-mini/mini.surround",
    event = "VeryLazy",
    opts = {}
  },

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
