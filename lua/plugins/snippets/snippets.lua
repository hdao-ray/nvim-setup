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

ls.add_snippets("tex", {
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
        trig = "beg", 
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
        snippetType = "autosnippet"},
    fmta(
      "\\frac{<>}{<>}",
      {
        i(1),
        i(2),
      }
    ),
    {condition = in_mathzone}  -- `condition` option passed in the snippet `opts` table 
  ),
    
})