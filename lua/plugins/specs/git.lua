-- git stuff
return {
  "lewis6991/gitsigns.nvim",
  ft = { "gitcommit", "diff" },
  init = function()
    -- load gitsigns only when a git file is opened
    vim.api.nvim_create_autocmd({ "bufread" }, {
      group = vim.api.nvim_create_augroup("gitsignslazyload", { clear = true }),
      callback = function()
        vim.fn.system("git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse")
        if vim.v.shell_error == 0 then
          vim.api.nvim_del_augroup_by_name("gitsignslazyload")
          vim.schedule(function()
            require("lazy").load({ plugins = { "gitsigns.nvim" } })
          end)
        end
      end,
    })
  end,
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
        change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
        delete = { hl = "DiffDelete", text = "󰍵", numhl = "GitSignsDeleteNr" },
        topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
        changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
        untracked = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
      },
      on_attach = function(bufnr)
        require("utils").load_mappings("gitsigns", { buffer = bufnr })
      end,
    })
  end,
}
