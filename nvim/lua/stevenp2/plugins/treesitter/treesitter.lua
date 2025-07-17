local M = {}

function M.setup()
  local treesitter_statis_ok, _ = pcall(require, "nvim-treesitter")

  if not treesitter_statis_ok then
    return
  end

  local configs = require("nvim-treesitter.configs")
  configs.setup{
    ensure_installed = "all", -- one of 'all', 'maintained' (parsers with maintainers), or a list of languages
    sync_install = false,  -- install languages synchornously (only applied to 'ensure_installed')
    ignore_install = { "latex" }, -- List of parsers to ignore installing
    autopairs = {
      enable = true,
    },
    highlight = {
      enable = true, -- false will disable the whole extension
      disable = { "latex" }, -- list of language that will be disabled
      additional_vim_regex_highlighting = true,

    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    indent = { enable = true, disable = { "yaml", "latex" } },
  }

end

return M
