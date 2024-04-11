return {
	-- {
	-- 	"vimpostor/vim-tpipeline",
	-- 	lazy = false,
	-- 	dependencies = {
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = "",
				section_separators = "",
				disabled_filetypes = { "dashboard", "NvimTree", "packer" },
				always_divide_middle = true,
				globalstatus = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", { "diagnostics", sources = { "nvim_diagnostic" } } },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = { "quickfix", "nvim-tree", "fzf" },
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	-- 	},
	-- },
}
