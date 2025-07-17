local M = {}

function M.setup()
  local opts = { script = true, expr = true, silent = true }
  vim.keymap.set("i", "<c-a>", "copilot#Accept()", opts)
  vim.keymap.set("i", "<c-x>", "copilot#Dismiss()", opts)
  vim.keymap.set("i", "<c-[>", "copilot#Previous()", opts)
  vim.keymap.set("i", "<c-]>", "copilot#Next()", opts)
  -- vim.keymap.set("i", "<a-\\>", "<Cmd>Copilot panel<CR>")

  vim.g.copilot_no_tab_map = true
end

vim.g.copilot_enabled = true

return M
