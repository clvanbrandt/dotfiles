local o = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.shell = "/bin/zsh"

-- Permanent undo
o.undodir = vim.fn.stdpath("cache") .. "/undo"
o.undofile = true

-- Decent wildmenu
o.wildmenu = true
o.wildmode = "list:longest"

-- Appearance
o.cmdheight = 1
o.colorcolumn = "88"
o.cursorline = true
-- o.foldmethod = 'marker'
o.number = true
o.relativenumber = true
o.ruler = false -- My statusline take care of that
o.showmode = false
o.signcolumn = "yes"
o.termguicolors = true
o.wrap = false

-- Backups
o.backup = false
o.writebackup = false
o.swapfile = false
o.autoread = true -- Automatically read a file when it has been changed from outside vim

o.pumblend = 10 -- Popup menu transparency
o.pumheight = 8 -- Popup menu height

-- General
o.clipboard = "unnamedplus"

o.hidden = true
o.joinspaces = false
o.mouse = "a"
o.scrolloff = 8
o.sidescrolloff = 8
o.splitbelow = false
o.splitright = true
o.timeoutlen = 1000
o.updatetime = 300
o.virtualedit = "block"
o.iskeyword = o.iskeyword + "-"

-- Listchars
-- vim.opt.list = true
-- vim.opt.listchars:append 'eol:↴'
-- vim.opt.listchars:append 'space:⋅'

-- Performance
-- o.lazyredraw = true
--
vim.g.autoformat = true

-- Search
o.inccommand = "nosplit" -- show substitutions incrementally
o.ignorecase = true
o.smartcase = true
o.wildignore = { ".git/*", "node_plugins/*" }
o.wildignorecase = true
o.incsearch = true

-- Tabs
o.expandtab = true
o.shiftwidth = 4
o.softtabstop = 4
o.tabstop = 4

-- Shortmess
o.shortmess = o.shortmess
	+ {
		A = true, -- don't give the "ATTENTION" message when an existing swap file is found.
		I = true, -- don't give the intro message when starting Vim |:intro|.
		W = true, -- don't give "written" or "[w]" when writing a file
		c = true, -- don't give |ins-completion-menu| messages
		m = true, -- use "[+]" instead of "[Modified]"
	}

-- Format options
o.formatoptions = {
	t = true, -- wrap text and comments using textwidth
	c = true,
	o = false, -- O and o, don't continue comments
	r = true, -- Pressing Enter will continue comments
	q = true, -- enable formatting of comments with gq
	n = true, -- detect lists for formatting
	b = true, -- auto-wrap in insert mode, and do not wrap old long lines
}

-- Editor settings
vim.g.autoindent = true

-- Older stuff
vim.cmd([[
    syntax on

    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    noremap <C-q> :confirm qall<CR>

    " =============================================================================
    " # GUI settings
    " =============================================================================
    set vb t_vb= " No more beeps
    set synmaxcol=500
    set laststatus=3
    set diffopt+=iwhite " No whitespace in vimdiff
    set diffopt+=algorithm:patience
    set diffopt+=indent-heuristic
    set showcmd " Show (partial) command in status line.

    " Show those damn hidden characters
    " Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
    set listchars=nbsp:¬,extends:»,precedes:«,trail:•
]])
