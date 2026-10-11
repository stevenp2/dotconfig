local M = {}

function M.setup()
  require("oil").setup({
    default_file_explorer = true,
    columns = { "icon" },
    watch_for_changes = true,
    buf_options = { autocomplete = false },
    view_options = {
      show_hidden = true,
      is_hidden_file = function(name)
        return vim.startswith(name, ".")
      end,
    },
    float = {
      padding = 2,
      border = "rounded",
      win_options = { winblend = 0 },
    },
    preview = {
      max_width = 0.9,
      min_width = { 70, 0.7 },
    },
  })
end

return M
