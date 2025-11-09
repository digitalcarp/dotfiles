return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "VeryLazy" },
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          -- Always need to be installed
          "c",
          "lua",
          "vim",
          "vimdoc",
          "query",
          -- Optional
          "bash",
          "cpp",
          "diff",
          "ini",
          "json",
          "make",
          "markdown",
          "markdown_inline",
          "regex",
          "toml",
          "verilog",
          "xml",
          "yaml"
        },
        sync_install = false,
        auto_install = false, -- Don't have tree-sitter CLI installed locally
        highlight = { enable = true },
        indent = { enable = true }
      })
    end
  }
}
