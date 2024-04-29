local config = require("config")

return {
	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
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
		lazy = false,
		config = function()
			if config.colorscheme == "tokyonight" then
				vim.cmd([[colorscheme tokyonight]])
			end
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		lazy = false,
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
		lazy = false,
		config = function()
			if config.colorscheme == "catppuccin" then
				vim.cmd.colorscheme(config.variant)
			end
		end,
	},
}
