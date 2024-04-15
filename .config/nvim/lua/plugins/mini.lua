return {
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.comment").setup()
			require("mini.jump").setup()
			require("mini.indentscope").setup()
			require("mini.pairs").setup()
			require("mini.surround").setup()
			require("mini.bracketed").setup({
				window = { suffix = "" },
			})
			require("mini.starter").setup()
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
			vim.keymap.set("n", "<leader>ft", ":lua MiniFiles.open()<CR>", { desc = "File browser", silent = true })
		end,
	},
}
