vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.tf",
  callback = function()
    vim.bo.filetype = "opentofu"
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.tfvars",
  callback = function()
    vim.bo.filetype = "opentofu-vars"
  end,
})
