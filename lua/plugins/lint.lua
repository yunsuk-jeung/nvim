return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = {
      sql = { 'sqlfluff' },
    }

    local group = vim.api.nvim_create_augroup('nvim-lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
      group = group,
      callback = function()
        -- Only lint if a linter is configured for this filetype
        require('lint').try_lint()
      end,
    })
  end,
}
