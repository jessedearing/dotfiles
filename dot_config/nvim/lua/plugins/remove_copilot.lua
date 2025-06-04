return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	build = ":Copilot auth",
	event = "BufReadPost",
	opts = {
		filetypes = {
			yaml = false,
			vimwiki = false,
		},
	},
}
