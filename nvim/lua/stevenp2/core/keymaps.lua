vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

local function open_lazygit()
  if vim.fn.executable("lazygit") == 0 then
    vim.notify("lazygit is not installed", vim.log.levels.WARN)
    return
  end
  vim.cmd("tabnew | terminal lazygit")
  vim.cmd("startinsert")
end

-- editing
map({ "n", "v", "x", "s", "o" }, "<Space>", "<Nop>", "Leader prefix")
map("n", "<Esc><Esc>", "<Cmd>nohlsearch<CR>", "Clear search highlight")
map("i", "jk", "<Esc>", "Leave insert mode")
map("v", "<", "<gv", "Indent left and keep selection")
map("v", ">", ">gv", "Indent right and keep selection")
map("v", "<A-j>", ":move '>+1<CR>gv=gv", "Move selection down")
map("v", "<A-k>", ":move '<-2<CR>gv=gv", "Move selection up")
map("v", "p", '"_dP', "Paste without replacing register")
map("v", "y", "ygv<Esc>", "Yank and keep selection")
map("x", "J", ":move '>+1<CR>gv-gv", "Move block selection down")
map("x", "K", ":move '<-2<CR>gv-gv", "Move block selection up")

-- windows and buffers
map("n", "<C-Up>", "<Cmd>resize +2<CR>", "Increase window height")
map("n", "<C-Down>", "<Cmd>resize -2<CR>", "Decrease window height")
map("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", "Decrease window width")
map("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", "Increase window width")
map("n", "<C-w>w", function()
  local current = vim.api.nvim_get_current_buf()
  vim.cmd("bprevious")
  if vim.api.nvim_buf_is_valid(current) then
    vim.api.nvim_buf_delete(current, {})
  end
end, "Close buffer and go to previous")
map("n", "<C-n>", "<Cmd>enew<CR>", "New buffer")
map("t", "<C-w>h", "<C-\\><C-n><C-w>h", "Move to left window")
map("t", "<C-w>j", "<C-\\><C-n><C-w>j", "Move to lower window")
map("t", "<C-w>k", "<C-\\><C-n><C-w>k", "Move to upper window")
map("t", "<C-w>l", "<C-\\><C-n><C-w>l", "Move to right window")
map("t", "<Esc>", "<C-\\><C-n>", "Leave terminal mode")

-- finding and navigation
map("n", "<leader>e", "<Cmd>Oil<CR>", "Explorer: open Oil")
map("n", "<leader>O", "<Cmd>Telescope find_files<CR>", "Find: files")
map("n", "<leader>F", "<Cmd>Telescope live_grep<CR>", "Find: grep text")
map("n", "<leader>b", "<Cmd>Telescope buffers initial_mode=normal sort_mru=true sort_lastused=true<CR>", "Find: buffers")
map("n", "<leader>R", "<Cmd>Telescope resume initial_mode=normal<CR>", "Find: resume picker")
map("n", "<leader>fo", "<Cmd>Telescope oldfiles<CR>", "Find: recent files")
map("n", "<leader>fk", "<Cmd>Telescope keymaps<CR>", "Find: keymaps")

-- diagnostics and tools
map("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, "Diagnostic: previous")
map("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, "Diagnostic: next")
map("n", "gK", vim.diagnostic.open_float, "Diagnostic: show current line")
map("n", "<leader>q", "<Cmd>Trouble diagnostics toggle<CR>", "Diagnostics: workspace list")
map("n", "<leader>dv", function()
  local enabled = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = enabled, virtual_text = not enabled })
end, "Diagnostics: toggle virtual lines")
map("n", "<leader>g", open_lazygit, "Git: open Lazygit")
local function format()
  require("stevenp2.plugins.lsp").format()
end
map("n", "<leader>fm", format, "LSP format buffer")
map("n", "<leader>r", vim.lsp.codelens.run, "LSP run code lens")
