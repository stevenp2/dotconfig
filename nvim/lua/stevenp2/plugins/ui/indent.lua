local M = {}

function M.setup()
  require("ibl").setup({
    indent = { char = "│" },
    whitespace = { remove_blankline_trail = false },
    scope = {
      enabled = true,
      show_start = true,
      show_end = false,
    },
    exclude = {
      filetypes = { "alpha", "help", "lazy", "mason", "oil", "terminal", "trouble" },
      buftypes = { "nofile", "prompt", "quickfix", "terminal" },
    },
  })
end

return M
