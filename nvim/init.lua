-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.neovide")
function Transparent(color)
  -- color = color or "tokyonight"
  -- vim.cmd.colorscheme("catpuccin")
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end
Transparent()
