local function show_macro_recording()
	local recording_register = vim.fn.reg_recording()
	if recording_register == "" then
		return ""
	else
		return "Recording @" .. recording_register
	end
end

local function refresh_lualine()
	local lualine = require("lualine")
	lualine.refresh({
		place = { "statusline" },
	})
end

local project_root = {
	function()
		return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
	end,
	icon = "",
	-- cond = hide_in_width,
	separator = "",
}

return {
	{
		"vimpostor/vim-tpipeline",
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {
						"dashboard",
						"NvimTree",
						"alfa-nvim",
						"help",
						"neo-tree",
						"trouble",
						"spectre_panel",
						"toggleterm",
						"Neogit",
					},
					winbar = {},
				},

				always_divide_middle = true,
				globalstatus = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					"branch",
					"diff",
					{ "diagnostics", sources = { "nvim_lsp" } },
				},
				lualine_c = { project_root, "filename" },
				lualine_x = {
					{
						"macro-recording",
						fmt = show_macro_recording,
					},
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = {
					{ "tabs", mode = 1 },
				},
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
		config = function(_, opts)
			local lualine = require("lualine")

			lualine.setup(opts)

			vim.api.nvim_create_autocmd("RecordingEnter", {
				callback = refresh_lualine,
			})

			vim.api.nvim_create_autocmd("RecordingLeave", {
				callback = function()
					local timer = vim.loop.new_timer()
					timer:start(50, 0, vim.schedule_wrap(refresh_lualine))
				end,
			})
		end,
	},
}
