local modules = {
  "templates",
  "symbols",
  "functions",
  "latex",
}

local snippets, autosnippets = {}, {}
for _, module in ipairs(modules) do
  local group = require("stevenp2.snippets.tex." .. module)
  vim.list_extend(snippets, group.snippets or {})
  vim.list_extend(autosnippets, group.autosnippets or {})
end

return snippets, autosnippets
