local ls = require("luasnip")

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

return {
  snippets = {
    ls.parser.parse_snippet("preamble", preamble),
    ls.parser.parse_snippet("template", template),
  },
}
