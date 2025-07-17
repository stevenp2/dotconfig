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

local snippets, autosnippets = {}, {}

local competitive_template = [[
#include <bits/stdc++.h>
#define MOD 1000000007
#define fio { cin.tie(nullptr); cin.sync_with_stdio(false); };
typedef long long ll

ll msub(ll a, ll b) { return ((a - b) % MOD + MOD) % MOD; }
ll madd(ll a, ll b) { return ((a + b) % MOD + MOD) % MOD; }

using namespace std;

int main() {
    fio

}

]]
table.insert(snippets, ls.parser.parse_snippet("competitive", competitive_template))


return snippets, autosnippets
