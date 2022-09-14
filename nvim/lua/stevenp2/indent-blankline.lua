local status_indent_ok, indent_ok = pcall(require, "indent_blankline")

if not status_indent_ok then
  return
end

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
--[[ vim.opt.listchars:append "eol:↴" ]]

indent_ok.setup({
  show_end_of_line = true,
  space_char_blankline = " ",
  show_current_context_start = true,
  show_current_context = true,
})
