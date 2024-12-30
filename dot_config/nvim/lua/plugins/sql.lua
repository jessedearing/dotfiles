return {
	"stevearc/conform.nvim",
	opts = function(_, opts)
		opts.formatters.sqlfluff = {
			args = { "format", "--dialect=postgres", "-" },
		}
	end,
}
