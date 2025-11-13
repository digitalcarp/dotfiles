local opts = {
  ensure_installed = {
    -- Always need to be installed as required by nvim-treesitter
    "c",
    "lua",
    "markdown",
    "markdown_inline",
    "vim",
    "vimdoc",
    "query",
    -- Custom required
    "bash",
    "cmake",
    "comment",
    "cpp",
    "css",
    "csv",
    "diff",
    "html",
    "ini",
    "javascript",
    "json",
    "just",
    "make",
    "python",
    "regex",
    "toml",
    "xml",
    "yaml",

    -- Optional (uncomment as needed)

    -- "latex",
    -- "perl",
    -- "rst",
    -- "rust",
    -- "sql",
    -- "typescript",
    -- "verilog",
    -- "vhdl",
    -- "tcl",
  },
  sync_install = false,
  auto_install = false, -- Don't have tree-sitter CLI installed locally
  highlight = {
    enable = true,
    -- Disable slow treesitter highlight for large files
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      else
        return false
      end
    end
  },
  indent = { enable = true },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- Useful for uncommenting a block comment in comment.nvim 
        ["oc"] = "@comment.outer",

        ["of"] = "@function.outer",
        ["uf"] = "@function.inner"
      }
    }
  }
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "master"
    },
    -- Official docs say they don't support lazy loading, but it seems to work
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup(opts)
    end
  }
}
