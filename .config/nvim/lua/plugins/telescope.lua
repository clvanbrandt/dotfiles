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
			{ "<leader>fb", "<cmd>Telescope buffers<CR>" },
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
			{ "<leader>ft", "<cmd>Telescope file_browser<CR>", desc = "File browser" },
			{ "<leader>fq", "<cmd>Telescope quickfix<CR>", desc = "Quickfix" },
			{ "<leader>fc", "<cmd>Telescope<CR>", desc = "Telescope" },
			{ "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "Git branches" },
		},
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				lazy = false,
			},
			"nvim-telescope/telescope-file-browser.nvim",
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("file_browser")
		end,
		opts = {
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
				file_browser = {
					theme = "ivy",
					hijack_netrw = true,
					mappings = {
						["i"] = {},
						["n"] = {},
					},
				},
			},
			follow_symlinks = true,
			defaults = {
				prompt_prefix = " ",
				selection_caret = "❯ ",
				path_display = { "smart" },
				layout_strategy = "bottom_pane",
				layout_config = { bottom_pane = { height = 0.5 } },
				file_ignore_patterns = { "node_plugins/.*" },
				mappings = {
					i = {
						["<C-j>"] = function(...)
							return require("telescope.actions").move_selection_next(...)
						end,
						["<C-k>"] = function(...)
							return require("telescope.actions").move_selection_previous(...)
						end,
						["<C-n>"] = function(...)
							return require("telescope.actions").cycle_history_next(...)
						end,
						["<C-p>"] = function(...)
							return require("telescope.actions").cycle_history_prev(...)
						end,
						["<C-d>"] = function(...)
							return require("telescope.actions").preview_scrolling_down(...)
						end,
						["<C-u>"] = function(...)
							return require("telescope.actions").preview_scrolling_up(...)
						end,
					},
					n = {
						["q"] = function(...)
							return require("telescope.actions").close(...)
						end,
					},
				},
			},
			pickers = {
				file_browser = {
					initial_mode = "normal",
				},
				buffers = {
					theme = "ivy",
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
				oldfiles = {
					theme = "ivy",
					previewer = false,
				},
				help_tags = {
					theme = "ivy",
					previewer = false,
				},
				live_grep = {
					theme = "ivy",
					layout_config = {
						height = 30,
					},
				},
			},
		},
	},
}
