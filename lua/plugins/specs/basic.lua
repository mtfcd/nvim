return {
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    init = function()
      require("utils").lazy_load("indent-blankline.nvim")
    end,
    config = function()
      require("utils").load_mappings("blankline")
      require("ibl").setup()
    end,
  },
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("onedark").setup({
        style = "darker",
      })
      require("onedark").load()
    end,
  },
  {
    "mbbill/undotree",
    keys = "<leader>tu",
    cmd = "Undotreetoggle",
    init = function()
      vim.keymap.set("n", "<leader>tu", vim.cmd.undotreetoggle, { desc = "toggle [u]ndotree" })
    end,
    config = function()
      vim.g.undotree_splitwidth = 50
    end,
  },
  {
    -- set lualine as statusline
    "nvim-lualine/lualine.nvim",
    lazy = false,
    -- see `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = "onedark",
        component_separators = "|",
        section_separators = "",
      },
      sections = {
        lualine_c = {
          {
            "filename",
            path = 1,
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    cmd = { "Tsinstall", "Tsbufenable", "Tsbufdisable", "Tsmoduleinfo" },
    build = ":TSUpdate",
    init = function()
      require("utils").lazy_load("nvim-treesitter")
    end,
    opts = function()
      return require("plugins.configs.treesitter")
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    init = function()
      require("utils").load_mappings("telescope")
    end,
    opts = function()
      return require("plugins.configs.telescope")
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
    end,
  },
  {
    "numtostr/comment.nvim",
    keys = { "<leader>/", "gcc", "gbc" },
    init = function()
      require("utils").load_mappings("comment")
    end,
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      local opts = require("plugins.configs.rust-tools")
      require("rust-tools").setup(opts)
    end,
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("dap-go").setup()
      require("utils").load_mappings("dap_go")
    end,
  },
  {
    "akinsho/bufferline.nvim",
    version = "v3.*",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "bufadd",
    config = function()
      require("bufferline").setup()
    end,
  },
  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    config = function(_, opts)
      local crates = require("crates")
      crates.setup(opts)
      crates.show()
    end,
  },
  {
    "rrethy/vim-illuminate",
    event = { "bufreadpost", "bufnewfile" },
    config = function()
      require("utils").load_mappings("illuminate")
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("utils").load_mappings("dap")
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    init = function()
      local dap = require("dap")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        require("utils").lazy_load("nvim-dap-ui")
        require("dapui").setup()
        require("dapui").open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        require("dapui").close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        require("dapui").close()
      end
    end,
  },
  {
    "folke/which-key.nvim",
    keys = { "<leader>", '"', "'", "`", "c", "v" },
    init = function()
      require("utils").load_mappings("whichkey")
    end,
    config = function()
      require("which-key").setup()
    end,
  },
  {
    dir = "/Users/cc/codes/rest.nvim",
    ft = "http",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("rest-nvim").setup({
        result_split_horizontal = true,
        result = {
          show_curl_command = false,
          formatters = {
            html = "bat"
          }
        }
      })
    end
  }
}
