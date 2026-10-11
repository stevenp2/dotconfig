local ctx = require("stevenp2.snippets.tex.context")
local ls, s, t, i, rep, math_mode = ctx.ls, ctx.s, ctx.t, ctx.i, ctx.rep, ctx.math_mode

return {
  autosnippets = {
    s("opname", { t("\\operatorname{"), i(1), t("}"), i(0) }, { condition = math_mode }),
    s("ds", { t("\\displaystyle"), i(0) }, { condition = math_mode }),
    s("text", { t("\\text{"), i(1), t("}"), i(0) }, { condition = math_mode }),
    s("pmat", { t({ "\\begin{pmatrix}", "\t" }), i(1), t({ "", "\\end{pmatrix}", "" }), i(0) }, { condition = math_mode }),
    s("bmat", { t({ "\\begin{bmatrix}", "\t" }), i(1), t({ "", "\\end{bmatrix}", "" }), i(0) }, { condition = math_mode }),
    s("imat", { t({ "\\begin{matrix}", "\t" }), i(1), t({ "", "\\end{matrix}", "" }), i(0) }, { condition = math_mode }),
    s("cases", { t({ "\\begin{cases}", "\t" }), i(1), t({ ", & \\text{" }), i(2), t({ "} \\\\", "\t" }), i(3), t(", & \\text{"), i(4), t({ "}", "\\end{cases}", "" }), i(0) }, { condition = math_mode }),
    s("{}", { t("{"), i(1), t("}"), i(0) }),
    s("$", { t("$"), i(1), t("$"), i(0) }),
  },
  snippets = {
    s("bold", { t("\\textbf{"), i(1), t("}"), i(0) }),
    s("italic", { t("\\textit{"), i(1), t("}"), i(0) }),
    s("underline", { t("\\underline{"), i(1), t("}"), i(0) }),
    s("underbrace", { t("\\underbrace{"), i(1, "target"), t("}"), t("_{"), i(2, "below"), t("}"), i(0) }),
    s("overset", { t("\\overset{"), i(1, "above"), t("}"), t("{"), i(2, "target"), t("}"), i(0) }),
    s("beg", { t("\\begin{"), i(1), t({ "}", "\t" }), i(2), t({ "", "\\end{" }), rep(1), t({ "}", "" }), i(0) }),
    s("item", { t({ "\\begin{itemize}", "\t \\item " }), i(1), t({ "", "\\end{itemize}", "" }), i(0) }),
    s("enum", { t({ "\\begin{enumerate}[label=\\roman{enumi}]", "\t \\item " }), i(1), t({ "", "\\end{enumerate}", "" }), i(0) }),
    ls.parser.parse_snippet("fig", [[
      \begin{center}
        \captionsetup{type=figure}
        \includegraphics[width=0.8\textwidth, scale=0.5]{$1}
        \captionof{figure}{$2}\label{$3}
      \end{center}
      $0
   ]]),
  },
}
