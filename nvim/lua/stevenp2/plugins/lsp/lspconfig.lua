local M = {}

M.servers = {
    "lua_ls",
    "pyright",
    "ruff",
    "clangd",
    "texlab",
    "rust_analyzer",
    "taplo",
    "marksman",
    "bashls",
    "gopls",
    "ts_ls",
    "eslint",
    "yamlls",
    "terraformls",
    "bzl"
  }

function M.setup()
  -- Register a handler that will be called for all installed servers.
  for _, server in pairs(M.servers) do
    local opts = {
      on_attach = require("stevenp2.plugins.lsp.handlers").on_attach,
      capabilities = require("stevenp2.plugins.lsp.handlers").capabilities,
    }

    if server == "jsonls" then
      local jsonls_opts = require("stevenp2.plugins.lsp.settings.jsonls")
    	opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
    end

    if server == "lua_ls" then
    	local lua_opts = require("stevenp2.plugins.lsp.settings.lua_ls")
    	opts = vim.tbl_deep_extend("force", lua_opts, opts)
    end

    if server == "texlab" then
    	require("stevenp2.plugins.lsp.settings.vimtex")
    end

    if server == "yamlls" then
      local yamlls_opts = require("stevenp2.plugins.lsp.settings.yamlls")
      opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
    end

    if server == "pyright" then
      local pyright_opts = require("stevenp2.plugins.lsp.settings.pyright")
      opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    end

    if server == "ruff" then
      local ruff_opts = require("stevenp2.plugins.lsp.settings.ruff")
      opts = vim.tbl_deep_extend("force", ruff_opts, opts)
    end

    if server == "rust_analyzer" then
      local keymap = vim.keymap.set
      local key_opts = { silent = true }

      keymap("n", "<leader>r", ":lua vim.lsp.codelens.run()<CR>", key_opts)

      opts.settings = {
        ["rust-analyzer"] = {
          lens = {
            enable = true,
          },
          check = {
            command = "clippy",
          },
        },
      }
    end

    vim.lsp.config(server, opts)
    vim.lsp.enable(server)
  end
end

return M
