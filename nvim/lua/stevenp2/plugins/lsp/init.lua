local M = {}

local formatters = require("stevenp2.config").lsp.format_on_save
local servers = require("stevenp2.plugins.lsp.servers")

function M.format(opts)
  opts = opts or {}
  local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
  local preferred = formatters[vim.bo[bufnr].filetype]
  local clients = vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/formatting" })
  local function allowed(client)
    return type(preferred) ~= "string" or client.name == preferred
  end
  if not vim.iter(clients):any(allowed) then
    if not opts.silent then
      vim.notify("No LSP formatter for this buffer", vim.log.levels.INFO)
    end
    return
  end
  vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 3000, filter = allowed })
end

local function setup_diagnostics()
  local severity = vim.diagnostic.severity
  vim.diagnostic.config({
    severity_sort = true,
    signs = {
      text = {
        [severity.ERROR] = " ",
        [severity.WARN] = " ",
        [severity.INFO] = " ",
        [severity.HINT] = "󰌵 ",
      },
    },
    underline = true,
    update_in_insert = false,
    virtual_text = { spacing = 2, source = "if_many" },
    float = { border = "rounded", source = true },
  })
end

local function set_keymaps(client, bufnr)
  local function map(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
  end

  map("gd", "<Cmd>Telescope lsp_definitions<CR>", "LSP definitions")
  map("gr", "<Cmd>Telescope lsp_references<CR>", "LSP references")
  map("gi", "<Cmd>Telescope lsp_implementations<CR>", "LSP implementations")
  map("gD", vim.lsp.buf.declaration, "LSP declaration")
  map("K", vim.lsp.buf.hover, "LSP hover documentation")
  map("<C-k>", vim.lsp.buf.signature_help, "LSP signature help")
  map("<leader>ca", vim.lsp.buf.code_action, "LSP code action")
  map("<leader>rn", vim.lsp.buf.rename, "LSP rename")

  local function format()
    M.format({ bufnr = bufnr })
  end
  map("<leader>fm", format, "LSP format buffer")

  if client:supports_method("textDocument/codeLens") then
    map("<leader>r", vim.lsp.codelens.run, "LSP run code lens")
  end

  vim.api.nvim_buf_create_user_command(bufnr, "Format", format, {
    desc = "Format the current buffer with LSP",
    force = true,
  })
end

local function setup_attach()
  local group = vim.api.nvim_create_augroup("stevenp2-lsp-attach", { clear = true })
  local highlights = vim.api.nvim_create_augroup("stevenp2-lsp-highlights", { clear = true })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if not client then return end

      if client:supports_method("textDocument/completion") then
        -- core/completion.lua handles automatic triggering
        vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = false })
      end

      set_keymaps(client, event.buf)
      if not client:supports_method("textDocument/documentHighlight") then
        return
      end

      vim.api.nvim_clear_autocmds({ group = highlights, buffer = event.buf })
      vim.api.nvim_create_autocmd("CursorHold", {
        group = highlights,
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
        group = highlights,
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end,
  })

  vim.api.nvim_create_autocmd("LspDetach", {
    group = group,
    callback = function(event)
      vim.lsp.buf.clear_references()
      vim.schedule(function()
        if not vim.api.nvim_buf_is_valid(event.buf) then return end
        local still_supported = vim.iter(vim.lsp.get_clients({ bufnr = event.buf })):any(function(client)
          return client:supports_method("textDocument/documentHighlight")
        end)
        if not still_supported then
          vim.api.nvim_clear_autocmds({ group = highlights, buffer = event.buf })
        end
      end)
    end,
  })
end

local function setup_format_on_save()
  local group = vim.api.nvim_create_augroup("stevenp2-lsp-format", { clear = true })

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    callback = function(event)
      if vim.bo[event.buf].buftype == "" and formatters[vim.bo[event.buf].filetype] then
        M.format({ bufnr = event.buf, silent = true })
      end
    end,
  })
end

local function setup_servers()
  vim.lsp.config("*", { capabilities = vim.lsp.protocol.make_client_capabilities() })

  local available = {}
  local names = vim.tbl_keys(servers)
  table.sort(names)

  for _, name in ipairs(names) do
    local server = servers[name]
    vim.lsp.config(name, server.config or {})
    local resolved = vim.lsp.config[name]
    if resolved and resolved.filetypes and #resolved.filetypes > 0 and vim.fn.executable(server.executable) == 1 then
      if server.check then
        local root_dir = resolved.root_dir
        vim.lsp.config(name, {
          root_dir = function(bufnr, on_dir)
            server.check(bufnr, function(usable, message)
              if not vim.api.nvim_buf_is_valid(bufnr)
                or not vim.list_contains(resolved.filetypes, vim.bo[bufnr].filetype) then
                return
              end
              if usable then
                root_dir(bufnr, on_dir)
              else
                vim.notify_once(message, vim.log.levels.WARN, { title = "LSP unavailable" })
              end
            end)
          end,
        })
      end
      table.insert(available, name)
    end
  end

  vim.lsp.enable(available)
end

function M.setup()
  setup_diagnostics()
  setup_attach()
  setup_format_on_save()
  setup_servers()
end

return M
