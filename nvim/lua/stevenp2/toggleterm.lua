local toggleterm_status_ok, toggleterm = pcall(require, "toggleterm")

if not toggleterm_status_ok then
  return
end

toggleterm.setup({
  --[[ size = 160, ]]
  direction = "float",
  autoscroll = true, -- automatically scroll to the bottom on terminal output
  float_opts = {
    border = "curved",
    width = math.ceil(vim.o.columns * 0.9) - 1,
    height = math.ceil(vim.o.lines * 0.9),
    winblend = 3
  }
})
