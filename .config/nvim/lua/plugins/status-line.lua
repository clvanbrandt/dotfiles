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
				lualine_b = {
					"branch",
					"diff",
					{ "diagnostics", sources = { "nvim_diagnostic" } },
				},
				lualine_c = { "filename" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = {
					{
						"macro-recording",
						fmt = show_macro_recording,
					},
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
					-- This is going to seem really weird!
					-- Instead of just calling refresh we need to wait a moment because of the nature of
					-- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
					-- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
					-- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
					-- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
					local timer = vim.loop.new_timer()
					timer:start(50, 0, vim.schedule_wrap(refresh_lualine))
				end,
			})
		end,
	},
	-- 	},
	-- },
}
