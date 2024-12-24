return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "c",
      "cpp",
      "lua",
      "python", -- 필요한 언어를 설치
    },
    highlight = {
      enable = true, -- 구문 강조 활성화
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
  },
}
