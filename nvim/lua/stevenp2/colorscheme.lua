-- local colorscheme = "default"
local colorscheme = "tokyonight"
local style = "night"

vim.g.tokyonight_style = style
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end


