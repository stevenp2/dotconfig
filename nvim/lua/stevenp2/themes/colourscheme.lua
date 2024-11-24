local M = {}

function M.setup()
  require("tokyonight").setup({
    style = "storm", -- night|storm|moon|day
    terminal_colors = true,
    styles = {
    comments = {
      italic = true
    },
    keywords = {
      italic = true
    },
    functions = {},
    variables = {},
    sidebars = "dark",
    floats = "dark",
    },
    sidebars = { "qf", "help" },
    day_brightness = 0.3,
    hide_inactive_statusline = false,
    dim_inactive = false,
    lualine_bold = false,
    on_colors = function(colors) end,
    on_highlights = function(highlights, colors) end,
  })
 
  local colourscheme = "tokyonight"
  vim.cmd("colorscheme " .. colourscheme)
  -- vim.cmd("highlight Normal guibg=none")
  vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
      local highlights = {
        'Normal',
        'LineNr',
        'Folded',
        'NonText',
        'SpecialKey',
        'VertSplit',
        'SignColumn',
        'EndOfBuffer',
        'TablineFill',
      }
      for _, name in pairs(highlights) do vim.cmd.highlight(name .. ' guibg=none ctermbg=none') end
  end,
  })
end

return M
