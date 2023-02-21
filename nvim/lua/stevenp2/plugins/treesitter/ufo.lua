local M = {}

vim.o.foldcolumn = '1'
vim.o.foldlevel = 99 -- hack way of doing it
vim.o.foldlevelstart = 99
vim.o.foldenable = true

function M.handler(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = ('  %d '):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, {chunkText, hlGroup})
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
          suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, {suffix, 'MoreMsg'})
  return newVirtText
end

function M.setup()
  local ufo_status_ok, ufo = pcall(require, "ufo")

  if not ufo_status_ok then
    return
  end

  ufo.setup({
    fold_virt_text_handler = M.handler,
    provider_selector = function(bufnr, filetype, buftype)
      return {'treesitter', 'indent'}
    end
  })

end

return M
