return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("stevenp2.plugins.editor.telescope").setup()
    end,
  },
  {
    "stevearc/oil.nvim",
    lazy = false,
    config = function()
      require("stevenp2.plugins.editor.oil").setup()
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
  },
}
