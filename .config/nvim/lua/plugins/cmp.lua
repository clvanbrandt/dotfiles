return {
	-- auto completion
	{
		"hrsh7th/nvim-cmp",
		version = false,
		lazy = false,
		enabled = false,
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"onsails/lspkind.nvim",
			"petertriho/cmp-git",
		},
		opts = function()
			local cmp = require("cmp")

			return {
				completion = {
					-- completeopt = "menu,menuone,noinsert",
					completeopt = "menu,menuone,noselect",
				},
				snippet = {
					expand = function(arg)
						vim.snippet.expand(arg.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-y>"] = cmp.mapping(
						cmp.mapping.confirm({
							behavior = cmp.ConfirmBehavior.Insert,
							select = true,
						}),
						{ "i", "c" }
					),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<S-CR>"] = cmp.mapping.confirm({ select = false }),
					["<C-CR>"] = function(fallback)
						cmp.abort()
						fallback()
					end,
					["<CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.confirm({
								select = true,
							})
						else
							fallback()
						end
					end),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "copilot" },
					{ name = "buffer", keyword_length = 3 },
					{ name = "nvim_lua" },
					{
						name = "lazydev",
						group_index = 0, -- set group index to 0 to skip loading LuaLS completions
					},
					{ name = "git" },
				}),
				formatting = {
					format = require("lspkind").cmp_format({
						mode = "symbol_text",
						maxwidth = function()
							return math.floor(0.45 * vim.o.columns)
						end,
						symbol_map = { Copilot = "" },
						ellipsis_char = "...",
						show_labelDetails = true,
						menu = {
							buffer = "[buffer]",
							nvim_lsp = "[LSP]",
							nvim_lua = "[lua]",
							path = "[path]",
							cmdline = "[cmdline]",
							lazydev = "[nvim]",
							git = "[git]",
							copilot = "[copilot]",
						},
					}),
				},
			}
		end,
		config = function(_, opts)
			local cmp = require("cmp")
			cmp.setup(opts)

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline", option = {
						ignore_cmds = { "Man", "!" },
					} },
				}),
				matching = { disallow_symbol_nonprefix_matching = false },
			})

			--Setup up vim-dadbod
			cmp.setup.filetype({ "sql" }, {
				sources = {
					{ name = "vim-dadbod-completion" },
					{ name = "buffer" },
				},
			})

			require("cmp_git").setup({ filetypes = { "gitcommit", "octo", "NeogitCommitMessage" } })
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		enabled = true,
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					keymap = {
						accept = "<C-y>",
						accept_word = false,
						accept_line = false,
						next = "<C-n>",
						prev = "<C-p>",
						dismiss = "<C-]>",
					},
				},
				panel = { enabled = false },
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		enabled = false,
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"saghen/blink.cmp",
		lazy = false,
		dependencies = "rafamadriz/friendly-snippets",
		version = "v0.*",
		opts = {
			keymap = {
				show = "<C-space>",
				hide = "<C-e>",
				accept = { "<Tab>" },
				select_prev = { "<C-k>" },
				select_next = { "<C-j>" },

				show_documentation = {},
				hide_documentation = {},
				scroll_documentation_up = "<C-b>",
				scroll_documentation_down = "<C-f>",

				snippet_forward = "<Tab>",
				snippet_backward = "<S-Tab>",
			},
		},
	},
}
