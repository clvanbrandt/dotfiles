local M = {}

M._keys = nil

function M.on_attach(client, buffer)
	local format = require("plugins.lsp.format").format
	local toggle_format = require("plugins.lsp.format").toggle

	local map = function(mode, key, cmd, desc)
		if desc ~= nil then
			vim.keymap.set(mode, key, cmd, { desc = desc, buffer = buffer, noremap = true, silent = true })
		else
			vim.keymap.set(mode, key, cmd, { buffer = buffer, noremap = true, silent = true })
		end
	end

	map("n", "<leader>e", vim.diagnostic.open_float, "Show diagnostics")

	map("n", "<leader>il", "<cmd>LspInfo<cr>")

	map("n", "gd", "<cmd>Telescope lsp_definitions<cr>")
	map("n", "gr", "<cmd>Telescope lsp_references<cr>")
	map("n", "gi", "<cmd>Telescope lsp_implementations<cr>")
	map("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>")
	map("n", "gD", vim.lsp.buf.declaration)

	map("n", "K", vim.lsp.buf.hover)
	map("n", "gK", vim.lsp.buf.signature_help, "Signature help")
	map("i", "<c-k>", vim.lsp.buf.signature_help, "Signature help")

	if not require("util").has("mini.bracketed") then
		map("n", "]d", M.diagnostic_goto(true), "Diagnostic forward")
		map("n", "[d", M.diagnostic_goto(false), "Diagnostic backward")
	end
	map("n", "]e", M.diagnostic_goto(true, "ERROR"), "Error forward")
	map("n", "[e", M.diagnostic_goto(false, "ERROR"), "Error backward")
	map("n", "]w", M.diagnostic_goto(true, "WARN"), "Warning forward")
	map("n", "[w", M.diagnostic_goto(false, "WARN"), "Warning backward")

	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Actions")
	map({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, "Run Codelens")
	map("n", "<leader>cC", vim.lsp.codelens.refresh, "Refresh & Display Codelens")

	map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
	map({ "n", "v" }, "<leader>cf", format, "Format Buffer")
	map("n", "<leader>uf", toggle_format, "Toggle Format on Save")
end

function M.diagnostic_goto(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

return M
