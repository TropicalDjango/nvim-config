local vim = vim

vim.o.termguicolors = true
vim.o.syntax = 'on'
vim.o.errorbells = false
vim.o.smartcase = true
vim.o.showmode = true
vim.bo.swapfile = false
vim.o.backup = false
vim.o.undodir = vim.fn.stdpath('config') .. '/undodir'
vim.o.undofile = true
vim.o.hidden = true
vim.o.completeopt='menuone,noinsert,noselect'
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes'
vim.wo.wrap = false

vim.opt.ignorecase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 750
vim.opt.colorcolumn = "80"
vim.opt.splitright = true
vim.opt.splitbelow = true

-- for folding
vim.opt.foldmethod = "marker"

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.mapleader = ' '

vim.bo.autoindent = true
vim.bo.smartindent = true

vim.o.cursorline = true
vim.cmd[[ set mouse=c ]]
vim.cmd[[ set mousehide ]]
