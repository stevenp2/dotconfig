local M = {}

function M.setup()
  local colours = require("tokyonight.colors").setup()

  require("scrollbar").setup({
    handle = {
      color = colours.bg_highlight,
      hide_if_all_visible = true,
    },
    marks = {
      Search = { color = colours.orange },
      Error = { color = colours.error },
      Warn = { color = colours.warning },
      Info = { color = colours.info },
      Hint = { color = colours.hint },
      Misc = { color = colours.purple },
    },
    excluded_buftypes = { "terminal" },
    excluded_filetypes = { "alpha", "prompt", "TelescopePrompt", "oil" },
    handlers = {
      cursor = true,
      diagnostic = true,
      gitsigns = true,
      handle = true,
      search = false,
    },
  })
end

return M
