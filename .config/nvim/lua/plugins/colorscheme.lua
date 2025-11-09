return {
  {
    name = "gruvbox",
    dir = vim.fn.stdpath("config") .. "/gruvbox",
    dev = true,
    priority = 9001,
    opts = {
      contrast = "",
      bold = true,
      italic = {
        strings = false,
        emphasis = true,
        comments = false,
        operators = false,
        folds = true
      }
    }
  }
}
