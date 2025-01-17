return {
	{
		"folke/which-key.nvim",
		event = { "VimEnter", "VeryLazy" },
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 1000
		end,
		opts = {},
	},
	{
		"mbbill/undotree",
		cmd = { "UndotreeToggle" },
		keys = {
			{ "<leader>ut", vim.cmd.UndotreeToggle, desc = "Toggle undo tree" },
		},
	},
	{
		"windwp/nvim-spectre",
		keys = {
			{
				"<leader>sr",
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
			require("fidget").setup({
				notification = {
					window = {
						winblend = 0,
					},
				},
			})
		end,
	},
	{
		"shortcuts/no-neck-pain.nvim",
		cmd = { "NoNeckPain" },
		keys = {
			{ "<leader>nnp", "<cmd>NoNeckPain<CR>", desc = "NoNeckPain" },
		},
		config = function()
			require("no-neck-pain").setup({
				width = 120,
				buffers = {
					right = { enabled = false },
				},
			})
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			messages = { enabled = true },
			-- add any options here
			popupmenu = {
				enabled = true, -- enables the Noice popupmenu UI
				backend = "nui", -- backend to use to show regular cmdline completions
				kind_icons = {}, -- set to `false` to disable icons
			},
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
				command_palette = false, -- position the cmdline and popupmenu together
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
			routes = {
				{
					filter = {
						event = "notify",
						find = "No information available",
					},
					opts = {
						skip = true,
					},
				},
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		config = function(_, opts)
			require("noice").setup(opts)
			vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
				if not require("noice.lsp").scroll(4) then
					return "<c-f>"
				end
			end, { silent = true, expr = true })

			vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
				if not require("noice.lsp").scroll(-4) then
					return "<c-b>"
				end
			end, { silent = true, expr = true })
		end,
	},
	{
		"stevearc/dressing.nvim",
	},
	--{
	-- 	"ggandor/leap.nvim",
	-- 	keys = {
	-- 		{ "gs", "<Plug>(leap)" },
	-- 	},
	-- },
	{ "NoahTheDuke/vim-just", ft = { "just" } },
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-Left>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-Down>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-Up>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-Right>", "<cmd>TmuxNavigateRight<cr>" },
		},
		init = function()
			vim.g.tmux_navigator_save_on_switch = 2
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {
			check_ts = true,
		},
	},
	{
		"OXY2DEV/markview.nvim",
		ft = "markdown",
		config = function()
			require("markview").setup()
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{ "chrisbra/csv.vim", ft = { "csv" } },
	{ "mistweaverco/kulala.nvim", enabled = false, opts = {}, ft = { "http" } },
}
