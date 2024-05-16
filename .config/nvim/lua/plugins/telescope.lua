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
		vim.fn.system("git rev-parse --is-inside-work-tree")
		is_inside_work_tree[cwd] = vim.v.shell_error == 0
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
			{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help pages" },
			{
				"<leader>fo",
				"<cmd>Telescope oldfiles<CR>",
				desc = "Recent files",
			},
			{ "<leader>fw", "<cmd>Telescope live_grep<CR>", desc = "Grep" },
			{
				"<leader>fn",
				"<cmd>Telescope notify<CR>",
				desc = "Notifications",
			},
			{ "<leader>fq", "<cmd>Telescope quickfix<CR>", desc = "Quickfix" },
			{ "<leader>fc", "<cmd>Telescope<CR>", desc = "Telescope" },
			{ "<leader>sa", "<cmd>Telescope autocommands<CR>", desc = "Auto Commands" },
			{ "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Buffer" },
			{ "<leader>sc", "<cmd>Telescope command_history<CR>", desc = "Command History" },
			{ "<leader>sC", "<cmd>Telescope commands<CR>", desc = "Commands" },
			{ "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<CR>", desc = "Document Diagnostics" },
			{ "<leader>sD", "<cmd>Telescope diagnostics<CR>", desc = "Workspace Diagnostics" },
			{ "<leader>sg", "<cmd>Telescope live_grep<CR>", desc = "Grep" },
			{ "<leader>sG", live_grep_from_root, desc = "Grep (Root Dir)" },
			{ "<leader>sh", "<cmd>Telescope help_tags<CR>", desc = "Help Pages" },
			{ "<leader>sH", "<cmd>Telescope highlights<CR>", desc = "Search Highlight Groups" },
			{ "<leader>sk", "<cmd>Telescope keymaps<CR>", desc = "Key Maps" },
			{ "<leader>sM", "<cmd>Telescope man_pages<CR>", desc = "Man Pages" },
			{ "<leader>sm", "<cmd>Telescope marks<CR>", desc = "Jump to Mark" },
			{ "<leader>so", "<cmd>Telescope vim_options<CR>", desc = "Options" },
			{ "<leader>sR", "<cmd>Telescope resume<CR>", desc = "Resume" },
			{ '<leader>s"', "<cmd>Telescope registers<CR>", desc = "Resume" },
		},
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				lazy = false,
			},
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function(_, _)
			local actions = require("telescope.actions")
			local trouble = require("trouble.sources.telescope")

			local Layout = require("nui.layout")
			local Popup = require("nui.popup")

			local telescope = require("telescope")
			local TSLayout = require("telescope.pickers.layout")

			local function make_popup(options)
				local popup = Popup(options)
				function popup.border:change_title(title)
					popup.border.set_text(popup.border, "top", title)
				end
				return TSLayout.Window(popup)
			end

			require("telescope").setup({
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							previewer = false,
							initial_mode = "normal",
							sorting_strategy = "ascending",
						}),
					},
				},
				follow_symlinks = true,
				defaults = {
					prompt_prefix = " ",
					selection_caret = "❯ ",
					path_display = { "smart" },
					-- layout_strategy = "vertical",
					-- layout_config = { bottom_pane = { height = 0.5 } },
					layout_strategy = "flex",
					layout_config = {
						horizontal = {
							size = {
								width = "90%",
								height = "80%",
							},
						},
						vertical = {
							size = {
								width = "90%",
								height = "90%",
							},
						},
					},
					create_layout = function(picker)
						local border = {
							results = {
								top_left = "┌",
								top = "─",
								top_right = "┬",
								right = "│",
								bottom_right = "",
								bottom = "",
								bottom_left = "",
								left = "│",
							},
							results_patch = {
								minimal = {
									top_left = "┌",
									top_right = "┐",
								},
								horizontal = {
									top_left = "┌",
									top_right = "┬",
								},
								vertical = {
									top_left = "├",
									top_right = "┤",
								},
							},
							prompt = {
								top_left = "├",
								top = "─",
								top_right = "┤",
								right = "│",
								bottom_right = "┘",
								bottom = "─",
								bottom_left = "└",
								left = "│",
							},
							prompt_patch = {
								minimal = {
									bottom_right = "┘",
								},
								horizontal = {
									bottom_right = "┴",
								},
								vertical = {
									bottom_right = "┘",
								},
							},
							preview = {
								top_left = "┌",
								top = "─",
								top_right = "┐",
								right = "│",
								bottom_right = "┘",
								bottom = "─",
								bottom_left = "└",
								left = "│",
							},
							preview_patch = {
								minimal = {},
								horizontal = {
									bottom = "─",
									bottom_left = "",
									bottom_right = "┘",
									left = "",
									top_left = "",
								},
								vertical = {
									bottom = "",
									bottom_left = "",
									bottom_right = "",
									left = "│",
									top_left = "┌",
								},
							},
						}

						local results = make_popup({
							focusable = false,
							border = {
								style = border.results,
								text = {
									top = picker.results_title,
									top_align = "center",
								},
							},
							win_options = {
								winhighlight = "Normal:Normal",
							},
						})

						local prompt = make_popup({
							enter = true,
							border = {
								style = border.prompt,
								text = {
									top = picker.prompt_title,
									top_align = "center",
								},
							},
							win_options = {
								winhighlight = "Normal:Normal",
							},
						})

						local preview = make_popup({
							focusable = false,
							border = {
								style = border.preview,
								text = {
									top = picker.preview_title,
									top_align = "center",
								},
							},
						})

						local box_by_kind = {
							vertical = Layout.Box({
								Layout.Box(preview, { grow = 1 }),
								Layout.Box(results, { grow = 1 }),
								Layout.Box(prompt, { size = 3 }),
							}, { dir = "col" }),
							horizontal = Layout.Box({
								Layout.Box({
									Layout.Box(results, { grow = 1 }),
									Layout.Box(prompt, { size = 3 }),
								}, { dir = "col", size = "50%" }),
								Layout.Box(preview, { size = "50%" }),
							}, { dir = "row" }),
							minimal = Layout.Box({
								Layout.Box(results, { grow = 1 }),
								Layout.Box(prompt, { size = 3 }),
							}, { dir = "col" }),
						}

						local function get_box()
							local strategy = picker.layout_strategy
							if strategy == "vertical" or strategy == "horizontal" then
								return box_by_kind[strategy], strategy
							end

							local height, width = vim.o.lines, vim.o.columns
							local box_kind = "horizontal"
							if width < 100 then
								box_kind = "vertical"
								if height < 40 then
									box_kind = "minimal"
								end
							end
							return box_by_kind[box_kind], box_kind
						end

						local function prepare_layout_parts(layout, box_type)
							layout.results = results
							results.border:set_style(border.results_patch[box_type])

							layout.prompt = prompt
							prompt.border:set_style(border.prompt_patch[box_type])

							if box_type == "minimal" then
								layout.preview = nil
							else
								layout.preview = preview
								preview.border:set_style(border.preview_patch[box_type])
							end
						end

						local function get_layout_size(box_kind)
							return picker.layout_config[box_kind == "minimal" and "vertical" or box_kind].size
						end

						local box, box_kind = get_box()
						local layout = Layout({
							relative = "editor",
							position = "50%",
							size = get_layout_size(box_kind),
						}, box)

						layout.picker = picker
						prepare_layout_parts(layout, box_kind)

						local layout_update = layout.update
						function layout:update()
							local box, box_kind = get_box()
							prepare_layout_parts(layout, box_kind)
							layout_update(self, { size = get_layout_size(box_kind) }, box)
						end

						return TSLayout(layout)
					end,
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
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("notify")
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
