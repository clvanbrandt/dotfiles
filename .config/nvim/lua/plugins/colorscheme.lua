local config = require("config")

return {
	{
		"scottmckendry/cyberdream.nvim",
		enabled = false,
		priority = 1000,
		config = function()
			require("cyberdream").setup({
				-- Recommended - see "Configuring" below for more config options
				transparent = true,
				italic_comments = true,
				hide_fillchars = true,
				borderless_telescope = true,
				terminal_colors = true,
			})
			vim.cmd("colorscheme cyberdream") -- set the colorscheme
		end,
	},
	{
		"folke/tokyonight.nvim",
		enabled = false,
		config = function()
			if config.colorscheme == "tokyonight" then
				vim.cmd([[colorscheme tokyonight]])
			end
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		enabled = false,
		config = function()
			if config.colorscheme == "github" then
				require("github-theme").setup({
					theme_style = config.variant,
				})
			end
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		enabled = true,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				integrations = {
					cmp = true,
					gitsigns = true,
					treesitter = true,
					notify = true,
					fidget = true,
					harpoon = true,
					noice = true,
					mini = {
						enabled = true,
						indentscope_color = "teal",
					},
					which_key = true,
				},
			})
			if config.colorscheme == "catppuccin" then
				vim.cmd.colorscheme(config.variant)
			end
		end,
	},
}
