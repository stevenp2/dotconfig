local M = {}

function M.setup()
  require("tokyonight").setup({
    style = "moon", -- night|storm|moon|day
    transparent = false,
    terminal_colors = true,
    styles = {
      comments = "italic",
      keywords = "italic",
      functions = "NONE",
      variables = "NONE",
      sidebars = "dark",
      floats = "dark",
    },
    sidebars = { "qf", "help" },
    day_brightness = 0.3,
    hide_inactive_statusline = false,
    dim_inactive = false,
    lualine_bold = false,
    on_colors = function(colors) end,
    on_highlights = function(highlights, colors) end,
  })

  local colourscheme = "tokyonight"
  vim.cmd("colorscheme " .. colourscheme)
end

return M
