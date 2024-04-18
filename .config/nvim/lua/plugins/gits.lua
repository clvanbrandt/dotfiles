return {
	{
		"NeogitOrg/neogit",
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
}
