local M = {}

function M.opts()

end

function M.setup()
  local toggleterm_status_ok, toggleterm = pcall(require, "toggleterm")
  
  if not toggleterm_status_ok then
    return
  end
  
  toggleterm.setup({
    size = function(term)
      if term.direction == "vertical" then
        return vim.o.columns * 0.4
      elseif term.direction == "horizontal" then
        return vim.o.lines * 0.4
      else
        return 20
      end
    end,
    float_opts = {
      border = "curved",
      width = math.ceil(vim.o.columns * 0.9),
      height = math.ceil(vim.o.lines * 0.9),
      winblend = 3
    },
  })
end

return M
