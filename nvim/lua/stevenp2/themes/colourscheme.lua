local colourscheme = "tokyonight"

local tokyo_status_ok, tokyonight = pcall(require, "tokyonight")

if not tokyo_status_ok then
  return
end

tokyonight.setup({
  style = "storm", -- night|storm|day
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

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colourscheme)

if not status_ok then
  vim.notify("colorscheme " .. colourscheme .. " not found!")
  return
end


