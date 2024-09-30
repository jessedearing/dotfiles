return {
	{
		"sindrets/diffview.nvim",
		config = function()
			require("config.diffview").setup()
		end,
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
