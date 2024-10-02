return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters = {
				sqlformatter = {
					command = "sql-formatter",
				},
			},
			formatters_by_ft = {
				sql = { "sqlformatter" },
			},
		},
	},
}
