vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { os.getenv("HOME") .. "/Documents/pensieve/*.md" },
	callback = function()
		local Job = require("plenary.job")
		local fileName = vim.fn.expand("%:t")
		Job:new({
			command = "git",
			args = { "-C", os.getenv("HOME") .. "/Documents/pensieve", "add", "-A", "." },
			on_exit = function(_, code)
				if code == 0 then
					Job:new({
						command = "git",
						args = {
							"-C",
							os.getenv("HOME") .. "/Documents/pensieve",
							"commit",
							"-q",
							"-m",
							fileName,
						},
						on_exit = function(_, code)
							if code == 0 then
								Job:new({
									command = "git",
									args = { "-C", os.getenv("HOME") .. "/Documents/pensieve", "push" },
								}):start()
							end
						end,
					}):start()
				end
			end,
		}):start()
	end,
})

vim.api.nvim_create_autocmd("BufRead", {
	pattern = { "Tiltfile" },
	callback = function()
		vim.bo.filetype = "starlark"
		vim.lsp.start({
			name = "Tilt",
			cmd = { "tilt", "lsp", "start" },
		})
	end,
})

local prose_filetypes = {
	gitcommit = true,
	jjdescription = true,
	mail = true,
	text = true,
}

local function setup_prose_formatting(buf)
	if not prose_filetypes[vim.bo[buf].filetype] then
		return
	end
	vim.bo[buf].formatexpr = ""
	vim.bo[buf].textwidth = 72
end

local prose_group = vim.api.nvim_create_augroup("prose_formatting", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = prose_group,
	pattern = vim.tbl_keys(prose_filetypes),
	callback = function(args)
		setup_prose_formatting(args.buf)
		vim.opt_local.colorcolumn = "+1"
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = prose_group,
	callback = function(args)
		setup_prose_formatting(args.buf)
	end,
})
