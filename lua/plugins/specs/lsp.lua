local M = require("plugins.configs.lspconfig")
local ensure_installed = vim.tbl_keys(M.servers)
return {
  {
    "b0o/schemastore.nvim",
    ft = { "json", "yaml" },
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.jsonls.setup({
        on_attach = M.on_attach(),
        capabilities = M.capabilities,
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })
      lspconfig.yamlls.setup({
        on_attach = M.on_attach(),
        capabilities = M.capabilities,
        settings = {
          yaml = {
            schemas = require("schemastore").yaml.schemas(),
          },
        },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    config = function()
      require("mason").setup()

      -- custom nvchad cmd to install all mason binaries listed
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
      end, {})

      -- vim.g.mason_binaries_list = ensure_installed
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      {
        "folke/neodev.nvim",
        config = function()
          require("neodev").setup({})
        end,
      },
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require("plugins.configs.null-ls")
        end,
      },
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require("mason").setup()
          require("mason-lspconfig").setup({
            ensure_installed = ensure_installed,
          })
        end,
      },
    },
    init = function()
      require("utils").lazy_load("nvim-lspconfig")
    end,
    config = function()
      for name, opt in pairs(M.servers) do
        opt.on_attach = M.on_attach
        opt.capabilities = M.capabilities
        require("lspconfig")[name].setup(opt)
      end
    end,
  },
}
