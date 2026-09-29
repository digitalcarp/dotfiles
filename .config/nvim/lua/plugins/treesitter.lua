local languages = {
  "bash",
  "cmake",
  "cpp",
  "css",
  "csv",
  "ini",
  "javascript",
  "just",
  "json",
  "make",
  "python",
  "rust",
  "systemverilog",
  "tcl",
  "toml",
  "typescript",
  "vhdl",
  "xml",
  "yaml"
}

local function setup_treesitter()
  require("nvim-treesitter").install(languages)

  vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
      local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
      if not lang then
        return
      end

      local max_filesize = 1024 * 1024 -- 1 MB
      local stats = vim.uv.fs_stat(args.file)
      if stats and stats.size > max_filesize then
        return
      end

      if vim.treesitter.query.get(lang, "highlights") then
        vim.treesitter.start()
      end

      if vim.treesitter.query.get(lang, "indents") then
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end

      -- if vim.treesitter.query.get(lang, "folds") then
      --   vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      --   vim.wo[0][0].foldmethod = "expr"
      -- end
    end
  })
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = setup_treesitter
  }
}
