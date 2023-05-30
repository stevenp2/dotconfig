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
    enable_autosnippets = true,
})

-- only insert under math mode in latex
local math_mode = function()
    return vim.api.nvim_command_output("echo vimtex#syntax#in_mathzone()") == '1'
end

local insert_to_snip = function(snip_list, ret_list)
    for _, snippet in ipairs(snip_list) do
        table.insert(ret_list, snippet)
    end
end

local preamble = [[
    \usepackage[tmargin=1cm,rmargin=1in,lmargin=1in,margin=0.85in,bmargin=2cm,footskip=.2in, headsep=.1in]{geometry}
    \usepackage{amsmath,amsthm,amssymb, mathtools,amsfonts, fancyhdr, color, graphicx}
    \usepackage{xcolor}
    \usepackage{pdfpages}
    \usepackage{indentfirst}
    \usepackage{hyperref}
    \usepackage{enumitem}

    % get rid of indent
    \setlength{\parindent}{0pt}
    \pagestyle{fancy}

    \renewcommand{\vec}[1]{\mathbf{#1}}
    % \renewcommand{\labelitemi}{$\circ$}

    \pdfsuppresswarningpagegroup=1

    \theoremstyle{plain}
    \newtheorem{thm}{Theorem}[section]
    \newtheorem{prop}[thm]{Proposition}
    \newtheorem{cor}[thm]{Corollary}
    \newtheorem{lem}[thm]{Lemma}

    \theoremstyle{definition}
    \newtheorem{dfn}[thm]{Definition}
    \newtheorem{ex}[thm]{Example}

    \theoremstyle{remark}
    \newtheorem{rem}[thm]{Remark}
    \newcommand{\nt}[1]{\fbox{\parbox{\linewidth - 0.1in}{\fbox{\textbf{Note:-}} \par #1}}}
]]
table.insert(snippets, ls.parser.parse_snippet("preamble", preamble))

local template = [[
    \documentclass{article}
    \input{../preamble.tex}

    \lhead{$1}
    \rhead{$2} % Course
    \chead{$3} % Subject

    \title{$2 - $3}
    \author{$1}
    \date{$4 - \today}

    \begin{document}
    \maketitle
    \pagebreak
    \tableofcontents
    \pagebreak
    \setcounter{page}{1}

    \section{$5}
        \input{$0}

    % \begin{appendices}
    %     \section{}
    %     \input{}
    % \end{appendices}

    \end{document}
]]
table.insert(snippets, ls.parser.parse_snippet("template", template))

local math_sets = {
   s("empty", { t("\\emptyset"), i(0) }, { condition = math_mode }),
   s("inf", { t("\\infty"), i(0) }, { condition = math_mode }),
   s("NN", { t("\\mathbb{N}"), i(0) }, { condition = math_mode }),
   s("PP", { t("\\mathbb{P}"), i(0) }, { condition = math_mode }),
   s("QQ", { t("\\mathbb{Q}"), i(0) }, { condition = math_mode }),
   s("CC", { t("\\mathbb{C}"), i(0) }, { condition = math_mode }),
   s("RR", { t("\\mathbb{R}"), i(0) }, { condition = math_mode }),
   s("ZZ", { t("\\mathbb{Z}"), i(0) }, { condition = math_mode }),

   s("AA", { t("\\mathbb{A}"), i(0) }, { condition = math_mode }),
   s("MM", { t("\\mathfrak{m}"), i(0) }, { condition = math_mode }),
   s("Pp", { t("\\mathfrak{p}"), i(0) }, { condition = math_mode }),
   s("OO", { t("\\mathscr{O}"), i(0) }, { condition = math_mode }),
   s("sett", { t("\\left\\{ "), i(1, "elem"), t(" \\mid " ), i(2, "conditions"), t(" \\right\\}"), i(0) }, { condition = math_mode }),

   s("subset", { t("\\subset"), i(0) }, { condition = math_mode }),
   s("cup", { t("\\cup{"), i(1, "n = 1}"), t("^{"), i(2, "\\infty"), t("}"), i(0) }, { condition = math_mode }),
   s("cap", { t("\\cap{"), i(1, "n = 1}"), t("^{"), i(2, "\\infty"), t("}"), i(0) }, { condition = math_mode }),
   s("<|", { t("\\triangleleft"), i(0) }, { condition = math_mode }),
   s("|>", { t("\\triangleright"), i(0) }, { condition = math_mode }),
}
insert_to_snip(math_sets, autosnippets)

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
insert_to_snip(math_greeks, autosnippets)

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
   s("maps", { t("\\mapsto"), i(0) }, { condition = math_mode }),
   s("!=", { t("\\neq"), i(0) }, { condition = math_mode }),
}
insert_to_snip(math_arrows, autosnippets)

local math_functions = {
   s("//", { t("\\frac{"), i(1), t("}{"), i(2), t("}"), i(0) }, { condition = math_mode } ),
   s("diff", { t("\\frac{d "), i(1), t("}{d "), i(2), t("}"), i(0) }, { condition = math_mode } ),
   s("partial", { t("\\frac{\\partial "), i(1), t("}{\\partial "), i(2), t("}"), i(0) }, { condition = math_mode } ),
   s("log", { t("\\log{"), i(1), t("}"), i(0) }, { condition = math_mode }),
   s("ceil", { t("\\left\\lceil "), i(1), t("\\right\\rceil"), i(0) }, { condition = math_mode }),
   s("floor", { t("\\left\\lfloor "), i(1), t("\\right\\rfloor"), i(0) }, { condition = math_mode }),
   s("conj", { t("\\overline{"), i(1), t("}"), i(0) }, { condition = math_mode }),
   s("sum", { t("\\sum_{"), i(1, "n=1}"), t("^{"), i(2, "\\infty"), t("}"), i(0) }, { condition = math_mode }),
   s("prod", { t("\\prod{"), i(1, "n=1}"), t("^{"), i(2, "\\infty"), t("}"), i(0) }, { condition = math_mode }),
   s("int", { t("\\int_{"), i(1, "-\\infty}"), t("^{"), i(2, "\\infty"), t("}"), i(0) }, { condition = math_mode }),
   s("limm", { t("\\lim{"), i(1, "1 \\to \\infty"), t("}"), i(0) }, { condition = math_mode }),
   s("limm", { t("\\lim{"), i(1, "1 \\to \\infty"), t("}"), i(0) }, { condition = math_mode }),
   s("limsup", { t("\\limsup_{"), i(1, "1 \\to \\infty"), t("}"), i(0) }, { condition = math_mode }),
   s("sqrt", { t("\\sqrt["),i(1), t("]{"), i(2), t("}"), i(0) }, { condition = math_mode }),
   s("abs", { t("\\left| "), i(1), t(" \\right|"), i(0) }, { condition = math_mode }),
   s("^^", { t("^{"), i(1), t("}"), i(0) }, { condition = math_mode }),
   s("__", { t("_{"), i(1), t("}"), i(0) }, { condition = math_mode }),
}
insert_to_snip(math_functions, autosnippets)

local math_operators = {
   s("()", { t("("), i(1), t(")"), i(0) }, { condition = math_mode }),
   s("[]", { t("["), i(1), t("]"), i(0) }, { condition = math_mode }),
   s("+-", { t("\\pm"), i(0) }, { condition = math_mode }),
   s("-+", { t("\\mp"), i(0) }, { condition = math_mode }),
   s("o+", { t("\\oplus"), i(0) }, { condition = math_mode }),
   s("ox", { t("\\otimes"), i(0) }, { condition = math_mode }),
   s("**", { t("\\cdot"), i(0) }, { condition = math_mode }),
   s("xx", { t("\\times"), i(0) }, { condition = math_mode }),
   s("<>", { t("\\langle "), i(1), t(" \\rangle"), i(0) }, { condition = math_mode }),
}
insert_to_snip(math_operators, autosnippets)

local math_quantifiers = {
   s("exists", { t("\\exists"),i(0) }, { condition = math_mode }),
   s("forall", { t("\\forall"),i(0) }, { condition = math_mode }),
   s("not", { t("\\not"),i(0) }, { condition = math_mode }),
   s("inn", { t("\\in"),i(0) }, { condition = math_mode }),
}
insert_to_snip(math_quantifiers, autosnippets)

local math_misc = {
   s("...", { t("\\ldots"),i(0) }, { condition = math_mode }),
   s("`", { t("~"),i(0) }, { condition = math_mode }),
   s("~~", { t("\\approx"),i(0) }, { condition = math_mode }),
   s("~-", { t("\\simeq"),i(0) }, { condition = math_mode }),
   s("~=", { t("\\cong"),i(0) }, { condition = math_mode }),
   s("-=", { t("\\equiv"),i(0) }, { condition = math_mode }),
}
insert_to_snip(math_misc, autosnippets)

local latex_general_auto = {
   s("opname", { t("\\operatorname{"), i(1), t("}"), i(0) }, { condition = math_mode }),
   s("ds", { t("\\displaystyle"),i(0) }, { condition = math_mode }),
   s("text", { t("\\text{"), i(1), t("}"), i(0)}, { condition = math_mode }),
   s("pmat", { t{"\\begin{pmatrix}", "\t"}, i(1), t{"", "\\end{pmatrix}", ""}, i(0)}, { condition = math_mode }),
   s("bmat", { t{"\\begin{bmatrix}", "\t"}, i(1), t{"", "\\end{bmatrix}", ""}, i(0)}, { condition = math_mode }),
   s("imat", { t{"\\begin{matrix}", "\t"}, i(1), t{"", "\\end{matrix}", ""}, i(0)}, { condition = math_mode }),
   s("cases", { t{"\\begin{case}", "\t"}, i(1), t{", & \\text{"}, i(2), t{"} \\\\", "\t"}, i(3), t(", & \\text{"), i(4), t{"}", "\\end{cases}", ""}, i(0)}, { condition = math_mode }),
   s("{}", { t("{"), i(1), t("}"), i(0) }),
   s("$", { t("$"), i(1), t("$"), i(0) }),
}
insert_to_snip(latex_general_auto, autosnippets)

local latex_general = {
   s("bold", { t("\\textbf{"), i(1), t("}"), i(0)}),
   s("italic", { t("\\textit{"), i(1), t("}"), i(0)}),
   s("underline", { t("\\underline{"), i(1), t("}"), i(0)}),
   s("underbrace", { t("\\underbrace{"), i(1, "target"), t("}"), t("_{"), i(2, "below"), t("}"), i(0)}),
   s("overset", { t("\\overset{"), i(1, "above"), t("}"), t("{"), i(2, "target"), t("}"), i(0)}),
   s("beg", { t("\\begin{"), i(1), t{"}", "\t"}, i(2), t{"", "\\end{"}, rep(1), t{"}", ""} , i(0)}),
   s("item", { t{"\\begin{itemize}", "\t \\item "}, i(1), t{"", "\\end{itemize}", ""}, i(0)}),
   s("enum", { t{"\\begin{enumerate}[label=\\roman{enumi}]", "\t \\item "}, i(1), t{"", "\\end{enumerate}", ""}, i(0)}),
   ls.parser.parse_snippet("fig", [[
      \begin{center}
        \captionsetup{type=figure}
        \includegraphics[width=0.8\textwidth, scale=0.5]{$1}
        \captionof{figure}{$2}\label{$3}
      \end{center}
      $0
   ]])
}
insert_to_snip(latex_general, snippets)

return snippets, autosnippets




