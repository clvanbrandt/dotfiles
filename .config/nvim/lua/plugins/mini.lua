return {
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.comment").setup()
			require("mini.jump").setup()
			require("mini.indentscope").setup()
			require("mini.surround").setup()
			require("mini.bracketed").setup({
				window = { suffix = "" },
			})
			require("mini.starter").setup()

			-- files
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
			vim.keymap.set("n", "<leader>ft", ":lua MiniFiles.open()<CR>", { desc = "File tree", silent = true })

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
					map_buf("i", MiniFiles.go_in)
					map_buf("<S-Right>", go_in_plus)
					map_buf("I", go_in_plus)
					map_buf("<Left>", MiniFiles.go_out)
					map_buf("m", MiniFiles.go_out)
					map_buf("<S-Left>", go_out_plus)
					map_buf("M", go_out_plus)
					map_buf("w", MiniFiles.synchronize)
					map_buf(",", MiniFiles.trim_left)
					map_buf(".", MiniFiles.trim_right)
				end,
			})

			-- clue
			local miniclue = require("mini.clue")
			miniclue.setup({
				triggers = {
					-- Leader triggers
					{ mode = "n", keys = "<Leader>" },
					{ mode = "x", keys = "<Leader>" },

					-- Built-in completion
					{ mode = "i", keys = "<C-x>" },

					-- `g` key
					{ mode = "n", keys = "g" },
					{ mode = "x", keys = "g" },

					-- Marks
					{ mode = "n", keys = "'" },
					{ mode = "n", keys = "`" },
					{ mode = "x", keys = "'" },
					{ mode = "x", keys = "`" },

					-- Registers
					{ mode = "n", keys = '"' },
					{ mode = "x", keys = '"' },
					{ mode = "i", keys = "<C-r>" },
					{ mode = "c", keys = "<C-r>" },

					-- Window commands
					{ mode = "n", keys = "<C-w>" },

					-- `z` key
					{ mode = "n", keys = "z" },
					{ mode = "x", keys = "z" },
				},

				clues = {
					-- Enhance this by adding descriptions for <Leader> mapping groups
					miniclue.gen_clues.builtin_completion(),
					miniclue.gen_clues.g(),
					miniclue.gen_clues.marks(),
					miniclue.gen_clues.registers(),
					miniclue.gen_clues.windows(),
					miniclue.gen_clues.z(),
				},
			})
		end,
	},
}
