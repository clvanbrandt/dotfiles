local Util = require("lazy.core.util")

local function on_attach(opts)
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(args)
			local buffer = args.buf
			-- vim.api.nvim_buf_set_option(buffer, "formatexpr", "v:lua.vim.lsp.formatexpr()")
			-- vim.api.nvim_buf_set_option(buffer, "omnifunc", "v:lua.vim.lsp.omnifunc")
			-- vim.api.nvim_buf_set_option(buffer, "tagfunc", "v:lua.vim.lsp.tagfunc")

			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client == nil then
				return
			end

			if client.name == "ruff_lsp" then
				---@diagnostic disable-next-line: inject-field
				client.server_capabilities.hover = false
			end

			if vim.fn.has("nvim-0.10") == 1 and client.supports_method("textDocument/inlayHint") then
				vim.lsp.inlay_hint.enable(opts.inlay_hints.enabled)
			end

			-- require("plugins.lsp.format").on_attach(client, buffer)
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
			inlay_hints = {
				enabled = false,
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
			on_attach(opts)

			-- diagnostics
			for name, icon in pairs(require("icons").diagnostics) do
				name = "DiagnosticSign" .. name
				vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
			end
			vim.diagnostic.config(opts.diagnostics)

			local servers = opts.servers
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

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

			local ensure_installed = { "lua_ls", "tsserver", "pyright", "terraformls", "ruff", "ruff_lsp" }
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
		"stevearc/conform.nvim",
		opts = {},
		config = function()
			require("conform").setup({
				format_on_save = function(bufnr)
					-- Disable with a global or buffer-local variable
					if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
						return
					end
					return { timeout_ms = 2000, lsp_fallback = true }
				end,
				formatters_by_ft = {
					lua = { "stylua" },
					terraform = { "terraform_fmt" },
					-- Use a sub-list to run only the first available formatter
					javascript = { { "prettierd", "prettier" } },
				},
			})

			vim.api.nvim_create_user_command("FormatDisable", function(args)
				if args.bang then
					vim.b.disable_autoformat = true
				else
					vim.g.disable_autoformat = true
				end
				Util.warn("Disabled format on save", { title = "Format" })
			end, {
				desc = "Disable autoformat-on-save",
				bang = true,
			})
			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.b.disable_autoformat = false
				vim.g.disable_autoformat = false
				Util.info("Enabled format on save", { title = "Format" })
			end, {
				desc = "Re-enable autoformat-on-save",
			})
			vim.api.nvim_create_user_command("FormatToggle", function()
				if vim.g.disable_autoformat then
					vim.cmd("FormatEnable")
				else
					vim.cmd("FormatDisable")
				end
			end, {
				desc = "Re-enable autoformat-on-save",
			})

			vim.keymap.set("n", "<leader>uf", function()
				vim.cmd("FormatToggle")
			end, { desc = "Toggle Format on Save" })

			vim.keymap.set({ "n", "v" }, "<leader>cf", require("conform").format, { desc = "Format Buffer" })
		end,
	},
	{
		"mfussenegger/nvim-lint",
		config = function(_, _)
			require("lint").linters_by_ft = {
				typescript = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				javascript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
