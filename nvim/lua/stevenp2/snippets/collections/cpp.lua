local ls = require("luasnip")

local competitive_template = [[
#include <bits/stdc++.h>
#define MOD 1000000007
#define fio { cin.tie(nullptr); cin.sync_with_stdio(false); };
typedef long long ll;

ll msub(ll a, ll b) { return ((a - b) % MOD + MOD) % MOD; }
ll madd(ll a, ll b) { return ((a + b) % MOD + MOD) % MOD; }

using namespace std;

int main() {
    fio;
    $0
}

]]

return { ls.parser.parse_snippet("competitive", competitive_template) }, {}
