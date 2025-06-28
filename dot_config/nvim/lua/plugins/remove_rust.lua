-- Having issues getting codelldb built
return {
	"julianolf/nvim-dap-lldb",
	dependencies = { "mfussenegger/nvim-dap" },
	opts = { codelldb_path = "/path/to/codelldb" },
}
