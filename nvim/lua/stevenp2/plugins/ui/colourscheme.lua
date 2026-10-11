local M = {}

function M.setup()
  require("tokyonight").setup({
    style = "storm",
    terminal_colors = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      sidebars = "dark",
      floats = "dark",
    },
    sidebars = { "qf", "help" },
  })

  vim.cmd.colorscheme("tokyonight")
end

return M
