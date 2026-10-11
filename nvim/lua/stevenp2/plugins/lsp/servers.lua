local schemas = require("stevenp2.plugins.lsp.schemas")

return {
  bashls = { executable = "bash-language-server" },
  bzl = { executable = "bzl" },
  clangd = { executable = "clangd" },
  eslint = { executable = "vscode-eslint-language-server" },
  marksman = { executable = "marksman" },
  taplo = { executable = "taplo" },
  terraformls = { executable = "terraform-ls" },
  texlab = { executable = "texlab" },
  ts_ls = { executable = "typescript-language-server" },

  gopls = {
    executable = "gopls",
    config = {
      -- gopls does not support go.sum documents
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_dir = function(bufnr, on_dir)
        local filename = vim.api.nvim_buf_get_name(bufnr)
        if filename == "" or vim.bo[bufnr].buftype ~= "" then return end
        local root = vim.fs.root(filename, "go.work") or vim.fs.root(filename, "go.mod")
        on_dir(root or vim.fs.dirname(filename))
      end,
      settings = {
        gopls = {
          analyses = {
            nilness = true,
            shadow = true,
            unusedparams = true,
            unusedwrite = true,
          },
          gofumpt = true,
          semanticTokens = true,
          staticcheck = true,
          usePlaceholders = true,
        },
      },
    },
  },

  lua_ls = {
    executable = "lua-language-server",
    config = {
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          telemetry = { enable = false },
          workspace = {
            checkThirdParty = false,
            library = { vim.env.VIMRUNTIME, vim.fn.stdpath("config") .. "/lua" },
          },
        },
      },
    },
  },

  pyright = {
    executable = "pyright-langserver",
    config = {
      -- ruff handles import organization
      settings = {
        pyright = { disableOrganizeImports = true },
      },
    },
  },

  ruff = {
    executable = "ruff",
    config = {
      on_attach = function(client)
        client.server_capabilities.hoverProvider = false
      end,
      init_options = {
        settings = {
          configurationPreference = "editorFirst",
          configuration = { format = { ["quote-style"] = "double" } },
          lint = {
            select = { "ANN", "B", "D", "F", "PL", "SIM", "TC" },
            ignore = { "D104" },
          },
        },
      },
    },
  },

  rust_analyzer = {
    executable = "rust-analyzer",
    check = function(bufnr, done)
      -- rustup proxies may exist without installed components
      local cwd = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
      vim.system({ "rust-analyzer", "--version" }, { text = true, cwd = cwd, timeout = 3000 }, function(result)
        vim.schedule(function()
          done(result.code == 0, "rust-analyzer could not start for this project. Check its Rustup toolchain and run: rustup component add rust-analyzer rust-src")
        end)
      end)
    end,
    config = {
      settings = {
        ["rust-analyzer"] = {
          check = { command = "clippy" },
          lens = { enable = true },
        },
      },
    },
  },

  jsonls = {
    executable = "vscode-json-language-server",
    config = { settings = { json = { schemas = schemas.json, validate = { enable = true } } } },
  },

  yamlls = {
    executable = "yaml-language-server",
    config = {
      settings = {
        yaml = {
          completion = true,
          format = { enable = true },
          hover = true,
          schemas = schemas.yaml,
        },
      },
    },
  },
}
