return {
	{
		"sindrets/diffview.nvim",
		desc = "Diffview",
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
