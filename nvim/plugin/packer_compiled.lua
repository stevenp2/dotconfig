-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/steven/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/steven/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/steven/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/steven/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/steven/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numtoStr/Comment.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["alpha-nvim"] = {
    config = { "\27LJ\2\nL\0\0\2\0\6\0\t6\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\3\0'\1\5\0=\1\4\0K\0\1\0\5\16colorcolumn\awo\14buflisted\abo\bvim�\f\1\0\b\0003\1\\6\0\0\0'\2\1\0B\0\2\0029\1\2\0009\1\3\0015\2\5\0=\2\4\0019\1\2\0009\1\6\0014\2\f\0009\3\a\0'\5\b\0'\6\t\0'\a\n\0B\3\4\2>\3\1\0029\3\a\0'\5\v\0'\6\f\0'\a\r\0B\3\4\2>\3\2\0029\3\a\0'\5\14\0'\6\15\0'\a\16\0B\3\4\2>\3\3\0029\3\a\0'\5\17\0'\6\18\0'\a\19\0B\3\4\2>\3\4\0029\3\a\0'\5\20\0'\6\21\0'\a\22\0B\3\4\2>\3\5\0029\3\a\0'\5\23\0'\6\24\0'\a\25\0B\3\4\2>\3\6\0029\3\a\0'\5\26\0'\6\27\0'\a\28\0B\3\4\2>\3\a\0029\3\a\0'\5\29\0'\6\30\0'\a\31\0B\3\4\2>\3\b\0029\3\a\0'\5 \0'\6!\0'\a\"\0B\3\4\2>\3\t\0029\3\a\0'\5#\0'\6$\0'\a%\0B\3\4\2>\3\n\0029\3\a\0'\5&\0'\6'\0'\a(\0B\3\4\0?\3\0\0=\2\4\0016\1\0\0'\3)\0B\1\2\0029\1*\0019\3+\0B\1\2\0016\1,\0009\1-\0019\1.\1'\3/\0005\0040\0003\0051\0=\0052\4B\1\3\1K\0\1\0\rcallback\0\1\0\2\fpattern\nalpha\tdesc8Disable alpha colorcolumn, show alpha in bufferline\rFileType\24nvim_create_autocmd\bapi\bvim\vconfig\nsetup\nalpha\16<Cmd>qa<CR>\21⏻  Quit Neovim\6q\24<Cmd>PackerSync<CR>\24  Update Plugins\6u3<Cmd>e ~/.config/nvim/lua/plugins/init.lua<CR>\22﫸 Neovim Config\6c)<Cmd>SessionManager load_session<CR>\23  Find Sessions\6S.<Cmd>SessionManager load_last_session<CR>\25  Restore Session\6s <Cmd>Telescope projects<CR>\23  Find Projects\6p <Cmd>Telescope oldfiles<CR>\22  Recent Files\6o\29<Cmd>Telescope marks<CR>\19  Bookmarks\6b!<Cmd>Telescope live_grep<CR>\19  Live Grep\6g;<Cmd>lua require'stevenp2.telescope'.file_search()<CR>\20  Find Files\6f#<Cmd>ene <BAR> startinsert<CR>\18  New File\6n\vbutton\fbuttons\1\t\0\0>          __                                   ________  >  _______/  |_  _______  __ ____   ____ ______ \\_____  \\ > /  ___/\\   __\\/ __ \\  \\/ // __ \\ /    \\\\____ \\ /  ____/ > \\___ \\  |  | \\  ___/\\   /\\  ___/|   |  \\  |_> >       \\ >/____  > |__|  \\___  >\\_/  \\___  >___|  /   __/\\_______ \\>     \\/            \\/          \\/     \\/|__|           \\/>                                                         >       > Press [s] to restore your last session <        \bval\vheader\fsection\27alpha.themes.dashboard\frequire\23����\4\0" },
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/alpha-nvim",
    url = "https://github.com/goolord/alpha-nvim"
  },
  ["bufferline.nvim"] = {
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["telescope-media-files.nvim"] = {
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/telescope-media-files.nvim",
    url = "https://github.com/nvim-telescope/telescope-media-files.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["vim-bbye"] = {
    loaded = true,
    path = "/Users/steven/.local/share/nvim/site/pack/packer/start/vim-bbye",
    url = "https://github.com/moll/vim-bbye"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: alpha-nvim
time([[Config for alpha-nvim]], true)
try_loadstring("\27LJ\2\nL\0\0\2\0\6\0\t6\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\3\0'\1\5\0=\1\4\0K\0\1\0\5\16colorcolumn\awo\14buflisted\abo\bvim�\f\1\0\b\0003\1\\6\0\0\0'\2\1\0B\0\2\0029\1\2\0009\1\3\0015\2\5\0=\2\4\0019\1\2\0009\1\6\0014\2\f\0009\3\a\0'\5\b\0'\6\t\0'\a\n\0B\3\4\2>\3\1\0029\3\a\0'\5\v\0'\6\f\0'\a\r\0B\3\4\2>\3\2\0029\3\a\0'\5\14\0'\6\15\0'\a\16\0B\3\4\2>\3\3\0029\3\a\0'\5\17\0'\6\18\0'\a\19\0B\3\4\2>\3\4\0029\3\a\0'\5\20\0'\6\21\0'\a\22\0B\3\4\2>\3\5\0029\3\a\0'\5\23\0'\6\24\0'\a\25\0B\3\4\2>\3\6\0029\3\a\0'\5\26\0'\6\27\0'\a\28\0B\3\4\2>\3\a\0029\3\a\0'\5\29\0'\6\30\0'\a\31\0B\3\4\2>\3\b\0029\3\a\0'\5 \0'\6!\0'\a\"\0B\3\4\2>\3\t\0029\3\a\0'\5#\0'\6$\0'\a%\0B\3\4\2>\3\n\0029\3\a\0'\5&\0'\6'\0'\a(\0B\3\4\0?\3\0\0=\2\4\0016\1\0\0'\3)\0B\1\2\0029\1*\0019\3+\0B\1\2\0016\1,\0009\1-\0019\1.\1'\3/\0005\0040\0003\0051\0=\0052\4B\1\3\1K\0\1\0\rcallback\0\1\0\2\fpattern\nalpha\tdesc8Disable alpha colorcolumn, show alpha in bufferline\rFileType\24nvim_create_autocmd\bapi\bvim\vconfig\nsetup\nalpha\16<Cmd>qa<CR>\21⏻  Quit Neovim\6q\24<Cmd>PackerSync<CR>\24  Update Plugins\6u3<Cmd>e ~/.config/nvim/lua/plugins/init.lua<CR>\22﫸 Neovim Config\6c)<Cmd>SessionManager load_session<CR>\23  Find Sessions\6S.<Cmd>SessionManager load_last_session<CR>\25  Restore Session\6s <Cmd>Telescope projects<CR>\23  Find Projects\6p <Cmd>Telescope oldfiles<CR>\22  Recent Files\6o\29<Cmd>Telescope marks<CR>\19  Bookmarks\6b!<Cmd>Telescope live_grep<CR>\19  Live Grep\6g;<Cmd>lua require'stevenp2.telescope'.file_search()<CR>\20  Find Files\6f#<Cmd>ene <BAR> startinsert<CR>\18  New File\6n\vbutton\fbuttons\1\t\0\0>          __                                   ________  >  _______/  |_  _______  __ ____   ____ ______ \\_____  \\ > /  ___/\\   __\\/ __ \\  \\/ // __ \\ /    \\\\____ \\ /  ____/ > \\___ \\  |  | \\  ___/\\   /\\  ___/|   |  \\  |_> >       \\ >/____  > |__|  \\___  >\\_/  \\___  >___|  /   __/\\_______ \\>     \\/            \\/          \\/     \\/|__|           \\/>                                                         >       > Press [s] to restore your last session <        \bval\vheader\fsection\27alpha.themes.dashboard\frequire\23����\4\0", "config", "alpha-nvim")
time([[Config for alpha-nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
