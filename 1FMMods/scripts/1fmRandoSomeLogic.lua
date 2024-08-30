LUAGUI_NAME = "1fmRandomizer"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Use with InstantGummi"

local idFind = 0
local idReplace = 0
local textFind = ""
local nextTextFind = ""
local textReplace = ""
local nextTextReplace = ""
local magicTexts = {"fire.", "ice.", "thunder.", "healing.", "stars.", "time.", "wind."}
local magicTexts2 = {"Fire", "Blizzard", "Thunder", "Cure", "Gravity", "Stop", "Aero"}
local trinityTexts = {"Blue Trinity", "Red Trinity", "Green Trinity", "Yellow Trinity", "White Trinity"}
local abilityNames = {"High Jump", "Mermaid Kick", "Glide", "Superglide"}
local infoBoxWas = 1

local trinityTable = {1, 2, 3, 4, 5}
local perMagicShuffle = {}
local magicUpdater = {}
local inventoryUpdater = {}
local gummiUpdater = {}
local dodgeDataAddr = 0
local bufferRemove = 0
local bufferRemoveTimer = 10
local HUDWas = 0
local menuWas = 0
local removeBlackTimer = 0
local prevTTFlag = 0
local OCTextFix = 0

local important = {188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 205, 229}
local shopPool = {}
local itemids = {}
local rewards = {}
local soraLevels = {}
local soraAbilities = {}
local soraAbilities2 = {}
local soraAbilities3 = {}
local donaldLevels = {}
local donaldAbilities = {}
local goofyLevels = {}
local goofyAbilities = {}
local weaponStr = {}
local weaponMag = {}
local itemData = {}
local shops = {}
local synths = {}
local chests = {}
local itemsAvailable = {}
local abilitiesAvailable = {}
local magicAvailable = {}
local reportData = {}
local dalmatiansAvailable = 0
local seedstring = ""
local randomized = false
local successfulRando = true
local isValidSeed = false
local initDone = false
local canExecute = false
local loaded = false

local function chestSpoilerText(location, content)
	return string.format("Chest at\n%s:\n%s\n\n", location, content)
end

local function rewardSpoilerText(original, condition, new)
	return string.format("Reward %s\n%s:\n%s\n\n", original, condition, new)
end

-- simple string hashing algorithm designed by Daniel J. Bernstein
local function Djb2(str)
	local hash = 5381

	for c in string.gmatch(str, '.') do
		hash = ((hash << 5) + hash) + string.byte(c)
	end

	return hash
end

local function importVars(file)
	if not pcall(require, file) then
		local errorString = "\n\n!!!!!!!! IMPORT ERROR !!!!!!!!\n\n"
		local msg = ""
		local slashIdx = string.find(file, "/")
		if slashIdx then
			msg = string.format("%s.lua missing, get it from the Github!", string.sub(file, slashIdx + 1, #file))
		else
			msg = string.format("%s.lua missing, get it from the Github!", file)
		end
		ConsolePrint(string.format("%s%s%s", errorString, msg, errorString))
	end
end

local function ArrayReplace(source, f, r, offset)
	local index = 1
	local newarray = {}
	for i=offset, #source do
		if source[i] == f[index] then
			index = index + 1
			if index > #f then
				for j=1, i + 1 - index do
					newarray[j] = source[j]
				end
				for j=1, #r do
					newarray[#newarray + 1] = r[j]
				end
				for j=#newarray + 1, #source + (#r - #f) do
					newarray[j] = source[j + (#f - #r)]
				end
				return newarray, i
			end
		elseif source[i] == f[1] then
			index = 2
		else
			index = 1
		end
	end
	if #newarray == 0 then
		return source, -1
	end
end

local function Translate(s, en, tr, isString)
	local translated = s
	local replaceoffset = 1
	if isString then
		translated = s:gsub("[()-]", "")
	end
	if #tr > 0 then
		for j=1, #tr do
			for _=1, 4 do
				if isString then
					translated = translated:gsub(en[j]:gsub("()-]", ""),tr[j])
					break
				else
					translated, replaceoffset = ArrayReplace(translated,en[j],tr[j],replaceoffset)
					if replaceoffset < 0 then
						break
					end
				end
			end
		end
	end
	return translated
end

local function StringToKHText(s, mempos)
	local reftable = {
		[10] = 2, [12] = 15, [38] = 97, [39] = 113, [40] = 116,
		[41] = 117, [43] = 99, [45] = 110, [46] = 104, [58] = 107
	}
	local reftable2 = {[132] = 207, [150] = 221, [164] = 230, [182] = 244}
	local returnTable = {}
	local skip = false
	for i=1, #s do
		if not skip then
			local c = string.byte(s, i)
			if c == 195 then
				i = i+1
				c = string.byte(s, i)
				if c >= 128 and c <= 130 then
					c = c + 86
				elseif c >= 135 and c <= 143 then
					c = c + 73
				elseif c >= 145 and c <= 148 then
					c = c + 74
				elseif c >= 153 and c <= 156 then
					c = c + 69
				elseif c >= 160 and c <= 162 then
					c = c + 67
				elseif c >= 167 and c <= 175 then
					c = c + 64
				elseif c >= 177 and c <= 180 then
					c = c + 63
				elseif c >= 185 and c <= 188 then
					c = c + 60
				elseif reftable2[c] then
					c = reftable2[c]
				else
					c = 1
				end
				skip = true
			elseif c == 194 then
				i = i + 1
				c = string.byte(s, i)
				if c == 176 then
					c = 249
				else
					c = 1
				end
				skip = true
			elseif c == 197 then
				i = i + 1
				c = string.byte(s, i)
				if c == 146 or c == 147 then
					c = c + 54
				else
					c = 1
				end
				skip = true
			else
				if c >= 97 then
					c = c - 28
				elseif c >= 65 then
					c = c - 22
				elseif c >= 48 and c <=57 then
					c = c - 15
				elseif reftable[c] then
					c = reftable[c]
				else
					c = 1
				end
			end
			if mempos >= 0 then
				WriteByte(mempos, c)
				mempos = mempos + 1
				if c == 15 then
					WriteByte(mempos, 1)
					mempos = mempos + 1
				end
			else
				returnTable[#returnTable + 1] = c
				if c == 15 then
					returnTable[#returnTable + 1] = 1
				end
			end
		else
			skip = false
		end
	end
	if mempos == -1 then
		returnTable[#returnTable + 1] = 0
		return returnTable
	elseif mempos < -1 then
		return returnTable
	end
	WriteByte(mempos, 0)
	return mempos + 1
end

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
		importVars("VersionCheck")
		if ReadByte(EGSGlobalVersion) == 106 then
			importVars("EpicGamesGlobal")
		elseif ReadByte(EGSJPVersion) == 106 then
			importVars("EpicGamesJP")
		elseif ReadByte(SteamGlobalVersion) == 106 then
			importVars("SteamGlobal")
		elseif ReadByte(SteamJPVersion) == 106 then
			importVars("SteamJP")
		else
			ConsolePrint("\n\n!!!!!!!! VERSION ERROR !!!!!!!!\n\nVersion check failed, check variable file version numbers against game version")
		end
	else
		ConsolePrint("KH1 not detected, not running script")
	end

	if canExecute then
		cutsceneFlags = cutsceneFlagBase - 1
		worldFlagBase = worldFlagBase - 218
		importVars("Rando/settings")
		importVars("Rando/itemNames")
		importVars("Rando/chests")
		importVars("Rando/rewards")
		loaded = true
		for _, val in ipairs(unrandomize) do
			for i=1, #important do
				if important[i] == val then
					table.remove(important, i)
					ConsolePrint("Unrandomizing " .. itemNames[val][1])
					break
				end
			end
		end
		for _, val in ipairs(earlyAbilities) do
			ConsolePrint("Early ability: " .. val)
		end
		ConsolePrint("WeaponStatRando: " .. weaponStatRando)
		ConsolePrint("StackAbilities: " .. stackAbilities)

		for i=1, 255 do
			itemids[i] = i
			inventoryUpdater[i] = ReadByte(inventory + (i - 1))
		end

		for i=1, 64 do
			gummiUpdater[i] = ReadByte(gummiInventory + (i - 1))
		end

		for i=1, 7 do
			magicUpdater[i] = 0
		end

		local seedfile = io.open("randofiles/seed.txt", "r")
		if seedfile ~= nil then
			local text = seedfile:read()
			seedstring = text
			if text == "Disabled" then
				ConsolePrint("Disabling rando because of seed Disabled")
				randomized = true
			end
			local seed = tonumber(text)
			if seed == nil then
				seed = Djb2(text)
			end
			math.randomseed(seed)
			ConsolePrint("Found existing seed")
		else
			seedfile = io.open("randofiles/seed.txt", "w")
			local newseed = os.time()
			math.randomseed(newseed)
			seedstring = string.format("%d", newseed)
			seedfile:write(newseed)
			ConsolePrint("Wrote new seed")
		end
		seedfile:close()

		initDone = true
		ConsolePrint("Init done.")
	end
end

local function OpenGummi()
	for i=0, 14 do
		if i ~= 11 then
			WriteByte(gummiFlagBase + i, 3)
		end
	end
end

local function RoomWarp(w, r)
	WriteByte(warpType1, 5)
	WriteByte(warpType2, 10)
	WriteByte(worldWarp, w)
	WriteByte(roomWarp, r)
	WriteByte(warpTrigger, 2)
end

local function ItemType(i)
	local attributes = ""
	if (i >= 1 and i <= 8 and i ~= 5) or (i >= 152 and i <= 154) or (i >= 142 and i <= 144) then
		attributes = attributes .. "Use"
	end
	if (i >= 9 and i <= 16) or i >= 233 then
		attributes = attributes .. "Synth"
	end
	if (i >= 17 and i <= 71) and i ~= 57 then
		attributes = attributes .. "Accessory"
	end
	if (i >= 81 and i <= 102) then
		attributes = attributes .. "SoraWeapon"
	end
	if (i >= 103 and i <= 117) then
		attributes = attributes .. "DonaldWeapon"
	end
	if (i >= 119 and i <= 133) then
		attributes = attributes .. "GoofyWeapon"
	end
	if (i >= 206 and i <= 209) or i == 137 or i == 140 then
		attributes = attributes .. "Summon"
	end
	if (i >= 217 and i <= 222) then
		attributes = attributes .. "Slide"
	end
	if (i >= 223 and i <= 226) then
		attributes = attributes .. "Evidence"
	end
	if i == 178 or i == 183 then
		attributes = attributes .. "Book"
	end
	if i == 227 or i == 230 or i == 210 or i == 168 or i == 170 or i == 174
	or i == 176 or i == 200 or i == 201 or i == 203 or i == 204 then
		attributes = attributes .. "NonImportant"
	end

	for j=1, #important do
		if i == important[j] then
			attributes = attributes .. "Important"
			break
		end
	end
	return attributes
end

local function ItemCompatibility(i, r)
	local a = ItemType(i)
	local b = ItemType(r)
	if string.find(a, "Weapon") or string.find(b, "Weapon") or
	   string.find(a, "Accessory") or string.find(b, "Accessory") then
		return a == b
	end
	if string.find(a, "Use") or string.find(a, "Synth") then
		return string.find(b, "Use") or string.find(b, "Synth")
	end
	if string.find(a, "Summon") then
		return string.find(b, "Summon")
	end
	return true
end

local function Salable(i)
	return i < 178 or i == 210 or i == 227 or i >= 230
end

local function ItemAccessible(i, c)
	return itemsAvailable[i] and itemsAvailable[i] >= c
end

local function AbilityAccessible(a, c)
	return abilitiesAvailable[a] and abilitiesAvailable[a] >= c
end

local function TrinityAccessible(s)
	for i=1, 5 do
		if trinityTexts[i] == s then
			if trinityTable[2] == i then
				return ItemAccessible(217, 6)
			elseif trinityTable[4] == i then
				return ItemAccessible(229, 1)
			end
		end
	end
	return true
end

local function MagicAccessible(s)
	if not magicAvailable[1] then
		return false
	end

	local magicRef = {"Fire", "Blizzard", "Thunder", "Cure", "Gravity", "Stop", "Aero"}
	local magicRef2 = {"Fira", "Blizzara", "Thundara", "Cura", "Gravira", "Stopra", "Aerora"}
	local magicRef3 = {"Firaga", "Blizzaga", "Thundaga", "Curaga", "Graviga", "Stopga", "Aeroga"}

	local a = true
	for i=1, #magicRef do
		if string.find(s, magicRef3[i]) or s == "Max" then
			a = a and magicAvailable[i] > 2
		elseif string.find(s, magicRef2[i]) then
			a = a and magicAvailable[i] > 1
		elseif string.find(s, magicRef[i]) or s == "All" then
			a = a and magicAvailable[i] > 0
		end
	end
	return a
end

local function IsAccessible(t, i)
	local canAccess = true
	for k=3, 6 do
		if not t[i][k] then
			break
		end
		local thisAccess = false
		if string.find(t[i][k], "Day1") then
			thisAccess = thisAccess or (ItemAccessible(192, 1) and ItemAccessible(193, 1)
									and ItemAccessible(194, 1))
		end
		if string.find(t[i][k], "High Jumpra") then
			thisAccess = thisAccess or AbilityAccessible(1, 2)
		elseif string.find(t[i][k], "High Jump") then
			thisAccess = thisAccess or AbilityAccessible(1, 1)
		end
		if string.find(t[i][k], "Glide") then
			thisAccess = thisAccess or AbilityAccessible(3, 1) or AbilityAccessible(4, 1)
		end
		if string.find(t[i][k], "Mermaid Kick") then
			thisAccess = thisAccess or AbilityAccessible(2, 1)
		end
		if string.find(t[i][k], "HB1") then
			thisAccess = thisAccess or (ItemAccessible(188, 1) and ItemAccessible(189, 1)
									and ItemAccessible(190, 1) and ItemAccessible(191, 1)
									and ItemAccessible(217, 6) and ItemAccessible(223, 4))
		end
		if string.find(t[i][k], "NaviG") then
			thisAccess = thisAccess or (ItemAccessible(200, 1) and ItemAccessible(201, 1))
		end
		if string.find(t[i][k], "Khama") then
			thisAccess = thisAccess or ItemAccessible(178, 1) or AbilityAccessible(1, 2)
		end
		if string.find(t[i][k], "Theon") then
			thisAccess = thisAccess or AbilityAccessible(1, 2) or (ItemAccessible(178, 1)
									and ItemAccessible(183, 1))
		end
		if string.find(t[i][k], "Jack") then
			thisAccess = thisAccess or ItemAccessible(228, 1)
		end
		if string.find(t[i][k], "Slides") then
			thisAccess = thisAccess or ItemAccessible(217, 6)
		end
		if string.find(t[i][k], "Evidence") then
			thisAccess = thisAccess or ItemAccessible(223, 4)
		end
		if string.find(t[i][k], "Entry Pass") then
			thisAccess = thisAccess or ItemAccessible(229, 1)
		end
		if string.find(t[i][k], "Postcard") then
			local cards = 6 + (AbilityAccessible(1, 1) and 1 or 0)
			if itemsAvailable[211] then
				cards = cards + itemsAvailable[211]
			end
			thisAccess = thisAccess or cards >= tonumber(string.sub(t[i][k], 9))
		end
		if string.find(t[i][k], "Puppies") then
			local pupCount = tonumber(string.sub(t[i][k], 1, 3))
			thisAccess = thisAccess or (pupCount and dalmatiansAvailable >= pupCount)
		end
		if string.find(t[i][k], "Page") then
			local accessiblePages = 0
			for p=212, 216 do
				if ItemAccessible(p, 1) then
					accessiblePages = accessiblePages + 1
				end
			end
			thisAccess = thisAccess or tonumber(string.sub(t[i][k], 5)) <= accessiblePages
		end
		if string.find(t[i][k], "All Summons") then
			thisAccess = thisAccess or (ItemAccessible(206, 1) and
			ItemAccessible(207, 1) and ItemAccessible(208, 1) and ItemAccessible(209, 1))
		elseif string.find(t[i][k], "Dumbo") then
			thisAccess = thisAccess or (ItemAccessible(206, 1) and MagicAccessible("Fire Magic"))
									or AbilityAccessible(1, 2)
		end
		if string.find(t[i][k], "All Spells") or string.find(t[i][k], "Arts") then
			thisAccess = thisAccess or MagicAccessible("All")
		end
		if string.find(t[i][k], "Trinity") then
			thisAccess = thisAccess or TrinityAccessible(t[i][k])
		end
		if string.find(t[i][k], "Magic") then
			thisAccess = thisAccess or MagicAccessible(t[i][k])
		end
		if string.find(t[i][k], "HB2") then
			thisAccess = thisAccess or true
		end
		if string.find(t[i][k], "EotW") then
			thisAccess = thisAccess or ItemAccessible(205, 1)
		end

		canAccess = canAccess and thisAccess
	end
	return canAccess
end

local function GetRandomOrder(size)
	local randomOrderPool = {}
	local randomOrder = {}
	for i=1, size do
		randomOrderPool[i] = i
	end
	for i=1, size do
		randomOrder[i] = table.remove(randomOrderPool, math.random(#randomOrderPool))
	end
	return randomOrder
end

local function GenerateSpoilers()
	local spoilers = {}
	local miscSpoilers = {}

	abilityNames[22] = "Dodge Roll"

	for c=1, 511 do
		if chests[c] then
			local it = 1
			local ab = 0
			if chests[c] % 16 == 0 and vanillaChests[c] == nil then
				it = itemids[chests[c] // 16]
			elseif chests[c] % 16 == 14 and rewards[(chests[c] // 16) + 1] then
				if rewards[(chests[c] // 16) + 1] % 256 == 240 then
					it = itemids[rewards[(chests[c] // 16) + 1] // 256]
				elseif rewards[(chests[c] // 16) + 1] % 256 == 177
				or rewards[(chests[c] // 16) + 1] // 256 == 22 then
					ab = rewards[(chests[c] // 16) + 1] // 256
				end
			end
			local itype = ItemType(it)
			if ab > 0 then
				spoilers[#spoilers + 1] = chestSpoilerText("Chest", chestDetails[c][2], abilityNames[ab])
			elseif itype == "Important" or it == 228 then
				spoilers[#spoilers + 1] = chestSpoilerText(chestDetails[c][2], itemNames[it][1])
			elseif itype == "Summon" or (itype == "Slide" and requiredSlides > 0) or
					(itype == "Evidence" and requiredEvidence > 0) or itype == "Book"
					or it == 211 or it == 213 or it == 214 then
				miscSpoilers[#miscSpoilers + 1] = chestSpoilerText(chestDetails[c][2], itemNames[it][1])
			end
		end
	end

	for r=1, 169 do
		if rewards[r] and vanillaRewards[r] == nil then
			local it = rewards[r] % 256 == 240 and itemids[rewards[r] // 256] or 1
			local itype = ItemType(it)
			if (rewards[r] % 256 == 177 or rewards[r] // 256) == 22 and rewardDetails[r][2]~="Chest" then
				local ab = rewards[r] // 256
				spoilers[#spoilers + 1] = rewardSpoilerText(rewardDetails[r][1], rewardDetails[r][2], abilityNames[ab])
			elseif (itype == "Important" or it == 228) and rewardDetails[r][2]~="Chest" then
				spoilers[#spoilers + 1] = rewardSpoilerText(rewardDetails[r][1], rewardDetails[r][2], itemNames[it][1])
			elseif (itype == "Summon" or it == 211 or (itype == "Slide" and requiredSlides > 0) or
					(itype == "Evidence" and requiredEvidence > 0) or itype == "Book")
					and rewardDetails[r][2] ~= "Chest" then
				miscSpoilers[#miscSpoilers + 1] = rewardSpoilerText(rewardDetails[r][1], rewardDetails[r][2], itemNames[it][1])
			end
		end
	end

	if hintLanguage == nil or hintLanguage == "auto" then
		if ReadInt(language) == 1196904521 then
			hintLanguage = "german"
		elseif ReadInt(language) == 1194000467 then
			hintLanguage = "spanish"
		end
	end
	ConsolePrint(hintLanguage)

	local enwords = {}
	local transwords = {}
	local translation = io.open(string.format("randofiles/%s.txt", hintLanguage))
	if translation ~= nil then
		while true do
			local line = translation:read("*l")
			if not line then
				break
			end
			local words = {}
			for w in line:gmatch("([^=]*)") do
				words[#words + 1] = w
			end
			enwords[#enwords + 1] = string.gsub(words[1], '^%s*(.-)%s*$', '%1')
			transwords[#transwords + 1] = string.gsub(words[2], '^%s*(.-)%s*$', '%1')
		end
		translation:close()
	end

	local f = io.open("randofiles/spoilers.txt", "w")
	for i=1, #spoilers do
		f:write(Translate(spoilers[i], enwords, transwords, true) .. "\n")
	end
	for i=1, #miscSpoilers do
		f:write(Translate(miscSpoilers[i], enwords, transwords, true) .. "\n")
	end
	f:close()

	return {spoilers, miscSpoilers}
end

local function GenerateReports()
	local spoilersT = GenerateSpoilers()
	local spoilers = spoilersT[1]
	local miscSpoilers = spoilersT[2]
	math.randomseed(Djb2(seedstring))
	for i=1, 13 do
		local hintText = ""
		local hintRatio = math.floor(#spoilers / (14 - i) + 0.99)
		local mhintRatio = math.floor(#miscSpoilers / (14 - i) + 0.99)
		for _=1, hintRatio do
			if #spoilers > 0 then
				hintText = hintText .. table.remove(spoilers, math.random(#spoilers))
			end
		end
		hintText = hintText .. "\f"
		for _=1, mhintRatio do
			if #miscSpoilers > 0 then
				hintText = hintText .. table.remove(miscSpoilers, math.random(#miscSpoilers))
			end
		end
		reportData[i] = StringToKHText(hintText, -1)
	end
end

local function GetAvailability()
	local abAv = {}
	local itAv = {}
	local rewAv = {}
	local dalmAv = 0

	for i=1, 255 do
		abAv[i] = 0
		itAv[i] = 0
	end

	for i=1, 511 do
		if chests[i] and chests[i] % 16 == 14 and not rewAv[(chests[i] // 16) + 1] then
			rewAv[(chests[i] // 16) + 1] = 0
		end
		if chestDetails[i] and IsAccessible(chestDetails, i) then
			if chests[i] % 16 == 0 then
				local it = itemids[chests[i] // 16]
				itAv[it] = itAv[it] + 1
			elseif chests[i] % 16 == 4 then
				dalmAv = dalmAv + 3
			elseif chests[i] % 16 == 14 then
				rewAv[(chests[i] // 16) + 1] = rewAv[(chests[i] // 16) + 1] + 1
			end
		end
	end

	for i=1, 169 do
		if rewardDetails[i] then
			if (rewAv[i] and rewAv[i] > 0) or (not rewAv[i] and IsAccessible(rewardDetails, i)) then
				if rewards[i] % 256 == 240 then
					local it = itemids[rewards[i] // 256]
					itAv[it] = itAv[it] + 1
				elseif rewards[i] % 256 == 177 then
					abAv[rewards[i] // 256] = abAv[rewards[i] // 256] + 1
				end
			end
		end
	end

	for i=149, 230 do
		if itemNames[i] then
			if (itemNames[i][3] and IsAccessible(itemNames, i)) or (itemNames[i][2] and itemNames[i][3] == nil) then
				itAv[itemids[i]] = itAv[itemids[i]] + 1
			end
		end
	end

	local slideCount = 0
	local evidenceCount = 0
	for i=217, 222 do
		slideCount = slideCount + math.min(itAv[i], 1)
	end
	for i=223, 226 do
		evidenceCount = evidenceCount + math.min(itAv[i], 1)
	end
	if slideCount >= 6 then
		itAv[217] = 6
	end
	if evidenceCount >= 4 then
		itAv[223] = 4
	end

	for i=1, 511 do
		itemsAvailable[i] = itAv[i]
		abilitiesAvailable[i] = abAv[i]
		dalmatiansAvailable = dalmAv
	end

	local m = perMagicShuffle[1]
	magicAvailable[m] = 2
	if ItemAccessible(188, 1) and ItemAccessible(189, 1)
	and ItemAccessible(190, 1) and ItemAccessible(191, 1) then
		magicAvailable[m] = 3
	end
	m = perMagicShuffle[2]
	magicAvailable[m] = 1
	if ItemAccessible(223, 4) then
		magicAvailable[m] = 2
	end
	if ItemAccessible(229, 1) then
		magicAvailable[m] = magicAvailable[m] + 1
	end
	m = perMagicShuffle[3]
	magicAvailable[m] = 1
	if AbilityAccessible(2, 1) then
		magicAvailable[m] = magicAvailable[m] + 1
	end
	if ItemAccessible(229, 1) then
		magicAvailable[m] = magicAvailable[m] + 1
	end
	m = perMagicShuffle[4]
	local cures = 0
	if TrinityAccessible("Green Trinity") then
		cures = 1
	end
	if ItemAccessible(188, 1) and ItemAccessible(189, 1)
	and ItemAccessible(190, 1) and ItemAccessible(191, 1) then
		cures = cures + 1
	end
	if ItemAccessible(217, 6) then
		cures = cures + 1
	end
	magicAvailable[m] = cures
	m = perMagicShuffle[5]
	magicAvailable[m] = 0
	if ItemAccessible(228, 1) then
		magicAvailable[m] = magicAvailable[m] + 1
	end
	if ItemAccessible(229, 1) then
		magicAvailable[m] = magicAvailable[m] + 2
	end
	m = perMagicShuffle[6]
	local accessiblePages = 0
	for p=212, 216 do
		if ItemAccessible(p, 1) then
			accessiblePages = accessiblePages + 1
		end
	end
	magicAvailable[m] = 0
	if AbilityAccessible(1, 1) or AbilityAccessible(3, 1) or AbilityAccessible(4, 1) then
		magicAvailable[m] = 1
	end
	if accessiblePages >= 3 then
		magicAvailable[m] = magicAvailable[m] + 1
	end
	if ItemAccessible(188, 1) and ItemAccessible(189, 1)
	and ItemAccessible(190, 1) and ItemAccessible(191, 1) and ItemAccessible(205, 1) then
		magicAvailable[m] = magicAvailable[m] + 1
	end
	m = perMagicShuffle[7]
	magicAvailable[m] = 0
	if TrinityAccessible("Red Trinity") then
		magicAvailable[m] = 1
	end
	if TrinityAccessible("Yellow Trinity") then
		magicAvailable[m] = magicAvailable[m] + 1
	end
	if dalmatiansAvailable == 99 then
		magicAvailable[m] = magicAvailable[m] + 1
	end
end

local function LoadRando()
	local randosave = io.open("randofiles/" .. string.sub(seedstring, 1, 10) .. ".save", "r")
	if not randosave then
		return false
	end

	local freshboot = false
	for i=1, 255 do
		itemData[i] = ReadArray(itemTable + ((i - 1) * 20), 20)
	end

	local loadstate = ""
	while randosave do
		local line = randosave:read("*l")
		if line == nil then
			break
		elseif #line < 3 then
			loadstate = ""
		elseif loadstate == "" then
			loadstate = line
		elseif string.find(loadstate, "ewards") then
			local i = tonumber(string.sub(line, 1, 3), 16)
			local v = tonumber(string.sub(line, 5, 8), 16)
			rewards[i] = v
			if v ~= ReadShort(rewardTable + ((i - 1) * 2)) then
				freshboot = true
			end
		elseif string.find(loadstate, "hests") then
			local i = tonumber(string.sub(line, 1, 3), 16)
			local v = tonumber(string.sub(line, 5, 8), 16)
			chests[i] = v
		elseif string.find(loadstate, "tem swaps") then
			local i = tonumber(string.sub(line, 1, 2), 16)
			local v = tonumber(string.sub(line, 4, 5), 16)
			itemids[i] = v
		elseif string.find(loadstate, "hops") then
			local i = tonumber(string.sub(line, 1, 3), 16)
			local v = tonumber(string.sub(line, 5, 6), 16)
			shops[i] = v
		elseif string.find(loadstate, "ynths") then
			local i = tonumber(string.sub(line, 1, 2), 16)
			synths[i] = {}
			for j=1, 6 do
				local v = tonumber(string.sub(line, 2 + (j * 2), 3 + (j * 2)), 16)
				synths[i][j] = v
			end
		elseif string.find(loadstate, "agic") then
			local i = tonumber(string.sub(line, 1, 1), 16)
			local v = tonumber(string.sub(line, 3, 3), 16)
			perMagicShuffle[i] = v
		elseif string.find(loadstate, "rinit") then
			local i = tonumber(string.sub(line, 1, 1), 16)
			local v = tonumber(string.sub(line, 3, 3), 16)
			trinityTable[i] = v
		elseif string.find(loadstate, "ora stats") then
			local i = tonumber(string.sub(line, 1, 2))
			local v = tonumber(string.sub(line, 4, 5), 16)
			soraLevels[i] = v
		elseif string.find(loadstate, "onald stats") then
			local i = tonumber(string.sub(line, 1, 2))
			local v = tonumber(string.sub(line, 4, 5), 16)
			donaldLevels[i] = v
		elseif string.find(loadstate, "oofy stats") then
			local i = tonumber(string.sub(line, 1, 2))
			local v = tonumber(string.sub(line, 4, 5), 16)
			goofyLevels[i] = v
		elseif string.find(loadstate, "ora abilities1") then
			local i = tonumber(string.sub(line, 1, 2))
			local v = tonumber(string.sub(line, 4, 5), 16)
			soraAbilities[i] = v
		elseif string.find(loadstate, "ora abilities2") then
			local i = tonumber(string.sub(line, 1, 2))
			local v = tonumber(string.sub(line, 4, 5), 16)
			soraAbilities2[i] = v
		elseif string.find(loadstate, "ora abilities3") then
			local i = tonumber(string.sub(line, 1, 2))
			local v = tonumber(string.sub(line, 4, 5), 16)
			soraAbilities3[i] = v
		elseif string.find(loadstate, "onald abilities") then
			local i = tonumber(string.sub(line, 1, 2))
			local v = tonumber(string.sub(line, 4, 5), 16)
			donaldAbilities[i] = v
		elseif string.find(loadstate, "oofy abilities") then
			local i = tonumber(string.sub(line, 1, 2))
			local v = tonumber(string.sub(line, 4, 5), 16)
			goofyAbilities[i] = v
		elseif string.find(loadstate, "eapons") then
			local i = tonumber(string.sub(line, 1, 2), 16)
			local str = tonumber(string.sub(line, 4, 5), 16)
			local mag = tonumber(string.sub(line, 7, 8), 16)
			weaponStr[i] = str
			weaponMag[i] = mag
		elseif string.find(loadstate, "eports") then
			local i = tonumber(string.sub(line, 1, 2), 16)
			reportData[i]= {}
			for j=1, (#line - 3) / 2 do
				local v = tonumber(string.sub(line, 2 + (j * 2), 3 + (j * 2)), 16)
				reportData[i][j] = v
			end
		elseif string.find(loadstate, "tem data") then
			local i = tonumber(string.sub(line, 1, 2), 16)
			for j=1, 20 do
				if not freshboot or (j>=9 and j<=12) then
					local v = tonumber(string.sub(line, 2 + (j * 2), 3 + (j * 2)), 16)
					itemData[i][j] = v
				end
			end
		end
	end
	randosave:close()
	ConsolePrint("Loaded saved rando")
	isValidSeed = true
	return true
end

local function Randomize()
	successfulRando = false

	if not LoadRando() then
		local missableRewards = {0, 2}
		local addItems = {
			137, 140, 169, 171, 172, 173, 175, 177, 178, 183,
			217, 218, 219, 220, 221, 222, 223, 224, 225, 226
		}
		local addRewards = {}
		local addChests = {}
		local importantPool = {5, 57, 72, 73, 74, 75, 76, 77, 78, 79, 80, 145, 146, 147, 148, 232}
		local rewardPool = {}
		local randomGets = {}
		local randomFiller = {}

		for i=1, 255 do
			itemids[i] = i
		end

		for i=1, #addItems do
			if addItems[i] <= 140 or math.random(2) == 2 then
				addChests[#addChests + 1] = addItems[i] * 16
			else
				addRewards[#addRewards + 1] = addItems[i] * 256 + 240
			end
		end

		for i=1, 169 do
			if rewardDetails[i] and vanillaRewards[i] ~= true then
				rewardPool[#rewardPool + 1] = ReadShort(rewardTable + ((i - 1) * 2))
			end
		end
		for i=1, 99 do
			soraLevels[i] = ReadByte(soraStatTable + i - 1)
			soraAbilities[i] = ReadByte(soraAbilityTable + i - 1)
			soraAbilities2[i] = ReadByte(soraAbilityTable2 + i - 1)
			soraAbilities3[i] = ReadByte(soraAbilityTable3 + i - 1)
			goofyLevels[i] = ReadByte(goofyStatTable + i - 1)
			goofyAbilities[i] = ReadByte(goofyAbilityTable + i - 1)
			donaldLevels[i] = ReadByte(donaldStatTable + i - 1)
			donaldAbilities[i] = ReadByte(donaldAbilityTable + i - 1)
		end

		local chestPool = {}

		for i=1, 511 do
			if chestDetails[i] and vanillaChests[i] ~= true then
				chestPool[#chestPool + 1] = ReadShort(chestTable + ((i - 1) * 2))
			end
		end

		local weaponPool = {}
		local accessoryPool = {}
		for i=17, 134 do
			if string.find(ItemType(i), "Weapon") then
				weaponPool[#weaponPool + 1] = i
			elseif string.find(ItemType(i), "Accessory") then
				accessoryPool[#accessoryPool + 1] = i
			end
		end

		local filler = 6 + math.random(6)

		for i=1, 255 do
			inventoryUpdater[i] = ReadByte(inventory + (i - 1))
			local itype = ItemType(i)
			if itype == "Important" then
				randomGets[#randomGets + 1] = i
			elseif string.find(itype, "Use") or string.find(itype, "Important") and not (i >= 200 and i <= 204) then
				randomFiller[#randomFiller + 1] = i
			elseif string.find(itype, "Accessory") and filler > 0 then
				randomFiller[#randomFiller + 1] = 1
				filler = filler - 1
			end
			if string.find(itype, "Weapon") then
				local r = math.random(#weaponPool)
				while not ItemCompatibility(i, weaponPool[r]) do
					r = math.random(#weaponPool)
				end
				itemids[i] = table.remove(weaponPool, r)
			end
			if string.find(itype, "Accessory") then
				local r = math.random(#accessoryPool)
				while not ItemCompatibility(i, accessoryPool[r]) do
					r = math.random(#accessoryPool)
				end
				itemids[i] = table.remove(accessoryPool, r)
			end
		end
		--Replace key item pickups with other stuff
		local order = GetRandomOrder(255)
		for j=1, 255 do
			local i = order[j]
			if string.find(ItemType(i), "Important") then
				if #randomFiller > 0 then
					itemids[i] = table.remove(randomFiller, math.random(#randomFiller))
				elseif not (i >= 195 and i <= 199) then
					itemids[i] = table.remove(randomGets, math.random(#randomGets))
				end
			end
		end
		--Assign key items to unused item IDs, which are then distributed to checks
		for i=1, #importantPool do
			if #randomGets > 0 then
				itemids[importantPool[i]] = table.remove(randomGets, math.random(#randomGets))
			else
				importantPool[i] = nil
			end
		end

		ConsolePrint(string.format("randomGets: %d", #randomGets))

		shopPool = {}

		for i=1, 255 do
			itemData[i] = ReadArray(itemTable + ((i - 1) * 20), 20)
			local price = 0
			if ReadShort(itemTable + ((i - 1) * 20) + 8) == 0 then
				price = (math.random(9) + 1) * 500
				itemData[i][9] = price % 256
				itemData[i][10] = price // 256
			end
			if ReadShort(itemTable + ((i - 1) * 20) + 10) == 0 and Salable(i) then
				price = price > 0 and (price // 10) or ReadShort(itemTable + ((i - 1) * 20) + 8)
				itemData[i][11] = price % 256
				itemData[i][12] = price // 256
			end

			if ItemType(i) ~= "" and not (i >= 200 and i <= 204) and randomShops ~= 0 and
				(randomShops ~= 1 or ItemType(i) ~= "Important") then
				shopPool[#shopPool + 1] = i
			end
		end

		local extraAbilities = {1, 1, 2, 4, 21, 22}
		order = GetRandomOrder(169)

		for r=1, 169 do
			local i=order[r]
			if rewardDetails[i] then
				if vanillaRewards[i] == true then
					rewards[i] = ReadShort(rewardTable + ((i - 1) * 2))
				elseif vanillaRewards[i] == false then
					rewards[i] = 496
				else
					rewards[i] = table.remove(rewardPool, math.random(#rewardPool))
					if rewards[i] % 256 == 240 and ItemType(rewards[i] // 256)=="Synth" then
						if #importantPool > 5 then
							rewards[i] = table.remove(importantPool, math.random(#importantPool)) * 256 + 240
						elseif #extraAbilities > 0 then
							rewards[i] = table.remove(extraAbilities, math.random(#extraAbilities)) * 256
							if rewards[i] // 256 <= 4 then
								rewards[i] = rewards[i] + 177
							else
								rewards[i] = rewards[i] + 1
							end
						elseif #addRewards > 0 then
							rewards[i] = table.remove(addRewards, 1)
						end
					end
				end
			end
		end

		ConsolePrint("Randomized reward pool")

		order = GetRandomOrder(511)

		for c=1, 511 do
			local i=order[c]
			if chestDetails[i] then
				if vanillaChests[i] == true then
					chests[i] = ReadShort(chestTable + ((i - 1) * 2))
				elseif vanillaChests[i] == false then
					chests[i] = 16
				else
					local r = math.random(#chestPool)
					while i == 0 and chestPool[r] % 16 == 4 do
						r = math.random(#chestPool)
					end
					chests[i] = table.remove(chestPool, r)

					if (chests[i] - 2) % 16 == 0 then
						if #importantPool > 0 then
							chests[i] = table.remove(importantPool, math.random(#importantPool)) * 16
						elseif #missableRewards > 0 then
							chests[i] = table.remove(missableRewards, 1) * 16 + 14
							ConsolePrint("Added missable reward to chest")
						elseif #addChests > 0 then
							chests[i] = table.remove(addChests, 1)
						else
							chests[i] = chests[i] + 4
						end
					end
				end
			end
		end

		ConsolePrint(string.format("importantPool: %d", #importantPool))
		ConsolePrint(string.format("AddItems: %d", #addChests + #addRewards))

		for i=1, 511 do
			if chests[i] and (i >= 447 or i == 1) and ((chests[i]-4) % 16) == 0 then
				for j=10, 446 do
					if chests[j] and chests[j] % 16 ~= 4 and vanillaChests[j] == nil then
						local temp = chests[j]
						chests[j] = chests[i]
						chests[i] = temp
						break
					end
				end
			end
		end
		ConsolePrint("Randomized chests")

		order = GetRandomOrder(169)
		for j=1, 73 do
			local i = order[j]
			if rewards[i] and rewards[i] % 256 == 1 and vanillaRewards[i] == nil then
				local r = math.random(95) + 4
				while soraAbilities[r] < 129 do
					r = math.random(95) + 4
				end
				local ab = soraAbilities[r]
				local replaced = {false, false, false}
				for l=1, 99 do
					if soraAbilities[l] == ab and not replaced[1] then
						soraAbilities[l] = (rewards[i] // 256) + 128
						replaced[1] = true
					end
					if soraAbilities2[l] == ab and not replaced[2] then
						soraAbilities2[l] = (rewards[i] // 256) + 128
						replaced[2] = true
					end
					if soraAbilities3[l] == ab and not replaced[3] then
						soraAbilities3[l] = (rewards[i] // 256) + 128
						replaced[3] = true
					end
				end
				rewards[i] = ((ab - 128) * 256) + 1
			elseif rewards[i] and rewards[i] % 256 == 33 and vanillaRewards[i] == nil then
				local r = math.random(95) + 4
				while goofyAbilities[r] < 129 do
					r = math.random(95) + 4
				end
				local ab = goofyAbilities[r]
				goofyAbilities[r] = (rewards[i] // 256) + 128
				rewards[i] = ((ab - 128) * 256) + 33
			elseif rewards[i] and rewards[i] % 256 == 17 and vanillaRewards[i] == nil then
				local r = math.random(95) + 4
				while donaldAbilities[r] < 129 do
					r = math.random(95) + 4
				end
				local ab = donaldAbilities[r]
				donaldAbilities[r] = (rewards[i] // 256) + 128
				rewards[i] = ((ab - 128) * 256) + 33
			end
		end
		ConsolePrint("Mixed level up abilities with reward abilities")

		for i=1, 99 do
			local r = math.random(99)
			local orig = soraLevels[i]
			local other = soraLevels[r]
			soraLevels[i] = other
			soraLevels[r] = orig

			if earlyAbilities[i] then
				soraAbilities[i] = earlyAbilities[i]
				soraAbilities2[i] = earlyAbilities[i]
				soraAbilities3[i] = earlyAbilities[i]
			else
				r = math.random(95) + 4
				orig = soraAbilities[i]
				if orig > 0 then
					while soraAbilities[r] == 0 do
						r = math.random(95) + 4
					end
					other = soraAbilities[r]
					soraAbilities[i] = other
					soraAbilities[r] = orig
				end

				r = math.random(95) + 4
				orig = soraAbilities2[i]
				if orig > 0 then
					while soraAbilities2[r] == 0 do
						r = math.random(95) + 4
					end
					other = soraAbilities2[r]
					soraAbilities2[i] = other
					soraAbilities2[r] = orig
				end

				r = math.random(95) + 4
				orig = soraAbilities3[i]
				if orig > 0 then
					while soraAbilities3[r] == 0 do
						r = math.random(95) + 4
					end
					other = soraAbilities3[r]
					soraAbilities3[i] = other
					soraAbilities3[r] = orig
				end
			end

			r = math.random(99)
			orig = goofyLevels[i]
			other = goofyLevels[r]
			goofyLevels[i] = other
			goofyLevels[r] = orig

			r = math.random(99)
			orig = goofyAbilities[i]
			if orig > 0 then
				while goofyAbilities[r] == 0 do
					r = math.random(99)
				end
				other = goofyAbilities[r]
				goofyAbilities[i] = other
				goofyAbilities[r] = orig
			end

			r = math.random(99)
			orig = donaldLevels[i]
			other = donaldLevels[r]
			donaldLevels[i] = other
			donaldLevels[r] = orig

			r = math.random(99)
			orig = donaldAbilities[i]
			if orig > 0 then
				while donaldAbilities[r] == 0 do
					r = math.random(99)
				end
				other = donaldAbilities[r]
				donaldAbilities[i] = other
				donaldAbilities[r] = orig
			end
		end
		ConsolePrint("Randomized level ups")

		local magicPool = {1, 2, 3, 4, 5, 6, 7}
		for i=1, 7 do
			perMagicShuffle[i] = table.remove(magicPool, math.random(#magicPool))
		end
		ConsolePrint("Randomized magic")

		local trinityPool = {1, 2, 3, 4, 5}
		for i=1, 5 do
			trinityTable[i] = table.remove(trinityPool, math.random(#trinityPool))
		end
		ConsolePrint("Randomized trinities")

		for i=1, 5 do
			ConsolePrint(string.format("trinity %x became %x", i, trinityTable[i]))
		end

		for i=81, 133 do
			if string.find(ItemType(i), "Weapon") then
				local tablePos = (itemids[i] - 81) * 88
				if weaponStatRando < 2 then
					tablePos = (i - 81) * 88
				end
				weaponStr[i] = ReadByte(weaponTable + tablePos)
				weaponMag[i] = ReadByte(weaponTable + tablePos + 8)
				local magSigned = (weaponMag[i] > 127) and -(256 - weaponMag[i]) or weaponMag[i]
				if weaponStatRando % 2 == 1 then
					local randomPower = math.random(8) + 6
					while weaponStr[i] + magSigned * 5 < randomPower do
						weaponStr[i] = weaponStr[i] + 1
					end
				end
			end
		end
		ConsolePrint("Randomized equipment")

		local shopMap = {}
		for i=0, 7 do
			if i == 4 or i == 7 then
				shopMap = {}
			end
			local shopItem = 0
			local shopItemID = ReadInt(shopTableBase + (i * 212) + (shopItem * 4))
			while shopItemID > 0 and #shopPool > 0 do
				if not shopMap[shopItemID] then
					shopMap[shopItemID] = table.remove(shopPool, math.random(#shopPool))
				end
				shops[i * 256 + shopItem + 1] = shopMap[shopItemID]
				shopItem = shopItem + 1
				shopItemID = ReadInt(shopTableBase + (i * 212) + (shopItem * 4))
			end
		end
		ConsolePrint("Randomized shops")

		local synthCommon = {156, 254, 255}
		local synthUnique = {}
		for i=10, 134 do
			if string.find(ItemType(i), "Weapon") then
				synthUnique[#synthUnique + 1] = i
			end
		end

		local shopItem = 0
		local shopItemID = ReadByte(synthItems + (shopItem * 10))
		while shopItemID > 0 and #shopPool > 0 do
			shopItem = shopItem + 1
			synths[shopItem] = {}
			local it = table.remove(shopPool, math.random(#shopPool))
			synths[shopItem][1] = it
			if math.random(10) >= 8 and #synthUnique > 0 and not (it >= 192 and it <= 198) then
				synths[shopItem][2] = table.remove(synthUnique, math.random(#synthUnique))
			else
				synths[shopItem][2] = synthCommon[math.random(#synthCommon)]
			end
			shopItemID = ReadByte(synthItems+(shopItem*10))
		end
		ConsolePrint("Randomized synth")
	end
	successfulRando = true
end

local function FixSeed()
	local keyitems = {
		188, 189, 190, 191, 205, 217, 218, 219, 220,
		221, 222, 223, 224, 225, 226, 228, 229
	}

	for i=1, #keyitems do
		local keyitem = keyitems[i]
		if not ItemAccessible(keyitem, 1) then
			local o = GetRandomOrder(511)
			local validswap = 1
			for j=1, 511 do
				local c = o[j]
				if chests[c] and chests[c] % 16 == 0 then
					local it = itemids[chests[c] // 16]
					if it == keyitem then
						local temp = chests[validswap]
						chests[validswap] = chests[c]
						chests[c] = temp
						ConsolePrint(string.format("Swapped location of %s", itemNames[keyitem][1]))
						break
					elseif chests[c] and vanillaChests[c] == nil then
						validswap = c
					end
				end
			end

			o = GetRandomOrder(169)
			for j=1, 169 do
				local r = o[j]
				if rewards[r] and rewards[r] % 256 == 240 then
					local it = itemids[rewards[r] // 256]
					if it == keyitem and it ~= rewards[r] // 256 then
						local temp = rewards[validswap]
						rewards[validswap] = rewards[r]
						rewards[r] = temp
						ConsolePrint(string.format("Swapped location of %s", itemNames[keyitem][1]))
						break
					elseif rewards[r] and vanillaRewards[r] == nil then
						validswap = r
					end
				end
			end
		end
	end
end

local function WriteTable(savefile, info)
	savefile:write(info[1])
	if info[4] == 2 then
		for i=1, #info[2] do
			savefile:write(string.format("%02x ", i))
			for j=1, #info[2][i] do
				savefile:write(string.format(info[3], info[2][i][j]))
			end
			savefile:write("\n")
		end
	else
		local startFor = 1
		local forLength = #info[2]
		if info[4] == 3 then
			startFor = info[5]
			forLength = info[6]
		end
		for i=startFor, forLength do
			if info[2][i] and info[1] ~= "\nWeapons:\n" then
				savefile:write(string.format(info[3], i, info[2][i]))
			elseif info[2][i] then
				savefile:write(string.format(info[3], i, info[2][i], weaponMag[i]))
			end
		end
	end
end

local function SaveRando()
	GenerateReports()
	local randosave = io.open("randofiles/" .. string.sub(seedstring, 1, 10) .. ".save", "w")
	tables = {
		{"Rewards:\n", rewards, "%03x %04x\n", 1},
		{"\nChests:\n", chests, "%03x %04x\n", 3, 1, 511},
		{"\nItem swaps:\n", itemids, "%02x %02x\n", 1},
		{"\nShops:\n", shops, "%03x %02x\n", 3, 1, 2559},
		{"\nSynths:\n", synths, "%02x", 2},
		{"\nMagic:\n", perMagicShuffle, "%x %x\n", 1},
		{"\nSora stats:\n", soraLevels, "%02d %x\n", 1},
		{"\nSora abilities1:\n", soraAbilities, "%02d %x\n", 1},
		{"\nSora abilities2:\n", soraAbilities2, "%02d %x\n", 1},
		{"\nSora abilities3:\n", soraAbilities3, "%02d %x\n", 1},
		{"\nDonald stats:\n", donaldLevels, "%02d %x\n", 1},
		{"\nDonald abilities:\n", donaldAbilities, "%02d %x\n", 1},
		{"\nGoofy stats:\n", goofyLevels, "%02d %x\n", 1},
		{"\nGoofy abilities:\n", goofyAbilities, "%02d %x\n", 1},
		{"\nWeapons:\n", weaponStr, "%02x %02x %02x\n", 3, 81, 134},
		{"\nReports:\n", reportData, "%02x", 2},
		{"\nItem data:\n", itemData, "%02x", 2},
	}
	for i=1, #tables do
		WriteTable(randosave, tables[i])
	end
	randosave:close()
	ConsolePrint("Saved rando")
end

local function ValidSeed()
	local keyitems = {205, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 228, 229}
	for _=1, 5 do
		itemsAvailable = {}
		abilitiesAvailable = {}
		dalmatiansAvailable = 0

		for i=1, 255 do
			itemsAvailable[i] = 0
			abilitiesAvailable[i] = 0
		end

		for j=1, 10 do
			GetAvailability()
			local HBWin = ItemAccessible(205, 1)
			ConsolePrint(itemNames[205][1] .. ": " .."205" .. " = " .. itemsAvailable[205])
			ConsolePrint(string.format("cd %s", tostring(ItemAccessible(205, 1))))
			for i=188, 191 do
				ConsolePrint(itemNames[i][1] .. ": " .. i .. " = " .. itemsAvailable[i])
				ConsolePrint(string.format("%s %s", itemNames[i][1], tostring(ItemAccessible(i, 1))))
				HBWin = HBWin and ItemAccessible(i, 1)
			end

			local DIWin = true
			for i=192, 199 do
				ConsolePrint(itemNames[i][1] .. ": " .. i .. " = " .. itemsAvailable[i])
				ConsolePrint(string.format("%s %s", itemNames[i][1], tostring(ItemAccessible(i, 1))))
				DIWin = DIWin and ItemAccessible(i, 1)
			end

			for i=1, #keyitems do
				ConsolePrint(string.format("%s %s", itemNames[keyitems[i]][1], tostring(ItemAccessible(keyitems[i], 1))))
			end

			ConsolePrint(itemNames[211][1] .. ": " .."211" .. " = " .. itemsAvailable[211])
			ConsolePrint(itemNames[228][1] .. ": " .."228" .. " = " .. itemsAvailable[228])
			ConsolePrint("Dalmations avail: " .. dalmatiansAvailable)
			local misc = dalmatiansAvailable == 99 and ItemAccessible(228, 1) and ItemAccessible(211, 3)

			ConsolePrint(string.format("Complexity %d", j))
			if HBWin then
				ConsolePrint("HBWin")
			end
			if DIWin then
				ConsolePrint("DI Win")
			end
			if misc then
				ConsolePrint("All checks possible")
			else
				ConsolePrint(string.format("Dalm: %d Jack: %s Postcards: %d",
				dalmatiansAvailable, tostring(ItemAccessible(228, 1)), itemsAvailable[211]))
			end
			if HBWin and DIWin and misc then
				SaveRando()
				return true
			end
		end

		for c=1, 511 do
			if chests[c] and chests[c] % 16 == 0 then
				local it = itemids[chests[c] // 16]
				if it >= 192 and it <= 199 then
					ConsolePrint(string.format("%s on chest %x", itemNames[it][1], c))
					break
				end
			end
		end

		for r=1, 169 do
			if rewards[r] and rewards[r] % 256 == 240 then
				local it = itemids[rewards[r] // 256]
				if it >= 192 and it <= 199 then
					ConsolePrint(string.format("%s on chest %x", itemNames[it][1], r))
					break
				end
			end
		end

		for i=1, 255 do
			if itemids[i] >= 192 and itemids[i] <= 199 then
				ConsolePrint(string.format("%s became %s", itemNames[i][1], itemNames[itemids[i]][1]))
			end
		end

		FixSeed()
		ConsolePrint("\nAttempted to fix seed\n")
	end

	ConsolePrint("Unwinnable, rerolling")
	return false
end

local function ApplyRandomization()
	for i=1, 169 do
		if rewards[i] then
			WriteShort(rewardTable + ((i - 1) * 2), rewards[i])
		end
	end
	ConsolePrint("Reward randomization applied")

	for i=1, 511 do
		if chests[i] then
			WriteShort(chestTable + ((i - 1) * 2), chests[i])
		end
	end
	ConsolePrint("Chest randomization applied")

	for i=1, 255 do
		WriteArray(itemTable + ((i - 1) * 20), itemData[i])
	end
	ConsolePrint("Applied item manipulation")

	for i=0, 7 do
		local shopItem = 0
		local maxtier = math.max(i <= 3 and 3 or 6, i)

		while shops[maxtier * 256 + shopItem + 1] do
			WriteInt(shopTableBase + (i * 212) + (shopItem * 4), shops[maxtier * 256 + shopItem + 1])
			shopItem = shopItem + 1
		end
	end
	ConsolePrint("Shop randomization applied")

	local reqOff = 0
	for i=0, (#synths) - 1 do
		WriteByte(synthItems + (i * 10), synths[i + 1][1]) -- Synth item
		WriteByte(synthItems + (i * 10) + 2, reqOff) -- Requirement table offset
		WriteByte(synthItems + (i * 10) + 3, #synths[i + 1] - 1) -- Requirement count
		for j=2, #synths[i + 1] do
			WriteByte(synthRequirements + (reqOff * 4), synths[i + 1][j]) -- Requirement item
			WriteByte(synthRequirements + (reqOff * 4) + 2, 1) -- Requirement count
			reqOff = reqOff + 1
		end
	end

	for i=1, 99 do
		WriteByte(soraStatTable + (i - 1), soraLevels[i])
		WriteByte(soraAbilityTable + (i - 1), soraAbilities[i])
		WriteByte(soraAbilityTable2 + (i - 1), soraAbilities2[i])
		WriteByte(soraAbilityTable3 + (i - 1), soraAbilities3[i])
		WriteByte(goofyStatTable + (i - 1), goofyLevels[i])
		WriteByte(goofyAbilityTable + (i - 1), goofyAbilities[i])
		WriteByte(donaldStatTable + (i - 1), donaldLevels[i])
		WriteByte(donaldAbilityTable + (i - 1), donaldAbilities[i])
	end
	ConsolePrint("Level randomization applied")

	for i=81, 133 do
		if weaponStr[i] then
			local tablePos = (i - 81) * 88
			WriteByte(weaponTable + tablePos, weaponStr[i])
			WriteByte(weaponTable + tablePos + 8, weaponMag[i])
			WriteArray(itemTable + ((i - 1) * 20), itemData[itemids[i]])
		end
	end
	ConsolePrint("Weapon randomization applied")

	for i=17, 71 do
		if i ~= itemids[i] and string.find(ItemType(i), "Accessory") then
			WriteArray(itemTable + ((i - 1) * 20), itemData[itemids[i]])
		end
	end
	ConsolePrint("Accessory randomization applied")

	ConsolePrint(string.rep("\nHiding spoilers\n", 10))
	for i=81, 96 do
		ConsolePrint(string.format("%x became %x", i, itemids[i]))
	end
	ConsolePrint("You can verify you have the same seed by referring to above")

	randomized = true
	ConsolePrint("Applied randomization")
	successfulRando = true
end

local function CharToMem(c)
	if c and c >= 65 and c <= 90 then
		return c - 54
	elseif c and c >= 97 and c <= 122 then
		return c - 60
	elseif c and c >= 48 and c <= 57 then
		return c - 47
	elseif c and c == 46 then
		return 72
	else
		return 9999
	end
end

local function CharSpacing(c)
	if c and (c == 23 or c == 33 or c == 49 or c == 59) then
		return 13
	elseif c and (c >= 11 and c <= 36) then
		return 11
	elseif c and (c == 45 or c == 48 or c == 72) then
		return 5
	else
		return 10
	end
end

local function StringToMem(off, text, l, base)
	local textlen = math.max(#text, l)
	local nextPos = 0
	local garbageCount = 0
	for i=1, textlen do
		local c = string.byte(text, i,i)
		local d = CharToMem(c)
		local addr = off + ((i - 1) * 20)
		if i > l then
			local sample = ReadArray(addr - 20, 20, true)
			sample[5] = sample[5] + 10
			if ReadShort(addr, true) == 0 or ReadShort(addr, true) > 9999 or ReadShort(addr + 4, true) == 0 then
				garbageCount = garbageCount + 1
			end
			WriteArray(addr, sample, true)
		end
		WriteShort(addr, d, true)
		if i > 1 then
			local newPos = nextPos
			WriteShort(addr + 4, newPos, true)
		end
		nextPos = ReadShort(addr + 4, true) + CharSpacing(d)
	end
	if textlen > l and garbageCount > 0 then
		local size = ReadShort(base + 2, true)
		if string.find(textFind, "btained") then
			size = #textReplace + 1
			garbageCount = 0
		end
		ConsolePrint(garbageCount)
		WriteShort(base + 2, size + garbageCount - 1, true)
	end
end

local function MemStringSearch(c, re)
	local textMatch = 1
	local ppos = 0
	local inc = 8
	local success = false

	while ppos < c do
		local pointer = textPointerBase + ppos
		local address = ReadLong(pointer)

		if address > 268435455 then
			for i=1, 50 do
				local letter = ReadShort(address + (i * 20), true)
				if letter > 10224 or letter == 0 then
					break
				end
				if letter == re[textMatch] then
					textMatch = textMatch + 1
					if textMatch >= 4 then
						local start = address + ((i - textMatch + 2) * 20)
						ConsolePrint(string.format("match at %x", ppos))
						StringToMem(start, textReplace, #textFind, address)
						textMatch = 1
						success = true
					end
				else
					textMatch = 1
				end
			end
		end

		ppos = ppos + inc
	end
	return success
end

local function ReplaceTexts()
	infoBoxWas = ReadByte(infoBoxNotVisible)

	if idFind > 0 and ReadByte(itemDropID) == idFind then
		WriteByte(itemDropID, idReplace)
		idFind = 0
		textFind = ""
		ConsolePrint("Replaced item drop")
	end

	if textFind ~= "" and (infoBoxWas == 0) then
		local re = {}
		for i=1, #textFind do
			re[i] = CharToMem(string.byte(textFind, i, i))
		end

		if MemStringSearch(65535, re) then
			textFind = nextTextFind
			textReplace = nextTextReplace
			nextTextFind = ""
		end
	end
end

local function MenuNameSwap(menuNow)
	for i=1, 255 do
		if (string.find(ItemType(i), "Important") or ItemType(i) == "" or
			string.find(ItemType(itemids[i]), "Important")) and i~=itemids[i] then

			if menuNow > 0 then
				WriteArray(itemTable + ((i - 1) * 20), itemData[i])
			else
				WriteArray(itemTable + ((i - 1) * 20), itemData[itemids[i]])
			end
		end
	end
end

-- Swap key items in inventory slots
local function UpdateInventory(HUDNow)
	if bufferRemove > 0 then
		if bufferRemoveTimer > 0 then
			bufferRemoveTimer = bufferRemoveTimer - 1
		else
			local itemCount = ReadByte(inventory + (bufferRemove - 1))
			WriteByte(inventory + (bufferRemove - 1), itemCount - 1)
			bufferRemove = 0
			ConsolePrint("Late item rando to prevent softlock")
		end
	end

	for i=1, 255 do
		if not string.find(ItemType(i), "Weapon") and not string.find(ItemType(i), "Accessory") and
																i ~= itemids[i] then
			local itemCount = ReadByte(inventory + (i - 1))
			local dif = itemCount - inventoryUpdater[i]
			if dif ~= 0 then
				ConsolePrint(string.format("%d %s", dif, itemNames[i][1]))
				if dif > 0 and ReadInt(closeMenu) == 0 then
					local curid = itemids[i]
					idFind = i
					idReplace = curid
					ConsolePrint(string.format("Replacing %x with %x", i, curid))

					local otherCount = ReadByte(inventory + (curid - 1))
					if i == 224 then
						bufferRemove = i
						bufferRemoveTimer = 360
						inventoryUpdater[i] = itemCount + dif
					else
						WriteByte(inventory + (i - 1), itemCount - dif)
					end
					if curid == 192 or curid == 198 then
						dif = 2
					elseif curid == 196 or curid == 197 then
						dif = 3
					end
					WriteByte(inventory+(curid-1), otherCount+dif)
					inventoryUpdater[curid] = otherCount+dif
				else
					inventoryUpdater[i] = itemCount
				end
			elseif string.find(ItemType(itemids[i]), "Important") and itemCount > 0 and HUDNow > 0
			and ItemType(i) == "" then
				WriteByte(inventory + (itemids[i] - 1), itemCount + ReadByte(inventory + (itemids[i] - 1)))
				WriteByte(inventory + (i - 1), 0)
				inventoryUpdater[i] = 0
				inventoryUpdater[itemids[i]] = itemCount
				ConsolePrint(string.format("Used fallback to replace %x with %s", i, itemNames[itemids[i]][1]))
			end
		end
		if i >= 206 and i <= 209 and ReadByte(inventory + (i - 1)) > 1 then
			WriteByte(inventory + (i - 1), 1)
			ConsolePrint("Removed duplicate summon gem")
		end

		if i == 137 or i == 140 then
			if ReadByte(inventory + (i - 1)) > 1 and inventoryUpdater[i] < 2 then
				local hasSummons = {}
				local giveSummon = (i == 137) and 2 or 3
				ConsolePrint(giveSummon)
				for j=0, 5 do
					if ReadByte(summons + j) == 255 and not hasSummons[giveSummon] then
						WriteByte(summons + j, giveSummon)
						textFind = "Obtained"
						textReplace = "Obtained " .. (i == 137 and "Genie  " or "Tinker Bell")
						ConsolePrint(textReplace)
					end
					hasSummons[ReadByte(summons + j)] = true
				end
			end
			inventoryUpdater[i] = ReadByte(inventory + (i - 1))
		end
	end

	for i=1, 64 do
		local itemCount = ReadByte(gummiInventory + (i - 1))
		if itemCount > gummiUpdater[i] then
			if ReadInt(closeMenu) == 0 and ReadByte(world) == 3 then
				local report = -1
				if i == 2 then
					report = 149
				elseif i == 7 then
					report = 150
				elseif i == 60 then
					report = 151
				end
				if report > 0 then
					WriteByte(inventory + (report - 1), 1)
					inventoryUpdater[report] = 1
					textFind = "Obtained"
					textReplace = "Obtained " .. itemNames[report][1]
					ConsolePrint(string.format("Replacing %s with %s", textFind, textReplace))
				end
			end
			gummiUpdater[i] = itemCount
		end
	end

	WriteByte(inventory + 199, 0)
	WriteByte(inventory + 200, 0)
	WriteByte(inventory + 202, 0)
	WriteByte(inventory + 203, 0)
	WriteByte(inventory + 227, math.min(1, ReadByte(inventory + 227)))
end

local function UpdateReports(HUDNow)
	if HUDNow < 1 then
		local reportTable = {
			[1] = 8, [2] = 7, [4] = 6, [8] = 5, [16] = 4,
			[32] = 3, [64] = 2, [128] = 1, [2048] = 13,
			[4096] = 12, [8192] = 11, [16384] = 10, [32768] = 9
		}
		local receivedReport = reportTable[ReadShort(reports)]
		if receivedReport and HUDWas == HUDNow then
			local i = itemids[167 + receivedReport]
			local addc = 1
			if i == 192 or i == 198 then
				addc = 2
			elseif i == 196 or i == 197 then
				addc = 3
			end
			WriteByte(inventory + (i - 1), ReadByte(inventory + (i - 1)) + addc)
			inventoryUpdater[i] = ReadByte(inventory + (i - 1))
			ConsolePrint(string.format("Gave %x instead of report", i))
		end
		WriteShort(reports, 0)
	else
		local reportTable = {
			[8] = 1, [7] = 2, [6] = 4, [5] = 8, [4] = 16,
			[3] = 32, [2] = 64, [1] = 128, [13] = 2048,
			[12] = 4096, [11] = 8192, [10] = 16384, [9] = 32768
		}
		local reportStatus = 0
		for i=1, 13 do
			local off = i <= 10 and 167 or 148 - 10
			if ReadByte(inventory + (off + i - 1)) > 0 then
				reportStatus = reportStatus + reportTable[i]
			end
		end
		WriteShort(reports, reportStatus)
		if ReadShort(report1) == 513 then
			if hintLanguage == nil or hintLanguage == "auto" then
				if ReadInt(report1 + 2) == 1380796727 then
					hintLanguage = "german"
				elseif ReadInt(report1 + 2) == 1263945014 then
					hintLanguage = "spanish"
				elseif ReadInt(report1 + 2) == 1296396596 then
					hintLanguage = "french"
				end
			end
			ConsolePrint(hintLanguage)

			local enwords = {}
			local transwords = {}
			local translation = io.open(string.format("randofiles/%s.txt", hintLanguage))
			if translation ~= nil then
				while true do
					local line = translation:read("*l")
					if not line then
						break
					end
					local words = {}
					for w in line:gmatch("([^=]*)") do
						words[#words+1] = w
					end
					enwords[#enwords+1] = StringToKHText(string.gsub(words[1], '^%s*(.-)%s*$', '%1'), -2)
					transwords[#transwords+1] = StringToKHText(string.gsub(words[2], '^%s*(.-)%s*$', '%1'), -2)
				end
				translation:close()
			end

			local mempos = report1
			for i=1, 13 do
				local trdata = Translate(reportData[i], enwords, transwords, false)
				WriteArray(mempos, trdata)
				mempos = mempos + #trdata
			end
			ConsolePrint("Wrote hints")
		end
	end
end

local function ReplaceMagic()
	local unlock = 0
	local isUnlocked = {false, false, false, false, false, false, false}
	for i=1, 7 do
		local r = perMagicShuffle[i]
		if ReadByte(magicFlags + (i - 1)) > 3 then
			WriteByte(magicFlags + (i - 1), 3)
		end
		local l = ReadByte(magicFlags + (i - 1))
		WriteByte(magicLevels + (r - 1), math.max(l, 1))
		if l > 0 then
			unlock = unlock + (2 ^ (r - 1))
			isUnlocked[r] = true
		end
		if l > magicUpdater[i] then
			magicUpdater[i] = l
			if not string.find(textFind, "-G") then
				ConsolePrint("Replacing magic text")
				textFind = magicTexts[i]
				textReplace = magicTexts[r]
				nextTextFind = magicTexts2[i]
				nextTextReplace = magicTexts2[r]
				if l > 1 then
					nextTextReplace = magicTexts2[r] .. " has been upgraded               "
				end
			end
		end
	end
	WriteByte(magicUnlock, unlock)
	for j=0, 2 do
		local s = ReadByte(shortcuts + j) + 1
		if not isUnlocked[s] and s < 10 then
			WriteByte(shortcuts + j, isUnlocked[perMagicShuffle[s]] and perMagicShuffle[s] - 1 or 255)
		end
	end
end

local function ReplaceTrinity(HUDNow)
	local unlock = 0
	if ReadByte(cutsceneFlags) >= 49 then
		unlock = unlock + (2 ^ (trinityTable[1] - 1))
	end
	if ReadByte(chronicles + 8) == 32 then
		unlock = unlock + (2 ^ (trinityTable[2] - 1))
	end
	if ReadByte(chronicles + 12) == 32 then
		unlock = unlock + (2 ^ (trinityTable[3] - 1))
	end
	if ReadByte(OCCupUnlock + 2) == 1 then
		unlock = unlock + (2 ^ (trinityTable[4] - 1))
	end
	if (ReadByte(characters) // 8) % 2 == 1 then
		unlock = unlock + (2 ^ (trinityTable[5] - 1))
	end
	if ReadByte(worldFlagBase + 138) < 4 and ReadByte(world) == 11 and ReadByte(room) == 1 then
		WriteByte(trinityUnlock, 0)
	else
		WriteByte(trinityUnlock, unlock)
	end
	if HUDNow < 1 then
		local i = 0
		if ReadByte(cutsceneFlags + 1) == 95 then
			i = 2
		elseif ReadByte(cutsceneFlags + 4) == 110 then
			i = 3
		elseif ReadByte(OCCupUnlock + 2) == 1 and ReadByte(world) == 11 and ReadByte(room) == 1 then
			i = 4
		elseif ReadByte(cutsceneFlags + 10) == 40 then
			i = 5
		end
		if i > 0 then
			textFind = trinityTexts[i]
			textReplace = trinityTexts[trinityTable[i]] .. ".     "
		end
	end
end

local function CountSharedAbilities()
	local shared = {0, 0, 0}
	for i=0, 9 do
		local ab = ReadByte(sharedAbilities + i)
		if ab == 3 or ab == 4 then
			shared[3] = shared[3] + 1
		elseif ab > 0 and ab <= 4 then
			shared[ab] = shared[ab] + 1
		end
	end
	return shared
end

local function CountSoraAbilities()
	local abils = {}
	for i=0, 40 do
		local ab = ReadByte(soraCurAbilities + i)
		if ab == 0 then
			break
		elseif not abils[ab] then
			abils[ab] = 1
		else
			abils[ab] = abils[ab] + 1
		end
	end
	return abils
end

local function DodgeDataValid(a)
	return ReadShort(a + 24, true) == 239 and ReadShort(a + 52, true) == 148
end

local function GetDodgeDataAddr()
	local halfPointers = ReadLong(halfPointersAddress)
	local animHalfPointers = ReadLong(animHalfPointersAddress)
	local ind = 192
	while ReadInt(animHalfPointers + ind, true) > 0 do
		local dodgePointer = halfPointers + ReadInt(animHalfPointers + ind, true) % 16777216
		if DodgeDataValid(dodgePointer) then
			ConsolePrint(string.format("Found dodge data at %x, dodge frames: %d", ind, ReadByte(dodgePointer + 4, true)))
			return dodgePointer
		end
		ind = ind + 4
	end
	return 0
end

local function StackAbilities()
	local countedAbilities = CountSharedAbilities()
	local jumpHeight = math.max(290, 190 + (countedAbilities[1] * 100))

	WriteShort(jumpHeights + 2, jumpHeight)
	if ReadByte(world) == 16 and countedAbilities[3] == 0 and stackAbilities == 3 and (ReadByte(room) == 33 or
			(ReadByte(cutsceneFlags + 11) >= 110) and ReadFloat(soraHUD) > 0) then
		WriteShort(jumpHeights, 390)
		WriteShort(jumpHeights + 2, math.max(390, jumpHeight))
	end

	if stackAbilities > 1 then
		local glides = false
		for i=0, 9 do
			local ab = ReadByte(sharedAbilities + i)
			if ab % 128 >= 3 and not glides then
				WriteByte(sharedAbilities + i, (ab % 128 == 4) and ab - 1 or ab)
				glides = true
			elseif ab % 128 == 3 and glides then
				WriteByte(sharedAbilities + i, ab + 1)
			end
		end

		WriteInt(superglideSpeedHack, superglideBaseSpeed + math.max(countedAbilities[3] - 2, 0) * 4)

		WriteFloat(mermaidKickSpeed, 10 + (8 * countedAbilities[2]))

		if stackAbilities == 3 then
			if countedAbilities[3] == 0 and ReadLong(soraPointer) then
				if (ReadByte(stateFlag) // 32) % 2 == 1 then
					WriteByte(stateFlag, ReadByte(stateFlag) - 32)
				end
				local airGround = ReadLong(soraPointer) + 112
				if ReadInt(ReadLong(soraPointer) + 176) > 0 then
					WriteByte(airGround, 2, true)
				end
			end
		end

		-- Allow early flight in Neverland if glide equipped
		if countedAbilities[3] > 0 and ReadByte(world) == 13 then
			if (ReadByte(stateFlag) // 32) % 2 == 0 then
				WriteByte(stateFlag, ReadByte(stateFlag) + 32)
			end
		end

		if not DodgeDataValid(dodgeDataAddr) then
			dodgeDataAddr = GetDodgeDataAddr()
		end

		if DodgeDataValid(dodgeDataAddr) then
			local abils = CountSoraAbilities()
			if abils[22] then
				WriteShort(dodgeDataAddr + 4, math.max(50 - (12 * abils[22]), 22), true)
			end
		end
	end
end

local function FlagFixes()
	if ReadByte(world) == 0 and ReadByte(room) == 0 and ReadByte(cutsceneFlags - 3) == 10 then
		WriteByte(cutsceneFlags - 3, 13)
		WriteByte(warpType1, 7)
		WriteByte(warpType2, 6)
		WriteByte(warpTrigger, 2)
		WriteLong(instantGummiFix, 0) -- Fixes InstantGummi
	end

	if ReadByte(world) == 1 and ReadFloat(soraHUD) > 0 and ReadInt(inGummi) == 0 then
		WriteByte(party1, 255)
		WriteByte(party1 + 1, 255)
	end

	-- Reset TT to avoid softlocks
	if ReadByte(cutsceneFlags) < 20 and ReadByte(world) > 3 then
		WriteByte(cutsceneFlags, 0)
		WriteByte(worldFlagBase + 18, 2)
	end

	-- Secret waterway Leon unmissable
	if ReadByte(waterwayCutsceneFlag) == 0 and ReadByte(cutsceneFlags) >= 49 then
		WriteByte(cutsceneFlags, 49)
		WriteByte(worldFlagBase + 40, 2)
	end

	-- Skip TT2
	if ReadByte(cutsceneFlags) == 62 then
		WriteByte(cutsceneFlags, 78)
		WriteByte(worldFlagBase + 18, 5)
	end

	if ReadByte(cutsceneFlags) ~= prevTTFlag then
		ConsolePrint(string.format("%x, %x", prevTTFlag, ReadByte(cutsceneFlags)))
	end
	-- Revert HB1 effect on TT story
	if (ReadByte(cutsceneFlags) == 110 and ReadByte(worldFlagBase + 18) ~= 5)
											or ReadByte(cutsceneFlags) == 150 then
		WriteByte(cutsceneFlags, prevTTFlag)
	end

	if ReadByte(cutsceneFlags + 10) >= 160 and ReadByte(worldFlagBase + 18) == 5
											and ReadByte(cutsceneFlags) < 110 then
		WriteByte(cutsceneFlags, 110)
		WriteByte(cutsceneFlags - 4, math.max(190, ReadByte(cutsceneFlags - 4)))
		ConsolePrint("Post HB TT")
	end

	prevTTFlag = ReadByte(cutsceneFlags)

	if ReadByte(oppositeState) >= 5 then
		WriteByte(oppositeTrigger, 0)
	end

	if ReadByte(world) == 3 and ReadByte(room) == 19 then
		local simbaAddr = ReadLong(deathPointer) + 78280
		local earthshine = -16955
		if ReadInt(simbaAddr, true) == 1393098752 then
			simbaAddr = simbaAddr + 1120 --Spanish
		elseif ReadInt(simbaAddr, true) == 20972800 then
			simbaAddr = simbaAddr + 4272 --German
		elseif ReadInt(simbaAddr, true) == 1829306368 then
			simbaAddr = simbaAddr - 8040 --Japanese
			earthshine = -16935
		end
		if ReadByte(simbaAddr, true)==5 then
			local hasSummons = {}
			local hasAll = true
			for i=0, 5 do
				hasSummons[ReadByte(summons + i)] = true
				hasAll = hasAll and ReadByte(summons + i) < 255
			end

			WriteByte(summonsReturned, hasSummons[1] and 1 or 0)
			WriteByte(summonsReturned + 1, hasSummons[0] and 1 or 0)
			WriteByte(summonsReturned + 2, hasSummons[4] and 1 or 0)
			WriteByte(summonsReturned - 1, hasSummons[5] and 1 or 0)

			local c = ReadByte(inventory + 208) > 0

			-- Nullify normal simba acqusition
			WriteInt(simbaAddr + 4, c and 402653752 or 402653188, true)
			WriteInt(simbaAddr + 12, c and 402653747 or 402653188, true)
			-- Replace another summon with Simba
			WriteByte(simbaAddr + earthshine, c and 209 or 207, true)
			WriteByte(simbaAddr + 5883, c and 209 or 207, true)
			WriteByte(simbaAddr + 5707, c and 5 or 1, true)
			WriteByte(simbaAddr + 5707 + 8, c and 5 or 1, true)
		end
	end

	if ReadByte(world) == 8 and ReadByte(room) == 18 and ReadShort(ardOff) == 127 then
		WriteShort(ardOff, 209)
		ConsolePrint("Removed normal genie")
	end

	if ReadByte(world) == 13 and ReadByte(room) == 9 and ReadShort(ardoffsetClock) == 1522 then
		WriteShort(ardoffsetClock, 1576)
		ConsolePrint("Removed normal tinker bell")
	end

	if ReadByte(cutsceneFlags) >= 49 then
		WriteByte(worldFlagBase + 28, 2) -- Cid in accessory shop
		WriteByte(worldFlagBase + 19, 3)
	end
	if ReadByte(cutsceneFlags + 5) < 20 then -- Fix monstro DI cutscene softlock
		WriteByte(cutsceneFlags + 5, 20)
	end

	-- Shorten solo and time trial
	if ReadByte(world) == 11 then
		if (ReadShort(OCseed) == 257 or ReadShort(OCseed) == 2827)
		and ReadFloat(soraHUD) > 0 and (ReadByte(party1) == 255 or ReadInt(minitimer) > 0) then
			WriteShort(OCseed, ReadShort(OCseed) == 257 and 2313 or 4626)
		elseif ReadByte(world) == 11 and ReadByte(room) == 1 then
			WriteInt(minitimer, 0)
		end

		for i=0, 3 do
			if ReadByte(OCCupUnlock + i) ~= 10 and ReadByte(OCCupUnlock + i) ~= 1 then
				WriteByte(OCCupUnlock + i, 10) -- Unlock cups
			end
		end

		if ReadInt(OCCupDialog) == 249 and ReadByte(room) == 1 then
			WriteInt(OCCupDialog, 656)
			OCTextFix = 60
		elseif OCTextFix > 0 and ReadInt(OCCupDialog) > 656 then
			WriteFloat(textBox, ReadFloat(textBox) > 0 and 155 or -110)
			WriteFloat(textBox + 80, 160)
			OCTextFix = 0
		end

		-- Require Entry Pass
		if ReadByte(cutsceneFlags + 2) == 10 then
			WriteByte(worldFlagBase + 138, ReadByte(inventory + 228) > 0 and 3 or 2)
		end
	end

	if (ReadByte(waterwayGate) // 128) % 2 == 0 then
		WriteByte(waterwayGate, ReadByte(waterwayGate) + 128)
	end

	if (ReadByte(waterwayTrinity) // 32) % 2 == 0 then
		WriteByte(waterwayTrinity, ReadByte(waterwayTrinity) + 32)
	end

	if ReadByte(worldFlagBase + 44) >= 0 then
		if (ReadByte(chestsOpened) // 2) % 2 == 0 then
			WriteByte(worldFlagBase + 44, 13)
		elseif (ReadByte(chestsOpened) // 4) % 2 == 0 then
			WriteByte(worldFlagBase + 44, 14)
		elseif (ReadByte(chestsOpened) // 8) % 2 == 0 then
			WriteByte(worldFlagBase + 44, 16)
		end
	end

	if ReadByte(world) == 3 and ReadByte(room) == 2 and ReadByte(cutsceneFlags) == 35 then
		WriteByte(unequipBlacklist, ReadByte(soraStats + 25))
	else
		for i=0, 3 do
			WriteByte(unequipBlacklist + (i * 4), 0)
		end
	end

	if ReadInt(inGummi) > 0 then
		if ReadByte(gummiSelect) == 3 then
			WriteShort(worldWarps, 1) -- Add DI warp
			if (ReadByte(unlockedWarps) // 8) % 2 == 0 then
				WriteByte(unlockedWarps, math.max(ReadByte(unlockedWarps) + 8, 9))
			end
			WriteByte(warpCount, 4)
		else
			WriteShort(worldWarps, 4) -- Revert to Wonderland
		end

		if ReadByte(gummiSelect) == 3 and ReadByte(cutsceneFlags) < 49 then
			WriteByte(party1, 255)
			WriteByte(party1 + 1, 255)
		elseif ReadByte(gummiSelect) == 15 and ReadByte(cutsceneFlags + 10) < 49
											and ReadByte(cutsceneFlags + 10) >= 30 then
			WriteByte(party1, 9)
			WriteByte(party1 + 1, 255)
			WriteByte(party2, 9)
			WriteByte(party2 + 1, 255)
		elseif ReadByte(party1) >= 9 then
			for i=0, 1 do
				WriteByte(party1 + i, i + 1)
				WriteByte(party2 + i, i + 1)
			end
		end

		if ReadByte(lockMenu) > 0 then
			WriteByte(lockMenu, 0) -- Unlock menu
		end

		if ReadByte(enableRC) ~= 0 then
			WriteByte(enableRC, 0)
		end

		if ReadByte(reports + 4) == 0 then
			WriteByte(reports + 4, 14)
		end

		if (ReadByte(battleLevel) // 16) % 2 == 0 then
			WriteByte(battleLevel, ReadByte(battleLevel) + 16)
		end
	end

	-- Shop upgrades
	local clearedWorlds = 0
	for i=0, 8 do
		if ReadByte(chronicles + (i * 4)) == 32 then
			clearedWorlds = clearedWorlds + 1
		end
	end
	for i=0, 6 do
		local baseCount = i <= 3 and 4 or 2
		WriteInt(shopTableBase + (i * 212) - 4, baseCount + (clearedWorlds * 2))
	end

	if ReadByte(world) == 1 and ReadByte(blackFade) > 0 and ReadByte(worldFlagBase) == 2 then -- DI Day2 Warp to EotW
		RoomWarp(16, 66)
		WriteByte(party1, 1)
		WriteByte(party1 + 1, 2)
		WriteByte(worldFlagBase, 0)
		if ReadByte(cutsceneFlags + 11) >= 90 then
			WriteByte(cutsceneFlags + 11, 0)
		end
	end

	if ReadByte(cutsceneFlags + 9) == 100 then
		RoomWarp(13, 39)
		WriteByte(cutsceneFlags + 9, 106)
	end

	if ReadByte(cutsceneFlags + 3) < 17 and ReadByte(world) == 4 then
		local evidenceCount = 0
		for i=222, 225 do
			evidenceCount = evidenceCount + math.min(ReadByte(inventory + i), 1)
		end
		if evidenceCount >= requiredEvidence then
			for i=0, 3 do
				WriteByte(evidence + i, math.min(ReadByte(inventory + 222 + i), 1))
			end
		else
			for i=0, 3 do
				WriteByte(evidence + i, 0)
			end
		end
		if ReadByte(room) == 4 and evidenceCount < requiredEvidence then
			local o = 0
			while o > -5 and ReadInt(evidenceActiveForest + 4 + o * 1200) ~= 262163
						 and ReadInt(evidenceActiveForest + 4 + o * 1200) ~= 0 do
				o = o - 1
			end
			if ReadLong(evidenceActiveForest + o * 1200) == 1125981511254531 then
				WriteLong(evidenceActiveForest + o * 1200, 0)
				WriteLong(evidenceActiveForest + (o + 1) * 1200, 0)
			end
		elseif ReadByte(room) == 1 then
			local o = 0
			while o > -5 and ReadInt(evidenceActiveBizarre + 4 + o * 1200) ~= 262163
						 and ReadInt(evidenceActiveBizarre + 4 + o * 1200) ~= 0 do
				o = o - 1
			end
			if ReadLong(evidenceActiveBizarre + o * 1200) == 1125981511254019 then
				if ReadByte(inventory + 223) > 0 or evidenceCount < requiredEvidence then
					WriteLong(evidenceActiveBizarre + o * 1200, 0)
				end
				if evidenceCount < requiredEvidence then
					WriteLong(evidenceActiveBizarre + (o + 1) * 1200, 0)
				end
			end
		end
	end

	if ReadByte(world) == 5 then
		if ReadByte(room) == 8 and ReadByte(sliderProgress) == 1 then
			WriteByte(collectedFruits, 0)
			WriteByte(savedFruits, 0)
			local warpsAddr = ReadLong(warpDefinitions)
			if ReadByte(warpsAddr, true)==0 and ReadByte(warpsAddr + 64, true) == 1 then
				for i=0, 4 do
					if ReadByte(sliderProgress + i) == 1 and ReadByte(warpsAddr + 2496) < 16 + i then
						WriteArray(warpsAddr + 2496, ReadArray(warpsAddr + 2496 + (64 * (i + 1)), 64, true), true)
					end
				end
			end
		end
		if ReadByte(room) > 15 then
			WriteByte(collectedFruits, math.max(ReadByte(collectedFruits), (ReadByte(room) - 15) * 10))
		end

		if ReadByte(cutsceneFlags + 1) <= 26 then
			if ReadByte(room) == 12 then
				local slideCount = 0
				for i=0, 5 do
					slideCount = slideCount + math.min(ReadByte(inventory + 216 + i), 1)
				end
				if slideCount < requiredSlides then
					local o = 0
					while ReadInt(slideActive + o * 1200 + 4) ~= 262168 and ReadInt(slideActive + o * 1200 + 4) ~= 0 and o > -5 do
						o = o-1
					end
					if ReadInt(slideActive + o * 1200 + 4) == 262168 then
						for i=0, 5 do
							if ReadInt(slideActive + (i + o) * 1200 + 4) == 262168 + (i > 1 and i + 4 or i) then
								WriteLong(slideActive + (i + o) * 1200, 0)
							end
						end
					end
				end
			end
		end
	end

	if ReadByte(world) == 6 then
		if ReadInt(poohProgress) == 0 then
			WriteInt(poohProgress, 1) --Intro cutscene
			WriteInt(poohProgress2, 131074) --1st and 2nd area
			WriteInt(poohProgress2 + 4, 131077) --3rd area and 4th (4,9 final)
			WriteInt(poohProgress2 + 8, 131074) --5th area and 6th (4,9 final)
		end
		if ReadByte(collectedFruits) >= 100 and ReadByte(room) == 4 then
			WriteInt(minitimer, 0)
		end
	end

	--Early EotW, blocked until HB2
	if ReadByte(cutsceneFlags + 10) < 195 and ReadByte(world) == 16 then
		if ReadByte(currentTerminus) == 9 then --Hide teleporter to HB portal
			WriteInt(terminusTeleUsable, 4294957296)
			WriteInt(terminusTeleVisible, 3323740160)
		end
	elseif ReadInt(inGummi) > 0 and eotWSkip ~= 0 and ReadByte(unlockedWarps + 9) < 3
								and ReadByte(cutsceneFlags + 10) >= 195 then
		WriteByte(unlockedWarps + 9, 3)
		WriteByte(cutsceneFlags + 11, math.max(ReadByte(cutsceneFlags + 11), 8))
		WriteByte(worldFlagBase + 210, 13)
		WriteByte(worldFlagBase + 213, 13)
	end

	if ReadByte(battleLevel) % 2 == 1 and ReadByte(cutsceneFlags + 10) < 140 then
		WriteByte(battleLevel, ReadByte(battleLevel) - 1)
	end

	-- Prevent issues in early HB exploration
	if ReadByte(cutsceneFlags + 10) <= 1 then
		WriteByte(cutsceneFlags + 10, 10)
	end

	if ReadByte(world) == 15 then
		local embCount = 0
		for i=187, 190 do
			embCount = embCount + math.min(ReadByte(inventory + i), 1)
			WriteByte(inventory + i, math.min(1, ReadByte(inventory + i)))
		end

		local canPlace = embCount == 4 or ReadByte(emblemDoor) > 0

		WriteByte(emblemCount, canPlace and 4 or 0)
		if ReadByte(cutsceneFlags + 10) > 50 and (ReadByte(room) ~= 4 or ReadByte(blackFade) == 0) then
			local doorClose = ReadByte(roomWarpRead) >= 16 and ReadByte(roomWarpRead) <= 19
			WriteByte(emblemDoor, doorClose and 3 or 4)
			WriteByte(emblemDoor + 3, doorClose and 1 or 5)
		end

		if ReadByte(libraryFlag) == 0 then
			WriteByte(libraryFlag, 2)
		end

		if ReadByte(room) == 5 and ReadLong(khamaActive) == 1125899906875395 then
			WriteLong(khamaActive, 0)
			WriteLong(theonActive, 0)
		end
	end

	if ReadByte(cutsceneFlags - 4) == 220 then
		WriteByte(gummiFlagBase + 11, 3)
	end

	WriteInt(worldMapLines, 4294967295)
	WriteByte(worldMapLines + 4, ReadByte(gummiFlagBase + 11) >= 3 and 255 or 0)

	if ReadByte(gummiFlagBase + 9) == 0 then
		OpenGummi()
	end
end

local function EquipmentFixes()
	local expMult = 1.0
	for p=0, 2 do
		local accOff = (p * 116)
		for i=0, 3 do
			local eqID = ReadByte(soraStats + accOff + i)
			local eqName = ReadByte(itemTable + ((eqID - 1) * 20))
			if eqName == 86 or eqName == 88 then
				expMult = expMult + 0.2
			elseif eqName == 89 or eqName == 90 then
				expMult = expMult + 0.3
			end
		end
	end
	WriteFloat(experienceMult, expMult)
end

function _OnFrame()
	if canExecute and loaded then
		local HUDNow = ReadFloat(soraHUD)
		if not randomized and initDone then
			if (ReadByte(soraHP) > 0 or ReadInt(randoInitCheck) == 1) and successfulRando then
				Randomize()
				while not isValidSeed and not ValidSeed() do
					Randomize()
				end
				randomized = true
				ApplyRandomization()
			elseif not successfulRando then
				ConsolePrint("Rando unsuccesful! Try restarting and rolling a new seed")
			end
		elseif randomized then
			local menuNow = ReadByte(menuCheck)
			UpdateInventory(HUDNow)
			ReplaceTrinity(HUDNow)
			UpdateReports(HUDNow)
			if HUDNow < 1 then
				ReplaceMagic(HUDNow)
			else
				nextTextFind = ""
				if HUDWas < 1 then
					textFind = ""
				end
			end
			ReplaceTexts()
			if menuWas ~= menuNow then
				MenuNameSwap(menuNow)
			end
			HUDWas = HUDNow
			menuWas = menuNow
		end

		if stackAbilities > 0 and ReadLong(closeMenu) == 0 then
			StackAbilities()
		end

		EquipmentFixes()

		FlagFixes()

		if ReadInt(blackFade) == 0 then
			removeBlackTimer = removeBlackTimer+1
		else
			removeBlackTimer = 0
		end

		if removeBlackTimer > 300 and ReadByte(world) == 16 then
			for i=0, 4 do
				WriteByte(fadeBase + i * 4, 128) --Remove black screen
			end
			ConsolePrint("Removed black screen")
			removeBlackTimer = 0
		end

		if ReadByte(saveOpenAddress) and ReadByte(menuButtonCount) < 5 then
			WriteByte(menuFunction, 3) --Unlock gummi
			WriteByte(menuButtonCount, 5) --Set 5 buttons to save menu
			WriteByte(menuMaxButtonCount, 5) --Set 5 buttons to save menu
			WriteByte(menuItemSlotCount, 5) --Set 5 buttons to save menu
			for i=0, 4 do
				WriteByte(buttonTypes + i * 4, i) --Set button types
			end
		end

		if ReadByte(RCName) ~= 54 and (warpAnywhere == 0 or
			(warpAnywhere == 1 and (ReadByte(stateFlag) ~= 0 or HUDNow < 1))) then
			WriteByte(menuFunction, 0)
		elseif ReadByte(RCName) == 54 then
			WriteByte(menuFunction, 3)
		end
	end
end

