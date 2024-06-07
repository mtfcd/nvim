local M = {
  genaral = {
    i = {
      -- save
      ["<C-s>"] = { "<cmd> w <CR><ESC>", "save file" },
      -- go to  beginning and end
      ["<C-b>"] = { "<ESC>^i", "beginning of line" },
      ["<C-e>"] = { "<End>", "end of line" },

      -- navigate within insert mode
      ["<C-h>"] = { "<Left>", "move left" },
      ["<C-l>"] = { "<Right>", "move right" },
      ["<C-j>"] = { "<Down>", "move down" },
      ["<C-k>"] = { "<Up>", "move up" },
    },

    n = {
      ["<Esc>"] = { ":noh <CR>", "clear highlights" },
      -- switch between windows
      ["<C-h>"] = { "<C-w>h", "window left" },
      ["<C-l>"] = { "<C-w>l", "window right" },
      ["<C-j>"] = { "<C-w>j", "window down" },
      ["<C-k>"] = { "<C-w>k", "window up" },

      -- save
      ["<C-s>"] = { "<cmd> w <CR>", "save file" },

      -- Copy all
      ["<C-c>"] = { "<cmd> %y+ <CR>", "copy whole file" },

      -- line numbers
      ["<leader>n"] = { "<cmd> set nu! <CR>", "toggle line number" },
      ["<leader>rn"] = { "<cmd> set rnu! <CR>", "toggle relative number" },

      -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
      -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
      -- empty mode is same as using <cmd> :map
      -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
      ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "move down", opts = { expr = true } },
      ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "move up", opts = { expr = true } },
      ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "move up", opts = { expr = true } },
      ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "move down", opts = { expr = true } },

      -- buffer
      ["<S-h>"] = { ":bprevious<CR>", "previous buffer", { noremap = true, silent = true } },
      ["<S-l>"] = { ":bnext<CR>", "next buffer", { noremap = true, silent = true } },
      ["<leader>x"] = { ":bd<CR>", "delete buffer", { noremap = true, silent = true } },
      ["<leader>er"] = { "<Plug>RestNvim", "execute request" },
      ["<leader>ep"] = { "<Plug>RestNvimPreview", "preview curl" },
    },

    t = {
      ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "escape terminal mode" },
    },

    v = {
      ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "move up", opts = { expr = true } },
      ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "move down", opts = { expr = true } },
    },

    x = {
      ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "move down", opts = { expr = true } },
      ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "move up", opts = { expr = true } },
      -- Don't copy the replaced text after pasting in visual mode
      -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
      ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "dont copy replaced text", opts = { silent = true } },
    },
  },
}

M.undo = {
  n = {
    ["<leader>tu"] = { ":UndotreeToggle<CR>", desc = "[t]oggle [u]ndotree" },
  },
}

M.illuminate = {
  n = {
    ["]]"] = {
      function()
        require("illuminate").goto_next_reference(true)
      end,
      "goto next reference",
    },
    ["[["] = {
      function()
        require("illuminate").goto_prev_reference(true)
      end,
      "goto prev reference",
    },
  },
}

M.comment = {
  -- toggle comment in both modes
  n = {
    ["gcc"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "toggle comment",
    },
  },

  v = {
    ["gcc"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "toggle comment",
    },
  },
}

M.lspconfig = {
  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

  n = {
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "lsp declaration",
    },

    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "lsp definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "lsp hover",
    },

    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "lsp implementation",
    },

    ["<leader>s"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "lsp signature_help",
    },

    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "lsp definition type",
    },

    ["<leader>ra"] = {
      vim.lsp.buf.rename,
      "lsp rename",
    },

    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "lsp code_action",
    },

    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "lsp references",
    },

    ["<leader>e"] = {
      function()
        vim.diagnostic.open_float({ border = "rounded" })
      end,
      "floating diagnostic",
    },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev()
      end,
      "goto prev",
    },

    ["]d"] = {
      function()
        vim.diagnostic.goto_next()
      end,
      "goto_next",
    },

    ["<leader>q"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "diagnostic setloclist",
    },

    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format({ async = true })
      end,
      "lsp formatting",
    },

    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "add workspace folder",
    },

    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "remove workspace folder",
    },

    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "list workspace folders",
    },
  },
}

M.neotree = {
  n = {
    -- toggle
    ["<leader>l"] = { "<cmd>Neotree toggle<cr>", "reveal in filestree", { silent = true } },
  },
}

M.telescope = {
  n = {
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "find files" },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "find all" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "find oldfiles" },
    ["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "find in current buffer" },

    -- git
    ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "telescope git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "git status" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "pick hidden term" },
  },
}

M.whichkey = {
  n = {
    ["<leader>wK"] = {
      function()
        vim.cmd("WhichKey")
      end,
      "which-key all keymaps",
    },
    ["<leader>wk"] = {
      function()
        local input = vim.fn.input("WhichKey: ")
        vim.cmd("WhichKey " .. input)
      end,
      "which-key query lookup",
    },
  },
}

M.blankline = {
  n = {
    ["<leader>cc"] = {
      function()
        local ok, start = require("indent_blankline.utils").get_current_context(
          vim.g.indent_blankline_context_patterns,
          vim.g.indent_blankline_use_treesitter_scope
        )

        if ok then
          vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
          vim.cmd([[normal! _]])
        end
      end,

      "Jump to current_context",
    },
  },
}

M.gitsigns = {
  n = {
    -- Navigation through hunks
    ["]c"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },

    ["[c"] = {
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to prev hunk",
      opts = { expr = true },
    },

    -- Actions
    ["<leader>hr"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },
    ["<leader>hs"] = {
      function()
        require("gitsigns").stage_hunk()
      end,
      "Stage hunk",
    },
    ["<leader>hu"] = {
      function()
        require("gitsigns").undo_stage_hunk()
      end,
      "undo stage hunk",
    },

    ["<leader>ph"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },

    ["<leader>gb"] = {
      function()
        package.loaded.gitsigns.blame_line()
      end,
      "Blame line",
    },

    ["<leader>td"] = {
      function()
        require("gitsigns").toggle_deleted()
      end,
      "Toggle deleted",
    },
  },
  v = {
    ["<leader>hr"] = {
      function()
        require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end,
      "Reset hunk",
    },
    ["<leader>hs"] = {
      function()
        require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end,
      "Stage hunk",
    },
  },
}

M.dap = {
  n = {
    ["<leader>db"] = {
      "<cmd>DapToggleBreakpoint<CR>",
      "Toggle breakpint",
    },
    ["<leader>dus"] = {
      function()
        local widgets = require("dap.ui.widgets")
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      "Open debugging sidebar",
    },
    ["<F5>"] = {
      function()
        require("dap").continue()
      end,
      "debug continue",
    },
    ["<F1>"] = {
      function()
        require("dap").step_into()
      end,
      "debug step_into",
    },
    ["<F2>"] = {
      function()
        require("dap").step_over()
      end,
      "debug step_over",
    },
    ["<F3>"] = {
      function()
        require("dap").step_out()
      end,
      "debug step_out",
    },
  },
}

M.dap_go = {
  n = {
    ["<leader>dgt"] = {
      function()
        require("dap-go").debug_test()
      end,
      "Debug go test",
    },
    ["<leader>dgl"] = {
      function()
        require("dap-go").debug_last_test()
      end,
      "Debug last go test",
    },
  },
}
return M
