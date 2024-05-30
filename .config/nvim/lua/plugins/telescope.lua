local util = require("util")

local function find_files_from_root()
    local opts = {}
    local builtin = "find_files"

    if util.is_git_repo() then
        opts = {
            cwd = util.get_git_root(),
            hidden = true,
            show_untracked = true,
        }

        builtin = "git_files"
    end
    require("telescope.builtin")[builtin](opts)
end

local function live_grep_from_root()
    local opts = {}
    if util.is_git_repo() then
        opts = {
            cwd = util.get_git_root(),
            hidden = true,
            show_untracked = true,
            only_sort_text = true,
        }
    end

    require("telescope.builtin").live_grep(opts)
end

local is_inside_work_tree = {}

local function project_files()
    local opts = { hidden = true, show_untracked = true }

    local builtin = require("telescope.builtin")

    local cwd = vim.fn.getcwd()
    if is_inside_work_tree[cwd] == nil then
        is_inside_work_tree[cwd] = util.is_git_repo
    end

    if is_inside_work_tree[cwd] then
        builtin.git_files(opts)
    else
        builtin.find_files(opts)
    end
end

return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        -- tag = "0.1.6",
        keys = {
            {
                "<leader>ff",
                project_files,
                desc = "Find Files",
            },
            {
                "<leader>fF",
                find_files_from_root,
                desc = "Find Files (Root Dir)",
            },
            { "<leader>fg", "<cmd>Telescope git_files<CR>", desc = "Find files (git)" },
            { "<leader>fb", "<cmd>Telescope buffers<CR>",   desc = "Buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help pages" },
            {
                "<leader>fo",
                "<cmd>Telescope oldfiles<CR>",
                desc = "Recent files",
            },
            { "<leader>fw",       "<cmd>Telescope live_grep<CR>",                desc = "Grep" },
            { "<leader>f<space>", '<cmd>Telescope smart_open cwd_only=true<CR>', desc = "Smart Open" },
            {
                "<leader>fn",
                "<cmd>Telescope notify<CR>",
                desc = "Notifications",
            },
            { "<leader>fq", "<cmd>Telescope quickfix<CR>",                  desc = "Quickfix" },
            { "<leader>fc", "<cmd>Telescope<CR>",                           desc = "Telescope" },
            { "<leader>sa", "<cmd>Telescope autocommands<CR>",              desc = "Auto Commands" },
            { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Buffer" },
            { "<leader>sc", "<cmd>Telescope command_history<CR>",           desc = "Command History" },
            { "<leader>sC", "<cmd>Telescope commands<CR>",                  desc = "Commands" },
            { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<CR>",       desc = "Document Diagnostics" },
            { "<leader>sD", "<cmd>Telescope diagnostics<CR>",               desc = "Workspace Diagnostics" },
            { "<leader>sg", "<cmd>Telescope live_grep<CR>",                 desc = "Grep" },
            { "<leader>sG", live_grep_from_root,                            desc = "Grep (Root Dir)" },
            { "<leader>sh", "<cmd>Telescope help_tags<CR>",                 desc = "Help Pages" },
            { "<leader>sH", "<cmd>Telescope highlights<CR>",                desc = "Search Highlight Groups" },
            { "<leader>sk", "<cmd>Telescope keymaps<CR>",                   desc = "Key Maps" },
            { "<leader>sM", "<cmd>Telescope man_pages<CR>",                 desc = "Man Pages" },
            { "<leader>sm", "<cmd>Telescope marks<CR>",                     desc = "Jump to Mark" },
            { "<leader>so", "<cmd>Telescope vim_options<CR>",               desc = "Options" },
            { "<leader>sR", "<cmd>Telescope resume<CR>",                    desc = "Resume" },
            { '<leader>s"', "<cmd>Telescope registers<CR>",                 desc = "Registers" },
        },
        dependencies = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                lazy = false,
            },
            {
                "danielfalk/smart-open.nvim",
                branch = "0.2.x",
                dependencies = {
                    "kkharji/sqlite.lua",
                    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
                },
            },
        },
        config = function(_, _)
            local actions = require("telescope.actions")
            local trouble = require("trouble.sources.telescope")

            require("telescope").setup({
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                    smart_open = {
                        match_algorithm = "fzf"
                    }
                },
                follow_symlinks = true,
                defaults = {
                    prompt_prefix = "  ",
                    selection_caret = "❯ ",
                    path_display = { "smart" },
                    layout_strategy = "horizontal",
                    -- layout_strategy = "flex",
                    layout_config = {
                        bottom_pane = { height = 0.5 },
                        horizontal = {
                            size = {
                                width = "90%",
                                height = "90%",
                            },
                        },
                        vertical = {
                            size = {
                                width = "90%",
                                height = "90%",
                            },
                        },
                    },
                    file_ignore_patterns = { "node_plugins/.*", "%.git/.", "package-lock.json" },
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--hidden",
                        "--glob=!.git/",
                    },
                    mappings = {
                        i = {
                            ["<C-q>"] = function(...)
                                actions.send_to_qflist(...)
                            end,
                            ["<C-s>"] = function(...)
                                actions.send_selected_to_qflist(...)
                            end,
                            ["<C-j>"] = function(...)
                                return actions.move_selection_next(...)
                            end,
                            ["<C-k>"] = function(...)
                                return actions.move_selection_previous(...)
                            end,
                            ["<C-n>"] = function(...)
                                return actions.cycle_history_next(...)
                            end,
                            ["<C-p>"] = function(...)
                                return actions.cycle_history_prev(...)
                            end,
                            ["<C-d>"] = function(...)
                                return actions.preview_scrolling_down(...)
                            end,
                            ["<C-u>"] = function(...)
                                return actions.preview_scrolling_up(...)
                            end,
                            ["<C-t>"] = trouble.open,
                        },
                        n = {
                            ["<ESC>"] = function(...)
                                return actions.close(...)
                            end,
                            ["t"] = trouble.open,
                        },
                    },
                },
                pickers = {
                    builtin = {
                        previewer = false,
                    },
                    prompt = {
                        previewer = false,
                    },
                    prompt_patch = {
                        previewer = false,
                    },
                    buffers = {
                        initial_mode = "normal",
                        mappings = {
                            i = {
                                ["<c-d>"] = actions.delete_buffer,
                            },
                            n = {
                                ["d"] = actions.delete_buffer,
                            },
                        },
                    },
                    find_files = {
                        hidden = true,
                    },
                    git_files = {
                        hidden = true,
                        show_untracked = true,
                    },
                    oldfiles = {
                        previewer = false,
                    },
                    help_tags = {
                        previewer = false,
                    },
                    live_grep = {
                        hidden = true,
                        only_sort_text = true,
                    },
                },
            })
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("notify")
            require("telescope").load_extension("smart_open")
        end,
    },
    -- {
    -- 	"ibhagwan/fzf-lua",
    -- 	dependencies = { "nvim-tree/nvim-web-devicons" },
    -- 	config = function()
    -- 		local actions = require("fzf-lua.actions")
    --
    -- 		require("fzf-lua").setup({
    -- 			grep = {
    -- 				rg_opts = "--sort-files --hidden --column --line-number --no-heading "
    -- 					.. "--color=never --smart-case -g '!{.git,node_modules}/*'",
    -- 			},
    -- 			actions = {
    -- 				files = {
    -- 					["default"] = actions.file_edit,
    -- 					["ctrl-s"] = actions.file_split,
    -- 					["ctrl-v"] = actions.file_vsplit,
    -- 					["ctrl-t"] = actions.file_tabedit,
    -- 					["ctrl-q"] = actions.file_sel_to_qf,
    -- 				},
    -- 			},
    -- 		})
    -- 		vim.keymap.set(
    -- 			"n",
    -- 			"<leader>ff",
    -- 			"<cmd>lua require('fzf-lua').files()<CR>",
    -- 			{ silent = true, desc = "Files" }
    -- 		)
    -- 		vim.keymap.set(
    -- 			"n",
    -- 			"<leader>fb",
    -- 			"<cmd>lua require('fzf-lua').buffers()<CR>",
    -- 			{ silent = true, desc = "Buffers" }
    -- 		)
    -- 		vim.keymap.set(
    -- 			"n",
    -- 			"<leader>fw",
    -- 			"<cmd>lua require('fzf-lua').live_grep()<CR>",
    -- 			{ silent = true, desc = "Buffers" }
    -- 		)
    -- 	end,
    -- },
}
