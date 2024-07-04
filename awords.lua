local awords_table = {
	["jaune"] = { sp = "adj.", ns = "jaune", fs = "jaune", np = "jaunes", fp = "jaunes", eng = "yellow" },
	["rose"] = { sp = "adj.", ns = "rose", fs = "rose", np = "roses", fp = "roses", eng = "pink" },
	["rouge"] = { sp = "adj.", ns = "rouge", fs = "rouge", np = "rouges", fp = "rouges", eng = "red" },
	["bleu"] = { sp = "adj.", ns = "bleu", fs = "bleue", np = "bleus", fp = "bleues", eng = "blue" },
	["vert"] = { sp = "adj.", ns = "vert", fs = "verte", np = "verts", fp = "vertes", eng = "green" },
	["noir"] = { sp = "adj.", ns = "noir", fs = "noire", np = "noirs", fp = "noires", eng = "black" },
	["violet"] = { sp = "adj.", ns = "violet", fs = "violette", np = "violets", fp = "violettes", eng = "purple" },
	["gris"] = { sp = "adj.", ns = "gris", fs = "grise", np = "gris", fp = "grises", eng = "grey" },
	["blanc"] = { sp = "adj.", ns = "blanc", fs = "blanche", np = "blancs", fp = "blanches", eng = "white" },
	["marron"] = { sp = "adj.", ns = "marron", fs = "marron", np = "marron", fp = "marron", eng = "brown" },
	["orange"] = { sp = "adj.", ns = "orange", fs = "orange", np = "orange", fp = "orange", eng = "orange" },
	["gros"] = { sp = "adj.", ns = "gros", fs = "grosse", np = "gros", fp = "grosses", eng = "fat" },
	["mince"] = { sp = "adj.", ns = "mince", fs = "mince", np = "minces", fp = "minces", eng = "slim" },
	["grand"] = { sp = "adj.", ns = "grand", fs = "grande", np = "grands", fp = "grandes", eng = "tall" },
	["petit"] = { sp = "adj.", ns = "petit", fs = "petite", np = "petits", fp = "petites", eng = "short" },
  ["blond"]={sp="adj.",ns="blond",fs="blonde",np="blonds",fp="blondes",eng="blonde"},
}
local function put_word(k, v)
	if v.ns ~= k then
		tex.print([[\textcolor{red}{]] .. k .. [[} & ]])
	else
		tex.print(k .. " & ")
	end
	local suff = string.gsub(v.fs, "^" .. k, "")
	if suff == "e" or (string.find(k, "e$") and suff == "") then
		tex.print(v.fs .. " & ")
	else
		local normal = ""
		local special = ""
		if k == v.fs then
			normal = ""
			special = v.fs
		elseif not string.find(v.fs, "^" .. k) then
			normal = ""
			special = v.fs
		else
			normal = k
			special = suff
		end
		tex.print(normal .. [[\textcolor{red}{]] .. special .. [[} & ]])
	end
	suff = string.gsub(v.np, "^" .. v.ns, "")
	if suff == "s" or (string.find(v.ns, "s$") and suff == "") then
		tex.print(v.np .. " & ")
	else
		local normal = ""
		local special = ""
		if v.ns == v.np then
			normal = ""
			special = v.np
		elseif not string.find(v.np, "^" .. v.ns) then
			normal = ""
			special = v.np
		else
			normal = v.ns
			special = suff
		end
		tex.print(normal .. [[\textcolor{red}{]] .. special .. [[} & ]])
	end
	suff = string.gsub(v.fp, "^" .. v.fs, "")
	if suff == "s" or (string.find(v.fs, "s$") and suff == "") then
		tex.print(v.fp .. " & ")
	else
		local normal = ""
		local special = ""
		if v.fs == v.fp then
			normal = ""
			special = v.fp
		elseif not string.find(v.fp, "^" .. v.fs) then
			normal = ""
			special = v.fp
		else
			normal = v.fs
			special = suff
		end
		tex.print(normal .. [[\textcolor{red}{]] .. special .. [[} & ]])
	end
	tex.print(v.eng .. [[ \\ ]])
end
local function awords_enum()
	tex.print([[\begin{longtblr}{|c|c|c|c|c|}\hline n.s. & f.s. & n.pl. &f.pl.& eng\\ ]])
	for k, v in pairs(awords_table) do
		put_word(k, v)
	end
	tex.print([[\hline\end{longtblr}]])
end
return awords_enum
