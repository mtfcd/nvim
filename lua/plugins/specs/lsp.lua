local servers = {
  html = {},
  cssls = {},
  gopls = {},
  tsserver = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            [vim.fn.stdpath("data") .. "/lazy/extensions/nvchad_types"] = true,
            [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  },
}
local function config()
  local utils = require("utils")

  local function on_attach(client, bufnr)
    utils.load_mappings("lspconfig", { buffer = bufnr })
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()

  capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      },
    },
  }

  for name, opt in pairs(servers) do
    opt.on_attach = on_attach
    opt.capabilities = capabilities
    require("lspconfig")[name].setup(opt)
  end
end

return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    config = function(_, opts)
      local ensure_installed = vim.tbl_keys(servers)
      require("mason").setup({
        ensure_installed = ensure_installed,
      })

      -- custom nvchad cmd to install all mason binaries listed
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end, {})

      vim.g.mason_binaries_list = opts.ensure_installed
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
          require("mason").setup({
            ensure_installed = { "lua_ls", "rust_analyzer", "gopls", "tsserver" },
          })
          require("mason-lspconfig").setup()
        end,
      },
    },
    init = function()
      require("utils").lazy_load("nvim-lspconfig")
    end,
    config = config,
  },
}
