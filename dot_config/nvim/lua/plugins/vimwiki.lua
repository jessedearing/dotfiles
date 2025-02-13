return {
	"vimwiki/vimwiki",
	desc = "Vimwiki",
	keys = {
		{ "<leader>ww", "<cmd>VimwikiIndex<cr>", desc = "Open vimwiki index" },
		{ "<leader>w<leader>w", "<cmd>VimwikiMakeDiaryNote<cr>", desc = "Open vimwiki diary for today" },
		{ "<leader>w<leader>W", "<cmd>VimwikiDiaryIndex<cr>", desc = "Open vimwiki diary index" },
	},
	init = function()
		local vimwiki_path = os.getenv("HOME") .. "/Documents/pensieve"
		vim.g.vimwiki_list = {
			{
				path = vimwiki_path,
				ext = ".md",
				syntax = "markdown",
			},
		}
	end,
	config = function()
		vim.treesitter.language.register("markdown", "vimwiki")
	end,
}
