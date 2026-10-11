local M = {}

local header = {
  [[      ⣶⡶⠶ ⠶⢶⣶⠶⠆ ⣶⡶⠶⠶⠆ ⣶⡆ ⣶⡆ ⣶⡶⠶⠶⠆ ⣶⣆⣀ ⢰⣶ ⢰⣶⠶⢶⣶ ⠶⢶⣶      ]],
  [[      ⠉⢱⣶  ⢸⣿   ⣿⣷⣶   ⣿⡇ ⣿⡇ ⣿⣷⣶   ⣿⡏⠉⣶⣾⣿ ⢸⣿⣶⣾⣿ ⣶⡎⠉      ]],
  [[      ⠛⠛⠛  ⠘⠛   ⠛⠛⠛⠛⠃  ⠘⠛   ⠛⠛⠛⠛  ⠛⠃  ⠘⠛ ⠘⠛    ⠛⠛⠛      ]],
  [[⠀⠀⠀⠀        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠔⢀⡈⠉⠁⠢⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠚⠁⢠⠃⠀⢠⠒⠁⠈⢂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠄⠀⢠⠀⠀⠀  ⠀]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠔⠒⠲⣤⠠⠴⠮⠤⠤⣮⠁⠀⣀⣀⠀⢀⣀⣂⠀⠑⡀⠀⠀⠀⠀⠀⠀⡀⠤⡄⠀⠀⠀⠔⠁⠀⢀⠆⠀⠀⠀  ⠀]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠔⠁⠀⠀⠀⠛⣷⡄⠀⠀⢰⣿⠀⠀⠈⢻⡄⠀⠈⢻⣯⠒⠧⣀⠤⠤⠄⢐⡂⠀⠀⡇⢀⠔⠁⠀⠀⢠⠃⠀⠀⠀⠀  ⠀]],
  [[⠀⠀⠀⠀⠀⠀⠀⡠⠊⢠⢤⠀⠀⠀⠀⠀⠈⠃⠀⠀⣿⠋⠀⠀⠀⣼⠇⠀⠀⢠⣿⠀⠀⠀⠑⠢⡌⠀⠀⠀⠀⡇⠓⠢⡀⠀⠀⢣⠀⠀⠀⠀⠀  ⠀]],
  [[⠀⠀⠀⠀⢀⡠⠊⠀⠀⠈⠃⠀⠈⠑⣆⠀⠀⠀⠴⠞⠁⠀⠀⢀⣾⡏⠀⠀⠀⣸⡿⠀⠀⠀⠀⠀⠈⠁⠀⠒⠒⠊⠀⠀⠀⢢⠀⠀⠁⠢⡀⠀⠀  ⠀]],
  [[⠀⠀⠀⢠⡁⠀⠀⣀⣀⣀⡀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⣀⡿⠟⠀⠀⠀⣸⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠸⠠⠄⠀⠀⠈⣢⠀  ⠀]],
  [[⠀⠀⠀⠀⠈⠙⠓⡒⠠⠄⢈⠆⠀⢠⡟⠀⠀⠀⠀⠀⢀⣼⡿⠁⠀⠀⢠⡾⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡔⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠑⠄⣀⡀⠊⠁⠀⠀⠀⠀⠀⠴⠋⠁⠀⠀⠀⠀⠋⠀⠀⠀⠀⠀⠀⢀⣀⡀⠤⠄⠲⠌⠁⢀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠄⠉⠝⢠⠂⠀⡖⠲⡤⠤⠤⠤⠤⠀⠒⠒⠀⠀⠀⠉⠉⠉⠑⢄⠈⠠⡀⠀⠀⡔⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀]],
  [[⠀⠀⠀⠀⠀⠀⠀⢠⠄⠊⠁⠀⡠⠄⠃⠃⠐⢀⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⠠⠌⣀⡠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠁⠒⠂⠉⠀⠀⡠⠠⠄⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    ]],
  [[                                                        ]],
  [[           > Press [c] to go to your config <           ]],
}

local function buttons(dashboard)
  local config_file = vim.fn.fnameescape(vim.fn.stdpath("config") .. "/lua/stevenp2/config.lua")
  return {
    dashboard.button("n", "  New file", "<Cmd>ene <Bar> startinsert<CR>"),
    dashboard.button("f", "󰱼  Find files", "<Cmd>Telescope find_files<CR>"),
    dashboard.button("g", "󰺮  Find text", "<Cmd>Telescope live_grep<CR>"),
    dashboard.button("r", "  Recent files", "<Cmd>Telescope oldfiles<CR>"),
    dashboard.button("c", "  Configuration", "<Cmd>edit " .. config_file .. "<CR>"),
    dashboard.button("u", "󰚰  Update plugins", "<Cmd>Lazy sync<CR>"),
    dashboard.button("q", "󰩈  Quit", "<Cmd>qa<CR>"),
  }
end

function M.setup()
  local dashboard = require("alpha.themes.dashboard")

  dashboard.section.header.val = header
  dashboard.section.buttons.val = buttons(dashboard)
  dashboard.config.opts.noautocmd = true

  require("alpha").setup(dashboard.config)
end

return M
