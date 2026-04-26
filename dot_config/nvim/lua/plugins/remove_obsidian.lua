local function folder_exists(path)
	return vim.loop.fs_stat(vim.fn.expand(path)) ~= nil
end

local workspaces = {}

if folder_exists("~/Documents/Jesse's Vault") then
	table.insert(workspaces, {
		name = "personal",
		path = "~/Documents/Jesse's Vault",
	})
end

if folder_exists("~/Documents/Obsidian Vault") then
	table.insert(workspaces, {
		name = "work",
		path = "~/Documents/Obsidian Vault",
	})
end

return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = false,
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	--   -- refer to `:h file-pattern` for more examples
	--   "BufReadPre path/to/my-vault/*.md",
	--   "BufNewFile path/to/my-vault/*.md",
	-- },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see below for full list of optional dependencies 👇
	},
	opts = {
		workspaces = workspaces,
		-- see below for full list of options 👇
	},
}
