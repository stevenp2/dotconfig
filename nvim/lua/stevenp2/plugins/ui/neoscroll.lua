local M = {}

function M.setup()
  require("neoscroll").setup({
    mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zz" },
    hide_cursor = true,
    stop_eof = true,
    respect_scrolloff = false,
    cursor_scrolls_alone = true,
    duration_multiplier = 0.7,
    easing = "quadratic",
    performance_mode = false,
  })
end

return M
