-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

vim.keymap.set("i", "fd", "<Esc>", { desc = "jj to escape" }) -- alternative

-- vim.keymap.set("i", "<C-D>", "<Esc>", { desc = "jj to escape" }) -- alternative
-- vim.keymap.set("i", "<C-F>", "<Esc>", { desc = "jj to escape" }) -- alternative
vim.keymap.set("i", "<A-BS>", "<C-w>", { desc = "Delete previous word (Alt+Delete) in insert mode" })
vim.keymap.set("n", "<C-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
map("n", "<A-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height", remap = true })
map("n", "<A-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

local opts = { noremap = true, silent = true }
map("n", "<D-s>", ":w<CR>", opts)
map("i", "<D-s>", "<Esc>:w<CR>a", opts)
map("n", "<D-z>", "u", opts)
map("n", "<D-S-z>", "<C-r>", opts)
map("n", "<Up>", "k", opts)
map("n", "<Down>", "j", opts)
map("n", "<Left>", "h", opts)
map("n", "<Right>", "l", opts)

map("i", "<Up>", "<Esc>ka", opts)
map("i", "<Down>", "<Esc>ja", opts)
map("i", "<Left>", "<Esc>ha", opts)
map("i", "<Right>", "<Esc>la", opts)

map("v", "<Up>", "k", opts)
map("v", "<Down>", "j", opts)
map("v", "<Left>", "h", opts)
map("v", "<Right>", "l", opts)
-- -- Command + Arrow: jump to line/file boundaries
-- map("i", "<D-Left>", "<Esc>I", opts) -- Start of line
-- map("i", "<D-Right>", "<Esc>A", opts) -- End of line
-- map("i", "<D-Up>", "<Esc>ggA", opts) -- Top of file
-- map("i", "<D-Down>", "<Esc>G$a", opts) -- Bottom of file
--
-- -- Option + Arrow: move by word
-- map("i", "<A-Left>", "<Esc>bi", opts)
-- map("i", "<A-Right>", "<Esc>ea", opts)
--
-- -- ===== Selection variants (Shift + Command/Option) =====
-- -- Unfortunately Neovim doesn’t support native “shift-select” in insert mode,
-- -- so we emulate it by temporarily entering Visual mode.
-- map("i", "<D-S-Left>", "<Esc>v^", opts)
-- map("i", "<D-S-Right>", "<Esc>v$", opts)
-- map("i", "<D-S-Up>", "<Esc>vgg", opts)
-- map("i", "<D-S-Down>", "<Esc>vG", opts)
-- map("i", "<A-S-Left>", "<Esc>vb", opts)
-- map("i", "<A-S-Right>", "<Esc>ve", opts)
