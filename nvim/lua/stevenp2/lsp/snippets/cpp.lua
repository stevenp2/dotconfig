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

local competitive_setup = [[
#include <bits/stdc++.h>
#define MOD 1000000007
#define fio { cin.tie(nullptr); cin.sync_with_stdio(false); }
typedef long long ll;
using namespace std;
ll madd(ll a, ll b) { return ((a + b) % MOD + MOD) % MOD; }
ll msub(ll a, ll b) { return ((a - b) % MOD + MOD) % MOD; }
ll lb(ll a, ll b) { return max(a - b, (ll) 0); }
ll ub(ll a, ll b, ll n) { return min(a + b, n); }

int main() {
    fio;
    $0
}
]]

local bin_search = [[
int binarysearch(function<bool(int)> f) {
    int lo = 0;
    int hi = 100000;
    int bestSoFar = -1;
    // Range [lo, hi];
    while (lo <= hi) {
        int mid = (lo + hi) / 2;
        if (f(mid)) {
            bestSoFar = mid;
            hi = mid - 1;
        } else {
            lo = mid + 1;
        }
    }
    return bestSoFar;
}
]]

local union_find = [[
const int N = 100100; // size of array indexed by 0
int parent[N];
int subtree_size[N];  

void init(int n) {
  for (int i = 0; i < n; i++) {
    parent[i] = i;
    subtree_size[i] = 1;
  }
}

int root(int x) {
  // only roots are their own parents
  return parent[x] == x ? x : root(parent[x]);
}

void join(int x, int y) {
  // join roots
  x = root(x); y = root(y);
  // test whether already connected
  if (x == y)
    return;
  // size heuristic
  // hang smaller subtree under root of larger subtree
  if (subtree_size[x] < subtree_size[y]) {
    parent[x] = y;
    subtree_size[y] += subtree_size[x];
  } else {
    parent[y] = x;
    subtree_size[x] += subtree_size[y];
  }
}
]]

local range_tree = [[
const int N = 100100;
// the number of additional nodes created can be as high as the next power of two up from N (131,072)
int tree[3*N];

int n; // actual length of underlying array

// query the sum over [qL, qR) (0-based)
// i is the index in the tree, rooted at 1 so children are 2i and 2i+1
// instead of explicitly storing each node's range of responsibility [cL,cR), we calculate it on the way down
// the root node is responsible for [0, n)
int query(int qL, int qR, int i = 1, int cL = 0, int cR = n) {
  // the query range exactly matches this node's range of responsibility
  if (cL == qL && cR == qR)
    return tree[i];
  // we might need to query one or both of the children
  int mid = (cL + cR) / 2;
  int ans = 0;
  // query the part within the left child [cL, mid), if any
  if (qL < mid) ans += query(qL, min(qR, mid), i * 2, cL, mid);
  // query the part within the right child [mid, cR), if any
  if (qR > mid) ans += query(max(qL, mid), qR, i * 2 + 1, mid, cR);
  return ans;
}
/*
 * range tree update
 */

// p is the index in the array (0-based)
// v is the value that the p-th element will be updated to
// i is the index in the tree, rooted at 1 so children are 2i and 2i+1
// instead of explicitly storing each node's range of responsibility [cL,cR), we calculate it on the way down
// the root node is responsible for [0, n)
void update(int p, int v, int i = 1, int cL = 0, int cR = n) {
  if (cR - cL == 1) {
    // this node is a leaf, so apply the update
    tree[i] = v;
    return;
  }
  // figure out which child is responsible for the index (p) being updated
  int mid = (cL + cR) / 2;
  if (p < mid)
    update(p, v, i * 2, cL, mid);
  else
    update(p, v, i * 2 + 1, mid, cR);
  // once we have updated the correct child, recalculate our stored value.
  tree[i] = tree[i*2] + tree[i*2+1];
}
]]

table.insert(snippets, ls.parser.parse_snippet("competitive", competitive_setup))
table.insert(snippets, ls.parser.parse_snippet("binary_search", bin_search))
table.insert(snippets, ls.parser.parse_snippet("union_find", union_find))
table.insert(snippets, ls.parser.parse_snippet("range_tree", range_tree))

return snippets, autosnippets
