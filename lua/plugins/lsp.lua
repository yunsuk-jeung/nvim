return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      require('mason').setup()

      local servers = {
        -- basedpyright = {},
        clangd={},
        dockerls = {},
        jsonls = {},
        yamlls = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
              runtime = { version = 'LuaJIT' },
              workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file('', true) },
              diagnostics = { disable = { 'missing-fields' } },
              format = { enable = false },
            },
          },
        },
      }

      require('mason-lspconfig').setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      require('mason-tool-installer').setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local on_attach = require 'plugins.lspattach'

      -- Neovim 0.11+ API
      if vim.lsp.config and vim.lsp.enable then
        for server_name, server_opts in pairs(servers) do
          server_opts = vim.tbl_deep_extend('force', {
            capabilities = capabilities,
            on_attach = on_attach,
          }, server_opts or {})
          vim.lsp.config(server_name, server_opts)
          vim.lsp.enable(server_name)
        end
      else
        -- Backward compatibility for older Neovim versions
        local lspconfig = require 'lspconfig'
        for server_name, server_opts in pairs(servers) do
          server_opts = vim.tbl_deep_extend('force', {
            capabilities = capabilities,
            on_attach = on_attach,
          }, server_opts or {})
          lspconfig[server_name].setup(server_opts)
        end
      end
    end,
  },
  {
    -- {
    --   'jay-babu/mason-null-ls.nvim',
    --   dependencies = {
    'nvimtools/none-ls.nvim',
    --   'williamboman/mason.nvim',
    -- },
    config = function()
      -- require('mason-null-ls').setup {
      --   ensure_installed = { 'sqlfluff' },
      --   automatic_installation = true,
      -- }
      local null_ls = require 'null-ls'
      null_ls.setup {
        sources = {
          null_ls.builtins.diagnostics.sqlfluff,
          null_ls.builtins.formatting.sqlfluff,
        },
        on_attach = require 'plugins.lspattach',
      }
    end,
    -- },
  },
}
