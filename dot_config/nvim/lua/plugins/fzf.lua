return {
	{
		"ibhagwan/fzf-lua",
		keys = {
			{ "<leader>fF", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
			{ "<leader>ff", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
		},
		opts = {
			files = {
				fd_opts = [[--color=never --hidden --type f --type l --exclude .git --exclude .jj --exclude node_modules]],
			},
		},
	},
}
