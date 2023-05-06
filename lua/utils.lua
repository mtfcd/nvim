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

return M
