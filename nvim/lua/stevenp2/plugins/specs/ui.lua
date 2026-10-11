local ui = require("stevenp2.config").ui

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("stevenp2.plugins.ui.colourscheme").setup()
    end,
  },
  {
    "goolord/alpha-nvim",
    enabled = ui.dashboard,
    event = "VimEnter",
    cond = function()
      return vim.fn.argc() == 0
    end,
    config = function()
      require("stevenp2.plugins.ui.dashboard").setup()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("stevenp2.plugins.ui.gitsigns").setup()
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    enabled = ui.statusline,
    event = "VeryLazy",
    config = function()
      require("stevenp2.plugins.ui.statusline").setup()
    end,
  },
  {
    "b0o/incline.nvim",
    enabled = ui.window_titles,
    event = "VeryLazy",
    config = function()
      require("stevenp2.plugins.ui.incline").setup()
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = ui.indent_guides,
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("stevenp2.plugins.ui.indent").setup()
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    enabled = ui.scrollbar,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "lewis6991/gitsigns.nvim" },
    config = function()
      require("stevenp2.plugins.ui.scrollbar").setup()
    end,
  },
}
