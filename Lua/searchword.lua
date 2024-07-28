local lefff_lookup = require("lefff")
local function genre(word)
  local gen=""
  for _,v in ipairs(lefff_lookup(word)) do 
    if not v.speech:match("^n[pc]$") then 
      return 0
    end
  end
  local gender = 0
  if string.find(gen,"m") then 
    gender = gender+1
  end
  if string.find(gen,"f") then 
    gender = gender+2
  end
  return gender
end
return genre
