local ls = require("luasnip")

ls.config.setup({ history = true,
update_events = 'TextChanged, TextChangedI',
enable_autosnippets = true })

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
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key


vim.keymap.set({"i"}, "<Tab>", function() 
    ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<Tab>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<S-Tab>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

local date = function() return {os.date('%Y-%m-%d')} end
ls.add_snippets("all", {
        s({
            trig = "bruh",
            name = "Date",
            dscr = "Date in the form of YYYY-MM-DD",
        }, {
            f(date, {})
        }),
        
})

--tex

local in_mathzone = function()
    -- The `in_mathzone` function requires the VimTeX plugin
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
  end
  -- Then pass the table `{condition = in_mathzone}` to any snippet you want to
  -- expand only in math contexts.

ls.add_snippets("all", {
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
        trig = "//",
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
    s({
        trig = "(%S+)/",
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
        trig = "(%S+)bar",
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

    s({
        trig = "(%S+)und",
        name = "underline",
        wordTrig = false,
        regTrig = true,
        snippetType = "autosnippet"
    },
    f(function(_, snip)
        return "\\underline{"..snip.captures[1].."}"
    end, {})
    ),

   s({
        trig = "(%S+)-dot",
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
        trig = "(%S+)-ddot",
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
        trig = "(%S+)hat",
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
        trig = "(%S+)vec",
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
        trig = "(%S+)ora",
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
        trig = "(%S+)ola",
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
        trig = "dfd",
        name = "first derivative",
        snippetType = "autosnippet"
    },{
        t("\\dv{"),
        i(1),
        t("}{"),
        i(2),
        t("}")
    },
        {condition = in_mathzone}
    ),

    s({
        trig = "dd",
        name = "first derivative operator",
        snippetType = "autosnippet"
    }, {
        t("\\dv{"),
        i(1),
        t("}")
        },
        {condition = in_mathzone}
    ),

    s({
        trig = "d(%w+)fd",
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

    s({
        trig = "d(%w+)d",
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
 s({
        trig = "pfp",
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

    s({
        trig = "pp",
        name = "first partial derivative operator",
        snippetType = "autosnippet"
    }, {
        t("\\pdv{"),
        i(1),
        t("}")
        },
        {condition = in_mathzone}
    ),

    s({
        trig = "p(%w+)fp",
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

    s({
        trig = "p(%w+)p",
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

})

