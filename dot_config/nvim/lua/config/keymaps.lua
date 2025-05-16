local map = vim.keymap.set
local unmap = vim.keymap.del

local function goiferr()
	require("go.iferr").run()
end

unmap("n", "<S-h>")
unmap("n", "<S-l>")

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move whole line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move whole line up" })

map("i", "<c-e>", goiferr, { desc = "Use iferr to automatically populate the if err block" })
map("i", "<c-c>", "<esc>")
