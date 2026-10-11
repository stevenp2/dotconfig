if vim.fn.has("nvim-0.12.4") == 0 then
  error("This configuration requires Neovim 0.12.4 or newer; run ./setup.sh to upgrade")
end

require("stevenp2")
