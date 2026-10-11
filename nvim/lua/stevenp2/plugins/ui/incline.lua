local M = {}

function M.setup()
  require("incline").setup({
    hide = { only_win = true },
    window = {
      margin = { horizontal = 1, vertical = 1 },
      padding = 1,
      placement = { horizontal = "right", vertical = "top" },
    },
    render = function(props)
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
      if filename == "" then
        filename = "[No Name]"
      end

      return {
        { filename, gui = vim.bo[props.buf].modified and "bold,italic" or "bold" },
        vim.bo[props.buf].modified and { " ●", group = "DiagnosticWarn" } or "",
      }
    end,
  })
end

return M
