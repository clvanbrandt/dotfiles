local Util = require("lazy.core.util")

local M = {}

M.root_patterns = { ".git", "lua", ".gitignore" }

function M.map(mode, key, cmd, opts)
	vim.keymap.set(mode, key, cmd, opts or { noremap = true, silent = true })
end

---@param plugin string
function M.has(plugin)
	return require("lazy.core.config").plugins[plugin] ~= nil
end

---@param fn fun()
function M.on_very_lazy(fn)
	vim.api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		callback = function()
			fn()
		end,
	})
end

---@param name string
function M.opts(name)
	local plugin = require("lazy.core.config").plugins[name]
	if not plugin then
		return {}
	end
	local Plugin = require("lazy.core.plugin")
	return Plugin.values(plugin, "opts", false)
end

---@param silent boolean?
---@param values? {[1]:any, [2]:any}
function M.toggle(option, silent, values)
	if values then
		if vim.opt_local[option]:get() == values[1] then
			vim.opt_local[option] = values[2]
		else
			vim.opt_local[option] = values[1]
		end
		return Util.info("Set " .. option .. " to " .. vim.opt_local[option]:get(), { title = "Option" })
	end
	vim.opt_local[option] = not vim.opt_local[option]:get()
	if not silent then
		if vim.opt_local[option]:get() then
			Util.info("Enabled " .. option, { title = "Option" })
		else
			Util.warn("Disabled " .. option, { title = "Option" })
		end
	end
end

function M.is_git_repo()
	vim.fn.system("git rev-parse --is-inside-work-tree")

	return vim.v.shell_error == 0
end

function M.get_git_root()
	local dot_git_path = vim.fn.finddir(".git", ".;")
	return vim.fn.fnamemodify(dot_git_path, ":h")
end

local diagnostics_enabled = true
function M.toggle_diagnostics()
	if vim.diagnostic.is_enabled then
		diagnostics_enabled = not vim.diagnostic.is_enabled()
	end

	diagnostics_enabled = not diagnostics_enabled

	if diagnostics_enabled then
		vim.diagnostic.enable()
		Util.info("Enabled diagnostics", { title = "Diagnostics" })
	else
		vim.diagnostic.enable(false)
		Util.warn("Disabled diagnostics", { title = "Diagnostics" })
	end
end

---@param buf? number
---@param value? boolean
function M.toggle_inlay_hints(buf, value)
	local ih = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
	if type(ih) == "function" then
		ih(buf, value)
	elseif type(ih) == "table" and ih.enable then
		if value == nil then
			value = not ih.is_enabled(buf)
		end
		ih.enable(value, { bufnr = buf })
	end
end

return M
