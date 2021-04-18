local offset = 0x3A0606
local btltbl = 0x2D1F3C0 - offset
local itemTable = btltbl+0x1A58
local soraStatTable = btltbl+0x3AC0
local donaldStatTable = soraStatTable+0x3F8
local goofyStatTable = donaldStatTable+0x198
local soraAbilityTable = btltbl+0x3BF8
local donaldAbilityTable = soraAbilityTable+0x3F8
local goofyAbilityTable = donaldAbilityTable+0x198
local rewardTable = btltbl+0xC6A8
local chestTable = 0x5259E0 - offset

--local TTWarp = 0x5229B0+0x9B570C+6
local worldWarps = 0x50B940 - offset
local worldFlagBase = 0x2DE79D0+0x6C - offset
local gummiFlagBase = 0x2DE78C0 - offset
local worldMapLines = 0x2DE78E2 - offset
local gummiselect = 0x503CEC - offset
local unlockedWarps = 0x2DE78D6 - offset
local warpCount = 0x50BA30 - offset
local monstroCutsceneFlag = 0x2DE65D0-0x200+0xB09 - offset

local enableRC = 0x2DE6244 - offset
local lockMenu = 0x232A60C - offset
local party1 = 0x2DE5E5F - offset
local party2 = 0x2E1CBE5 - offset
local soraHUD = 0x280EB1C - offset

local gotoWorldMap = 0x2E1CC24 - offset
local openMenu = 0x2350CD4 - offset
local closeMenu = 0x2E90820 - offset
local menuCheck = 0x2E1BBBC - offset
local input = 0x233D034 - offset

local items = {}
local itemids = {}
local rewards = {}
local soraLevels = {}
local soraAbilities = {}
local donaldLevels = {}
local donaldAbilities = {}
local goofyLevels = {}
local goofyAbilities = {}
local chests = {}
local randomized = false

function _OnInit()
	for i=1,0xFF do
		items[i] = ReadArray(itemTable+(i-1)*20, 20)
		itemids[i] = i
	end
	for i=1, 0xA8 do
		rewards[i] = ReadShort(rewardTable+(i-1)*2)
	end
	for i=1, 99 do
		soraLevels[i] = ReadByte(soraStatTable+(i-1))
		soraAbilities[i] = ReadByte(soraAbilityTable+(i-1))
		goofyLevels[i] = ReadByte(goofyStatTable+(i-1))
		goofyAbilities[i] = ReadByte(goofyAbilityTable+(i-1))
		donaldLevels[i] = ReadByte(donaldStatTable+(i-1))
		donaldAbilities[i] = ReadByte(donaldAbilityTable+(i-1))
	end
	for i=1, 0x1DD do
		chests[i] = ReadShort(chestTable+(i-1)*2)
	end
end

function ItemType(id)
	local i = itemids[id]
	local attributes = ""
	if (i >= 1 and i <= 8 and i~=5) or (i >= 0x8E and i <= 0x90) or (i >= 0x98 and i <= 0x9A) then
		attributes = attributes .. "Use"
	end
	if (i >= 9 and i <= 0x10) or (i >= 0x9B and i <= 0x9D) or i >= 0xE9 then
		attributes = attributes .. "Synth"
	end
	if (i >= 0x11 and i <= 0x47) or (i >= 0x9E and i <= 0xA4) then
		attributes = attributes .. "Accessory"
	end
	if (i >= 0x51 and i <= 0x66) then
		attributes = attributes .. "SoraWeapon"
	end
	if (i >= 0x67 and i <= 0x76) then
		attributes = attributes .. "DonaldWeapon"
	end
	if (i >= 0x77 and i <= 0x86) then
		attributes = attributes .. "GoofyWeapon"
	end
	if (i >= 0x95 and i <= 0x97) and (i >= 0xA8 and i <= 0xB1) then
		attributes = attributes .. "Report"
	end
	if (i >= 0xA5 and i <= 0xA7) then
		attributes = attributes .. "Unique"
	end
	if (i >= 0xB2 and i <= 0xCD) or (i >= 0xD3 and i <= 0xE7) or i==0xD2 then
		attributes = attributes .. "Key"
	end
	if (i >= 0xCE and i <= 0xD1) then
		attributes = attributes .. "Summon"
	end
	if (i == 0xC0 or i == 0xC4 or i == 0xC5 or i == 0xC6 or i == 0xD3) then
		attributes = attributes .. "Multi"
	end
	return attributes
end

function ItemCompatibility(a, b)
	if string.find(a, "Weapon") then
		return a==b
	end
	if string.find(a, "Multi") then
		return string.find(b, "Use") or string.find(b, "Synth")
	end
	if string.find(a, "Use") or string.find(a, "Synth") or string.find(a, "Accessory") then
		return string.find(b, "Use") or string.find(b, "Synth") or string.find(b, "Accessory")
	end
	if string.find(a, "Report") or string.find(a, "Unique") or string.find(a, "Key") or string.find(a, "Summon") then
		return string.find(b, "Report") or string.find(b, "Unique") or string.find(b, "Key") or string.find(b, "Summon")
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

	for i=1,0xFF do
		local itemtype = ItemType(i)
		local r = math.random(0xFF)
		while not ItemCompatibility(itemtype, ItemType(r)) do
			local r = math.random(0xFF)
		end
		local orig = items[i]
		local other = items[r]
		WriteArray(itemTable+(i-1)*20, other)
		WriteArray(itemTable+(r-1)*20, orig)
		itemids[i] = r
		itemids[r] = i
		items[i] = other
		items[r] = orig
		print("Randomized item " .. tostring(i))
	end
	
	print("Randomized item pool")
	
	for i=1, 0xA8 do
		local r = math.random(0xA8)
		local orig = rewards[i]
		local other = rewards[r]
		WriteShort(rewardTable+(i-1)*2, other)
		WriteShort(rewardTable+(r-1)*2, orig)
		rewards[i] = other
		rewards[r] = orig
	end
	
	print("Randomized reward pool")
	
	for i=1, 0x1DD do
		local r = math.random(0x1DD)
		if chests[i] > 0x10 or (i>1 and chests[i-1] > 0x10 and chests[i+1] > 0x10) then
			while not (chests[r] > 0x10 or (r>1 and chests[r-1] > 0x10 and chests[r+1] > 0x10)) do
				r = math.random(0x1DD)
			end
			local orig = chests[i]
			local other = chests[r]
			WriteShort(chestTable+(i-1)*2, other)
			WriteShort(chestTable+(r-1)*2, orig)
			chests[i] = other
			chests[r] = orig
		end
	end
	
	print("Randomized chests")
	
	for i=1, 99 do
		local r = math.random(0xA8)
		local orig = soraLevels[i]
		local other = soraLevels[r]
		WriteByte(soraStatTable+(i-1), other)
		WriteByte(soraStatTable+(r-1), orig)
		soraLevels[i] = other
		soraLevels[r] = orig
		
		r = math.random(0xA8)
		orig = soraAbilities[i]
		if orig > 0 then
			while soraAbilities[r] == 0 do
				r = math.random(0xA8)
			end
			other = soraAbilities[r]
			WriteByte(soraAbilityTable+(i-1), other)
			WriteByte(soraAbilityTable+(r-1), orig)
			soraAbilities[i] = other
			soraAbilities[r] = orig
		end
		
		r = math.random(0xA8)
		orig = goofyLevels[i]
		other = goofyLevels[r]
		WriteByte(goofyStatTable+(i-1), other)
		WriteByte(goofyStatTable+(r-1), orig)
		goofyLevels[i] = other
		goofyLevels[r] = orig
		
		r = math.random(0xA8)
		orig = goofyAbilities[i]
		if orig > 0 then
			while goofyAbilities[r] == 0 do
				r = math.random(0xA8)
			end
			other = goofyAbilities[r]
			WriteByte(goofyAbilityTable+(i-1), other)
			WriteByte(goofyAbilityTable+(r-1), orig)
			goofyAbilities[i] = other
			goofyAbilities[r] = orig
		end
		
		r = math.random(0xA8)
		orig = donaldLevels[i]
		other = donaldLevels[r]
		WriteByte(donaldStatTable+(i-1), other)
		WriteByte(donaldStatTable+(r-1), orig)
		donaldLevels[i] = other
		donaldLevels[r] = orig
		
		r = math.random(0xA8)
		orig = donaldAbilities[i]
		if orig > 0 then
			while donaldAbilities[r] == 0 do
				r = math.random(0xA8)
			end
			other = donaldAbilities[r]
			WriteByte(donaldAbilityTable+(i-1), other)
			WriteByte(donaldAbilityTable+(r-1), orig)
			donaldAbilities[i] = other
			donaldAbilities[r] = orig
		end
	end
	print("Randomized level ups")
	ApplyRandomization()
end

function ApplyRandomization()
	for i=1,0xFF do
		WriteArray(itemTable+(i-1)*20, items[i])
	end
	for i=1, 0xA8 do
		WriteShort(rewardTable+(i-1)*2, rewards[i])
	end
	for i=1, 0x1DD do
		WriteShort(chestTable+(i-1)*2, chests[i])
	end
	for i=1, 99 do
		WriteByte(soraStatTable+(i-1), soraLevels[i])
		WriteByte(soraAbilityTable+(i-1), soraAbilities[i])
		WriteByte(goofyStatTable+(i-1), goofyLevels[i])
		WriteByte(goofyAbilityTable+(i-1), goofyAbilities[i])
		WriteByte(donaldStatTable+(i-1), donaldLevels[i])
		WriteByte(donaldAbilityTable+(i-1), donaldAbilities[i])
	end
	randomized = true
	print("Applied randomization")
end

function InstantGummi()
	WriteByte(gotoWorldMap, 1)
	WriteLong(closeMenu, 0)
end

function _OnFrame()
	if not randomized then
		Randomize()
	end

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
	
	if ReadByte(gummiFlagBase) ~= 3 then
		for i=0,14 do
			WriteByte(gummiFlagBase+i, 3)
		end
		WriteInt(worldMapLines, 0xFFFFFFFF)
		WriteByte(worldMapLines+4, 0xFF)
		
		for i=0,1 do
			WriteByte(party1+i, i+1)
			WriteByte(party2+i, i+1)
		end
	end
	
	if ReadByte(enableRC) ~= 0x0 then
		WriteByte(enableRC, 0x0)
	end
	
	if ReadByte(0x232A604) then
		WriteByte(0x2E1CC28, 3) --Unlock gummi
		WriteByte(0x2E1CB9C, 5) --Set 5 buttons to save menu
		WriteByte(0x2E8F450, 5) --Set 5 buttons to save menu
		WriteByte(0x2E8F452, 5) --Set 5 buttons to save menu
		for i=0,4 do
			WriteByte(0x2E1CBA0+i*4, i) --Set button types
		end
	end
end