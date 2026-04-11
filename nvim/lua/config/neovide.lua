if not vim.g.neovide then
  return {}
end

vim.o.guifont = "Monocraft Nerd Font"

vim.g.neovide_window_blurred = true
vim.g.neovide_theme = "Rose Pine Moon"

vim.g.transparency = 0.85
local alpha = function()
  return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
end
-- g:neovide_opacity should be 0 if you want to unify transparency of content and title bar.
--
-- vim.api.nvim_set_hl(0, "Cursor", { fg = "#FFC5DC", bg = "#FFC5DC" })
vim.g.neovide_opacity = 0.85
vim.g.neovide_normal_opacity = 0.15
vim.g.neovide_background_color = "#232137" .. alpha()
vim.g.neovide_cursor_animation_length = 0.2
vim.g.neovide_show_border = true
vim.g.neovide_floating_blur_amount_x = 10.0
vim.g.neovide_floating_blur_amount_y = 10.0
vim.g.neovide_floating_corner_radius = 0.8
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_cursor_vfx_opacity = 500.0
vim.keymap.set({ "n", "v" }, "<D-=>", function()
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
end, { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<D-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
vim.keymap.set({ "n", "v" }, "<D-0>", ":lua vim.g.neovide_scale_factor = 1<CR>")
