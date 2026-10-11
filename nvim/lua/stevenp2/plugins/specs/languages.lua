local config = require("stevenp2.config")

return {
  {
    "neovim/nvim-lspconfig",
    -- oil also emits BufReadPre, so load on filetype instead
    init = function()
      local group = vim.api.nvim_create_augroup("stevenp2-language-tools", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        callback = function(event)
          local bo = vim.bo[event.buf]
          if bo.buftype == "" and bo.filetype ~= "" and bo.filetype ~= "oil" then
            require("lazy").load({ plugins = { "nvim-lspconfig" } })
            vim.api.nvim_clear_autocmds({ group = group })
          end
        end,
      })
    end,
    config = function()
      require("stevenp2.plugins.lsp").setup()
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall" },
    opts = {},
  },
  {
    "L3MON4D3/LuaSnip",
    enabled = config.snippets.enabled,
    event = "InsertEnter",
    config = function()
      require("stevenp2.plugins.snippets").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = function()
      if vim.fn.executable("tree-sitter") == 1 then
        vim.cmd.TSUpdate()
      else
        vim.notify("Parser update skipped: install tree-sitter-cli 0.26.1+, then run :TSUpdate", vim.log.levels.WARN)
      end
    end,
    config = function()
      require("stevenp2.plugins.treesitter").setup_installer()
    end,
  },
  {
    "lervag/vimtex",
    ft = { "tex", "bib" },
    init = function()
      vim.g.vimtex_compiler_enabled = vim.fn.executable("latexmk")
      vim.g.vimtex_imaps_enabled = 0
      vim.g.vimtex_view_automatic = 0
      vim.g.vimtex_syntax_conceal_disable = 1
      vim.g.vimtex_fold_enabled = 1
      vim.g.vimtex_quickfix_ignore_filters = {
        [[Overfull \\\\hbox ([0-9]*.[0-9]*pt too wide) in paragraph at lines]],
      }

      if vim.fn.has("mac") == 1 then
        vim.g.vimtex_view_method = "general"
        vim.g.vimtex_view_general_viewer = "/Applications/Skim.app/Contents/SharedSupport/displayline"
        vim.g.vimtex_view_general_options = "-r @line @pdf @tex"
      else
        vim.g.vimtex_view_method = "zathura"
      end
    end,
  },
}
