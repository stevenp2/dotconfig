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
  -- My plugins here
  "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
  "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
  "numtoStr/Comment.nvim", -- comment things easily
  "lewis6991/gitsigns.nvim", -- signs to keep track of file edits for git
  "kyazdani42/nvim-web-devicons", -- icons used in plugins
  "kyazdani42/nvim-tree.lua", -- file explorer
  "akinsho/bufferline.nvim", -- buffer tabs for nvim
  "moll/vim-bbye", -- allow for deletion of buffer
  "nvim-lualine/lualine.nvim", -- for status line at bottom
  "stevearc/dressing.nvim", -- wrapper around vim calls
  "b0o/incline.nvim", -- buffer management with multiple splits
  "petertriho/nvim-scrollbar", -- scrollbar
  "lukas-reineke/indent-blankline.nvim", -- view degree of indentation
  "karb94/neoscroll.nvim", -- smoother scrolling experience
  "MunifTanjim/nui.nvim", -- UI component library for neovim
  { "goolord/alpha-nvim", dependencies = { "kyazdani42/nvim-web-devicons" }, lazy=false }, -- greeter for nvim
    "ellisonleao/glow.nvim", -- md viewer
  { "akinsho/toggleterm.nvim", version = "*"}, -- toggle terminal ]]
  -- TODO [[ "folke/which-key.nvim", -- viewing keymap ]]

  -- ColourSchemes
  { "folke/tokyonight.nvim", lazy=false}, -- Colourscheme plugin

  -- cmp plugins
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-buffer", -- buffer completions
  "hrsh7th/cmp-path", -- path completions
  "hrsh7th/cmp-cmdline", -- cmdline completions
  "saadparwaiz1/cmp_luasnip", -- snippet completions
  "hrsh7th/cmp-nvim-lsp", -- lsp completiona
  "hrsh7th/cmp-nvim-lua", -- lua completiona

  -- snippets
  "L3MON4D3/LuaSnip", --snippet engine
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use

  -- urlview - a special plugin that gets to take up a lot of space
  "axieax/urlview.nvim",

  -- lsp
  "neovim/nvim-lspconfig", -- enable lsp
  "williamboman/nvim-lsp-installer", -- simple lsp installer
  { "folke/trouble.nvim", dependencies = { "kyazdani42/nvim-web-devicons" } }, -- lsp diagnostics
  { "cseickel/diagnostic-window.nvim", dependencies = { "MunifTanjim/nui.nvim" }}, -- diagnostic window popup

  -- Telescope
  {
    "nvim-telescope/telescope.nvim", -- fuzzy finder
    dependencies = {
      { "kdheepak/lazygit.nvim" }, -- running lazygit in nvim
      { "nvim-lua/plenary.nvim" } -- Useful lua functions used ny lots of plugins
    },
  },
  "nvim-telescope/telescope-media-files.nvim", -- view media in telescope

  -- Treesitter
  "nvim-treesitter/nvim-treesitter",
  "JoosepAlviste/nvim-ts-context-commentstring", -- comment string based on context

  -- autopairs
  "windwp/nvim-autopairs", -- autopairing of parens, braces, etc.

  -- Latex
  { "lervag/vimtex", ft = { "tex", "bib", } },

  -- rust
  "simrat39/rust-tools.nvim",

})
