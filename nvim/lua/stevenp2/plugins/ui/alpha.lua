local M = {}

function M.setup()
  local alpha_status_ok, alpha = pcall(require, "alpha")
  if not alpha_status_ok then
    return
  end
  
  local dashboard = require("alpha.themes.dashboard")
  dashboard.section.header.val = {
  
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
  
  dashboard.section.buttons.val = {
    dashboard.button("n", "  New File", "<Cmd>ene <BAR> startinsert<CR>"),
    dashboard.button("f", "  Find Files", "<Cmd>Telescope find_files<CR>"),
    dashboard.button("g", "  Live Grep", "<Cmd>Telescope live_grep<CR>"),
    dashboard.button("r", "  Recent Files", "<Cmd>Telescope oldfiles<CR>"), -- TODO: use frecency
    dashboard.button("c", "﫸 Neovim Config", "<Cmd>e ~/.config/nvim/lua/stevenp2/plugins/init.lua<CR>"),
    dashboard.button("u", "  Update Plugins", "<Cmd>PackerSync<CR>"),
    dashboard.button("q", "⏻  Quit Neovim", "<Cmd>qa<CR>"),
  }
  require("alpha").setup(dashboard.config)
  
  vim.api.nvim_create_autocmd("FileType", {
    desc = "Disable alpha colorcolumn, show alpha in bufferline",
    pattern = "alpha",
    callback = function()
      vim.bo.buflisted = true
      vim.wo.colorcolumn = ""
    end,
  })
  
  alpha.setup(dashboard.config)
  
  end

return M
