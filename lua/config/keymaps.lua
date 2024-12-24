-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
vim.keymap.set("n", "zR", ":lua vim.cmd('set foldlevel=99')<CR>", { desc = "모든 폴딩 열기" })
vim.keymap.set("n", "zM", ":lua vim.cmd('set foldlevel=0')<CR>", { desc = "모든 폴딩 닫기" })
vim.keymap.set("n", "zo", "zo", { desc = "현재 폴딩 열기" })
vim.keymap.set("n", "zc", "zc", { desc = "현재 폴딩 닫기" })
vim.keymap.set("n", "za", "za", { desc = "폴딩 토글" })
