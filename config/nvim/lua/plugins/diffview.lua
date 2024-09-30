return {
	{
		"sindrets/diffview.nvim",
		lazy = true,
		keys = {
			{
				"<leader>dv",
				function()
					require("diffview").open({})
				end,
				desc = "Open Diffview",
			},
		},
	},
}
