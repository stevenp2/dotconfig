local M = {}

function M.setup()
  local luasnip = require("luasnip")
  luasnip.config.setup({
    enable_autosnippets = true,
    update_events = { "TextChanged", "TextChangedI", "TextChangedP" },
  })

  -- use luasnip for native lsp snippets
  vim.snippet.expand = function(body)
    luasnip.lsp_expand(body)
  end

  require("luasnip.loaders.from_lua").lazy_load({
    paths = { vim.fn.stdpath("config") .. "/lua/stevenp2/snippets/collections" },
  })

  vim.api.nvim_create_autocmd("ModeChanged", {
    group = vim.api.nvim_create_augroup("stevenp2-luasnip", { clear = true }),
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
