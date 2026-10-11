local M = {}

function M.setup()
  local luasnip = require("luasnip")
  luasnip.config.setup({
    enable_autosnippets = true,
    update_events = { "TextChanged", "TextChangedI" },
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
    pattern = "*",
    callback = function()
      local node = luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
      local left_snippet_mode = vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n"
      if node and not luasnip.session.jump_active and (left_snippet_mode or vim.v.event.old_mode == "i") then
        luasnip.unlink_current()
      end
    end,
  })
end

return M
