local function setup_fzf_lua()
  local fzf_lua = require("fzf-lua")
  local actions = fzf_lua.actions

  opts = {
    -- Taken from fzf-vim in fzf-lua profiles
    fzf_opts = {
      -- nullify fzf-lua's settings to inherit from FZF_DEFAULT_OPTS
      ["--info"] = false,
      ["--layout"] = false
    },
    keymap = {
      builtin = {
        true,
        -- nvim registers <C-/> as <C-_>, use insert mode
        -- and press <C-v><C-/> should output ^_
        ["<C-_>"] = "toggle-preview"
      },
      fzf = {
        true,
        ["ctrl-/"] = "toggle-preview"
      }
    },
    actions = {
      files = {
        ["enter"] = actions.file_edit,
        ["ctrl-x"] = actions.file_split,
        ["ctrl-v"] = actions.file_vsplit,
        ["ctrl-t"] = actions.file_tabedit,
        ["alt-q"] = actions.file_sel_to_qf,
        ["alt-l"] = actions.file_sel_to_ll
      }
    },
    files = {
      cmd = os.getenv("FZF_DEFAULT_COMMAND"),
      cwd_prompt = true,
      cwd_prompt_shorten_len = 1
    },
    grep = {
      git_icons = false,
      exec_empty_query = true
    }
  }

  fzf_lua.setup(opts)
end

return {
  {
    "ibhagwan/fzf-lua",
    cmd = { "FzfLua" },
    keys = {
      { "<leader>p", "<cmd>FzfLua files<CR>", desc = "Find file", silent = true },
      { "<leader>m", "<cmd>FzfLua oldfiles<CR>", desc = "Find history", silent = true },
      { "<leader>b", "<cmd>FzfLua buffers<CR>", desc = "Find buffer", silent = true }
    },
    config = setup_fzf_lua
  },
  -- File system manipulation
  {
    'stevearc/oil.nvim',
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}
  }
}
