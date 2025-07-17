local M = {}

function M.setup()
  local treesitter_status_ok, treesitter = pcall(require, "nvim-treesitter.configs")

  if not treesitter_status_ok then
    print("treesitter not ok")
    return
  end

  treesitter.setup({
    ensure_installed = "all",
    ignore_install = {
      "latex",
      "ipkg"
    },
    highlight = {
      enable = true,
      disable = {
        "latex",
        "cpp"
      },
      additional_vim_regex_highlighting = true,
    },
    enable_autocmd = false,
    indent = {
      enable = true,
      disable = {
        "yaml",
        "latex"
      }
    },
  })
  -- local configs = require("ts_context_commentstring")

end

return M
