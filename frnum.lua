local frnum_table = {
	[0] = "zéro",
	[1] = "un",
	[2] = "deux",
	[3] = "trois",
	[4] = "quatre",
	[5] = "cinq",
	[6] = "six",
	[7] = "sept",
	[8] = "huit",
	[9] = "neuf",
	[10] = "dix",
	[11] = "onze",
	[12] = "douze",
	[13] = "treize",
	[14] = "quatorze",
	[15] = "quinze",
	[16] = "seize",
	[17] = "dix-sept",
	[18] = "dix-huit",
	[19] = "dix-neuf",
	[20] = "vingt",
	[30] = "trente",
	[40] = "quarante",
	[50] = "cinquante",
	[60] = "soixante",
	[80] = "quatre-vingts",
}
for i = 2, 6 do
	for j = 1, 9 do
		if j == 1 then
			frnum_table[10 * i + j] = frnum_table[10 * i] .. "et un"
		else
			frnum_table[10 * i + j] = frnum_table[10 * i] .. "-" .. frnum_table[j]
		end
	end
end
frnum_table[80] = "quatre-vingt"
for i = 7, 9, 2 do
	for j = 0, 9 do
		if j == 1 then
			if i == 7 then
				frnum_table[10 * i + j] = frnum_table[10 * (i - 1)] .. " et onze"
			else
				frnum_table[10 * i + j] = frnum_table[10 * (i - 1)] .. "-onze"
			end
		else
			frnum_table[10 * i + j] = frnum_table[10 * (i - 1)] .. "-" .. frnum_table[j + 10]
		end
	end
end
local i = 8
for j = 1, 9 do
	frnum_table[10 * i + j] = "quatre-vingt-" .. frnum_table[j]
end
frnum_table[80] = "quatre-vingts"
for x = 0, 99 do
	print(frnum_table[x])
end
