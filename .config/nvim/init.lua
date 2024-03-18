function Map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

local set = vim.opt

-------------
-- General --
-------------
vim.g.mapleader = " "
set.guicursor = ""

set.history = 100
set.updatetime = 50

set.hidden = true

set.ignorecase = true
set.smartcase = true
set.incsearch = true

set.swapfile = false
set.backup = false
set.undodir = vim.fn.expand("$HOME/undodir")
set.undofile = true

--------
-- UI --
--------
set.termguicolors = true

set.ruler = true
set.number = true
set.relativenumber = true

set.signcolumn = "yes:1"
set.colorcolumn = "80"

set.scrolloff = 8

----------
-- Text --
----------
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true

set.linebreak = true
set.wrap = false

-- Either use treesitter indent or this but not both
-- set.smartindent = true

----------------
-- Navigation --
----------------
Map("n", "<C-h>", "<C-W>h")
Map("n", "<C-j>", "<C-W>j")
Map("n", "<C-k>", "<C-W>k")
Map("n", "<C-l>", "<C-W>l")

Map("t", "<C-h>", "<cmd>wincmd h<CR>")
Map("t", "<C-j>", "<cmd>wincmd j<CR>")
Map("t", "<C-k>", "<cmd>wincmd k<CR>")
Map("t", "<C-l>", "<cmd>wincmd l<CR>")

Map("n", "<leader>h", "<cmd>bprevious<CR>")
Map("n", "<leader>l", "<cmd>bnext<CR>")

set.splitbelow = true
set.splitright = true

-- Reopen files at last location
vim.api.nvim_create_autocmd(
  {'BufReadPost'},
  {
    pattern = {'*'},
    callback = function()
      local ft = vim.opt_local.filetype:get()
      -- Ignore git messages
      if (ft:match('commit') or ft:match('rebase')) then
        return
      end
      -- Go to position of last saved edit
      local markpos = vim.api.nvim_buf_get_mark(0,'"')
      local line = markpos[1]
      local col = markpos[2]
      if (line > 1) and (line <= vim.api.nvim_buf_line_count(0)) then
        vim.api.nvim_win_set_cursor(0,{line,col})
      end
    end
  }
)

------------
-- Remaps --
------------

-- Move selection by one line
Map("x", "J", ":m '>+1<CR>gv=gv")
Map("x", "K", ":m -2<CR>gv=gv")

-- Keep cursor in middle
Map("n", "J", "mzJ`z")
Map("n", "<C-d>", "<C-d>zz")
Map("n", "<C-u>", "<C-u>zz")
Map("n", "<PageDown>", "<C-d>zz")
Map("n", "<PageUp>", "<C-u>zz")
Map("n", "n", "nzzzv")
Map("n", "N", "Nzzzv")

-- Yank to system clipboard
Map("n", "<leader>y", "\"+y")
Map("x", "<leader>y", "\"+y")
Map("n", "<leader>Y", "\"+Y")

-- No Ex mode
Map("n", "Q", "<Nop>")

-- Toggle search highlighting
Map("n", "<CR>", "<cmd>nohlsearch<CR>")

-------------
-- Plugins --
-------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
set.rtp:prepend(lazypath)

require("lazy").setup("plugins")

vim.api.nvim_set_hl(0, "@constructor.cpp", { link = "GruvboxGreen" })
vim.api.nvim_set_hl(0, "@function.cpp", { link = "GruvboxGreen" })
vim.api.nvim_set_hl(0, "@function.call.cpp", { link = "GruvboxGreen" })
vim.api.nvim_set_hl(0, "@function.method.call.cpp", { link = "GruvboxGreen" })
vim.api.nvim_set_hl(0, "@function.method.cpp", { link = "GruvboxGreen" })
vim.api.nvim_set_hl(0, "@module.cpp", { link = "GruvboxBlue" })
vim.api.nvim_set_hl(0, "@property.cpp", { link = "GruvboxFg1" })
vim.api.nvim_set_hl(0, "@string.cpp", { link = "GruvboxPurple" })
vim.api.nvim_set_hl(0, "@type.cpp", { link = "GruvboxBlue" })
vim.api.nvim_set_hl(0, "@type.definition.cpp", { link = "GruvboxBlue" })
vim.api.nvim_set_hl(0, "@type.qualifier.cpp", { link = "GruvboxRed" })
vim.api.nvim_set_hl(0, "@variable.member.cpp", { link = "GruvboxFg1" })
vim.api.nvim_set_hl(0, "@variable.parameter.cpp", { link = "GruvboxFg1" })
vim.api.nvim_set_hl(0, "@variable.builtin.cpp", { link = "GruvboxRed" })
