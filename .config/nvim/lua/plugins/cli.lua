return {
  {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    keys = {
      { "<leader>p", "<cmd>FzfLua files<CR>", desc = "Find file", silent = true },
      { "<leader>m", "<cmd>FzfLua oldfiles<CR>", desc = "Find history", silent = true },
      { "<leader>b", "<cmd>FzfLua buffers<CR>", desc = "Find buffer", silent = true }
    }
  }
}
