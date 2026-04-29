return {
	{ "nvim-neotest/neotest-python" },
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/neotest-python",
		},
		opts = {
			adapters = {
				["neotest-python"] = {
					python = ".venv/bin/python",
				},
			},
		},
	},
}
