local M = {}

M.load_mappings = function(mapping_name, mapping_opts)
  local mapping = require("mappings")[mapping_name]
  for mode, mode_values in pairs(mapping) do
    for keybind, info in pairs(mode_values) do
      local action = info[1]
      local opts = vim.tbl_deep_extend("force", mapping_opts or {}, info.opts or {})
      opts.desc = info[2]
      vim.keymap.set(mode, keybind, action, opts)
    end
  end
end

M.lazy_load = function(plugin)
  vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
    callback = function()
      local file = vim.fn.expand("%")
      local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""

      if condition then
        vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

        -- dont defer for treesitter as it will show slow highlighting
        -- This deferring only happens only when we do "nvim filename"
        if plugin ~= "nvim-treesitter" then
          vim.schedule(function()
            require("lazy").load({ plugins = plugin })

            if plugin == "nvim-lspconfig" then
              vim.cmd("silent! do FileType")
            end
          end)
        else
          require("lazy").load({ plugins = plugin })
        end
      end
    end,
  })
end

return M
