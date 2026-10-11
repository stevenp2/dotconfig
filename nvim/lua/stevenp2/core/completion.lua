local M = {}
local config = require("stevenp2.config").completion

local function can_complete(prefix)
  if vim.bo.buftype ~= "" or not vim.bo.modifiable or vim.bo.filetype == "oil" then
    return false
  end
  local word = vim.fn.matchstr(prefix, [[\k\+$]])
  if vim.fn.strchars(word) >= config.min_chars then
    return true
  end
  if not prefix:match("%S%S$") then
    return false
  end
  local last = prefix:sub(-1)
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0, method = "textDocument/completion" })) do
    local provider = client.server_capabilities.completionProvider
    if type(provider) == "table" and vim.list_contains(provider.triggerCharacters or {}, last) then
      return true
    end
  end
  return false
end

local function prefix()
  return vim.api.nvim_get_current_line():sub(1, vim.api.nvim_win_get_cursor(0)[2])
end

local function tab(direction)
  return function()
    if vim.fn.pumvisible() == 1 then
      return direction == 1 and "<Down>" or "<Up>"
    end
    vim.bo.autocomplete = false
    if package.loaded.luasnip then
      local luasnip = require("luasnip")
      if direction == 1 and luasnip.expand_or_locally_jumpable() then
        return "<Cmd>lua require('luasnip').expand_or_jump()<CR>"
      end
      if direction == -1 and luasnip.locally_jumpable(-1) then
        return "<Cmd>lua require('luasnip').jump(-1)<CR>"
      end
    end

    return direction == 1 and "<Tab>" or "<C-d>"
  end
end

function M.setup()
  vim.opt.autocomplete = false
  vim.opt.autocompletedelay = config.delay
  vim.opt.complete = { "o", ".^20" }
  vim.opt.completeopt = { "menu", "menuone", "popup", "noinsert", "noselect" }
  vim.opt.pumheight = 12
  vim.opt.shortmess:append("c")

  local group = vim.api.nvim_create_augroup("stevenp2-completion", { clear = true })
  vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    group = group,
    callback = function() vim.bo.autocomplete = false end,
  })
  vim.api.nvim_create_autocmd("InsertCharPre", {
    group = group,
    callback = function() vim.bo.autocomplete = can_complete(prefix() .. vim.v.char) end,
  })
  vim.api.nvim_create_autocmd({ "TextChangedI", "TextChangedP" }, {
    group = group,
    callback = function(event)
      if vim.bo.autocomplete and not can_complete(prefix()) then vim.bo.autocomplete = false end
      if vim.bo.autocomplete
        and #vim.lsp.get_clients({ bufnr = event.buf, method = "textDocument/completion" }) > 0 then
        local bufnr, tick = event.buf, vim.api.nvim_buf_get_changedtick(event.buf)
        local cursor = vim.api.nvim_win_get_cursor(0)
        vim.defer_fn(function()
          local menu = vim.fn.complete_info({ "selected", "mode" })
          if vim.api.nvim_get_current_buf() == bufnr and vim.bo.autocomplete
            and vim.api.nvim_buf_get_changedtick(bufnr) == tick
            and vim.deep_equal(vim.api.nvim_win_get_cursor(0), cursor)
            and menu.selected == -1
            -- buffer words may still be waiting for native lsp completion
            and (vim.fn.pumvisible() == 0 or menu.mode == "eval")
            and vim.api.nvim_get_mode().mode:sub(1, 1) == "i" then
            vim.lsp.completion.get()
          end
        end, config.delay)
      end
    end,
  })

  vim.keymap.set({ "i", "s" }, "<Tab>", tab(1), { expr = true, desc = "Next completion, snippet stop or indent" })
  vim.keymap.set({ "i", "s" }, "<S-Tab>", tab(-1), { expr = true, desc = "Previous completion, snippet stop or unindent" })

  vim.keymap.set("i", "<CR>", function()
    if vim.fn.pumvisible() == 1 then
      return vim.fn.complete_info().selected ~= -1 and "<C-y>" or "<C-e><CR>"
    end
    return "<CR>"
  end, { expr = true, desc = "Accept selected completion" })

  vim.keymap.set("i", "<C-Space>", function()
    vim.lsp.completion.get()
  end, { desc = "Trigger LSP completion" })
end

return M
