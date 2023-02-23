local M = {}

M.servers = {
    "lua_ls",
    "tsserver",
    "pyright",
    "jsonls",
    "clangd",
    "rome",
    "texlab",
    "rust_analyzer",
    "taplo",
    "marksman"
  }

function M.setup()

local status_ok, mason = pcall(require, "mason")
  if not status_ok then
    return
  end


  mason.setup()

  local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
  if not lspconfig_status_ok then
    return
  end

  -- Register a handler that will be called for all installed servers.
  -- Alternatively, you may also register handlers on specific server instances instead (see example below).
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

  if server == "rust_analyzer" then
    local keymap = vim.keymap.set
    local key_opts = { silent = true }

    keymap("n", "<leader>r", ":lua vim.lsp.codelens.run()<CR>", key_opts)
    --[[ keymap("n", "<leader>rh", "<cmd>RustSetInlayHints<Cr>", key_opts) ]]
    --[[ keymap("n", "<leader>rhd", "<cmd>RustDisableInlayHints<Cr>", key_opts) ]]
    --[[ keymap("n", "<leader>th", "<cmd>RustToggleInlayHints<Cr>", key_opts) ]]
    --[[ keymap("n", "<leader>rr", "<cmd>RustRunnables<Cr>", key_opts) ]]
    --[[ keymap("n", "<leader>rem", "<cmd>RustExpandMacro<Cr>", key_opts) ]]
    --[[ keymap("n", "<leader>roc", "<cmd>RustOpenCargo<Cr>", key_opts) ]]
    --[[ keymap("n", "<leader>rpm", "<cmd>RustParentModule<Cr>", key_opts) ]]
    --[[ keymap("n", "<leader>rjl", "<cmd>RustJoinLines<Cr>", key_opts) ]]
    --[[ keymap("n", "<leader>rha", "<cmd>RustHoverActions<Cr>", key_opts) ]]
    --[[ keymap("n", "<leader>rhr", "<cmd>RustHoverRange<Cr>", key_opts) ]]
    --[[ keymap("n", "<leader>rmd", "<cmd>RustMoveItemDown<Cr>", key_opts) ]]
    --[[ keymap("n", "<leader>rmu", "<cmd>RustMoveItemUp<Cr>", key_opts) ]]
    --[[ keymap("n", "<leader>rsb", "<cmd>RustStartStandaloneServerForBuffer<Cr>", key_opts) ]]
    --[[ keymap("n", "<leader>rd", "<cmd>RustDebuggables<Cr>", key_opts) ]]
    --[[ keymap("n", "<leader>rv", "<cmd>RustViewCrateGraph<Cr>", key_opts) ]]
    --[[ keymap("n", "<leader>rw", "<cmd>RustReloadWorkspace<Cr>", key_opts) ]]
    --[[ keymap("n", "<leader>rss", "<cmd>RustSSR<Cr>", key_opts) ]]
    --[[ keymap("n", "<leader>rxd", "<cmd>RustOpenExternalDocs<Cr>", key_opts) ]]

    require("rust-tools").setup {
      tools = {
        on_initialized = function()
          vim.cmd [[
            autocmd BufEnter,CursorHold,InsertLeave,BufWritePost *.rs silent! lua vim.lsp.codelens.refresh()
          ]]
        end,
      },
      server = {
        on_attach = require("stevenp2.plugins.lsp.handlers").on_attach,
        capabilities = require("stevenp2.plugins.lsp.handlers").capabilities,
        settings = {
          ["rust-analyzer"] = {
            lens = {
              enable = true,
            },
            checkOnSave = {
              command = "clippy",
            },
          },
        },
      },
    }

    goto continue
        end

      lspconfig[server].setup(opts)
      ::continue::
  end
end

return M
