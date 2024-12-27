return {
	{
		"echasnovski/mini.nvim",
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
		config = function()
			require("mini.ai").setup()
			require("mini.bracketed").setup({
				window = { suffix = "" },
			})
			require("mini.diff").setup()
			require("mini.files").setup({
				mappings = {
					close = "q",
					go_in = "l",
					go_in_plus = "L",
					go_out = "h",
					go_out_plus = "H",
					reset = "<BS>",
					reveal_cwd = "@",
					show_help = "g?",
					synchronize = "=",
					trim_left = "<",
					trim_right = ">",
				},
			})
			require("mini.icons").setup()

			require("mini.indentscope").setup({
				draw = {
					delay = 100,
					animation = require("mini.indentscope").gen_animation.none(),
					priority = 2,
				},
			})
			require("mini.jump").setup()
			require("mini.jump2d").setup({
				allowed_windows = {
					current = true,
					not_current = false,
				},
			})

			local MiniStatusline = require("mini.statusline")
			MiniStatusline.setup({
				content = {
					active = function()
						local trunc_width = 0
						local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = trunc_width })
						local git = MiniStatusline.section_git({ trunc_width = trunc_width })
						local diff = MiniStatusline.section_diff({ trunc_width = trunc_width })
						local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = trunc_width })
						local lsp = MiniStatusline.section_lsp({ trunc_width = trunc_width })
						local filename = (function(_)
							if vim.bo.buftype == "terminal" then
								return "%t"
							else
								return "%f%m%r"
							end
						end)()

						local location = (function(args)
							if MiniStatusline.is_truncated(args.trunc_width) then
								return "%l/%2v"
							end

							return '%l/%L│%2v/%-2{virtcol("$") - 1}'
						end)({ trunc_width = trunc_width })
						local search = MiniStatusline.section_searchcount({ trunc_width = trunc_width })

						local fileinfo = (function(args)
							local filetype = vim.bo.filetype

							if filetype == "" or vim.bo.buftype ~= "" then
								return ""
							end

							local MiniIcons = require("mini.icons")
							local get_icon = function()
								return MiniIcons.get("filetype", filetype)
							end

							filetype = get_icon() .. " " .. filetype

							if MiniStatusline.is_truncated(args.trunc_width) then
								return filetype
							end

							local encoding = vim.bo.fileencoding or vim.bo.encoding

							return string.format("%s %s", filetype, encoding)
						end)({ trunc_width = trunc_width })

						return MiniStatusline.combine_groups({
							{ hl = mode_hl, strings = { mode } },
							{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
							"%<", -- Mark general truncate point
							{ hl = "MiniStatuslineFilename", strings = { filename } },
							"%=", -- End left alignment
							{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
							{ hl = mode_hl, strings = { search, location } },
						})
					end,
					inactive = nil,
				},
				use_icons = true,
				set_vim_settings = false,
			})
			require("mini.splitjoin").setup()
			-- require("mini.starter").setup()
			require("mini.surround").setup()

			vim.keymap.set("n", "<leader>ft", ":lua MiniFiles.open()<CR>", {
				desc = "File tree",
				silent = true,
			})

			local MiniFiles = require("mini.files")

			local go_in_plus = function()
				for _ = 1, vim.v.count1 do
					MiniFiles.go_in({ close_on_file = true })
				end
			end

			local go_out_with_count = function()
				for _ = 1, vim.v.count1 do
					MiniFiles.go_out()
				end
			end

			local go_out_plus = function()
				go_out_with_count()
				MiniFiles.trim_right()
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				callback = function(args)
					local map_buf = function(lhs, rhs)
						vim.keymap.set("n", lhs, rhs, { buffer = args.data.buf_id })
					end

					map_buf("<Right>", MiniFiles.go_in)
					map_buf("<S-Right>", go_in_plus)
					map_buf("<Left>", MiniFiles.go_out)
					map_buf("<S-Left>", go_out_plus)
					map_buf("w", MiniFiles.synchronize)
					map_buf(",", MiniFiles.trim_left)
					map_buf(".", MiniFiles.trim_right)
				end,
			})
		end,
	},
}
