return {
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    name = "minisnacks",
    dir = vim.fn.stdpath("config") .. "/minisnacks",
    dev = true,
    lazy = false,
    priority = 1000,
    opts = {
      bigfile = { enabled = true }
    },
    keys = {
      { "<leader>bd", function() Minisnacks.bufdelete() end, desc = "Delete Buffer" }
    }
  }
}
