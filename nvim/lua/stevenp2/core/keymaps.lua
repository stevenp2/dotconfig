local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

-- clear highlithgint
keymap("n", "<esc><esc>", ":noh<return>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<C-w>w", ":Bdelete<CR>", opts)
keymap("n", "<C-n>", "<Cmd>ene <BAR><CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- paste not copy
keymap("v", "p", '"_dP', opts)
-- yank cursor stay 
keymap("v", "y", "ygv<ESC>", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-w>h", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-w>j", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-w>k", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-w>l", "<C-\\><C-N><C-w>l", term_opts)
keymap("t", "<esc>", "<C-\\><C-N>", term_opts)

-- Oil
keymap("n", "<leader>e", ":Oil<cr>", opts)

-- Lazygit
keymap("n", "<leader>g", ":LazyGit<cr>", opts)

-- diagnostic view 
keymap("n", "gK", ":DiagWindowShow<cr>", opts)

-- Telescope
keymap("n", "<leader>F", ":Telescope live_grep<cr>", opts)
keymap("n", "<leader>O", ":Telescope find_files<cr>", opts)
keymap("n", "<leader>R", ":Telescope resume initial_mode=normal<cr>", opts)
keymap("n", "<leader>b", ":Telescope buffers initial_mode=normal sort_mru=true sort_lastused=true<cr>", opts)

-- Trouble
keymap("n", "<leader>q", "<cmd>Trouble diagnostics toggle<CR>", opts)

-- format
keymap("n", "<leader>fm", ":=vim.lsp.buf.format()<cr><cr>", opts)
