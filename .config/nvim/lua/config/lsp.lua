-- Optional config
vim.lsp.config("ty", {
  init_options = {
    settings = {
      -- ty language server settings go here
    },
  },
})
vim.lsp.enable("ty") -- Required
