local glow_status_ok, glow = pcall(require, "glow")
if not glow_status_ok then
  return
end

glow.setup({
  --[[ glow_path = "", -- filled automatically with your glow bin in $PATH, ]]
  glow_install_path = "~/.local/bin", -- default path for installing glow binary
  border = "shadow", -- floating window border config
  style = "dark", -- filled automatically with your current editor background, you can override using glow json style
  pager = true,
  width = 400,
})
