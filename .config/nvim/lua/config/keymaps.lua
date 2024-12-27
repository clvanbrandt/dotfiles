-- Remove some keymaps
vim.keymap.del("n", "<leader>ft")
vim.keymap.del("n", "<leader>fT")

-- Copy/Paste
vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("n", "gp", '"+p', { desc = "Paste from system clipboard" })

-- Quick-save
vim.keymap.set("n", "<leader>fs", ":silent w<CR>", { noremap = true, silent = true, desc = "Save file" })
vim.keymap.set("n", "<leader>fz", ":silent wq<CR>", { noremap = true, silent = true, desc = "Save file" })

--<leader><leader> toggles between buffer
vim.keymap.set("n", "<Space><Space>", "<c-^>", { desc = "Last buffer" })
