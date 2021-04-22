local keyitemsMatter = true

local offset = 0x3A0606
local btltbl = 0x2D1F3C0 - offset
local itemTable = btltbl+0x1A58
local soraStatTable = btltbl+0x3AC0
local donaldStatTable = soraStatTable+0x3F8
local goofyStatTable = donaldStatTable+0x198
local soraAbilityTable = btltbl+0x3BF8
local soraAbilityTable2 = soraAbilityTable-0xD0
local soraAbilityTable3 = soraAbilityTable-0x68
local donaldAbilityTable = soraAbilityTable+0x328
local goofyAbilityTable = donaldAbilityTable+0x198
local rewardTable = btltbl+0xC6A8
local chestTable = 0x5259E0 - offset

local inventory = 0x2DE5E6A - offset

--local TTWarp = 0x5229B0+0x9B570C+6
local worldWarps = 0x50B940 - offset
local worldFlagBase = 0x2DE79D0+0x6C - offset
local gummiFlagBase = 0x2DE78C0 - offset
local worldMapLines = 0x2DE78E2 - offset
local gummiselect = 0x503CEC - offset
local inGummi = 0x50421D - offset
local unlockedWarps = 0x2DE78D6 - offset
local warpCount = 0x50BA30 - offset
local monstroCutsceneFlag = 0x2DE65D0-0x200+0xB09 - offset
local soraStory = 0x2DE7367 - offset
local OCFlag = 0x2DE75EA - offset
local DJFlag = 0x2DE5EBF - offset
local AGFlag = 0x2DE5EC0 - offset
local OCTrinityFlag = 0x2DE68FC - offset
local Riku1Flag = 0x2DE79D0+0x6C+0xB6 - offset

local infoBoxNotVisible = 0x23D0890 - offset
local preventMenu = 0x232A60C - offset
local blackfade = 0x4D93B8 - offset
local enableRC = 0x2DE6244 - offset
local lockMenu = 0x232A60C - offset
local party1 = 0x2DE5E5F - offset
local party2 = 0x2E1CBE5 - offset
local soraHUD = 0x280EB1C - offset
local magicUnlock = 0x2DE5A44 - offset
local magicLevels = magicUnlock + 0x41E
local magicFlags = 0x2DE75EE - offset
local trinityUnlock = magicUnlock + 0x1BA7
local soraHP = 0x2D592CC - offset
local world = 0x233CADC - offset
local room = world + 0x68

local gotoWorldMap = 0x2E1CC24 - offset
local openMenu = 0x2350CD4 - offset
local closeMenu = 0x2E90820 - offset
local menuCheck = 0x2E8EE98 - offset
local input = 0x233D034 - offset
local menuState = 0x2E8F268 - offset

local textsBase = 0x2EE03B0 - offset
local textsOff = 0x232A5EC - offset
local textsOff2 = 0xDCE244 - offset
local textPos = 0
local textFind = ""
local textReplace = ""
local infoBoxWas = 1

local trinityTable = {}
local magicShuffled = {}
local perMagicShuffle = {}
local magicChecks = {soraStory, OCFlag}
local magicCheckValues = {0x80, 1}
local inventoryUpdater = {}
local HUDWas = 0
local introJump = true

local itemNames = {}
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
local chests = {}
local randomized = false
local initDone = false

function RArray(off, c)
	local l = {}
	for i=1, c do
		l[i] = ReadByte(off+(i-1))
	end
	return l
end

function WArray(off, l, c)
	for i=1, c do
		WriteByte(off+(i-1), l[i])
	end
end

function _OnInit()
	local f = io.open("items.txt")
	if not f then
		print("items.txt missing!")
	else
		for i=1,0xFF do
			itemNames[i] = f:read("*l")
		end
		f:close()
	end
	for i=1,0xFF do
		itemids[i] = i
	end
	for i=1, 0xA8 do
		rewards[i] = ReadShort(rewardTable+((i-1)*2))
	end
	for i=1, 99 do
		soraLevels[i] = ReadByte(soraStatTable+(i-1))
		soraAbilities[i] = ReadByte(soraAbilityTable+(i-1))
		soraAbilities2[i] = ReadByte(soraAbilityTable2+(i-1))
		soraAbilities3[i] = ReadByte(soraAbilityTable3+(i-1))
		goofyLevels[i] = ReadByte(goofyStatTable+(i-1))
		goofyAbilities[i] = ReadByte(goofyAbilityTable+(i-1))
		donaldLevels[i] = ReadByte(donaldStatTable+(i-1))
		donaldAbilities[i] = ReadByte(donaldAbilityTable+(i-1))
	end
	for i=1, 0x1DD do
		chests[i] = ReadShort(chestTable+((i-1)*2))
	end
	for i=1, 0xFF do
		inventoryUpdater[i] = ReadByte(inventory+(i-1))
	end
	initDone = true
	print("Init done")
end

function ItemType(id)
	local i = id
	local attributes = ""
	if (i >= 1 and i <= 8 and i~=5) then
		attributes = attributes .. "Use"
	end
	if (i >= 0x98 and i <= 0x9A) or (i >= 0x8E and i <= 0x90) then
		attributes = attributes .. "Stock"
	end
	if (i >= 9 and i <= 0x10) or (i >= 0x9B and i <= 0x9D) or i >= 0xE9 then
		attributes = attributes .. "Synth"
	end
	if (i >= 0x11 and i <= 0x47) then
		attributes = attributes .. "Accessory"
	end
	if (i >= 0x51 and i <= 0x66) then
		attributes = attributes .. "SoraWeapon"
	end
	if (i >= 0x67 and i <= 0x75) then
		attributes = attributes .. "DonaldWeapon"
	end
	if (i >= 0x77 and i <= 0x85) then
		attributes = attributes .. "GoofyWeapon"
	end
	if (i >= 0x95 and i <= 0x97) and (i >= 0x9E and i <= 0xA7) then
		attributes = attributes .. "Unique"
	end
	if (i >= 0xA8 and i <= 0xCD) or (i >= 0xD4 and i <= 0xE7) or i == 0xD2 then
		attributes = attributes .. "Key"
	end
	if (i == 0xC0 or (i >= 0xC4 and i <= 0xC6) or i == 0xD3) then
		attributes = attributes .. "Farm"
	end
	if (i >= 0xCE and i <= 0xD1) then
		attributes = attributes .. "Summon"
	end
	return attributes
end

function ItemCompatibility(i, r)
	a = ItemType(i)
	b = ItemType(r)
	if string.find(a, "Weapon") then
		return a==b
	end
	if string.find(a, "Stock") then
		return string.find(b, "Stock")
	end
	if string.find(a, "Use") then
		return string.find(b, "Use")
	end
	if string.find(a, "Synth")then
		return string.find(b, "Synth")
	end
	if string.find(a, "Accessory") then
		return string.find(b, "Accessory")
	end
	if string.find(a, "Unique") then
		return string.find(b, "Unique")
	end
	if a == "Key" then
		return string.find(b, "Key") or string.find(b, "Synth") or string.find(b, "Unique")
	end
	if string.find(a, "Farm") then
		return b == "Synth"
	end
	return true
end

function Randomize()
	seedfile = io.open("seed.txt", "r")
	if seedfile ~= nil then
		math.randomseed(tonumber(seedfile:read()))
		print("Found existing seed")
	else
		seedfile = io.open("seed.txt", "w")
		local newseed = os.time()
		math.randomseed(newseed)
		seedfile:write(newseed)
		print("Wrote new seed")
	end
	seedfile:close()
	
	-- for i=1,0xFF do
		-- if items[i][9]==0 and items[i][10]==0 then
			-- items[i][9] = math.random(5)*40
			-- items[i][10] = math.random(5)+3
		-- end
	-- end

	for i=1,0xFF do
		local itemtype = ItemType(i)
		if itemtype ~= "" then
			local r = math.random(0xFF)
			while not ItemCompatibility(i, r) do
				r = math.random(0xFF)
			end
			local origid = itemids[i]
			local otherid = itemids[r]
			itemids[i] = otherid
			itemids[r] = origid
			--print(string.format("%x : %x", itemids[i], itemids[r]))
		end
	end
	print("Randomized item pool")

	for i=1, 0xA8 do
		local r = math.random(0xA8)
		local orig = rewards[i]
		local other = rewards[r]
		rewards[i] = other
		rewards[r] = orig
	end
	
	print("Randomized reward pool")
	
	for i=1, 0x1DD do
		if ((chests[i]-2) % 0x10) == 0 then
			local change = {-2, 4, 4, 12}
			chests[i] = chests[i] + change[math.random(4)]
		end
	end
	
	for i=1, 0x1DD do
		local r = math.random(0x1DD)
		if chests[i] > 0x10 or (i>1 and i<0x1DD and chests[i-1] > 0x10 and chests[i+1] > 0x10) then
			local valid = false
			while not (valid and (chests[r] > 0x10 or (r>1 and r<0x1DD and chests[r-1] > 0x10 and chests[r+1] > 0x10))) do
				r = math.random(0x1DD)
				valid = not ((i >= 0x1C0 or i == 0) and ((chests[r]-4) % 0x10) == 0)
				if not valid then
					print("Prevented EotW dalmatians")
				end
			end

			local orig = chests[i]
			local other = chests[r]
			chests[i] = other
			chests[r] = orig
		end
	end
	
	print("Randomized chests")
	
	for i=1, 99 do
		local r = math.random(99)
		local orig = soraLevels[i]
		local other = soraLevels[r]
		soraLevels[i] = other
		soraLevels[r] = orig
		
		r = math.random(99)
		orig = soraAbilities[i]
		if orig > 0 then
			while soraAbilities[r] == 0 do
				r = math.random(99)
			end
			other = soraAbilities[r]
			soraAbilities[i] = other
			soraAbilities[r] = orig
		end
		
		r = math.random(99)
		orig = soraAbilities2[i]
		if orig > 0 then
			while soraAbilities2[r] == 0 do
				r = math.random(99)
			end
			other = soraAbilities2[r]
			soraAbilities2[i] = other
			soraAbilities2[r] = orig
		end
		
		r = math.random(99)
		orig = soraAbilities3[i]
		if orig > 0 then
			while soraAbilities3[r] == 0 do
				r = math.random(99)
			end
			other = soraAbilities3[r]
			soraAbilities3[i] = other
			soraAbilities3[r] = orig
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
	print("Randomized level ups")
	
	local magicPool = {1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,7}
	local magicPool2 = {1,2,3,4,5,6,7}
	for i=1, 21 do
		magicShuffled[i] = table.remove(magicPool, math.random(#magicPool))
		if i <= 7 then
			perMagicShuffle[i] = table.remove(magicPool2, math.random(#magicPool2))
		end
	end
	
	local trinityPool = {1,2,3,4,5}
	for i=1,5 do
		trinityTable[i] = table.remove(trinityPool, math.random(#trinityPool))
	end
	
	print("Randomized magic")
	
	ApplyRandomization()
end

function ApplyRandomization()
	for i=1, 0xA8 do
		WriteShort(rewardTable+((i-1)*2), rewards[i])
	end
	for i=1, 0x1DD do
		WriteShort(chestTable+((i-1)*2), chests[i])
	end
	for i=1, 99 do
		WriteByte(soraStatTable+(i-1), soraLevels[i])
		WriteByte(soraAbilityTable+(i-1), soraAbilities[i])
		WriteByte(soraAbilityTable2+(i-1), soraAbilities2[i])
		WriteByte(soraAbilityTable3+(i-1), soraAbilities3[i])
		WriteByte(goofyStatTable+(i-1), goofyLevels[i])
		WriteByte(goofyAbilityTable+(i-1), goofyAbilities[i])
		WriteByte(donaldStatTable+(i-1), donaldLevels[i])
		WriteByte(donaldAbilityTable+(i-1), donaldAbilities[i])
	end
	randomized = true
	print("Applied randomization")
end

function CharToMem(c)
	if c >= 65 and c <= 90 then
		c = c-54
	elseif c >= 97 and c <= 122 then
		c = c-60
	end
	return c
end

function MemStringSearch(off, c, re)
	local textMatch = 1
	off = off+4
	local pos = 0

	while pos < c do
		local letter = ReadIntA(off+pos)
		local inc = 4

		if letter == re[textMatch] then
			textMatch = textMatch + 1
			if textMatch >= 4 then
				print(string.format("match at %x", off+pos-((textMatch-2)*20)))
				StringToMem((off+pos-((textMatch-2)*20)), textReplace)
				textMatch = 1
			end
		else
			textMatch = 1
		end
		
		if textMatch > 1 then
			inc = 20
		end
		
		pos = pos+inc
	end
end

function StringToMem(off, text)
	for i=1, #text do
		local c = string.byte(text, i,i)
		if c >= 65 and c <= 90 then
			c = c-54
		elseif c >= 97 and c <= 122 then
			c = c-60
		else
			c = 0x270F
		end
		WriteShortA(off+((i-1)*20), c)
	end
end

function ReplaceTexts()
	textFind = "Obtained"
	textReplace = "LOLOL"

	infoBoxWas = ReadByte(infoBoxNotVisible)
	
	if textFind ~= "" and ReadFloat(soraHUD) < 1 then
		local re = {}
		for i=1,#textFind do
			re[i] = CharToMem(string.byte(textFind, i, i))
		end

		local rewardText = ReadLong(textsBase+8) + 0xC00000
		MemStringSearch(rewardText, 0xAFF00, re)
	end
end

-- Swap key items in inventory slots
function UpdateInventory()
	for i=0x1,0xFF do
		if not string.find(ItemType(i), "Weapon") and not string.find(ItemType(i), "Accessory") and
																i ~= itemids[i] then
			local itemCount = ReadByte(inventory+(i-1))
			local dif = itemCount - inventoryUpdater[i]
			if dif ~= 0 then
				if dif > 0 and ReadByte(closeMenu) == 0 then
					local curid = itemids[i]
					local otherCount = ReadByte(inventory+(curid-1))
					WriteByte(inventory+(i-1), itemCount-dif)
					WriteByte(inventory+(curid-1), otherCount+dif)
					inventoryUpdater[curid] = otherCount+dif
				else
					inventoryUpdater[i] = itemCount
				end
			end
		end
	end
end

function ReplaceMagic(HUDNow)
	-- magicUpdater = {0,0,0,0,0,0,0}
	-- for i=1, #magicChecks do
		-- if ReadByte(magicChecks[i]) >= magicCheckValues[i] then
			-- magicUpdater[magicShuffled[i]] = magicUpdater[magicShuffled[i]]+1
			-- print(string.format("Magic check %x detected", i))
		-- end
	-- end
	unlock = 0
	for i=1,7 do
		local r = perMagicShuffle[i]
		local l = ReadByte(magicFlags+(i-1))
		WriteByte(magicLevels+(r-1), math.max(l, 1))
		if l > 0 then
			unlock = unlock + (2^(r-1))
		end
	end
	WriteByte(magicUnlock, unlock)
end

function ReplaceTrinity(HUDNow)
	local unlock = 0
	if ReadByte(magicFlags) > 0 then
		unlock = unlock + (2^(trinityTable[1]-1))
	end
	if ReadByte(DJFlag) > 0 then
		unlock = unlock + (2^(trinityTable[2]-1))
	end
	if ReadByte(AGFlag) > 0 then
		unlock = unlock + (2^(trinityTable[3]-1))
	end
	if ReadByte(OCTrinityFlag) > 0 then
		unlock = unlock + (2^(trinityTable[4]-1))
	end
	if ReadByte(Riku1Flag) > 0 then
		unlock = unlock + (2^(trinityTable[5]-1))
	end
	WriteByte(trinityUnlock, unlock)
end

function InstantGummi()
	WriteByte(gotoWorldMap, 1)
	WriteLong(closeMenu, 0)
end

function _OnFrame()
	if not randomized and initDone then
		Randomize()
	end
	
	UpdateInventory()
	local HUDNow = ReadFloat(soraHUD)
	if HUDNow < 1 then
		ReplaceTrinity(HUDNow)
		ReplaceMagic(HUDNow)
	end
	ReplaceTexts()
	HUDWas = HUDNow

	if ReadByte(unlockedWarps-7) < 8 then
		WriteByte(unlockedWarps-7, 9)
		WriteByte(warpCount+4*3, 4)
	end
	if ReadByte(gummiselect)==3 then
		--WriteByte(TTWarp, 1) -- Change it to DI world ID
		WriteShort(worldWarps+0x18, 1) -- Add DI warp
		--WriteByte(worldFlagBase+7, 0) -- Fix up story flags
	else
		WriteShort(worldWarps+0x18, 4) -- Revert to Wonderland
	end
	
	if ReadByte(monstroCutsceneFlag) < 0x14 then
		WriteByte(monstroCutsceneFlag, 0x14)
	end
	
	if ReadInt(input) == 3848 then
		InstantGummi()
	end
	
	if ReadFloat(soraHUD) > 0 and ReadByte(lockMenu) > 0 then
		WriteByte(lockMenu, 0) -- Unlock menu
	end
	
	if ReadByte(gummiFlagBase+14) ~= 3 then
		for i=0,1 do
			WriteByte(party1+i, i+1)
			WriteByte(party2+i, i+1)
		end
	end
	
	if ReadByte(enableRC) ~= 0x0 then
		WriteByte(enableRC, 0x0)
	end
	
	if ReadByte(0x232A604-offset) and ReadByte(0x2E1CB9C-offset) < 5 and ReadShort(menuState)==62576 then
		for i=0,14 do
			if i~=9 then
				WriteByte(gummiFlagBase+i, 3)
			end
		end
		WriteInt(worldMapLines, 0xFFFFFFFF)
		WriteByte(worldMapLines+4, 0xFF)
		
		WriteByte(0x2E1CC28-offset, 3) --Unlock gummi
		WriteByte(0x2E1CB9C-offset, 5) --Set 5 buttons to save menu
		WriteByte(0x2E8F450-offset, 5) --Set 5 buttons to save menu
		WriteByte(0x2E8F452-offset, 5) --Set 5 buttons to save menu
		for i=0,4 do
			WriteByte(0x2E1CBA0+i*4-offset, i) --Set button types
		end
	end
end