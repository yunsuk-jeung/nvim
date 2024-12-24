-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- 기본 폴딩 설정
vim.opt.foldmethod = "expr" -- 폴딩 방식을 표현식 기반으로 설정
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- Treesitter를 사용한 폴딩
vim.opt.foldenable = false -- 기본적으로 폴딩 비활성화 (펼친 상태)
vim.opt.foldlevel = 99 -- 기본적으로 모든 폴딩을 펼침
vim.opt.foldlevelstart = 99 -- 파일 열 때 폴딩 레벨
