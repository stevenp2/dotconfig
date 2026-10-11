local ctx = require("stevenp2.snippets.tex.context")
local s, t, i, math_mode = ctx.s, ctx.t, ctx.i, ctx.math_mode

return {
  autosnippets = {
    -- functions and structured expressions
    s("//", { t("\\frac{"), i(1), t("}{"), i(2), t("}"), i(0) }, { condition = math_mode }),
    s("diff", { t("\\frac{d "), i(1), t("}{d "), i(2), t("}"), i(0) }, { condition = math_mode }),
    s("partial", { t("\\frac{\\partial "), i(1), t("}{\\partial "), i(2), t("}"), i(0) }, { condition = math_mode }),
    s("log", { t("\\log{"), i(1), t("}"), i(0) }, { condition = math_mode }),
    s("ceil", { t("\\left\\lceil "), i(1), t("\\right\\rceil"), i(0) }, { condition = math_mode }),
    s("floor", { t("\\left\\lfloor "), i(1), t("\\right\\rfloor"), i(0) }, { condition = math_mode }),
    s("conj", { t("\\overline{"), i(1), t("}"), i(0) }, { condition = math_mode }),
    s("sum", { t("\\sum_{"), i(1, "n=1"), t("}^{"), i(2, "\\infty"), t("}"), i(0) }, { condition = math_mode }),
    s("prod", { t("\\prod_{"), i(1, "n=1"), t("}^{"), i(2, "\\infty"), t("}"), i(0) }, { condition = math_mode }),
    s("int", { t("\\int_{"), i(1, "-\\infty"), t("}^{"), i(2, "\\infty"), t("}"), i(0) }, { condition = math_mode }),
    s("limm", { t("\\lim_{"), i(1, "1 \\to \\infty"), t("}"), i(0) }, { condition = math_mode }),
    s("limsup", { t("\\limsup_{"), i(1, "1 \\to \\infty"), t("}"), i(0) }, { condition = math_mode }),
    s("sqrt", { t("\\sqrt["), i(1), t("]{"), i(2), t("}"), i(0) }, { condition = math_mode }),
    s("abs", { t("\\left| "), i(1), t(" \\right|"), i(0) }, { condition = math_mode }),
    s("^^", { t("^{"), i(1), t("}"), i(0) }, { condition = math_mode }),
    s("__", { t("_{"), i(1), t("}"), i(0) }, { condition = math_mode }),

    -- operators and paired delimiters
    s("()", { t("("), i(1), t(")"), i(0) }, { condition = math_mode }),
    s("[]", { t("["), i(1), t("]"), i(0) }, { condition = math_mode }),
    s("+-", { t("\\pm"), i(0) }, { condition = math_mode }),
    s("-+", { t("\\mp"), i(0) }, { condition = math_mode }),
    s("o+", { t("\\oplus"), i(0) }, { condition = math_mode }),
    s("ox", { t("\\otimes"), i(0) }, { condition = math_mode }),
    s("**", { t("\\cdot"), i(0) }, { condition = math_mode }),
    s("xx", { t("\\times"), i(0) }, { condition = math_mode }),
    s("<>", { t("\\langle "), i(1), t(" \\rangle"), i(0) }, { condition = math_mode }),
  },
}
