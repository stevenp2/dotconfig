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
  use "lukas-reineke/indent-blankline.nvim" -- view degree of indentation
  use "karb94/neoscroll.nvim" -- smoother scrolling experience

  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    } -- greeter for nvim
  use "ellisonleao/glow.nvim"
  --[[ use "folke/which-key.nvim" -- viewing keymap ]]
  use { "akinsho/toggleterm.nvim", tag = "*"} -- toggle terminal

  -- ColourSchemes
  use "folke/tokyonight.nvim" -- Colourscheme plugin

  -- cmp plugins
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp" -- lsp completiona
  use "hrsh7th/cmp-nvim-lua" -- lua completiona
  --[[ use ("github/copilot.vim", "copilot") -- AI generated code ]]

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- urlview - a special plugin that gets to take up a lot of space
  use "axieax/urlview.nvim"

  -- lsp
  use "neovim/nvim-lspconfig" -- enable lsp
  use "williamboman/nvim-lsp-installer" -- simple lsp installer
  use "smjonas/inc-rename.nvim" -- lightweight renaming fn requires dressing.nvim
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
  })
  use "nvim-telescope/telescope-media-files.nvim" -- view media in telescope

  -- Treesitter
  use "nvim-treesitter/nvim-treesitter"
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
