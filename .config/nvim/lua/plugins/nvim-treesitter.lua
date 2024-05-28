return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false, -- last release is way too old and doesn't work on Windows
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"HiPhish/nvim-ts-rainbow2",
			"windwp/nvim-ts-autotag",
			"JoosepAlviste/nvim-ts-context-commentstring",
			-- "nvim-treesitter/nvim-treesitter-context",
		},
		opts = {
			-- ensure_installed = "all",
			auto_install = true,
			highlight = {
				enable = true, -- false will disable the whole extension
				additional_vim_regex_highlighting = true,
			},
			indent = { enable = true, disable = { "terraform", "yaml" } },
			autopairs = { enable = true },
			-- rainbow = { enable = true },
			autotag = { enable = true },
			-- context_commentstring = { enable = true },
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
