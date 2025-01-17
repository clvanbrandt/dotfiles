local Util = require("util")

vim.keymap.set("", "<space>", "<Nop>")
vim.keymap.set("", "<C-z>", "<Nop>")

-- Search results centered please
vim.keymap.set("n", "<silent> n", "nzz")
vim.keymap.set("n", "<silent> N", "Nzz")
vim.keymap.set("n", "<silent> *", "*zz")
vim.keymap.set("n", "<silent> #", "#zz")
vim.keymap.set("n", "<silent> g*", "g*zz")

-- Centered navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Very magic by default
vim.cmd([[
    nnoremap ? ?\v
    nnoremap / /\v
    " cnoremap s %sm/
]])

--=============================================================================
--# Keyboard shortcuts
--=============================================================================
-- Copy/Paste

vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("n", "gp", '"+p', { desc = "Paste from system clipboard" })

-- - Paste in Visual with `P` to not copy selected text (`:h v_P`)
vim.keymap.set("x", "gp", '"+P', { desc = "Paste from system clipboard" })

-- Quick-save
vim.keymap.set("n", "<leader>fs", ":silent w<CR>", { noremap = true, silent = true, desc = "Save file" })
vim.keymap.set("n", "<leader>fz", ":silent wq<CR>", { noremap = true, silent = true, desc = "Save file" })

-- ; as
vim.keymap.set("n", ";", ":")

vim.keymap.set("n", "Q", "<nop>")

-- No accidental macro recording
vim.keymap.set("n", "q", "<nop>", { noremap = true })
vim.keymap.set("n", "qq", "q", { noremap = true })

vim.keymap.set("i", "<C-c>", "<Esc>")

-- Ctrl+h to stop searching
vim.keymap.set("v", "<C-h>", ":nohlsearch<cr>", { silent = true })
vim.keymap.set("v", "<C-g>", ":nohlsearch<cr>", { silent = true })
vim.keymap.set("n", "<C-h>", ":nohlsearch<cr>", { silent = true })
vim.keymap.set("n", "<C-g>", ":nohlsearch<cr>", { silent = true })

-- Jump to start and end of line using the home row keys
-- vim.keymap.set("", "gH", "H", { noremap = true, silent = false })
-- vim.keymap.set("", "gL", "L", { noremap = true, silent = false })

-- vim.keymap.set("", "H", "^", { noremap = false, silent = false })
-- vim.keymap.set("", "L", "$", { noremap = false, silent = false })

-- Open new file adjacent to current file
vim.cmd([[nnoremap <leader>fa :e <C-R>=expand("%:p:h") . "/" <CR>]])

-- Buffer navigation
-- vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
-- vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Move by line
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "gj", "j")
vim.keymap.set("n", "gk", "k")

vim.keymap.set("n", "<Down>", "g<Down>")
vim.keymap.set("n", "<Up>", "g<Up>")
vim.keymap.set("n", "g<Down>", "<Down>")
vim.keymap.set("n", "g<Up>", "<Up>")

-- Split
vim.keymap.set("n", "<leader>ws", "<C-W><C-S>", { desc = "Split window" })
vim.keymap.set("n", "<leader>wv", "<C-W><C-V>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>wc", "<C-W><C-C>", { desc = "Close window" })
vim.keymap.set("n", "<leader>wo", "<C-W><C-O>", { desc = "Close all other windows" })

-- Navigation
vim.keymap.set("n", "<leader>j", "<C-W><C-J>", { desc = "Go to lower window" })
vim.keymap.set("n", "<leader>k", "<C-W><C-K>", { desc = "Go to upper window" })
vim.keymap.set("n", "<leader>l", "<C-W><C-L>", { desc = "Go to right window" })
vim.keymap.set("n", "<leader>h", "<C-W><C-H>", { desc = "Go to left window" })

vim.keymap.set("n", "<leader>wj", "<C-W><C-J>", { desc = "Go to lower window" })
vim.keymap.set("n", "<leader>wk", "<C-W><C-K>", { desc = "Go to upper window" })
vim.keymap.set("n", "<leader>wl", "<C-W><C-L>", { desc = "Go to right window" })
vim.keymap.set("n", "<leader>wh", "<C-W><C-H>", { desc = "Go to left window" })

-- Colemak edition
vim.keymap.set("n", "<leader>wn", "<C-W><C-J>", { desc = "Go to lower window" })
vim.keymap.set("n", "<leader>we", "<C-W><C-K>", { desc = "Go to upper window" })
vim.keymap.set("n", "<leader>wi", "<C-W><C-L>", { desc = "Go to right window" })
vim.keymap.set("n", "<leader>wm", "<C-W><C-H>", { desc = "Go to left window" })

-- Split resize
vim.keymap.set("n", "<C-S-Up>", ":resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-S-Down>", ":resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-S-Left>", ":vertical resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-S-Right>", ":vertical resize +2<CR>", { silent = true })

--<leader><leader> toggles between buffer
vim.keymap.set("n", "<leader><leader>", "<c-^>", { desc = "Last buffer" })

--Cursor position after J
vim.keymap.set("n", "J", "mzJ`z", { desc = "Move down" })

-- Move current line / block with J/K a la vscode.
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move down", silent = true })
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move up", silent = true })

-- QuickFix
-- vim.keymap.set("n", "<c-k>", ":cnext<CR>", { desc = "Next quickfix", silent = true })
-- vim.keymap.set("n", "<c-j>", ":cprev<CR>", { desc = "Prev quickfix", silent = true })
vim.keymap.set("n", "<leader>xL", "<cmd>lopen<cr>", { desc = "Location List" })
vim.keymap.set("n", "<leader>xQ", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- Indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

local has_snacks, _ = pcall(require, "snacks")

if not has_snacks then
	vim.keymap.set("n", "<leader>uh", function()
		Util.toggle_inlay_hints()
	end, { desc = "Toggle Inlay Hints" })

	vim.keymap.set("n", "<leader>ui", function()
		Util.toggle("list")
	end, { desc = "Toggle invisible characters" })

	vim.keymap.set("n", "<leader>un", function()
		Util.toggle("number")
	end, { desc = "Toggle numbers" })

	vim.keymap.set("n", "<leader>ur", function()
		Util.toggle("relativenumber")
	end, { desc = "Toggle relative numbers" })

	local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
	vim.keymap.set("n", "<leader>uc", function()
		Util.toggle("conceallevel", false, { 0, conceallevel })
	end, { desc = "Toggle conceal" })

	-- Diagnostics
	vim.keymap.set("n", "<leader>ud", Util.toggle_diagnostics, { desc = "Toggle diagnostics" })
end

-- Format
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
