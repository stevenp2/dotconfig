local configs = require("nvim-treesitter.configs")
configs.setup {
  ensure_installed = "all", -- one of 'all', 'maintained' (parsers with amintainers), or a list of languages
  sync_install = false,  -- install languages synchornously (only applied to 'ensure_installed')
  ignore_install = { "" }, -- List of parsers to ignore installing
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,

  },
  indent = { enable = true, disable = { "yaml" } },
}
