return {
	{
		"ibhagwan/fzf-lua",
		keys = {
			{ "<leader>fF", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
			{ "<leader>ff", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
		},
		opts = {
			files = {
				cmd = 'rg --files --no-ignore --hidden --follow -g "!{.git/**,node_modules/**,vendor/**}" 2> /dev/null',
			},
		},
	},
}
