local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "numtoStr/Comment.nvim" -- comment things easily
  use "lewis6991/gitsigns.nvim" -- signs to keep track of file edits for git
  use "kyazdani42/nvim-web-devicons" -- icons used in plugins
  use "kyazdani42/nvim-tree.lua" -- file explorer
  use "akinsho/bufferline.nvim" -- buffer tabs for nvim
  use "moll/vim-bbye" -- allow for deletion of buffer
  use "nvim-lualine/lualine.nvim" -- for status line at bottom
  use "stevearc/dressing.nvim" -- wrapper around vim calls
  use "b0o/incline.nvim" -- buffer management with multiple splits
  use "petertriho/nvim-scrollbar" -- scrollbar
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = require("stevenp2.alpha")
    } -- greeter for nvim

  -- ColourSchemes
  use "folke/tokyonight.nvim" -- Colourscheme plugin

  -- cmp plugins
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp" -- lsp completiona

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- urlview - a special plugin that gets to take up a lot of space
  use {"axieax/urlview.nvim",
    config = function()
      require("urlview").setup({
        -- Prompt title (`<context> <default_title>`, e.g. `Buffer Links:`)
        default_title = "Links:",
        -- Default picker to display links with
        -- Options: "native" (vim.ui.select) or "telescope"
        default_picker = "native",
        -- Set the default protocol for us to prefix URLs with if they don't start with http/https
        default_prefix = "https://",
        -- Command or method to open links with
        -- Options: "netrw", "system" (default OS browser); or "firefox", "chromium" etc.
        navigate_method = "system",
        -- Ensure links shown in the picker are unique (no duplicates)
        unique = true,
        -- Ensure links shown in the picker are sorted alphabetically
        sorted = true,
        -- Logs user warnings (recommended for error detection)
        debug = true,
        -- Custom search captures
        -- NOTE: captures follow Lua pattern matching (https://riptutorial.com/lua/example/20315/lua-pattern-matching)
        custom_searches = {
          -- KEY: search source name
          -- VALUE: custom search function or table (map with keys capture, format)
          jira = {
            capture = "AXIE%-%d+",
            format = "https://jira.axieax.com/browse/%s",
          },
        },
      })
    end
  }

  -- lsp
  use "neovim/nvim-lspconfig" -- enable lsp
  use "williamboman/nvim-lsp-installer" -- simple lsp installer
  use "glepnir/lspsaga.nvim" -- lsp plugin that is lightweight
  -- lsp: diagnostics
  use {
    "folke/trouble.nvim",
    requires = {"kyazdani42/nvim-web-devicons"} 
  }
  use {
    "cseickel/diagnostic-window.nvim",
    requires = { "MunifTanjim/nui.nvim" }
  }


  -- prettier diagnostics

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim", -- fuzzy finder
    requires = {
      { "kdheepak/lazygit.nvim" }, -- running lazygit in nvim
      { "nvim-lua/plenary.nvim" } -- Useful lua functions used ny lots of plugins
    },
    config = function()
        require("telescope").load_extension("lazygit")
      end,
    })
  use "nvim-telescope/telescope-media-files.nvim" -- view media in telescope

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "JoosepAlviste/nvim-ts-context-commentstring" -- comment string based on context

  -- autopairs
  use "windwp/nvim-autopairs" -- autopairing of parens, braces, etc.

  -- Latex
  use({
    "lervag/vimtex",
    ft = {
      "tex",
      "bib",
    },
  })

  -- rust 
  use "simrat39/rust-tools.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
