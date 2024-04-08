local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local extras = require("luasnip.extras")
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local rep = extras.rep
local fmta = require("luasnip.extras.fmt").fmta
local in_tipa = function()
	local line = vim.api.nvim_get_current_line()
	local r, c = unpack(vim.api.nvim_win_get_cursor(0))
	line = string.sub(line, 0, c)
	return string.match(line, "\\begin{word}%b{}{[^}]*$")
end
return {
	s(
		{ trig = ".wo", snippetType = "autosnippet" },
		fmta(
			"\\begin{newword}{<>}{\\mytipa{<>}}{<>}\\label{wo:<>}\n\\begin{enumerate}[label=(\\arabic*)]\n\\item <> \n\\end{enumerate}\n\\end{newword}",
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
		{ trig = ".gr", snippetType = "autosnippet" },
		fmta("\\begin{grammar}\n <> \n\\end{grammar}", {
			i(1),
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
}
