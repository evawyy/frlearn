local nwords_table = {
	["mur"] = { the = "le", eng = "wall" },
	["sac"] = { the = "le", eng = "bag" },
	["fenêtre"] = { the = "la", eng = "window" },
	["chaise"] = { the = "la", eng = "chair" },
	["lit"] = { the = "le", eng = "bed" },
	["chapeuo"] = { the = "le", eng = "hat" },
	["fauteuil"] = { the = "le", eng = "armchair" },
	["blouson"] = { the = "le", eng = "casual or sporty jacket" },
  ["costume"]={the="le",eng="suit"},
  ["manteau"]={the="le",eng="coat"},
  ["pull"]={the="le",eng="sweater"},
  ["sweat-shirt"]={the="le",eng="causal garment with long sleeves and round neckline"},
  
	["fleur"] = { the = "la", eng = "flower" },
	["téléphone"] = { the = "le", eng = "phone" },
	["verre"] = { the = "le", eng = "glass" },
	["pièce"] = { the = "la", eng = "room" },
	["maison"] = { the = "la", eng = "house" },
	["grenier"] = { the = "le", eng = "attic" },
	["bureau"] = { the = "le", eng = "office" },
	["couloir"] = { the = "le", eng = "corridor" },
	["salle de bains"] = { the = "la", eng = "bathroom" },
	["chambre"] = { the = "la", eng = "bedroom" },
	["balcon"] = { the = "le", eng = "balcony" },
	["garage"] = { the = "le", eng = "garage" },
	["entrée"] = { the = "la", eng = "entrance" },
	["cuisine"] = { the = "la", eng = "kitchen" },
	["toilettes"] = { the = "les", eng = "toilet" },
	["salon"] = { the = "le", eng = "living room" },
	["salle à manger"] = { the = "la", eng = "dining room" },
	["terrasse"] = { the = "la", eng = "terrace" },
	["moyen"] = { the = "le", eng = "mean" },
	["voiture"] = { the = "la", eng = "car" },
	["vélo"] = { the = "le", eng = "bike" },
	["bateau"] = { the = "le", eng = "ship" },
	["métro"] = { the = "le", eng = "subway" },
	["pied"] = { the = "le", eng = "foot" },
	["train"] = { the = "le" },
	["scooter"] = { the = "le" },
	["moto"] = { the = "la" },
	["vase"] = { the = "le" },
	["photo"] = { the = "la" },
	["stylo"] = { the = "le" },
	["table"] = { the = "la" },
	["livre"] = { the = "le" },
	["gomme"] = { the = "la" ,eng = "eraser"},
	["veste"] = { the = "la", eng="broader range of jackets or coats" },
	["stylos"] = { the = "les" },
	["chat"] = { the = "le" },
	["chien"] = { the = "le" },
	["robe"] = { the = "la" ,eng="dress"},
	["jupe"] = { the = "la" ,eng="skirt"},
	["chemise"] = { the = "la", eng ="shirt or blouse with botton in the front"},
  ["t-shirt"]={the="le",eng=""},
  ["polo"]={the="le",eng="polo"},
  ["pantalon"]={the="le",eng="pants"},
  ["jean"]={the="le",eng=""},
  ["short"]={the="le",eng="short"},
	["avion"] = { the = "la", abbr = "l'avion", eng = "plane" },
	["armoire"] = { the = "la", abbr = "l'armoire", eng = "cupboard" },
	["ordinateur"] = { the = "le", abbr = "l'ordinateur", eng = "computer" },
	["assiette"] = { the = "la", abbr = "l'assiette", eng = "plate" },
	["étagère"] = { the = "la", abbr = "l'étagère", eng = "sheef" },
	["affiche"] = { the = "la", abbr = "l'affiche", eng = "post" },
	["ville"] = { the = "la", eng = "city" },
	["école"] = { abbr = "l'école", the = "le", eng = "school" },
	["poste"] = { the = "la", eng = "post" },
	["hôpital"] = { the = "le", abbr = "l'hôpital", eng = "hospital" },
	["gare"] = { the = "la", eng = "railway station" },
	["commissariat de police"] = { the = "le", eng = "police" },
	["banque"] = { the = "la", eng = "bank" },
	["musée"] = { the = "le", eng = "museum" },
	["restaurant"] = { the = "le", eng = "restaurant" },
	["hôtel"] = { abbr = "l'hôtel", the = "le", eng = "hotel" },
	["cinéma"] = { the = "le", eng = "cinema" },
	["boulangerie"] = { the = "la", eng = "bakery" },
	["supermarché"] = { the = "le", eng = "supermarket" },
	["bibliothéque"] = { the = "la", eng = "library" },
	["pharmacie"] = { the = "la", eng = "pharmacy" },
	["théâtre"] = { the = "le", eng = "theatre" },
  ["chemisier"]={the="le",eng="blouse"},
}
local function put_word(k, v)
	if v.abbr then
		tex.print(v.abbr .. " &" .. v.eng .. [[\\]])
	else
		tex.print(v.the .. " " .. k .. "&" .. v.eng .. [[\\]])
	end
end
local function nwords_enum()
	tex.print([[\begin{longtblr}{|c|c|}]])
	for k, v in pairs(nwords_table) do
		if not v.eng then
			v.eng = k
		end
		if v.the == "la" then
			put_word(k, v)
		end
	end
	for k, v in pairs(nwords_table) do
		if v.the == "le" then
			put_word(k, v)
		end
	end
	for k, v in pairs(nwords_table) do
		if v.the ~= "le" and v.the ~= "la" then
			put_word(k, v)
		end
	end
	tex.print([[\end{longtblr}]])
end
return nwords_enum
