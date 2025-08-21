# https://github.com/nvim-lua/kickstart.nvim
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.number = true
vim.o.showmode = false

vim.o.breakindent = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 800

vim.o.list = true
vim.opt.listchars = { tab = '> ', nbsp = '.' }
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

if vim.o.background == 'dark' then
	vim.cmd('colorscheme lunaperche')
end

vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.confirm = true

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- TODO: Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

require("config.lazy")

require("config.telescope")

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

require("config.prettier")

require("config.commands")
