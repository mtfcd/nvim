local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local sources = {
  formatting.prettier,
  formatting.stylua,
  formatting.rustfmt,
  formatting.gofmt,
  formatting.goimports_reviser,
}

null_ls.setup({
  debug = true,
  sources = sources,
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          print(client)
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})
