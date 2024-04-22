return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		tag = "0.1.6",
		keys = {
			{
				"<leader>ff",
				'<cmd>lua require"telescope.builtin".find_files()<CR>',
				desc = "Find files",
			},
			{
				"<leader>fF",
				'<cmd>lua require"telescope.builtin".find_files({cwd = false})<CR>',
				desc = "Find files (cwd)",
			},
			{ "<leader>fg", '<cmd>lua require"telescope.builtin".git_files()<CR>', desc = "Find files (git)" },
			{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
			{ "<leader>fh", '<cmd>lua require"telescope.builtin".help_tags()<CR>', desc = "Help pages" },
			{
				"<leader>fo",
				'<cmd>lua require"telescope.builtin".oldfiles()<CR>',
				desc = "Recent files",
			},
			{ "<leader>fw", '<cmd>lua require"telescope.builtin".live_grep()<CR>', desc = "Grep" },
			{
				"<leader>fn",
				'<cmd>lua require("telescope").extensions.notify.notify()<CR>',
				desc = "Notifications",
			},
			{ "<leader>fq", "<cmd>Telescope quickfix<CR>", desc = "Quickfix" },
			{ "<leader>fc", "<cmd>Telescope<CR>", desc = "Telescope" },
			{ "<leader>fm", "<cmd>Telescope git_status<CR>", desc = "Modified files" },
		},
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				lazy = false,
			},
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function(_, opts)
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local trouble = require("trouble.sources.telescope")

			require("telescope").setup({
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							previewer = false,
							initial_mode = "normal",
							sorting_strategy = "ascending",
						}),
					},
				},
				follow_symlinks = true,
				defaults = {
					prompt_prefix = " ",
					selection_caret = "❯ ",
					path_display = { "smart" },
					layout_strategy = "bottom_pane",
					layout_config = { bottom_pane = { height = 0.5 } },
					file_ignore_patterns = { "node_plugins/.*", "%.git/.", "package-lock.json" },
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
						"--glob=!.git/",
					},
					mappings = {
						i = {
							["<C-q>"] = function(...)
								actions.send_to_qflist(...)
							end,
							["<M-q>"] = function(...)
								actions.send_selected_to_qflist(...)
							end,
							["<C-j>"] = function(...)
								return actions.move_selection_next(...)
							end,
							["<C-k>"] = function(...)
								return actions.move_selection_previous(...)
							end,
							["<C-n>"] = function(...)
								return actions.cycle_history_next(...)
							end,
							["<C-p>"] = function(...)
								return actions.cycle_history_prev(...)
							end,
							["<C-d>"] = function(...)
								return actions.preview_scrolling_down(...)
							end,
							["<C-u>"] = function(...)
								return actions.preview_scrolling_up(...)
							end,
							["<C-t>"] = trouble.open,
						},
						n = {
							["q"] = function(...)
								return actions.close(...)
							end,
							["t"] = trouble.open,
						},
					},
				},
				pickers = {
					builtin = {
						theme = "ivy",
					},
					buffers = {
						theme = "ivy",
						initial_mode = "normal",
						mappings = {
							i = {
								["<c-d>"] = actions.delete_buffer,
							},
							n = {
								["d"] = actions.delete_buffer,
							},
						},
					},
					find_files = {
						theme = "ivy",
						hidden = true,
					},
					git_files = {
						theme = "ivy",
						hidden = true,
						show_untracked = true,
					},
					git_status = {
						theme = "ivy",
					},
					oldfiles = {
						theme = "ivy",
						previewer = false,
					},
					help_tags = {
						theme = "ivy",
						previewer = false,
					},
					lsp_references = {
						theme = "ivy",
					},
					lsp_definitions = {
						theme = "ivy",
					},
					notify = {
						theme = "ivy",
					},
					live_grep = {
						theme = "ivy",
						hidden = true,
						only_sort_text = true,
						layout_config = {
							height = 0.5,
						},
					},
				},
			})
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("notify")
		end,
	},
}
