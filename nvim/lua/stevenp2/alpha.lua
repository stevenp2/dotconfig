-- stolen from https://github.com/axieax/dotconfig/blob/main/nvim/lua/axie/plugins/start.lua
-- edited after stealing

local alpha_status_ok, alpha = pcall(require, "alpha")

if not alpha_status_ok then
  return
end

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
  dashboard.button("f", "  Find Files", "<Cmd>Telescope find_files<CR>"),
  dashboard.button("g", "  Live Grep", "<Cmd>Telescope live_grep<CR>"),
  dashboard.button("r", "  Recent Files", "<Cmd>Telescope oldfiles<CR>"), -- TODO: use frecency
  --[[ dashboard.button("s", "  Restore Session", "<Cmd>SessionManager load_last_session<CR>"), ]]
  --[[ dashboard.button("S", "  Find Sessions", "<Cmd>SessionManager load_session<CR>"), ]]
  dashboard.button("c", "﫸 Neovim Config", "<Cmd>e ~/.config/nvim/lua/stevenp2/plugins.lua<CR>"),
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
