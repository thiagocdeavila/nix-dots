-- Seta <Space> como leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.number = true
vim.o.relativenumber = true

-- ativa o modo de mouse
vim.o.mouse = "a"

-- não mostra o modo
vim.o.showmode = false

-- clipboard
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

vim.o.signcolumn = "yes"

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.cursorline = true

-- ativa arquivo de histórico
vim.o.undofile = true

-- Número mínimo de linhas acima e abaixo do cursor
vim.o.scrolloff = 10

-- Usa dois espaços como indentação
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.autoindent = true
vim.o.breakindent = true
vim.o.smartindent = true
