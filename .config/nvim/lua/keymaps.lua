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

-- Quick-save
vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, silent = true, desc = "Save file" })

-- ; as
vim.keymap.set("n", ";", ":")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("i", "<C-c>", "<Esc>")

-- Ctrl-j to escape
-- vim.keymap.set("n", "<C-j>", "<Esc>")
vim.keymap.set("i", "<C-j>", "<Esc>")
vim.keymap.set("v", "<C-j>", "<Esc>")
vim.keymap.set("s", "<C-j>", "<Esc>")
vim.keymap.set("x", "<C-j>", "<Esc>")
vim.keymap.set("c", "<C-j>", "<C-c>")
vim.keymap.set("o", "<C-j>", "<Esc>")
vim.keymap.set("l", "<C-j>", "<Esc>")
vim.keymap.set("t", "<C-j>", "<Esc>")

-- Ctrl+h to stop searching
vim.keymap.set("v", "<C-h>", ":nohlsearch<cr>", { silent = true })
vim.keymap.set("n", "<C-h>", ":nohlsearch<cr>", { silent = true })

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

-- Split navigation
vim.keymap.set("n", "<leader>j", "<C-W><C-J>", { desc = "Go to lower window" })
vim.keymap.set("n", "<leader>k", "<C-W><C-K>", { desc = "Go to upper window" })
vim.keymap.set("n", "<leader>l", "<C-W><C-L>", { desc = "Go to right window" })
vim.keymap.set("n", "<leader>h", "<C-W><C-H>", { desc = "Go to left window" })

-- Split resize
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true })

--<leader><leader> toggles between buffer
vim.keymap.set("n", "<leader><leader>", "<c-^>", { desc = "Last buffer" })

--Cursor position after J
vim.keymap.set("n", "J", "mzJ`z", { desc = "Move down" })

-- Move current line / block with J/K a la vscode.
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- QuickFix
-- vim.keymap.set("n", "]q", ":cnext<CR>", { desc = "Next quickfix" })
-- vim.keymap.set("n", "[q", ":cprev<CR>", { desc = "Prev quickfix" })
vim.keymap.set("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location list" })
vim.keymap.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix list" })

-- Indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "<leader>ui", function()
	Util.toggle("list")
end, { desc = "Toggle invisible characters" })

vim.keymap.set("n", "<leader>un", function()
	Util.toggle("number")
end, { desc = "Toggle numbers" })

vim.keymap.set("n", "<leader>ur", function()
	Util.toggle("relativenumber")
end, { desc = "Toggle relative numbers" })

if not vim.g.vscode then
	vim.keymap.set("n", "<leader>ud", Util.toggle_diagnostics, { desc = "Toggle diagnostics" })

	local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
	vim.keymap.set("n", "<leader>uc", function()
		Util.toggle("conceallevel", false, { 0, conceallevel })
	end, { desc = "Toggle conceal" })
end
