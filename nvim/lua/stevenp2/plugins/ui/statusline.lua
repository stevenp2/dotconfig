local M = {}

local function active_lsp_clients()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    return ""
  end

  local names = vim.tbl_map(function(client)
    return client.name
  end, clients)
  table.sort(names)
  return " " .. table.concat(names, ",")
end

function M.setup()
  require("lualine").setup({
    options = {
      theme = "tokyonight",
      globalstatus = true,
      component_separators = { left = "│", right = "│" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = { statusline = { "alpha" } },
    },
    sections = {
      lualine_a = { { "mode", fmt = string.lower } },
      lualine_b = { "branch", "diff" },
      lualine_c = { { "filename", path = 1, symbols = { modified = " ●", readonly = " " } } },
      lualine_x = {
        { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " } },
        active_lsp_clients,
        "filetype",
      },
      lualine_y = { { "searchcount", maxcount = 9999, timeout = 50 }, "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_c = { { "filename", path = 1 } },
      lualine_x = { "location" },
    },
    extensions = { "lazy", "mason", "oil", "quickfix", "trouble" },
  })
end

return M
