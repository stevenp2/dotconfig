require("stevenp2.plugins.treesitter")
require("stevenp2.plugins.utils")
require("stevenp2.plugins.ui")
require("stevenp2.plugins.lsp")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

-- Install your plugins here
return lazy.setup({
  -- ColourSchemes
  { "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      require("stevenp2.themes.colourscheme").setup()
    end
  },

  -------------------------------
  -- utils
  -------------------------------
  { "numtoStr/Comment.nvim",
    config = function() require("stevenp2.plugins.utils.comment").setup() end
  }, -- comment things easily

  { "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" } -- Useful lua functions used ny lots of plugins
    },
  }, -- a fuzzy finder

  { "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim"
    }
  }, -- running lazygit in nvim

  { "nvim-telescope/telescope-media-files.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim"
    }
  }, -- view media in telescope

  { "akinsho/toggleterm.nvim",
    version = "*",
    config = function() require("stevenp2.plugins.utils.toggleterm").setup() end
  }, -- toggle terminal

  { "axieax/urlview.nvim",
    config = function() require("stevenp2.plugins.utils.urlview").setup() end
  },-- urlview - a special plugin that gets to take up a lot of space

  { "kyazdani42/nvim-tree.lua",
    config = function() require("stevenp2.plugins.utils.nvim-tree").setup() end
  }, -- file explorer

  -- TODO
  --[[ {"folke/which-key.nvim", ]]
  --[[   config = function() require("stevenp2.plugins.utils.which-key").setup() end ]]
  --[[ }, -- viewing keymap ]]

  -------------------------------
  -- ui
  -------------------------------
  { "goolord/alpha-nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function() require("stevenp2.plugins.ui.alpha").setup() end
  }, -- greeter for nvim

  { "lewis6991/gitsigns.nvim",
    config = function() require("stevenp2.plugins.ui.gitsigns").setup() end
  }, -- signs to keep track of file edits for git

  { "akinsho/bufferline.nvim",
    config = function() require("stevenp2.plugins.ui.bufferline").setup() end
  }, --stevenp2.plugins.ui.lualine

  { "petertriho/nvim-scrollbar",
    dependencies = "folke/tokyonight.nvim",
    config = function() require("stevenp2.plugins.ui.scrollbar").setup() end
  }, -- scrollbar

  { "karb94/neoscroll.nvim",
    config = function() require("stevenp2.plugins.ui.neoscroll").setup() end
  }, -- smoother scrolling experience

  { "b0o/incline.nvim",
    config = function() require("stevenp2.plugins.ui.incline").setup() end
  }, -- buffer management with multiple splits

  { "nvim-lualine/lualine.nvim",
    config = function() require("stevenp2.plugins.ui.lualine").setup() end
  }, -- for status line at bottom

  { "lukas-reineke/indent-blankline.nvim",
    config = function() require("stevenp2.plugins.ui.indent-blankline").setup() end
  }, -- view degree of indentation

  { "stevearc/dressing.nvim",
    dependencies = "smjonas/inc-rename.nvim",
    config = function() require("stevenp2.plugins.ui.dressing").setup() end
  }, -- wrapper around vim calls

  ----------------------------------
  -- lsp
  ----------------------------------
  { "neovim/nvim-lspconfig",
    dependencies = { "williamboman/nvim-lsp-installer" }, -- simple lsp installer
    priority = 1000,
    config = function()
      require("stevenp2.plugins.lsp.lspconfig").setup()
    end
  }, -- enable lsp

  { "folke/trouble.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function() require("stevenp2.plugins.lsp.trouble").setup() end
  },

  -- cmp
  {"hrsh7th/nvim-cmp",
    config = function() require("stevenp2.plugins.lsp.cmp").setup() end
  },
  "hrsh7th/cmp-buffer", -- buffer completions
  "hrsh7th/cmp-path", -- path completions
  "hrsh7th/cmp-cmdline", -- cmdline completions
  "saadparwaiz1/cmp_luasnip", -- snippet completions
  "hrsh7th/cmp-nvim-lsp", -- lsp completiona
  "hrsh7th/cmp-nvim-lua", -- lua completiona

  -- snippets
  "L3MON4D3/LuaSnip", --snippet engine
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use

  -------------------------------
  -- Languages
  -------------------------------

  -- Latex
  { "lervag/vimtex",
    ft = { "tex", "bib", },
    dependencies = {
      "neovim/nvim-lspconfig"
    }
  },

  -- Rust
  {"simrat39/rust-tools.nvim",
    dependencies = {
      "neovim/nvim-lspconfig"
    }
  },

  -------------------------------
  -- Treesitter
  -------------------------------
  {"nvim-treesitter/nvim-treesitter",
    config = function() require("stevenp2.plugins.treesitter.treesitter").setup() end
  },
  "JoosepAlviste/nvim-ts-context-commentstring", -- comment string based on context

  -- autopairs
  {"windwp/nvim-autopairs",
    config = function() require("stevenp2.plugins.treesitter.autopairs").setup() end
  }, -- autopairing of parens, braces, etc.


  -------------------------------
  -- others
  -------------------------------
  "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
  "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
  "kyazdani42/nvim-web-devicons", -- icons used in plugins
  "moll/vim-bbye", -- allow for deletion of buffer
  "MunifTanjim/nui.nvim", -- UI component library for neovim

})
