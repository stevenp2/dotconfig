local M = {}

function M.setup()
  vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "InsertLeave", "TermClose" }, {
    group = vim.api.nvim_create_augroup("stevenp2-external-changes", { clear = true }),
    callback = function(event)
      if vim.api.nvim_get_mode().mode ~= "n" or vim.fn.getcmdwintype() ~= "" then
        return
      end
      -- avoid checking every buffer when entering oil
      local buffers = event.event == "BufEnter" and { event.buf } or vim.api.nvim_list_bufs()
      for _, bufnr in ipairs(buffers) do
        if vim.api.nvim_buf_is_loaded(bufnr)
          and vim.bo[bufnr].buftype == ""
          and not vim.bo[bufnr].modified
          and vim.api.nvim_buf_get_name(bufnr) ~= ""
          and not vim.api.nvim_buf_get_name(bufnr):match("^%a[%w+.-]*://")
        then
          vim.cmd.checktime({ args = { tostring(bufnr) } })
        end
      end
    end,
  })
end

return M
