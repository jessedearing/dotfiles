return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters = {
				sqlformatter = {
					command = "sql-formatter",
					args = { "-l", "postgresql" },
				},
			},
			formatters_by_ft = {
				sql = { "sqlformatter" },
			},
		},
	},
}
