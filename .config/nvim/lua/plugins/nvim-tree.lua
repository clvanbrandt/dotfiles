return {
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup()
			vim.keymap.set("n", "<leader>fs", "<cmd>NvimTreeToggle<CR>", { desc = "File tree" })
		end,
	},
}
