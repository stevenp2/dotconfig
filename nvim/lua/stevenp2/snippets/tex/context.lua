local ls = require("luasnip")

return {
  ls = ls,
  s = ls.snippet,
  t = ls.text_node,
  i = ls.insert_node,
  rep = require("luasnip.extras").rep,

  math_mode = function()
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
  end,
}
