local ls = require("luasnip")

ls.config.setup({ history = true,
update_events = 'TextChanged, TextChangedI',
enable_autosnippets = true })

local s = ls.snippet
--local sn = ls.snippet_node
--local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
--local c = ls.choice_node
--local d = ls.dynamic_node
--local r = ls.restore_node
--local events = require("luasnip.util.events")
--local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
--local l = extras.lambda
local rep = extras.rep
--local p = extras.partial
--local m = extras.match
--local n = extras.nonempty
--local dl = extras.dynamic_lambda
--local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
--local conds = require("luasnip.extras.expand_conditions")
--local postfix = require("luasnip.extras.postfix").postfix
--local types = require("luasnip.util.types")
--local parse = require("luasnip.util.parser").parse_snippet
--local ms = ls.multi_snippet
--local k = require("luasnip.nodes.key_indexer").new_key

vim.keymap.set({"i", "s"}, "<Tab>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<S-Tab>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

--tex

local in_mathzone = function()
    -- The `in_mathzone` function requires the VimTeX plugin
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
  end
  -- Then pass the table `{condition = in_mathzone}` to any snippet you want to
-- expand only in math contexts.

ls.add_snippets("html", {
   s({
      trig = "qs",
      name = "quick start for html",
      dscr = "completes a standard skeleton for html",
      snippetType = "snippet"
   },
    fmta(
      [[
      <<!DOCTYPE html>>
      <<html lang="en">>
         <<head>> 
            <<meta charset="UFT-8">>
            <<link type="text\css" rel="stylesheet" href="">>
            <<title>><><</title>>
            <<meta name="description" content="">>
         <</head>>
         <<body>>
            <<div id="wrapper">>
               <<header>>
                  <>
               <</header>>
               <<nav>>
                  <>
               <</nav>>
               <<main>>
                  <>
               <</main>>
               <<footer>>
                  <>
               <</footer>>
            <</div>>
         <<script src="">><</script>>
         <</body>>
      <</html>>
      ]],

      {
      i(1),
      i(2),
      i(3),
      i(4),
      i(5)
      }
     )
   )
})

ls.add_snippets("tex", {
    s({
        trig = "test",
    }, t("bruh")),

    s({
        trig = "qsa",
        name = "quick start article document",
        dscr = "completes an article document setup",
        snippetType = "snippet"
    }, fmta(
           [[
           \documentclass[12pt]{article}
           \usepackage[margin = 1in]{geometry}
           \usepackage{graphicx, wrapfig, pifont, array, enumitem, amsmath, amsthm, mathtools, amssymb, faktor, xfrac, setspace, physics}

           \renewcommand\qedsymbol{\(\blacksquare\)}

           \DeclareMathOperator{\adj}{adj}
           \DeclareMathOperator{\ord}{ord}
           \DeclareMathOperator{\lcm}{lcm}
           \DeclareMathOperator{\ima}{Im}
           \DeclareMathOperator{\itr}{int}
           \DeclareMathOperator{\ext}{ext}

           \newcommand{\tmod}[1]{~(\text{mod}~#1)}
           \newcommand{\ang}[1]{\left\langle #1 \right\rangle}
           \newcommand{\tang}[1]{\textlangle#1\textrangle}

           \theoremstyle{definition}
           \newtheorem*{df}{Definition}

           %\newcolumntype{C}{>>{\(}c<<{\)}}

           \allowdisplaybreaks

           \title{<>}
           \author{Ray Hu}
           \date{<>}

           \begin{document}

           \maketitle
           \onehalfspacing

           <>

           \end{document}
           ]],
            {
            i(1),
            i(2),
            i(3),
            }
        )
    ),

    s({
        trig = "\\(",
        name = "Inline Math Mode",
        dscr = "Completes inline math environment",
        snippetType = "autosnippet"
    }, {
        t("\\("),
        i(1),
        t("\\)")
    }),

    s({
        trig = "\\[",
        name = "Display Math Mode",
        dscr = "Completes display math environment",
        snippetType = "autosnippet"
    }, {
        t("\\["),
        i(1),
        t("\\]")
    }),

    s({
        trig = "\\{",
        name = "Brackets",
        dscr = "auto-completes brackets",
        snippetType = "autosnippet"
    }, {
        t("\\{"),
        i(1),
        t("\\}")
    }),



    s({
        trig = "\\left(",
        name = "\\left \\right",
        dscr = "Completes \\left( \\right)",
        snippetType = "autosnippet"
    }, {
        t("\\left("),
        i(1),
        t("\\right")
        }
    ),

     s({
        trig = "\\left[",
        name = "\\left \\right",
        dscr = "Completes \\left[ \\right]",
        snippetType = "autosnippet"
    }, {
        t("\\left["),
        i(1),
        t("\\right")
        }
    ),

      s({
        trig = "\\left{",
        name = "\\left \\right",
        dscr = "Completes \\left{ \\right}",
        snippetType = "autosnippet"
    }, {
        t("\\left{"),
        i(1),
        t("\\right")
        }
    ),

       s({
        trig = "\\left|",
        name = "\\left \\right",
        dscr = "Completes \\left| \\right|",
        snippetType = "autosnippet"
    }, {
        t("\\left|"),
        i(1),
        t("\\right|")
        }
    ),

       s({
        trig = "txb",
        name = "bold",
        dscr = "Completes \\textbf",
        snippetType = "autosnippet"
    }, {
        t("\\textbf{"),
        i(1),
        t("}")
        }
    ),

    s({
        trig = "beg",
        name = "Environment Setup",
        snippetType = "snippet"
    }, fmta(
        [[
            \begin{<>}
               <>
            \end{<>}
        ]],
        {
            i(1),
            i(2),
            rep(1)
        }
    )
    ),

    s({
        trig = "ff",
        name = "Fraction 1",
        dscr = "Creates \\frac{}{} command",
        snippetType = "autosnippet"
    }, fmta(
      "\\frac{<>}{<>}",
      {
        i(1),
        i(2),
      }
    ),
    {condition = in_mathzone}  -- `condition` option passed in the snippet `opts` table 
  ),

--[[
    ({
        trig = "qf",
        name = "quotient fraction",
        dscr = "creates \\faktor{}{} for quotients",
        snippetType = "autosnippet"
    }, fmta(
      "\\faktor{<>}{<>}",
      {
        i(1),
        i(2),
      }
    ),
    {condition = in_mathzone}  -- `condition` option passed in the snippet `opts` table 
  ),

    s({
        trig = "qsf",
        name = "small quotient fraction",
        dscr = "creates \\xfrac{}{} for quotients",
        snippetType = "autosnippet"
    }, fmta(
      "\\sfrac{<>}{<>}",
      {
        i(1),
        i(2),
      }
    ),
    {condition = in_mathzone}  -- `condition` option passed in the snippet `opts` table 
  ),
]]

    s({
        trig = "(%w+)/",
        name = "Fraction 2",
        dscr = "Turns a/ into \\frac{a}{}",
        wordTrig = false,
        regTrig = true,
        snippetType = "autosnippet"},
    {
        f(function(_, snip) return "\\frac{"..snip.captures[1].."}{" end),
        i(1),
        t("}")
    },
    {condition = in_mathzone}  -- `condition` option passed in the snippet `opts` table
  ),

    s({
        trig = "(%w)bar",
        name = "overbar",
        wordTrig = false,
        regTrig = true,
        snippetType = "autosnippet"
    },
    f(function(_, snip)
        return "\\overline{"..snip.captures[1].."}"
    end, {}),
        {condition = in_mathzone}
    ),

   --[[ s({
        trig = "(%S+)-und",
        name = "underline",
        wordTrig = false,
        regTrig = true,
        snippetType = "autosnippet"
    },
    f(function(_, snip)
        return "\\underline{"..snip.captures[1].."}"
    end, {})
    ),
    ]]

       s({
        trig = "-und",
        name = "underline",
        dscr = "Completes \\underline{}",
        snippetType = "autosnippet"
    }, {
        t("\\underline{"),
        i(1),
        t("}")
        }
    ),


   s({
        trig = "(%w)dt",
        name = "dot",
        wordTrig = false,
        regTrig = true,
        snippetType = "autosnippet"
    },
    f(function(_, snip)
        return "\\dot{"..snip.captures[1].."}"
    end, {}),
        {condition = in_mathzone}
    ),

   s({
        trig = "(%w)Dt",
        name = "double dot",
        wordTrig = false,
        regTrig = true,
        snippetType = "autosnippet"
    },
    f(function(_, snip)
        return "\\ddot{"..snip.captures[1].."}"
    end, {}),
        {condition = in_mathzone}
    ),

    s({
        trig = "(%w)hat",
        name = "hat",
        wordTrig = false,
        regTrig = true,
        snippetType = "autosnippet"
    },
    f(function(_, snip)
        return "\\hat{"..snip.captures[1].."}"
    end, {}),
        {condition = in_mathzone}
    ),

    s({
        trig = "(%w)vec",
        name = "vector",
        wordTrig = false,
        regTrig = true,
        snippetType = "autosnippet"
    },
    f(function(_, snip)
        return "\\vec{"..snip.captures[1].."}"
    end, {}),
        {condition = in_mathzone}
    ),

    s({
        trig = "(%w)ora",
        name = "over right arrow",
        wordTrig = false,
        regTrig = true,
        snippetType = "autosnippet"
    },
    f(function(_, snip)
        return "\\overrightarrow{"..snip.captures[1].."}"
    end, {}),
        {condition = in_mathzone}
    ),

    s({
        trig = "(%w)ola",
        name = "over left arrow",
        wordTrig = false,
        regTrig = true,
        snippetType = "autosnippet"
    },
    f(function(_, snip)
        return "\\overleftarrow{"..snip.captures[1].."}"
    end, {}),
        {condition = in_mathzone}
    ),

    s({
        --[[trig = "([%w%/%{%}%\\]+)til"]]
        trig = "(%w)til",
        name = "tilde",
        wordTrig = false,
        regTrig = true,
        snippetType = "autosnippet"
    },
    f(function(_, snip)
        return "\\widetilde{"..snip.captures[1].."}"
    end, {}),
        {condition = in_mathzone}
    ),

    s({
        trig = "dd",
        name = "differential",
        snippetType = "autosnippet"
    },{
        t("\\dd{"),
        i(1),
        t("}")
        },
        {condition = in_mathzone}
    ),

    s({
        trig = "pp",
        name = "partial differential",
        snippetType = "autosnippet"
    },{
        t("\\partial{"),
        i(1),
        t("}")
        },
        {condition = in_mathzone}
    ),


--[[    s({
        trig = "dfv",
        name = "first derivative",
        snippetType = "autosnippet"
    }, {
        t("\\dv{"),
        i(1),
        t("}{"),
        i(2),
        t("}")
        },
        {condition = in_mathzone}
    ),
]]

    s({
        trig = "dv",
        name = "first derivative operator",
        snippetType = "autosnippet"
    }, {
        t("\\dv{"),
        i(1),
        t("}")
        },
        {condition = in_mathzone}
    ),

    --[[
    s({
        trig = "d^(%w+)fv",
        name = "nth derivative",
        wordTrig = false,
        regTrig = true,
        snippetType = "autosnippet"
    }, {
        f(function(_, snip)
            return "\\dv["..snip.captures[1].."]{"
        end, {}),
        i(1),
        t("}{"),
        i(2),
        t("}")
        },
        {condition = in_mathzone}
    ),
    ]]

    s({
        trig = "d^(%w+)v",
        name = "nth derivative operator",
        wordTrig = false,
        regTrig = true,
        snippetType = "autosnippet"
    }, {
        f(function(_, snip)
            return "\\dv["..snip.captures[1].."]{" end, {}),
        i(1),
        t("}"),
        },
        {condition = in_mathzone}
     ),

    --[[
 s({
        trig = "pfv",
        name = "first partial derivative",
        snippetType = "autosnippet"
    },{
        t("\\pdv{"),
        i(1),
        t("}{"),
        i(2),
        t("}")
    },
        {condition = in_mathzone}
    ),
    ]]

    s({
        trig = "pv",
        name = "first partial derivative operator",
        snippetType = "autosnippet"
    }, {
        t("\\pdv{"),
        i(1),
        t("}")
        },
        {condition = in_mathzone}
    ),

    --[[

    s({
        trig = "p^(%w+)fv",
        name = "nth derivative",
        wordTrig = false,
        regTrig = true,
        snippetType = "autosnippet"
    }, {
        f(function(_, snip)
            return "\\pdv["..snip.captures[1].."]{"
        end, {}),
        i(1),
        t("}{"),
        i(2),
        t("}")
        },
        {condition = in_mathzone}
    ),
    ]]

    s({
        trig = "p^(%w+)v",
        name = "nth derivative operator",
        wordTrig = false,
        regTrig = true,
        snippetType = "autosnippet"
    }, {
        f(function(_, snip)
            return "\\pdv["..snip.captures[1].."]{" end, {}),
        i(1),
        t("}"),
        },
        {condition = in_mathzone}
     ),

    s({
        trig = "epv",
        name = "varepsilon",
        snippetType = "autosnippet"
    }, {
        t("\\varepsilon")
        },
        {condition = in_mathzone}
    ),

    s({
        trig = "phv",
        name = "varphi",
        snippetType = "autosnippet"
    }, {
        t("\\varphi")
        },
        {condition = in_mathzone}
    ),

    s({
        trig = "o+",
        name = "oplus",
        snippetType = "autosnippet"
    }, {
        t("\\oplus")
        },
        {condition = in_mathzone}
    ),

    s({
        trig = "ot",
        name = "otimes",
        snippetType = "autosnippet"
    }, {
        t("\\otimes")
        },
        {condition = in_mathzone}
    ),

    s({
        trig = "\\(%u),",
        name = "blackboard bold",
        wordTrig = false,
        regTrig = true,
        snippetType = "autosnippet"
    }, {
        f(function(_, snip)
            return "\\mathbb{"..snip.captures[1].."}" end)
        },
        {condition = in_mathzone}
    ),

    s({
        trig = "\\(%u)%.",
        name = "mathcal",
        wordTrig = false,
        regTrig = true,
        snippetType = "autosnippet"
    }, {
        f(function(_, snip)
            return "\\mathcal{"..snip.captures[1].."}" end)
        },
        {condition = in_mathzone}
    ),

    s({
        trig = "\\(%u);",
        name = "mathfrak",
        wordTrig = false,
        regTrig = true,
        snippetType = "autosnippet"
    }, {
        f(function(_, snip)
            return "\\mathfrak{"..snip.captures[1].."}" end)
        },
        {condition = in_mathzone}
    ),


    s({
        trig = "([%a%)%}%]])(%d+) ",
        name = "quick subscript",
        wordTrig = false,
        regTrig = true,
        snippetType = "autosnippet"
    },{
      f(function(_, snip) return snip.captures[1].."_{"..snip.captures[2].."}" end)
    },
        {condition = in_mathzone}
    ),

    s({
        trig = "([\\?[%w%[%]%{%}]+)__(%w+) ",
        name = "quick subscript sequence",
        dscr = "generates a_1, a_2, ... a_n given a and n as input",
        wordTrig = false,
        regTrig = true,
        snippetType = "autosnippet"
    }, {
        f(function(_, snip) return snip.captures[1].."_{1}, "..snip.captures[1].."_{2}, \\ldots, "..snip.captures[1].."_{"..snip.captures[2].. "}" end)
        },
        {condition = in_mathzone}
    ),
})

