return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 1000
		end,
		opts = {},
	},
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle, { desc = "Toggle undo tree" })
		end,
	},
	{
		"windwp/nvim-spectre",
		keys = {
			{
				"<leader>sp",
				function()
					require("spectre").open()
				end,
				desc = "Replace in files (Spectre)",
			},
		},
	},
	{
		"norcalli/nvim-colorizer.lua",
		lazy = false,
		config = function(_, _)
			require("colorizer").setup()
		end,
	},
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({})
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			messages = { enabled = false },
			-- add any options here
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
				progress = { enabled = false },
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>cln",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Delete all Notifications",
			},
		},
		opts = {
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
	},
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
	{
		"levouh/tint.nvim",
		config = function()
			require("tint").setup()
		end,
	},
	{ "NoahTheDuke/vim-just" },
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
		config = function()
			local map = function(mode, key, cmd, opts)
				vim.keymap.set(mode, key, cmd, opts or { noremap = true, silent = true })
			end
			map("n", "<leader>h", "<cmd> TmuxNavigateLeft<CR>", { expr = false, desc = "Navigate window left" })
			map("n", "<leader>l", "<cmd> TmuxNavigateRight<CR>", { expr = false, desc = "Navigate window right" })
			map("n", "<leader>j", "<cmd> TmuxNavigateDown<CR>", { expr = false, desc = "Navigate window down" })
			map("n", "<leader>k", "<cmd> TmuxNavigateUp<CR>", { expr = false, desc = "Navigate window up" })
		end,
	},
}
