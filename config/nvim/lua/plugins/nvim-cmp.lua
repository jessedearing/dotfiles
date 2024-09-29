return {
	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			opts.mapping = vim.tbl_extend("force", opts.mapping, {
				["<CR>"] = vim.NIL,
				["<Tab>"] = LazyVim.cmp.confirm({ select = false }),
			})
			opts.completion.completeopt = "menu,menuone,noinsert,noselect"
		end,
	},
}
