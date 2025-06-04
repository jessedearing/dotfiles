return {
	"ravitemer/mcphub.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"ravitemer/mcphub.nvim",
	},
	build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
	opts = {
		config = vim.fn.expand("~/.config/mcphub/servers.json"), -- Absolute path to MCP Servers config file (will create if not exists)
		disabled_tools = {
			"list_files", -- Built-in file operations
			"search_files",
			"read_file",
			"create_file",
			"rename_file",
			"delete_file",
			"create_dir",
			"rename_dir",
			"delete_dir",
			"bash", -- Built-in terminal access
		},
		auto_approve = true,
		extensions = {
			avante = {
				make_slash_commands = true, -- make /slash commands from MCP server prompts
			},
		},
	},
	config = {},
}
