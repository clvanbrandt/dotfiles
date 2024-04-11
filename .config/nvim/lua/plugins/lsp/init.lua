local function on_attach()
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(args)
			local buffer = args.buf
			-- vim.api.nvim_buf_set_option(buffer, "formatexpr", "v:lua.vim.lsp.formatexpr()")
			-- vim.api.nvim_buf_set_option(buffer, "omnifunc", "v:lua.vim.lsp.omnifunc")
			-- vim.api.nvim_buf_set_option(buffer, "tagfunc", "v:lua.vim.lsp.tagfunc")

			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client.name == "ruff_lsp" then
				client.server_capabilities.hover = false
			end

			if vim.fn.has("nvim-0.10") == 1 and client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(args.buf, true)
			end

			require("plugins.lsp.format").on_attach(client, buffer)
			require("plugins.lsp.keymaps").on_attach(client, buffer)
		end,
	})
end

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			-- { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			-- { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
			{
				"williamboman/mason.nvim",
				cmd = "Mason",
				keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
			},
			"williamboman/mason-lspconfig.nvim",
			"jose-elias-alvarez/nvim-lsp-ts-utils",
			"nvim-lua/lsp_extensions.nvim",
			"towolf/vim-helm",
		},
		opts = {
			-- options for vim.diagnostic.config()
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = { spacing = 4, prefix = "●" },
				severity_sort = true,
			},
			-- Automatically format on save
			autoformat = true,
			format = {
				formatting_options = nil,
				timeout_ms = nil,
			},
			-- LSP Server Settings
			servers = {
				jsonls = {},
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								checkThirdParty = false,
								library = {
									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									[vim.fn.stdpath("config") .. "/lua"] = true,
								},
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
				pyright = {
					settings = {
						python = {
							analysis = { diagnosticMode = "workspace" },
						},
					},
				},
				tsserver = {
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayVariableTypeHintsWhenTypeMatchesName = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayVariableTypeHintsWhenTypeMatchesName = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				},
			},
			setup = {},
		},
		config = function(plugin, opts)
			-- setup formatting and keymaps
			on_attach()

			-- diagnostics
			for name, icon in pairs(require("icons").diagnostics) do
				name = "DiagnosticSign" .. name
				vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
			end
			vim.diagnostic.config(opts.diagnostics)

			local servers = opts.servers
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, servers[server] or {})

				if opts.setup[server] then
					if opts.setup[server](server, server_opts) then
						return
					end
				elseif opts.setup["*"] then
					if opts.setup["*"](server, server_opts) then
						return
					end
				end
				require("lspconfig")[server].setup(server_opts)
			end

			local mlsp = require("mason-lspconfig")
			local available = mlsp.get_available_servers()

			local ensure_installed = { "lua_ls", "tsserver", "pyright", "eslint", "terraformls", "ruff", "ruff_lsp" }
			for server, server_opts in pairs(servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
					if server_opts.mason == false or not vim.tbl_contains(available, server) then
						setup(server)
					else
						ensure_installed[#ensure_installed + 1] = server
					end
				end
			end

			require("mason").setup({})
			require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup_handlers({ setup })
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				-- Plugin configuration
				tools = {},
				-- LSP configuration
				server = {
					on_attach = on_attach,
					default_settings = {
						-- rust-analyzer language server configuration
						["rust-analyzer"] = {
							-- enable clippy on save
							checkOnSave = {
								command = "clippy",
							},
						},
					},
				},
				-- DAP configuration
				dap = {},
			}
		end,
	},
	{
		"scalameta/nvim-metals",
		ft = { "scala", "sbt", "java" },
		init = function()
			local metals_config = require("metals").bare_config()
			metals_config.init_options.statusBarProvider = "off"
			metals_config.on_attach = on_attach
			metals_config.capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("metals", { clear = true }),
				callback = function()
					require("metals").initialize_or_attach(metals_config)
				end,
				pattern = { "java", "scala", "sbt" },
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			"nvimtools/none-ls-extras.nvim",
		},
		ft = { "" },
		opts = function()
			local nls = require("null-ls")
			local format = nls.builtins.formatting
			-- local diagnostics = nls.builtins.diagnostics
			-- local ca = nls.builtins.code_actions

			return {
				should_attach = function(bufnr)
					return true
					-- 	return not vim.api.nvim_buf_get_name(bufnr):match("yaml")
				end,
				sources = {
					-- diagnostics.eslint,
					-- diagnostics.flake8,
					require("none-ls.code_actions.eslint"),
					format.prettier,
					-- format.prettierd,
					format.stylua,
					format.terraform_fmt,
					format.isort,
					format.black,
				},
			}
		end,
	},
}
