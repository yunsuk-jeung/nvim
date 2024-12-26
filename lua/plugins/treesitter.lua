return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "c",
      "cpp",
      "lua",
      "python",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  },
}
