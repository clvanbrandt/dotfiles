local M = {}

vim.cmd([[
    augroup ftplugin
        au!
        " au BufWinEnter * set formatoptions-=cro
        au BufNewFile,BufRead *.tf setl filetype=terraform 
        au BufNewFile,BufRead *.json setl filetype=jsonc " To allow comments on json files
        au FileType man setl laststatus=0 noruler
        au FileType markdown setl wrap linebreak conceallevel=2
        au FileType vim,html,css,json,javascript,javascriptreact,typescript,typescriptreact,sh,zsh setl sw=2

        " Leave paste mode when leaving insert mode
        autocmd InsertLeave * set nopaste

        " Git commit message
        autocmd Filetype gitcommit setlocal spell tw=72 colorcolumn=73
        " nftables
        autocmd BufRead,BufNewFile *.nft setfiletype nftables
        " Shorter columns in text
        autocmd Filetype tex setlocal spell tw=80 colorcolumn=81
        autocmd Filetype text setlocal spell tw=72 colorcolumn=73
        autocmd Filetype markdown setlocal spell tw=72 colorcolumn=73
        " No autocomplete in text
    augroup END
]])

local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

-- help split on the right
vim.cmd("autocmd! FileType help wincmd L")

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"qf",
		"help",
		"man",
		"notify",
		"lspinfo",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"PlenaryTestPopup",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

return M
