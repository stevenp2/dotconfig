local M = {}

function M.setup()
  local status_indent_ok, indent_ok = pcall(require, "ibl")
  
  if not status_indent_ok then
    return
  end

  vim.opt.list = true
  vim.opt.listchars:append "space:⋅"

  indent_ok.setup({
    whitespace = {
      remove_blankline_trail = false
    },
    scope = {
      enabled = true,
      show_start = true,
      show_end = true,
    }
  })
end

return M
