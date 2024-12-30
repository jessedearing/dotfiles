return {
	"vimwiki/vimwiki",
	keys = {
		{ "<leader>ww", "<cmd>VimwikiIndex<cr>" },
		{ "<leader>w<leader>w", "<cmd>VimwikiMakeDiaryNote<cr>" },
		{ "<leader>w<leader>W", "<cmd>VimwikiDiaryIndex<cr>" },
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
