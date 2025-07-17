local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local m = extras.m
local l = extras.l
local rep = extras.rep
local postfix = require("luasnip.extras.postfix").postfix

-- enable autosnippets
ls.setup({
    enable_autosnippets = true
})

-- only insert under math mode in latex
local math_mode = function ()
    return vim.api.nvim_command_output("echo vimtex#syntax#in_mathzone()") == '1'
end

local snippets, autosnippets = {}, {}

return snippets, autosnippets
