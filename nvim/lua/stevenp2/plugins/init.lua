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

-- lazy config
local lazy_config = {
  root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
  defaults = {
    lazy = false, -- should plugins be lazy-loaded?
  },
  git = {
    log = { "--since=3 days ago" }, -- show commits from the last 3 days
    timeout = 120, -- kill processes that take more than 2 minutes
    url_format = "https://github.com/%s.git",
    filter = true,
  },
  install = {
    missing = true,
    colorscheme = { "tokyonight" },
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[]
      paths = {}, -- add any custom paths here that you want to includes in the rtp
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zip",
        "zipPlugin",
        "tar",
        "tarPlugin",
        "vimball",
        "vimballPlugin",
        "logipat",
        "spellfile_plugin",
      },
    },
  },

}

-- Install your plugins here
return lazy.setup({
  -------------------------------
  -- colourscheme
  -------------------------------
  { "folke/tokyonight.nvim",
    priority = 1000,
    dependencies = {
      "petertriho/nvim-scrollbar",
      "nvim-lualine/lualine.nvim",
    },
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
    cmd = "Telescope",
    dependencies = {
      {
        "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
        "nvim-telescope/telescope-media-files.nvim", -- view media in telescope
      } -- Useful lua functions used ny lots of plugins
    },
  }, -- a fuzzy finder

  { "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    dependencies = {
      "nvim-telescope/telescope.nvim"
    }
  }, -- running lazygit in nvim

  { "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
    config = function() require("stevenp2.plugins.utils.toggleterm").setup() end
  }, -- toggle terminal

  { "axieax/urlview.nvim",
    cmd = "UrlView",
    config = function() require("stevenp2.plugins.utils.urlview").setup() end
  },-- urlview - a special plugin that gets to take up a lot of space

  { "kyazdani42/nvim-tree.lua",
    cmd = "NvimTreeToggle",
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
    config = function() require("stevenp2.plugins.ui.alpha").setup() end
  }, -- greeter for nvim

  { "lewis6991/gitsigns.nvim",
    config = function() require("stevenp2.plugins.ui.gitsigns").setup() end
  }, -- signs to keep track of file edits for git

  { "akinsho/bufferline.nvim",
    config = function() require("stevenp2.plugins.ui.bufferline").setup() end
  }, --stevenp2.plugins.ui.lualine

  { "petertriho/nvim-scrollbar",
    config = function() require("stevenp2.plugins.ui.scrollbar").setup() end
  }, -- scrollbar

  { "karb94/neoscroll.nvim",
    event = "VeryLazy",
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
    event = "VeryLazy",
    config = function() require("stevenp2.plugins.ui.dressing").setup() end
  }, -- wrapper around vim calls

  ----------------------------------
  -- lsp
  ----------------------------------
  { "neovim/nvim-lspconfig",
    config = function()
      require("stevenp2.plugins.lsp.lspconfig").setup()
    end
  }, -- enable lsp

  { "williamboman/mason.nvim",
    cmd = "Mason",
    config = true
  }, -- simple lsp installer

  { "folke/trouble.nvim",
    lazy = true,
    cmd = "TroubleToggle",
    config = function() require("stevenp2.plugins.lsp.trouble").setup() end
  },

  -- cmp
  { "hrsh7th/nvim-cmp",
    lazy = true,
    event = "InsertEnter",
    dependencies = {
      "windwp/nvim-autopairs",
      "hrsh7th/cmp-buffer", -- buffer completions
      "hrsh7th/cmp-path", -- path completions
      "hrsh7th/cmp-cmdline", -- cmdline completions
      "hrsh7th/cmp-nvim-lsp", -- lsp completions
      "hrsh7th/cmp-nvim-lua"  -- lua completions
    },
    config = function() require("stevenp2.plugins.lsp.cmp").setup() end
  },


  -- snippets
  { "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = {
      "saadparwaiz1/cmp_luasnip", -- lua snippets
      "rafamadriz/friendly-snippets", -- a bunch of snippets to use
    }
  }, --snippet engine


  -------------------------------
  -- Languages
  -------------------------------

  -- Latex
  { "lervag/vimtex",
    ft = { "tex", "bib", },
  },

  -- Rust
  { "simrat39/rust-tools.nvim",
    dependencies = {
      "neovim/nvim-lspconfig"
    }
    ft = { "rs" },
  },

  -------------------------------
  -- Treesitter
  -------------------------------
  { "nvim-treesitter/nvim-treesitter",
    config = function() require("stevenp2.plugins.treesitter.treesitter").setup() end
  },

  "JoosepAlviste/nvim-ts-context-commentstring", -- comment string based on context

  -- autopairs
  { "windwp/nvim-autopairs",
    config = function() require("stevenp2.plugins.treesitter.autopairs").setup() end
  }, -- autopairing of parens, braces, etc.
    dependencies = {
      "kevinhwang91/nvim-ufo"
    },
    config = function() require("stevenp2.plugins.treesitter.treesitter").setup() end
  },

  { "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true
  }, -- comment string based on context

  { "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function() require("stevenp2.plugins.treesitter.autopairs").setup() end
  }, -- autopairing of parens, braces, etc.

  { 'kevinhwang91/nvim-ufo',
    keys = { "zc", "zo", "zR", "zM" },
    dependencies = 'kevinhwang91/promise-async',
    event = "InsertEnter",
    config = function() require("stevenp2.plugins.treesitter.ufo").setup() end
  }, -- folding
  -------------------------------
  -- others
  -------------------------------
  { "kyazdani42/nvim-web-devicons",
    dependencies = {
      "goolord/alpha-nvim",
    }
  }, -- icons used in plugins

  "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
  "moll/vim-bbye", -- allow for deletion of buffer
  "MunifTanjim/nui.nvim", -- UI component library for neovim

}, lazy_config)
