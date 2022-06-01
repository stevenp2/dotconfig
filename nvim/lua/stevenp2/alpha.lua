-- stolen from https://github.com/axieax/dotconfig/blob/main/nvim/lua/axie/plugins/start.lua

return function()
  local dashboard = require("alpha.themes.dashboard")

  dashboard.section.header.val = {
    [[          __                                   ________  ]],
    [[  _______/  |_  _______  __ ____   ____ ______ \_____  \ ]],
    [[ /  ___/\   __\/ __ \  \/ // __ \ /    \\____ \ /  ____/ ]],
    [[ \___ \  |  | \  ___/\   /\  ___/|   |  \  |_> >       \ ]],
    [[/____  > |__|  \___  >\_/  \___  >___|  /   __/\_______ \]],
    [[     \/            \/          \/     \/|__|           \/]],
    [[                                                         ]],
    [[       > Press [s] to restore your last session <        ]],
  }

  dashboard.section.buttons.val = {
    dashboard.button("n", "  New File", "<Cmd>ene <BAR> startinsert<CR>"),
    dashboard.button("f", "  Find Files", "<Cmd>lua require'stevenp2.telescope'.file_search()<CR>"),
    dashboard.button("g", "  Live Grep", "<Cmd>Telescope live_grep<CR>"),
    dashboard.button("b", "  Bookmarks", "<Cmd>Telescope marks<CR>"),
    -- TODO: orgmode notes
    dashboard.button("o", "  Recent Files", "<Cmd>Telescope oldfiles<CR>"), -- TODO: use frecency
    dashboard.button("p", "  Find Projects", "<Cmd>Telescope projects<CR>"),
    dashboard.button("s", "  Restore Session", "<Cmd>SessionManager load_last_session<CR>"),
    dashboard.button("S", "  Find Sessions", "<Cmd>SessionManager load_session<CR>"),
    dashboard.button("c", "﫸 Neovim Config", "<Cmd>e ~/.config/nvim/lua/plugins/init.lua<CR>"),
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
end
