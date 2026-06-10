-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.breakindent = true

-- This will be applied after the colorscheme loads
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- vim.api.nvim_set_hl(0, "LineNr", { fg = "#89dceb", bold = true })
  end,
})
