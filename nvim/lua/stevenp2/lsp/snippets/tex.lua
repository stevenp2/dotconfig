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

-- enable autosnippets
ls.setup({
    enable_autosnippets = true
})

-- only insert under math mode in latex
local math_mode = function()
    return vim.api.nvim_command_output("echo vimtex#syntax#in_mathzone()") == '1'
end

local insert_to_autosnip = function(snip_list)
    for _, snippet in ipairs(snip_list) do
        table.insert(autosnippets, snippet)
    end
end

local insert_to_snip = function(snip_list)
    for _, snippet in ipairs(snip_list) do
        table.insert(snippets, snippet)
    end
end

local preamble = [[
    \usepackage[margin=1in, headsep=0.1in]{geometry} 
    \usepackage{amsmath,amsthm,amssymb,amsfonts, fancyhdr, color, graphicx}
    \usepackage{xcolor}
    \usepackage{pdfpages}
    \usepackage{indentfirst}
    \usepackage{hyperref}

    % get rid of indent
    \setlength{\parindent}{0pt}
    \pagestyle{fancy}

    \renewcommand{\vec}[1]{\mathbf{#1}}
    \renewcommand{\labelitemi}{$\Rightarrow$}
    \renewcommand{\tab}{\hspace{10mm}}

    \pdfsuppresswarningpagegroup=1
]]
table.insert(snippets, ls.parser.parse_snippet("preamble", preamble))

local template = [[
    \documentclass{report}

    \input{../master.tex} % location of master.tex

    \lhead{Steven Phung}
    \rhead{$1} % Course
    \chead{$2} % Subject

    \title{$1}
    \author{Steven Phung}
    \date{\today}

    \begin{document}
    \maketitle
        $3
    \tableofcontents

    \newpage
    \section{$4}
        $0

    \end{document}
]]
table.insert(snippets, ls.parser.parse_snippet("template", template))

local math_sets = {
   s("empty", { t("\\emptyset"), i(0) }, { condition = math_mode }),
   s("NN", { t("\\mathbb{N}"), i(0) }, { condition = math_mode }),
   s("PP", { t("\\mathbb{P}"), i(0) }, { condition = math_mode }),
   s("QQ", { t("\\mathbb{Q}"), i(0) }, { condition = math_mode }),
   s("CC", { t("\\mathbb{CC}"), i(0) }, { condition = math_mode }),
   s("ZZ", { t("\\mathbb{ZZ}"), i(0) }, { condition = math_mode }),

   s("AA", { t("\\mathbb{A}"), i(0) }, { condition = math_mode }),
   s("MM", { t("\\mathfrak{m}"), i(0) }, { condition = math_mode }),
   s("Pp", { t("\\mathfrak{p}"), i(0) }, { condition = math_mode }),
   s("OO", { t("\\mathscr{O}"), i(0) }, { condition = math_mode }),

}
insert_to_autosnip(math_sets)

local math_greeks = {
   s("alp", { t("\\alpha"), i(0) }, { condition = math_mode }),
   s("beta", { t("\\beta"), i(0) }, { condition = math_mode }),
   s("gamm", { t("\\gamma"), i(0) }, { condition = math_mode }),
   s("delt", { t("\\delta"), i(0) }, { condition = math_mode }),
   s("nab", { t("\\nabla"), i(0) }, { condition = math_mode }),
   s("epsi", { t("\\epsilon"), i(0) }, { condition = math_mode }),
   s("zet", { t("\\zeta"), i(0) }, { condition = math_mode }),
   s("eta", { t("\\eta"), i(0) }, { condition = math_mode }),
   s("thet", { t("\\theta"), i(0) }, { condition = math_mode }),
   s("iot", { t("\\iota"), i(0) }, { condition = math_mode }),
   s("kap", { t("\\kappa"), i(0) }, { condition = math_mode }),
   s("lam", { t("\\lambda"), i(0) }, { condition = math_mode }),
   s("mu", { t("\\mu"), i(0) }, { condition = math_mode }),
   s("nu", { t("\\nu"), i(0) }, { condition = math_mode }),
   s("xi", { t("\\xi"), i(0) }, { condition = math_mode }),
   s("omi", { t("\\omicron"), i(0) }, { condition = math_mode }),
   s("pi", { t("\\pi"), i(0) }, { condition = math_mode }),
   s("sig", { t("\\sigma"), i(0) }, { condition = math_mode }),
   s("tau", { t("\\tau"), i(0) }, { condition = math_mode }),
   s("upsi", { t("\\upsilon"), i(0) }, { condition = math_mode }),
   s("phi", { t("\\phi"), i(0) }, { condition = math_mode }),
   s("Phi", { t("\\varphi"), i(0) }, { condition = math_mode }),
   s("chi", { t("\\chi"), i(0) }, { condition = math_mode }),
   s("psi", { t("\\psi"), i(0) }, { condition = math_mode }),
   s("omeg", { t("\\omega"), i(0) }, { condition = math_mode }),
}
insert_to_autosnip(math_greeks)

local math_arrows = {
   s("=>", { t("\\implies"), i(0) }, { condition = math_mode }),
   s("=<", { t("\\impliedby"), i(0) }, { condition = math_mode }),
   s("iff", { t("\\iff"), i(0) }, { condition = math_mode }),
   s(">=", { t("\\geq"), i(0) }, { condition = math_mode }),
   s("<=", { t("\\leq"), i(0) }, { condition = math_mode }),
   s("<=", { t("\\leq"), i(0) }, { condition = math_mode }),
   s("->", { t("\\to"), i(0) }, { condition = math_mode }),
   s("<-", { t("\\gets"), i(0) }, { condition = math_mode }),
   s("~>", { t("\\rightsquigarrow"), i(0) }, { condition = math_mode }),
   s("<~", { t("\\rightsquigarrow"), i(0) }, { condition = math_mode }),
   s(">>", { t("\\twoheadrightarrow"), i(0) }, { condition = math_mode }),
   s("<<", { t("\\twoheadleftarrow"), i(0) }, { condition = math_mode }),
   s("<!", { t("\\triangleleft"), i(0) }, { condition = math_mode }),
   s("!>", { t("\\triangleright"), i(0) }, { condition = math_mode }),
   s("maps", { t("\\mapsto"), i(0) }, { condition = math_mode }),
   s("!=", { t("\\neq"), i(0) }, { condition = math_mode }),
}
insert_to_autosnip(math_arrows)


return snippets, autosnippets
