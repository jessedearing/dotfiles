return {
	"yuukiflow/Arduino-Nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		-- Load Arduino plugin for .ino files
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "arduino",
			callback = function()
				require("Arduino-Nvim")
			end,
		})
		require("lspconfig").arduino_language_server.setup({
			cmd = {
				"arduino-language-server",
				"-cli-config",
				"/home/daemon503/.arduino15/arduino-cli.yaml",
				"-fqbn",
				"arduino:avr:nano",
			},
		})
	end,
}
