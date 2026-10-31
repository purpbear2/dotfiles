-- Defaults
local set = vim.opt

set.clipboard = "unnamedplus"
set.cursorline = true
set.expandtab = true
set.ignorecase = true
set.mouse = "a"
set.number = true
set.relativenumber = true
set.shiftwidth = 2
set.shortmess = "I"
set.smartcase = true
set.smartindent = true
set.softtabstop = 2
set.splitbelow = true
set.splitright = true
set.tabstop = 2
set.termguicolors = true
set.wrap = false

-- Leader key setup
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Keymaps
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>y", "0vg_y", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>r", "<cmd>setlocal relativenumber!<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>s", "<cmd>setlocal spell!<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>t", "<cmd>NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>w", "<cmd>setlocal wrap!<CR>", { noremap = true, silent = true })

-- Initialize lazy.nvim plugin manager configuration
require("config.lazy")
