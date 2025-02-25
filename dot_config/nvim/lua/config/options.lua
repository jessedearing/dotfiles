-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
vim.g.mapleader = ","
vim.g.snips_author = "Jesse Dearing"
opt.ruler = true
opt.mouse = "a"
opt.colorcolumn = "80"
if vim.env.SSH_TTY then
	local function paste()
		return vim.split(vim.fn.getreg(""), "\n")
	end
	vim.g.clipboard = {
		name = "OSC 52",
		copy = {
			["+"] = require("vim.ui.clipboard.osc52").copy("+"),
			["*"] = require("vim.ui.clipboard.osc52").copy("*"),
		},
		paste = {
			["+"] = paste,
			["*"] = paste,
		},
	}
end

vim.g.lazyvim_python_lsp = "basedpyright"
