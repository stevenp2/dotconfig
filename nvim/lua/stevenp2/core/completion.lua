local M = {}
local config = require("stevenp2.config").completion
local readiness_timer
local completion_interaction
local empty_result_retries = 0
local retry_delays = { 100, 300, 1000 }

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
  local last_character = prefix:sub(-1)
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0, method = "textDocument/completion" })) do
    local provider = client.server_capabilities.completionProvider
    if type(provider) == "table" and vim.list_contains(provider.triggerCharacters or {}, last_character) then
      return true
    end
  end
  return false
end

local function text_before_cursor()
  return vim.api.nvim_get_current_line():sub(1, vim.api.nvim_win_get_cursor(0)[2])
end

local function current_position()
  return {
    buffer = vim.api.nvim_get_current_buf(),
    changedtick = vim.api.nvim_buf_get_changedtick(0),
    cursor = vim.api.nvim_win_get_cursor(0),
  }
end

local function position_is_current(position)
  return vim.api.nvim_get_current_buf() == position.buffer
    and vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
    and vim.api.nvim_buf_get_changedtick(0) == position.changedtick
    and vim.deep_equal(vim.api.nvim_win_get_cursor(0), position.cursor)
end

local function cancel_readiness_retry()
  if readiness_timer then
    readiness_timer:stop()
    readiness_timer:close()
    readiness_timer = nil
  end
end

local function cancel_pending_completions(bufnr)
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    for id, request in pairs(client.requests) do
      if request.bufnr == bufnr and request.method == "textDocument/completion" and request.type == "pending" then
        client:cancel_request(id)
      end
    end
  end
end

local function preserve_completion_intent()
  local interaction = completion_interaction
  if interaction and interaction.kind == "dismissed" then
    if vim.fn.pumvisible() == 1 then
      vim.schedule(function()
        if completion_interaction == interaction and position_is_current(interaction) and vim.fn.pumvisible() == 1 then
          vim.fn.complete(interaction.cursor[2] + 1, {})
        end
      end)
    end
    return
  end
  local menu = vim.fn.complete_info({ "selected", "items" })
  if menu.selected >= 0 then
    cancel_readiness_retry()
    completion_interaction = current_position()
    completion_interaction.kind = "selected"
    completion_interaction.item = menu.items[menu.selected + 1]
    completion_interaction.items = menu.items
    return
  end
  local choice = completion_interaction
  if not choice then return end
  -- native lsp completion rebuilds the menu before selection can be restored
  vim.schedule(function()
    if completion_interaction ~= choice or not position_is_current(choice) then return end
    local current = vim.fn.complete_info({ "selected", "items" })
    if current.selected ~= -1 then return end
    if vim.deep_equal(current.items, choice.items) then
      completion_interaction = nil
      return
    end
    for index, item in ipairs(current.items) do
      if item.word == choice.item.word and vim.deep_equal(item.user_data, choice.item.user_data) then
        vim.api.nvim_select_popupmenu_item(index - 1, false, false, {})
        return
      end
    end
  end)
end

local function retry_when_ready(bufnr, client_id, delay)
  local client = vim.lsp.get_client_by_id(client_id)
  if bufnr ~= vim.api.nvim_get_current_buf() or not client
    or not client.attached_buffers[bufnr] or not client:supports_method("textDocument/completion")
    or not vim.bo.autocomplete or vim.api.nvim_get_mode().mode:sub(1, 1) ~= "i"
    or not can_complete(text_before_cursor()) then
    return
  end
  cancel_readiness_retry()
  local position = current_position()
  local timer
  timer = vim.defer_fn(function()
    if readiness_timer ~= timer then return end
    readiness_timer = nil
    if not position_is_current(position) or not client.attached_buffers[bufnr]
      or not vim.bo.autocomplete or not can_complete(text_before_cursor()) then
      return
    end
    local menu = vim.fn.complete_info({ "selected", "matches" })
    if menu.selected ~= -1 then return end
    for _, item in ipairs(menu.matches) do
      if vim.tbl_get(item, "user_data", "nvim", "lsp") then return end
    end
    if delay then empty_result_retries = empty_result_retries + 1 end
    -- get() cannot refresh a visible buffer-only menu
    vim.fn.complete(position.cursor[2] + 1, {})
    vim.lsp.completion.get()
  end, delay or config.delay)
  readiness_timer = timer
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
  cancel_readiness_retry()
  vim.opt.autocomplete = false
  vim.opt.autocompletedelay = config.delay
  vim.opt.complete = { ".^20", "o" }
  vim.opt.completeopt = { "menu", "menuone", "popup", "noinsert", "noselect" }
  vim.opt.pumheight = 12
  vim.opt.shortmess:append("c")

  local group = vim.api.nvim_create_augroup("stevenp2-completion", { clear = true })
  vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave", "BufLeave" }, {
    group = group,
    callback = function()
      vim.bo.autocomplete = false
      completion_interaction = nil
      empty_result_retries = 0
      cancel_readiness_retry()
    end,
  })
  vim.api.nvim_create_autocmd("CompleteChanged", {
    group = group,
    callback = preserve_completion_intent,
  })
  vim.api.nvim_create_autocmd("CompleteDone", {
    group = group,
    callback = function()
      if not completion_interaction then return end
      if completion_interaction.kind == "selected" then
        completion_interaction = nil
      elseif vim.v.event.reason == "cancel" then
        -- cancelling a native menu can change changedtick without changing the text
        completion_interaction.changedtick = vim.api.nvim_buf_get_changedtick(0)
      end
    end,
  })
  vim.api.nvim_create_autocmd("LspProgress", {
    group = group,
    pattern = "end",
    callback = function(event)
      retry_when_ready(vim.api.nvim_get_current_buf(), event.data.client_id)
    end,
  })
  vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    callback = function(event)
      vim.schedule(function() retry_when_ready(event.buf, event.data.client_id) end)
    end,
  })
  vim.api.nvim_create_autocmd("LspRequest", {
    group = group,
    callback = function(event)
      local request = event.data.request
      local delay = retry_delays[empty_result_retries + 1]
      -- gopls can return an empty list while discovering unimported packages
      if delay and request.type == "complete" and request.method == "textDocument/completion" then
        retry_when_ready(event.buf, event.data.client_id, delay)
      end
    end,
  })
  vim.api.nvim_create_autocmd("InsertCharPre", {
    group = group,
    callback = function()
      completion_interaction = nil
      empty_result_retries = 0
      vim.bo.autocomplete = can_complete(text_before_cursor() .. vim.v.char)
    end,
  })
  vim.api.nvim_create_autocmd({ "TextChangedI", "TextChangedP" }, {
    group = group,
    callback = function()
      cancel_readiness_retry()
      if vim.bo.autocomplete and not can_complete(text_before_cursor()) then vim.bo.autocomplete = false end
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
    completion_interaction = nil
    empty_result_retries = 0
    cancel_readiness_retry()
    vim.bo.autocomplete = can_complete(text_before_cursor())
    if #vim.lsp.get_clients({ bufnr = 0, method = "textDocument/completion" }) == 0 then
      return "<C-e><C-x><C-n>"
    end
    return "<Cmd>lua vim.fn.complete(vim.fn.col('.'), {}); vim.lsp.completion.get()<CR>"
  end, { expr = true, desc = "Show completion suggestions now" })

  vim.keymap.set("i", "<C-e>", function()
    if vim.fn.pumvisible() == 1 then
      completion_interaction = current_position()
      completion_interaction.kind = "dismissed"
      vim.bo.autocomplete = false
      cancel_readiness_retry()
      cancel_pending_completions(vim.api.nvim_get_current_buf())
    end
    return "<C-e>"
  end, { expr = true, desc = "Dismiss completion suggestions" })
end

return M
