local M = {}

function M.setup()
  local luasnip = require("luasnip")
  luasnip.config.setup({
    enable_autosnippets = false,
    update_events = { "TextChanged", "TextChangedI", "TextChangedP" },
  })

  -- use luasnip for native lsp snippets
  vim.snippet.expand = function(body)
    luasnip.lsp_expand(body)
  end

  require("luasnip.loaders.from_lua").lazy_load({
    paths = { vim.fn.stdpath("config") .. "/lua/stevenp2/snippets/collections" },
  })

  local group = vim.api.nvim_create_augroup("stevenp2-luasnip", { clear = true })
  -- check after typing so autosnippets do not interrupt native completion
  vim.api.nvim_create_autocmd({ "TextChangedI", "TextChangedP" }, {
    group = group,
    callback = function()
      if not luasnip.session.jump_active then luasnip.expand_auto() end
    end,
  })
  vim.api.nvim_create_autocmd("ModeChanged", {
    group = group,
    pattern = { "i*:n", "s:n" },
    callback = function()
      local node = luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
      if node and not luasnip.session.jump_active then
        luasnip.unlink_current()
      end
    end,
  })
end

return M
