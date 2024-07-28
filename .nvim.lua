local ls = require("luasnip")
local d = ls.dynamic_node
local s = ls.snippet
local t = ls.text_node
local c = ls.choice_node
local sn = ls.snippet_node
local i = ls.insert_node
local f = ls.function_node
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })
local extras = require("luasnip.extras")
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local rep = extras.rep
local fmta = require("luasnip.extras.fmt").fmta
local in_tipa = function()
	local line = vim.api.nvim_get_current_line()
	local r, c = unpack(vim.api.nvim_win_get_cursor(0))
	line = string.sub(line, 0, c)
	return string.match(line, "\\myf?tipa{[^}]*$")
end

--Personal snippet setting for spechial characters in french alphebet
--

local accent = {
	grave = 1,
	circonflexe = 2,
	aigu = 3,
	trema = 4,
	cedille = 5,
	oe = 6,
}
local pattern = {
	d = accent.grave,
	f = accent.circonflexe,
	s = accent.trema,
	a = accent.aigu,
	g = accent.cedille,
	e = accent.oe,
}
local fralphebet = {
	a = {
		[accent.grave] = "à",
		[accent.circonflexe] = "â",
		[accent.trema] = "",
		[accent.aigu] = "",
		[accent.cedille] = "",
	},
	A = {
		[accent.grave] = "À",
		[accent.circonflexe] = "Â",
		[accent.trema] = "",
		[accent.aigu] = "",
		[accent.cedille] = "",
	},
	e = {
		[accent.grave] = "è",
		[accent.circonflexe] = "ê",
		[accent.trema] = "ë",
		[accent.aigu] = "é",
		[accent.cedille] = "",
	},
	E = {
		[accent.grave] = "È",
		[accent.circonflexe] = "Ê",
		[accent.trema] = "Ë",
		[accent.aigu] = "É",
		[accent.cedille] = "",
	},
	u = {
		[accent.grave] = "ù",
		[accent.circonflexe] = "û",
		[accent.trema] = "ü",
		[accent.aigu] = "",
		[accent.cedille] = "",
	},
	U = {
		[accent.grave] = "Ù",
		[accent.circonflexe] = "Û",
		[accent.trema] = "Ü",
		[accent.aigu] = "",
		[accent.cedille] = "",
	},
	i = {
		[accent.grave] = "",
		[accent.circonflexe] = "î",
		[accent.trema] = "ï",
		[accent.aigu] = "",
		[accent.cedille] = "",
	},
	I = {
		[accent.grave] = "",
		[accent.circonflexe] = "Î",
		[accent.trema] = "Ï",
		[accent.aigu] = "",
		[accent.cedille] = "",
	},
	y = {
		[accent.grave] = "ÿ",
		[accent.circonflexe] = "ÿ",
		[accent.trema] = "ÿ",
		[accent.aigu] = "ÿ",
		[accent.cedille] = "ÿ",
	},
	Y = {
		[accent.grave] = "Ÿ",
		[accent.circonflexe] = "Ÿ",
		[accent.trema] = "Ÿ",
		[accent.aigu] = "Ÿ",
		[accent.cedille] = "Ÿ",
	},
	o = {
		[accent.grave] = "ô",
		[accent.circonflexe] = "ô",
		[accent.trema] = "ô",
		[accent.aigu] = "ô",
		[accent.cedille] = "ô",
		[accent.oe] = "œ",
	},
	O = {
		[accent.grave] = "Ô",
		[accent.circonflexe] = "Ô",
		[accent.trema] = "Ô",
		[accent.aigu] = "Ô",
		[accent.cedille] = "Ô",
		[accent.oe] = "Œ",
	},
	c = {
		[accent.grave] = "ç",
		[accent.circonflexe] = "ç",
		[accent.trema] = "ç",
		[accent.aigu] = "ç",
		[accent.cedille] = "ç",
	},
	C = {
		[accent.grave] = "Ç",
		[accent.circonflexe] = "Ç",
		[accent.trema] = "Ç",
		[accent.aigu] = "Ç",
		[accent.cedille] = "Ç",
	},
}
local makesnip = function(_, snip)
	local alphas = fralphebet[snip.captures[1]]
	if not alphas then
		return sn(nil, t(snip.captures[1] .. ";" .. snip.captures[2]))
	end
	local cap = alphas[pattern[snip.captures[2]]]
	if cap and cap ~= "" then
		return sn(nil, t(cap))
	end
	local choices = {}
	for _, v in ipairs(alphas) do
		if v ~= "" then
			table.insert(choices, t(v))
		end
	end
	return sn(nil, { c(1, choices) })
end
local function zip_add(str, char)
	if string.find(str, char .. "$") then
		return str
	else
		return str .. char
	end
end
ls.add_snippets("lua", {
	s(
		{ trig = ".vs", snippetType = "autosnippet" },
		fmta([[["<>"]={je="<>",tu="<>",il="<>",elle="<><>",nous="<>",vous="<>",ils="<>",elles="<><>"},]], {
			i(1),
			i(2),
			i(3),
			i(4),
			i(5),
			f(function(args, snip)
				return args[2][1] == "" and args[1][1] or ""
			end, { 4, 5 }),
			i(6),
			i(7),
			i(8),
			i(9),
			f(function(args, snip)
				return args[2][1] == "" and args[1][1] or ""
			end, { 8, 9 }),
		}),
		{}
	),
	s(
		{ trig = "%.([ae])n", regTrig = true, snippetType = "autosnippet" },
		fmta([[["<>"]={<><><>the="<>",eng="<>"},]], {
			i(1),
			f(function(args, snip)
				local str = args[1][1]
				if str ~= "" then
					return [[abbr="]]
				else
					return ""
				end
			end, { 2 }),
			i(2),
			f(function(args, snip)
				local str = args[1][1]
				if str ~= "" then
					return [[",]]
				else
					return ""
				end
			end, { 2 }),
			f(function(args, snip)
				return "l" .. snip.captures[1]
			end),
			i(3),
		}),
		{}
	),
	s({ trig = "(%a);(%a)", wordTrig = false, regTrig = true, snippetType = "autosnippet" }, {
		d(1, makesnip),
	}),
	s(
		{ trig = "%.adj", regTrig = true, snippetType = "autosnippet" },
		fmta([[["<>"]={sp="adj.",ns="<><>",fs="<><>",np="<><>",fp="<><>",eng="<>"},]], {
			i(1),
			i(2),
			f(function(args, snip)
				return args[2][1] == "" and args[1][1] or ""
			end, { 1, 2 }),
			i(3),
			f(function(args, snip)
				if args[2][1] == "" then
					return zip_add(args[1][1], "e")
				else
					return ""
				end
			end, { 1, 3 }),
			i(4),
			f(function(args, snip)
				if args[2][1] == "" then
					return zip_add(args[1][1], "s")
				else
					return ""
				end
			end, { 1, 4 }),
			i(5),
			f(function(args, snip)
				local fs = args[2][1]
				if fs == "" then
					fs = zip_add(args[1][1], "e")
				end
				if args[3][1] == "" then
					return zip_add(fs, "s")
				else
					return ""
				end
			end, { 1, 3, 5 }),
			i(6),
		}),
		{}
	),
})
ls.add_snippets("tex", {
	s(
		{ trig = ".wo", snippetType = "autosnippet" },
		fmta(
			"\\begin{word}{<>}{\\myftipa{<>}}{<>}\\label{wo:<>}\n\\begin{enumerate}[label=(\\arabic*)]\n\\item <> \n\\end{enumerate}\n\\end{word}",
			{
				i(1),
				i(2),
				i(3),
				rep(1),
				i(4),
			}
		),
		{ condition = line_begin }
	),
	s(
		{ trig = ".se", snippetType = "autosnippet" },
		fmta("\\begin{sentence}\n <> \n\\end{sentence}", {
			i(1),
		}),
		{ condition = line_begin }
	),
	s(
		{ trig = ".pn", snippetType = "autosnippet" },
		fmta("\\begin{pronuciation}\n <> \n\\end{pronuciation}", {
			i(1),
		}),
		{ condition = line_begin }
	),
	s(
		{ trig = ".pa", snippetType = "autosnippet" },
		fmta(
			"\\begin{practice}<>\n\\begin{enumerate}[label=(\\arabic*)]\n\\item <> \n\\end{enumerate}\n\\end{practice}",
			{
				i(1),
				i(2),
			}
		),
		fmta("\\begin{practice}\n <> \n\\end{practice}", {
			i(1),
		}),
		{ condition = line_begin }
	),
	s(
		{ trig = ".gr", snippetType = "autosnippet" },
		fmta("\\begin{grammar}{<>}\n <> \n\\end{grammar}", {
			i(1),
			i(2),
		}),
		{ condition = line_begin }
	),
	s(
		{ trig = ".ar", snippetType = "autosnippet" },
		fmta("\\begin{article}{<>}\n <> \n\\end{article}", {
			i(1),
			i(2),
		}),
		{ condition = line_begin }
	),
	s(
		{ trig = "//", snippetType = "autosnippet" },
		fmta(
			[[
      \myftipa{<>}<>
      ]],
			{
				i(1),
				i(0),
			}
		)
	),
	s(
		{ trig = "([%a]+)@", regTrig = true, snippetType = "autosnippet" },
		fmta("\\emword[wo:<>]{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{
			condition = function()
				return not in_tipa()
			end,
		}
	),
	s(
		{ trig = "([%a]+)#", regTrig = true, snippetType = "autosnippet" },
		fmta("\\emword{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{}
	),
	s(
		{ trig = "([^%.%?!]+[%.%?!])@", regTrig = true, snippetType = "autosnippet" },
		fmta("\\emsent[se:<>]{<>}", {
			f(function(_, snip)
				local sentence = snip.captures[1]
				sentence = string.gsub(sentence, "^ *", "")
				local str = string.match(sentence, "^.")
				sentence = string.gsub(sentence, "^[^ ]* ", "")
				str = str .. string.match(sentence, "^.")
				sentence = string.gsub(sentence, "^[^ ]* ", "")
				str = str .. string.match(sentence, "^.")
				sentence = string.gsub(sentence, "^[^ ]* ", "")
				str = str .. string.match(sentence, "^.")
				return str
			end),
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{
			condition = function()
				return not in_tipa()
			end,
		}
	),
	s(
		{ trig = "([^%.%?!]+[%.%?!])#", regTrig = true, snippetType = "autosnippet" },
		fmta("\\emsent{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{}
	),
	s({ trig = "(%a);(%a)", wordTrig = false, regTrig = true, snippetType = "autosnippet" }, {
		d(1, makesnip),
	}),
	s(
		{ trig = "udl", snippetType = "snippet" },
		fmta("\\underline{<>}", {
			i(1),
		}),
		{}
	),
})
