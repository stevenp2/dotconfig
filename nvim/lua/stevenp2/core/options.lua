local opt = vim.opt

-- files and persistence
opt.autoread = true
opt.backup = false
opt.clipboard = "unnamedplus"
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.swapfile = false
opt.tabstop = 4
opt.undofile = true
opt.writebackup = false

-- appearance and layout
opt.cmdheight = 1
opt.cursorline = false
opt.foldlevelstart = 99
opt.laststatus = 3
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.scrolloff = 8
opt.showmode = false
opt.showtabline = 0
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smoothscroll = true
opt.termguicolors = true
opt.winborder = "rounded"
opt.wrap = true

-- search and command interaction
opt.hlsearch = true
opt.ignorecase = true
opt.inccommand = "split"
opt.smartcase = true
opt.timeoutlen = 500
opt.updatetime = 200

-- window behaviour
opt.confirm = true
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true

vim.cmd("set whichwrap+=<,>,[,],h,l")
