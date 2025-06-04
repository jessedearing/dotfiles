return {
	"olimorris/codecompanion.nvim",
	lazy = true,
	cmd = {
		"CodeCompanion",
		"CodeCompanionChat",
		"CodeCompanionActions",
		"CodeCompanionCmd",
	},
	opts = {},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("codecompanion").setup({
			extensions = {
				mcphub = {
					callback = "mcphub.extensions.codecompanion",
					opts = {
						show_result_in_chat = true, -- Show mcp tool results in chat
						make_vars = true, -- Convert resources to #variables
						make_slash_commands = true, -- Add prompts as /slash commands
					},
				},
			},
		})
	end,
}
