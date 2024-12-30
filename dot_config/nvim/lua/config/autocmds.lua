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
