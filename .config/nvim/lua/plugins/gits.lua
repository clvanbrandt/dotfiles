return {
	{
		"NeogitOrg/neogit",
		branch = "nightly",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},

		opts = {
			kind = "tab",
		},
		config = function(_, opts)
			local neogit = require("neogit")
			vim.keymap.set("n", "<leader>gs", ":Neogit<CR>", { silent = true, noremap = true })
			vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>", { silent = true, noremap = true })
			vim.keymap.set("n", "<leader>gp", ":Neogit pull<CR>", { silent = true, noremap = true })
			vim.keymap.set("n", "<leader>gP", ":Neogit push<CR>", { silent = true, noremap = true })
			vim.keymap.set("n", "<leader>gb", ":Neogit branch<CR>", { silent = true, noremap = true })

			neogit.setup(opts)
		end,
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
