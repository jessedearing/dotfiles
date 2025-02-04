local map = vim.keymap.set
local unmap = vim.keymap.del

unmap("n", "<S-h>")
unmap("n", "<S-l>")
unmap("n", "<c-space>")

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move whole line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move whole line up" })
