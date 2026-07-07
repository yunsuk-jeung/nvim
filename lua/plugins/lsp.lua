return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = { 'Mason', 'MasonInstall', 'MasonUpdate', 'LspInfo', 'LspInstall', 'LspStart' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      require('mason').setup()

      local servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = 'standard',
                diagnosticMode = 'openFilesOnly',
              },
            },
          },
        },
        ruff = {},
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

      local venv = vim.env.CONDA_PREFIX or vim.env.VIRTUAL_ENV
      if venv then
        servers.basedpyright.settings.python = { pythonPath = venv .. '/bin/python' }
      end

      require('mason-lspconfig').setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      require('mason-tool-installer').setup {
        -- LSP servers plus standalone tools (formatters/linters) used by conform & nvim-lint
        ensure_installed = vim.list_extend(vim.tbl_keys(servers), { 'sqlfluff' }),
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
}
