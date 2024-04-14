local Util = require("lazy.core.util")

local M = {}

function M.toggle()
	vim.b.autoformat = not vim.b.autoformat
	if vim.b.autoformat then
		Util.info("Enabled format on save", { title = "Format" })
	else
		Util.warn("Disabled format on save", { title = "Format" })
	end
end

function M.format()
	local buf = vim.api.nvim_get_current_buf()
	if vim.b.autoformat == false then
		return
	end
	local ft = vim.bo[buf].filetype
	local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

	vim.lsp.buf.format(vim.tbl_deep_extend("force", {
		bufnr = buf,
		filter = function(client)
			if have_nls then
				return client.name == "null-ls"
					or client.name == "metals"
					or client.name == "rust_analyzer"
					or client.name == "ruff"
			end
			return client.name ~= "null-ls"
		end,
	}, require("util").opts("nvim-lspconfig").format or {}))
end

function M.on_attach(client, buf)
	if vim.b.autoformat == nil then
		vim.b.autoformat = vim.g.autoformat
	end
	-- dont format if client disabled it
	if
		client.config
		and client.config.capabilities
		and client.config.capabilities.documentFormattingProvider == false
	then
		return
	end

	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("LspFormat." .. buf, {}),
			buffer = buf,
			callback = function()
				if vim.b.autoformat then
					M.format()
				end
			end,
		})
	end
end

return M
