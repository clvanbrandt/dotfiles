return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function(opts)
			local neogit = require("neogit")
			vim.keymap.set("n", "<leader>gs", neogit.open, { desc = "Neogit open", silent = true, noremap = true })
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
		"ldelossa/gh.nvim",
		dependencies = {
			{
				"ldelossa/litee.nvim",
				config = function()
					require("litee.lib").setup()
				end,
			},
		},
		config = function()
			require("litee.gh").setup()
			local wk = require("which-key")
			wk.register({
				g = {
					name = "+Git",
					h = {
						name = "+Github",
						c = {
							name = "+Commits",
							c = { "<cmd>GHCloseCommit<cr>", "Close" },
							e = { "<cmd>GHExpandCommit<cr>", "Expand" },
							o = { "<cmd>GHOpenToCommit<cr>", "Open To" },
							p = { "<cmd>GHPopOutCommit<cr>", "Pop Out" },
							z = { "<cmd>GHCollapseCommit<cr>", "Collapse" },
						},
						i = {
							name = "+Issues",
							p = { "<cmd>GHPreviewIssue<cr>", "Preview" },
						},
						l = {
							name = "+Litee",
							t = { "<cmd>LTPanel<cr>", "Toggle Panel" },
						},
						r = {
							name = "+Review",
							b = { "<cmd>GHStartReview<cr>", "Begin" },
							c = { "<cmd>GHCloseReview<cr>", "Close" },
							d = { "<cmd>GHDeleteReview<cr>", "Delete" },
							e = { "<cmd>GHExpandReview<cr>", "Expand" },
							s = { "<cmd>GHSubmitReview<cr>", "Submit" },
							z = { "<cmd>GHCollapseReview<cr>", "Collapse" },
						},
						p = {
							name = "+Pull Request",
							c = { "<cmd>GHClosePR<cr>", "Close" },
							d = { "<cmd>GHPRDetails<cr>", "Details" },
							e = { "<cmd>GHExpandPR<cr>", "Expand" },
							o = { "<cmd>GHOpenPR<cr>", "Open" },
							p = { "<cmd>GHPopOutPR<cr>", "PopOut" },
							r = { "<cmd>GHRefreshPR<cr>", "Refresh" },
							t = { "<cmd>GHOpenToPR<cr>", "Open To" },
							z = { "<cmd>GHCollapsePR<cr>", "Collapse" },
						},
						t = {
							name = "+Threads",
							c = { "<cmd>GHCreateThread<cr>", "Create" },
							n = { "<cmd>GHNextThread<cr>", "Next" },
							t = { "<cmd>GHToggleThread<cr>", "Toggle" },
						},
					},
				},
			}, { prefix = "<leader>" })
		end,
	},
	-- {
	-- 	"pwntester/octo.nvim",
	-- 	config = function(opts)
	-- 		require("octo").setup()
	-- 	end,
	-- },
}
