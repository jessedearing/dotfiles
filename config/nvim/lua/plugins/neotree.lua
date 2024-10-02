return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		keys = {
			{
				"<leader>fE",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
				end,
				desc = "Explorer NeoTree (Root Dir)",
			},
			{
				"<leader>fe",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
				end,
				desc = "Explorer NeoTree (cwd)",
			},
			{ "<leader>e", "<leader>fe", desc = "Explorer NeoTree (cwd)", remap = true },
			{ "<leader>E", "<leader>fE", desc = "Explorer NeoTree (Root Dir)", remap = true },
		},
	},
}
