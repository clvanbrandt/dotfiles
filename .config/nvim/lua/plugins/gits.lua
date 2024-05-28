return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		cmd = { "Neogit" },
		opts = {
			kind = "tab",
			commit_editor = {
				kind = "auto",
				show_staged_diff = false,
			},
		},
		keys = {
			{ "<leader>gs", ":Neogit<CR>", desc = "Neogit", noremap = true, silent = true },
			{ "<leader>gc", ":Neogit commit<CR>", noremap = true, silent = true },
			{ "<leader>gp", ":Neogit pull<CR>", noremap = true, silent = true },
			{ "<leader>gP", ":Neogit push<CR>", noremap = true, silent = true },
			{ "<leader>gb", ":Neogit branch<CR>", noremap = true, silent = true },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function(_, _)
			require("gitsigns").setup()
		end,
		lazy = false,
	},
	{
		{
			"kdheepak/lazygit.nvim",
			cmd = {
				"LazyGit",
				"LazyGitConfig",
				"LazyGitCurrentFile",
				"LazyGitFilter",
				"LazyGitFilterCurrentFile",
			},
			-- optional for floating window border decoration
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			-- setting the keybinding for LazyGit with 'keys' is recommended in
			-- order to load the plugin when the command is run for the first time
			keys = {
				{ "<leader>gl", "<cmd>LazyGit<cr>", desc = "LazyGit" },
			},
		},
	},
}
