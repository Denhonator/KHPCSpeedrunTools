local offset = 0x3A0606
local btltbl = 0x2D1F3C0 - offset
local itemTable = btltbl+0x1A58
local soraStatTable = btltbl+0x3AC0
local donaldStatTable = soraStatTable+0x3F8
local goofyStatTable = donaldStatTable+0x198
local soraAbilityTable = btltbl+0x3BF8
local donaldAbilityTable = soraAbilityTable+0x328
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
local menuState = 0x2E8F268 - offset

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
local initDone = false

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
	initDone = true
end

function ItemType(id)
	local i = itemids[id]
	local attributes = ""
	if (i >= 1 and i <= 8 and i~=5) then
		attributes = attributes .. "Use"
	end
	if (i >= 0x98 and i <= 0x9A) or (i >= 0x8E and i <= 0x90) then
		attributes = attributes .. "Stock"
	end
	if (i >= 9 and i <= 0x10) or (i >= 0x9B and i <= 0x9D) or i >= 0xE9 or i == 0xD3  then
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
	if (i >= 0x95 and i <= 0x97) and (i >= 0xA8 and i <= 0xB1) then
		attributes = attributes .. "Report"
	end
	if (i >= 0x9E and i <= 0xA7) then
		attributes = attributes .. "Unique"
	end
	if (i >= 0xB2 and i <= 0xCD) or (i >= 0xD4 and i <= 0xE7) or i==0xD2 then
		attributes = attributes .. "Key"
	end
	if (i >= 0xCE and i <= 0xD1) then
		attributes = attributes .. "Summon"
	end
	return attributes
end

function ItemCompatibility(a, b)
	if string.find(a, "Weapon") then
		return a==b
	end
	if string.find(a, "Stock") then
		return string.find(b, "Stock")
	end
	if string.find(a, "Use") then
		return string.find(b, "Use")
	end
	if string.find(a, "Synth") then
		return string.find(b, "Synth")
	end
	if string.find(a, "Accessory") then
		return string.find(b, "Accessory")
	end
	if string.find(a, "Report") or string.find(a, "Unique") or string.find(a, "Key") then
		return string.find(b, "Report") or string.find(b, "Unique") or string.find(b, "Key")
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
		if items[i][9]==0 and items[i][10]==0 then
			items[i][9] = math.random(5)*40
			items[i][10] = math.random(4)+3
		end
	end

	for i=1,0xFF do
		local itemtype = ItemType(i)
		if itemtype ~= "" and itemtype ~= "Use" and itemtype ~= "Stock" and itemtype ~= "Summon" then
			local r = math.random(0xFF)
			while not ItemCompatibility(itemtype, ItemType(r)) do
				r = math.random(0xFF)
			end
			local orig = items[i]
			local other = items[r]
			local origid = itemids[i]
			local otherid = itemids[r]
			itemids[i] = otherid
			itemids[r] = origid
			items[i] = other
			items[r] = orig
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
			local change = {-2, 4, 12}
			chests[i] = chests[i] + change[math.random(3)]
		end
	end
	
	for i=1, 0x1DD do
		local r = math.random(0x1DD)
		if chests[i] > 0x10 or (i>1 and i<0x1DD and chests[i-1] > 0x10 and chests[i+1] > 0x10) then
			while not (chests[r] > 0x10 or (r>1 and r<0x1DD and chests[r-1] > 0x10 and chests[r+1] > 0x10)) do
				r = math.random(0x1DD)
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
	ApplyRandomization()
end

function ApplyRandomization()
	if ReadByte(itemTable) == 0x1F and ReadByte(itemTable+0x50) == 0x23 then
		for i=1,0xFF do
			WriteArray(itemTable+(i-1)*20, items[i])
			print(string.format("item %x became %x", i, itemids[i]))
		end
	else
		print("Items seem randomized already, skipping. Restart game to redo it")
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
	if not randomized and initDone then
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
	
	if ReadByte(gummiFlagBase+14) ~= 3 then
		for i=0,14 do
			if i~=9 then
				WriteByte(gummiFlagBase+i, 3)
			end
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
	
	if ReadByte(0x232A604-offset) and ReadByte(0x2E1CB9C-offset) < 5 and ReadShort(menuState)==62576 then
		WriteByte(0x2E1CC28-offset, 3) --Unlock gummi
		WriteByte(0x2E1CB9C-offset, 5) --Set 5 buttons to save menu
		WriteByte(0x2E8F450-offset, 5) --Set 5 buttons to save menu
		WriteByte(0x2E8F452-offset, 5) --Set 5 buttons to save menu
		for i=0,4 do
			WriteByte(0x2E1CBA0+i*4-offset, i) --Set button types
		end
	end
end