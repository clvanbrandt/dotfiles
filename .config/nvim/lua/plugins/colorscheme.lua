local config = require("config")

return {
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
