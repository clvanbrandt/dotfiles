return {
  { "akinsho/bufferline.nvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "nvim-lualine/lualine.nvim", enabled = false },
  { "snacks.nvim", opts = {
    scroll = { enabled = false },
    dashboard = { enabled = false },
  } },
  {
    "ibhagwan/fzf-lua",
    keys = {
      {
        "<leader><space>",
        false,
      },
    },
    opts = function()
      local actions = require("fzf-lua.actions")
      return {
        files = {
          cwd_prompt = true,
          actions = {
            ["ctrl-i"] = { actions.toggle_ignore },
            ["ctrl-h"] = { actions.toggle_hidden },
          },
        },
        grep = {
          actions = {
            ["ctrl-i"] = { actions.toggle_ignore },
            ["ctrl-h"] = { actions.toggle_hidden },
          },
        },
      }
    end,
  },
  {
    "vimpostor/vim-tpipeline",
    event = "VeryLazy",
  },
  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle" },
    keys = {
      { "<leader>ut", vim.cmd.UndotreeToggle, desc = "Toggle undo tree" },
    },
  },
  {
    "echasnovski/mini.splitjoin",
    opts = {},
  },
  {
    "echasnovski/mini.statusline",
    opts = {},
  },
  {
    "echasnovski/mini.files",
    opts = {
      windows = {
        preview = false,
      },
      options = {
        use_as_default_explorer = true,
      },
    },
    keys = {
      {
        "<leader>ft",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (Directory of Current File)",
      },
      {
        "<leader>fT",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
      },
    },
  },
}
