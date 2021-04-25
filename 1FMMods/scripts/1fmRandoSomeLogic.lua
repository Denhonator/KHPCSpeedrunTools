-- If you want guaranteed abilities on first level ups, put the hex codes for unequipped abilities here.
-- Maximum 4 or they will replace other abilities.
-- Find ability codes here https://pastebin.com/ZH0L3XXi
-- Scroll down for the Not Equipped versions.
-- For example, early scan and dodge roll would be:
-- local earlyAbilities = {0x8A, 0x96}

local earlyAbilities = {0x8A}

local offset = 0x3A0606
local btltbl = 0x2D1F3C0 - offset
local itemTable = btltbl+0x1A58
local weaponTable = btltbl+0x94F8
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
local gummiInventory = 0x2DF1848 - offset

--local TTWarp = 0x5229B0+0x9B570C+6
local worldWarps = 0x50B940 - offset
local worldFlagBase = 0x2DE79D0+0x6C - offset
local gummiFlagBase = 0x2DE78C0 - offset
local worldMapLines = 0x2DE78E2 - offset
local gummiselect = 0x503CEC - offset
local inGummi = 0x50421D - offset
local unlockedWarps = 0x2DE78D6 - offset
local warpCount = 0x50BA30 - offset
local cutsceneFlags = 0x2DE65D0-0x200 - offset
local DIDay2WarpPointer = 0x23944B8 - offset

local soraStory = 0x2DE7367 - offset
local OCFlag = 0x2DE75EA - offset
local DJFlag = 0x2DE7373 - offset
local AGFlag = 0x2DE7377 - offset
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
local shortcuts = 0x2DE6214 - offset
local trinityUnlock = magicUnlock + 0x1BA7
local soraHP = 0x2D592CC - offset
local world = 0x233CADC - offset
local room = world + 0x68
local sharedAbilities = 0x2DE5F69 - offset
local soraJumpHeight = 0x2D592A0 - offset

local gotoWorldMap = 0x2E1CC24 - offset
local openMenu = 0x2350CD4 - offset
local closeMenu = 0x2E90820 - offset
local menuCheck = 0x2E8EE98 - offset
local input = 0x233D034 - offset
local menuState = 0x2E8F268 - offset

local itemDropID = 0x2849FC8 - offset
local textsBase = 0x2EE03B0 - offset
local textPointerBase = 0x2B98900 - offset
local textPos = 0
local idFind = 0
local idReplace = 0
local textFind = ""
local nextTextFind = ""
local textReplace = ""
local nextTextReplace = ""
local magicTexts = {"fire.","ice.","thunder.","healing.","stars.","time.","wind."}
local magicTexts2 = {"Fire","Blizzard","Thunder","Cure","Gravity","Stop","Aero"}
local trinityTexts = {"Blue Trinity", "Red Trinity", "Green Trinity", "Yellow Trinity", "White Trinity"}
local infoBoxWas = 1

local trinityTable = {}
local magicShuffled = {}
local perMagicShuffle = {}
local magicUpdater = {}
local inventoryUpdater = {}
local gummiUpdater = {}
local bufferRemove = 0
local bufferRemoveTimer = 10
local HUDWas = 0
local removeBlackTimer = 0
local introJump = true

local important = {0xB2, 0xB3, 0xB4, 0xB5, 0xB6, 0xB7, 0xB8, 0xB9, 0xC0, 0xC0, 0xC1, 0xC2, 0xC3, 0xC4, 0xC4, 0xC4, 0xC5, 0xC5, 0xC5, 0xC6, 0xC6, 0xC7}
local importantPool = {0x5, 0x39, 0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F, 0x50, 0x91, 0x91, 0x94, 0x94, 0x92, 0x92, 0x92, 0x93, 0x93, 0x93}
local gummiNames = {}
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
local randomGets = {}
local randomized = false
local successfulRando = true
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
	local f2 = io.open("gummis.txt")
	if not f then
		print("items.txt missing!")
	elseif not f2 then
		print("gummis.txt missing!")
	else
		for i=1,0xFF do
			itemNames[i] = f:read("*l")
		end
		for i=1,0x40 do
			gummiNames[i] = f2:read("*l")
		end
		f:close()
	end
	for i=1,0xFF do
		itemids[i] = i
	end
	
	for i=1, 7 do
		magicUpdater[i] = 0
	end
	initDone = true
	print("Init done.	")
end

-- function KeyItemWorlds(i)
	-- if i >= 0xB2 and i <= 0xB9 then
		-- return 0xF
	-- elseif i == 0xBA or (i >= 0xC0 and i <= 0xC7) then
		-- return 1
	-- elseif i == 0xC8 then
		-- return 5
	-- elseif i == 0xC9 then
		-- return 4
	-- elseif i == 0xCB or i == 0xD4 then
		-- return 3
	-- elseif i == 0xCC then
		-- return 0xD
	-- elseif i == 0xD5 then
		-- return 8
	-- elseif i == 0xD6 then
		-- return 0xC
	-- elseif i == 0xD7 or i == 0xE3 or i == 0xE4 then
		-- return 0xA
	-- elseif i == 0xD8 then
		-- return 9
	-- end
-- end

function ItemType(i)
	local attributes = ""
	if (i >= 1 and i <= 8 and i~=5) or (i >= 0x98 and i <= 0x9A) or (i >= 0x8E and i <= 0x90) then
		attributes = attributes .. "Use"
	end
	if (i >= 9 and i <= 0x10) or i >= 0xE9 then
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
	if (i >= 0xCE and i <= 0xD1) then
		attributes = attributes .. "Summon"
	end
	if (i >= 0xC8 and i <= 0xCD) or (i >= 0xD9 and i<= 0xE7) then
		attributes = attributes .. "Shuffle"
	end

	for j=1,#important do
		if i==important[j] then
			attributes = attributes .. "Important"
			break
		end
	end
	return attributes
end

function ItemCompatibility(i, r)
	a = ItemType(i)
	b = ItemType(r)
	if string.find(a, "Weapon") then
		return a==b
	end
	if string.find(a, "Use") or string.find(a, "Synth") then
		return string.find(b, "Use") or string.find(b, "Synth")
	end
	if string.find(a, "Accessory") then
		return string.find(b, "Accessory")
	end
	if string.find(a, "Summon") then
		return string.find(b, "Summon")
	end
	return true
end

function Randomize()
	successfulRando = false
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
		local itype = ItemType(i)
		if string.find(itype, "Weapon") or string.find(itype, "Accessory") or string.find(itype, "Use") then
			local rl = #randomGets+1
			randomGets[rl] = i
		end
		if string.find(itype, "Weapon") then
			local r = 0x50 + math.random(0x35)
			while not ItemCompatibility(i, r) do
				r = 0x50 + math.random(0x35)
			end
			itemids[i] = r
			itemids[r] = i
		end
	end
	
	for i=1, 0x40 do
		gummiUpdater[i] = ReadByte(gummiInventory+(i-1))
	end
	
	-- Get rid of normal key items, replace with random good stuff
	for i=0x9B, 0xFF do
		if string.find(ItemType(i), "Important") then
			itemids[i] = table.remove(randomGets, math.random(#randomGets))
		end
	end
	
	local toShuffle = {}
	local c = 1
	for i=0xC8, 0xFF do
		if string.find(ItemType(i), "Shuffle") then
			toShuffle[c] = i
			c = c + 1
		end
	end
	
	for i=0xC8, 0xFF do
		if string.find(ItemType(i), "Shuffle") then
			itemids[i] = table.remove(toShuffle, math.random(#toShuffle))
		end
	end
	print("Shuffled some items")
	
	-- Need one of:
	itemids[0x48] = 0xB2
	itemids[0x49] = 0xB3
	itemids[0x4A] = 0xB4
	itemids[0x4B] = 0xB5
	itemids[0x4C] = 0xB6
	itemids[0x4D] = 0xB7
	itemids[0x4E] = 0xB8
	itemids[0x4F] = 0xB9
	itemids[0x50] = 0xC1
	itemids[0x39] = 0xC2
	itemids[0x5] = 0xC3
	itemids[0xE8] = 0xC7
	-- Need two of:
	itemids[0x91] = 0xC0
	itemids[0x94] = 0xC6
	-- Need three of:
	itemids[0x92] = 0xC4
	itemids[0x93] = 0xC5

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
		
		if earlyAbilities[i] then
			soraAbilities[i] = earlyAbilities[i]
			soraAbilities2[i] = earlyAbilities[i]
			soraAbilities3[i] = earlyAbilities[i]
		else
			r = math.random(95)+4
			orig = soraAbilities[i]
			if orig > 0 then
				while soraAbilities[r] == 0 do
					r = math.random(95)+4
				end
				other = soraAbilities[r]
				soraAbilities[i] = other
				soraAbilities[r] = orig
			end
			
			r = math.random(95)+4
			orig = soraAbilities2[i]
			if orig > 0 then
				while soraAbilities2[r] == 0 do
					r = math.random(95)+4
				end
				other = soraAbilities2[r]
				soraAbilities2[i] = other
				soraAbilities2[r] = orig
			end
			
			r = math.random(95)+4
			orig = soraAbilities3[i]
			if orig > 0 then
				while soraAbilities3[r] == 0 do
					r = math.random(95)+4
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
	print("Randomized level ups")
	
	local magicPool = {1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,7}
	local magicPool2 = {1,2,3,4,5,6,7}
	for i=1, 21 do
		magicShuffled[i] = table.remove(magicPool, math.random(#magicPool))
		if i <= 7 then
			perMagicShuffle[i] = table.remove(magicPool2, math.random(#magicPool2))
		end
	end
	
	print("Randomized magic")
	
	trinityTable = {1,2,3,4,5}
	local randoTrinity = true
	
	while trinityTable[4] == 3 or randoTrinity do
		local trinityPool = {1,2,3,4,5}
		for i=1,5 do
			trinityTable[i] = table.remove(trinityPool, math.random(#trinityPool))
		end
		randoTrinity = false
	end
	
	print("Randomized trinities")
	
	ApplyRandomization()
end

function ApplyRandomization()
	for i=1, 0xA8 do
		WriteShort(rewardTable+((i-1)*2), rewards[i])
	end
	
	local extraAbilities = {0x81,0x82,0x82,0x84,0x95,0x96}
	for i=1, 0xA8 do
		local offAddr = rewardTable+((i-1)*2)
		if ReadByte(offAddr) == 0xF0 and ItemType(ReadByte(offAddr+2)) == "Synth" then
			if #importantPool > 9 then
				local r = math.random(#importantPool)
				local it = importantPool[r]
				-- Add check that it is accessible
				WriteByte(offAddr+2, table.remove(importantPool, r))
				print(string.format("Added %s into reward %x", itemNames[itemids[it]], i))
			elseif #extraAbilities > 0 then
				local r = math.random(#extraAbilities)
				local ab = extraAbilities[r]
				WriteByte(offAddr+2, table.remove(extraAbilities, r))
				WriteByte(offAddr, ab <= 0x84 and 0xB1 or 1)
			end
		end
	end
	
	print("Put key items into rewards")
	
	for i=8, 0x1A0 do
		local sh = chests[i]
		if ((sh % 0x10) == 0 and ItemType(sh//0x10) == "Synth") or (sh-6) % 0x10 == 0 then
			local r = math.random(#importantPool)
			local it = importantPool[r]
			-- Add check that it is accessible
			chests[i] = table.remove(importantPool, r)*0x10
			print(string.format("Added %s into chest %x", itemNames[itemids[it]], i))
		end
		if #importantPool == 0 then
			break
		end
	end
	
	if #importantPool > 0 then
		print(string.format("%x important items still in pool! Re-roll", #importantPool))
		successfulRando = false
		return false
	end
	
	print("Placed key items successfully")
	
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
	local weaponStr = {}
	local weaponMag = {}
	local weaponItemData = {}
	for i=0x51,0x85 do
		if i~=itemids[i] and string.find(ItemType(i), "Weapon") then
			local tablePos = (itemids[i]-0x51)*0x58
			weaponStr[i] = ReadByte(weaponTable+tablePos+0x30)
			weaponMag[i] = ReadByte(weaponTable+tablePos+0x38)
			weaponItemData[i] = ReadArray(itemTable+((itemids[i]-1)*20), 20)
		end
	end
	for i=0x51, 0x85 do
		if weaponStr[i] then
			local tablePos = (i-0x51)*0x58
			WriteByte(weaponTable+tablePos+0x30, weaponStr[i])
			WriteByte(weaponTable+tablePos+0x38, weaponMag[i])
			WriteArray(itemTable+((i-1)*20), weaponItemData[i])
			if i>= 0x52 and i<= 0x55 then
				WriteArray(itemTable+((i-6)*20), weaponItemData[i])
				itemNames[i-5] = itemNames[itemids[i]]
				print(itemNames[i-5])
			end
		end
	end
	for i=1,5 do
		print(string.format("trinity %x became %x", i, trinityTable[i]))
	end
	randomized = true
	for i=1, 0xFF do
		print(string.format("%x became %x", i, itemids[i]))
	end
	print("Weapons randomized. If this was not done on a fresh boot, they got shuffled some more")
	print("Applied randomization")
	successfulRando = true
end

function CharToMem(c)
	if c and c >= 65 and c <= 90 then
		return c-54
	elseif c and c >= 97 and c <= 122 then
		return c-60
	elseif c and c >= 48 and c <= 57 then
		return c-47
	elseif c and c == 46 then
		return 72
	end
	return 0x270F
end

function CharSpacing(c)
	if c and (c == 0x17 or c == 0x21 or c == 0x3B or c == 0x31) then
		return 13
	elseif c and (c >= 11 and c <= 36) then
		return 11
	elseif c and (c == 72 or c == 0x2D or c == 0x30) then
		return 5
	else
		return 10
	end
end

function StringToMem(off, text, l, base)
	local textlen = math.max(#text, l)
	local nextPos = 0
	local garbageCount = 0
	for i=1, textlen do
		local c = string.byte(text, i,i)
		local d = CharToMem(c)
		local addr = off+((i-1)*20)
		if i > l then
			local sample = ReadArrayA(addr-20, 20)
			sample[5] = sample[5] + 10
			if ReadShortA(addr) == 0 or ReadShortA(addr) > 0x270F or ReadShortA(addr+4)==0 then
				garbageCount = garbageCount + 1
			end
			WriteArrayA(addr, sample)
		end
		WriteShortA(addr, d)
		if i > 1 then
			local newPos = nextPos
			WriteShortA(addr+4, newPos)
		end
		nextPos = ReadShortA(addr+4) + CharSpacing(d)
	end
	if textlen > l and garbageCount > 0 then
		local size = ReadShortA(base+2)
		print(garbageCount)
		WriteShortA(base+2, size+garbageCount-1)
	end
end

function MemStringSearch(c, re)
	local textMatch = 1
	local ppos = 0
	local inc = 0x8
	local success = false

	while ppos < c do
		local pointer = textPointerBase + ppos
		local address = ReadLong(pointer)
		
		if address > 0xFFFFFFF then
			for i=1,50 do
				local letter = ReadShortA(address+(i*20))
				if letter > 0x27F0 or letter == 0 then
					break
				end
				if letter == re[textMatch] then
					textMatch = textMatch + 1
					if textMatch >= 4 then
						local start = address+((i-textMatch+2)*20)
						print(string.format("match at %x", ppos))
						StringToMem(start, textReplace, #textFind, address)
						textMatch = 1
						success = true
					end
				else
					textMatch = 1
				end
			end
		end
		
		ppos = ppos+inc
		--inc = inc==8 and 0x20 or 8
	end
	return success
end

function ReplaceTexts()
	infoBoxWas = ReadByte(infoBoxNotVisible)
	
	if idFind > 0 and ReadByte(itemDropID) == idFind then
		WriteByte(itemDropID, idReplace)
		idFind = 0
		textFind = ""
		print("Replaced item drop")
	end
	
	if textFind ~= "" and (infoBoxWas==0) then
		local re = {}
		for i=1,#textFind do
			re[i] = CharToMem(string.byte(textFind, i, i))
		end

		local rewardText = ReadLong(textsBase+8) + 0xC00000
		if MemStringSearch(0xFFFF, re) then
			textFind = nextTextFind
			textReplace = nextTextReplace
			nextTextFind = ""
		end
	end
end

-- Swap key items in inventory slots
function UpdateInventory(HUDNow)
	if bufferRemove > 0 then
		if bufferRemoveTimer > 0 then
			bufferRemoveTimer = bufferRemoveTimer-1
		else
			local itemCount = ReadByte(inventory+(bufferRemove-1))
			WriteByte(inventory+(bufferRemove-1), itemCount-1)
			bufferRemove = 0
			print("Late item rando to prevent softlock")
		end
	end
	for i=0x1,0xFF do
		if not string.find(ItemType(i), "Weapon") and not string.find(ItemType(i), "Accessory") and
																i ~= itemids[i] then
			local itemCount = ReadByte(inventory+(i-1))
			local dif = itemCount - inventoryUpdater[i]
			if dif ~= 0 then
				if dif > 0 and ReadByte(closeMenu) == 0 then
					local curid = itemids[i]
					if string.find(ItemType(curid), "Important") then 
						textFind = "Obtained"
						textReplace = "Obtained " .. itemNames[curid]
					else
						textFind = itemNames[i]
						textReplace = itemNames[curid]
					end
					idFind = i
					idReplace = curid
					print(string.format("Replacing %x with %x", i, curid))
					print(string.format("Replacing %s with %s", textFind, textReplace))

					local otherCount = ReadByte(inventory+(curid-1))
					if (i==0xE0) then
						bufferRemove = i
						bufferRemoveTimer = 360
						inventoryUpdater[i] = itemCount+dif
					else
						WriteByte(inventory+(i-1), itemCount-dif)
					end
					WriteByte(inventory+(curid-1), otherCount+dif)
					inventoryUpdater[curid] = otherCount+dif
				else
					inventoryUpdater[i] = itemCount
				end
			end
		end
	end
	for i=1,0x40 do
		local itemCount = ReadByte(gummiInventory+(i-1))
		if itemCount > gummiUpdater[i] then
			if ReadByte(closeMenu) == 0 and ReadByte(world)==3 then
				local magicUp = -1
				if i==2 then
					magicUp = 3
				elseif i==7 then
					magicUp = 6
				elseif i==60 then
					magicUp = 5
				end
				if magicUp > 0 then
					WriteByte(magicFlags+magicUp, ReadByte(magicFlags+magicUp)+1)
					textFind = "Obtained " .. gummiNames[i]
					textReplace = "Power of " .. magicTexts[perMagicShuffle[magicUp+1]] .. "         "
					print(string.format("Replacing %s with %s", textFind, textReplace))
				end
				magicUp = -1
			end
			gummiUpdater[i] = itemCount
		end
	end
end

function ReplaceMagic(HUDNow)
	unlock = 0
	local isUnlocked = {false,false,false,false,false,false,false}
	for i=1,7 do
		local r = perMagicShuffle[i]
		local l = ReadByte(magicFlags+(i-1))
		WriteByte(magicLevels+(r-1), math.max(l, 1))
		if l > 0 then
			unlock = unlock + (2^(r-1))
			isUnlocked[r] = true
		end
		if l > magicUpdater[i] then
			magicUpdater[i] = l
			if not string.find(textFind, "-G") then
				print("Replacing magic text")
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
	local isShortcut = {}
	for j=0,2 do
		isShortcut[ReadByte(shortcuts+j)+1] = true
	end
	for j=0,2 do
		if not isUnlocked[ReadByte(shortcuts+j)+1] then
			for i=1,7 do
				if not isShortcut[i] then
					WriteByte(shortcuts+j, i-1)
				end
			end
		end
	end
end

function ReplaceTrinity(HUDNow)
	local unlock = 0
	if ReadByte(magicFlags) > 0 then
		unlock = unlock + (2^(trinityTable[1]-1))
	end
	if ReadByte(DJFlag) == 0x20 then
		unlock = unlock + (2^(trinityTable[2]-1))
	end
	if ReadByte(AGFlag) == 0x20 then
		unlock = unlock + (2^(trinityTable[3]-1))
	end
	if ReadByte(OCTrinityFlag) > 0 then
		unlock = unlock + (2^(trinityTable[4]-1))
	end
	if ReadByte(cutsceneFlags+0xB0E) >= 0x32 then
		unlock = unlock + (2^(trinityTable[5]-1))
	end
	local dif = ReadByte(trinityUnlock)
	WriteByte(trinityUnlock, (HUDNow > 0 or ReadByte(world)==3) and unlock or 0)
	if HUDNow < 1 and dif > 0 and textFind=="" then
		for i=2,5 do
			if dif == 2^(i-1) then
				print("Replacing trinity text")
				textFind = trinityTexts[i]
				textReplace = trinityTexts[trinityTable[i]]
				break
			end
		end
	end
end

function StackAbilities()
	local jumpHeight = ReadFloat(soraJumpHeight)
	if jumpHeight == 290 then
		jumpHeight = jumpHeight-100
		for i=0,7 do
			if ReadByte(sharedAbilities+i) == 1 then
				jumpHeight = jumpHeight + 100
			end
		end
		WriteFloat(soraJumpHeight, jumpHeight)
	end
end

function InstantGummi()
	WriteByte(gotoWorldMap, 1)
	WriteLong(closeMenu, 0)
end

function FlagFixes()
	if ReadByte(gummiselect)==3 then
		WriteShort(worldWarps+0x18, 1) -- Add DI warp
		if (ReadByte(unlockedWarps-7) // 8) % 2 == 0 then
			WriteByte(unlockedWarps-7, ReadByte(unlockedWarps-7)+8)
		end
		WriteByte(warpCount+4*3, 4)
	else
		WriteShort(worldWarps+0x18, 4) -- Revert to Wonderland
	end

	if ReadByte(cutsceneFlags+0xB04) >= 0x31 then
		WriteByte(worldFlagBase+0x1C, 5) -- Cid outside
		WriteByte(worldFlagBase+0x26, 2) -- Cid in accessory shop
	end
	if ReadByte(cutsceneFlags+0xB09) < 0x14 then -- Fix monstro DI cutscene softlock
		WriteByte(cutsceneFlags+0xB09, 0x14)
	end
	if ReadByte(cutsceneFlags+0xB0E) < 0xA and ReadByte(gummiselect)==15 then
		WriteByte(cutsceneFlags+0xB0E, 0xA)
	elseif ReadByte(cutsceneFlags+0xB0E) == 0x14 and ReadByte(gummiselect)~=15 then
		WriteByte(cutsceneFlags+0xB0E, 0)
	end
	
	if ReadByte(party1)==0xFF then
		for i=0,1 do
			WriteByte(party1+i, i+1)
			WriteByte(party2+i, i+1)
		end
	end
	
	if ReadByte(gummiFlagBase)==0 then
		OpenGummi()
	end
end

function OpenGummi()
	for i=0,14 do
		if i~=9 then
			WriteByte(gummiFlagBase+i, 3)
		end
	end
	WriteInt(worldMapLines, 0xFFFFFFFF)
	WriteByte(worldMapLines+4, 0xFF)
end

function _OnFrame()
	if ReadInt(input) == 3848 then
		InstantGummi()
	end

	local HUDNow = ReadFloat(soraHUD)
	if not randomized and initDone then
		if (ReadByte(soraHP) > 0 or ReadInt(0x7A8EE8-offset) == 1) and successfulRando then
			Randomize()
			if #itemNames==0 or #gummiNames==0 then
				print("items.txt or gummis.txt missing! Get them from the Github")
			end
		elseif not successfulRando then
			print("Rando unsuccesful! Try restarting and rolling a new seed")
		end
	elseif randomized then
		UpdateInventory(HUDNow)
		ReplaceTrinity(HUDNow)
		if HUDNow < 1 then
			ReplaceMagic(HUDNow)	
		else
			nextTextFind = ""
			if HUDWas < 1 then
				textFind = ""
				print("Text find reset")
			end
		end
		ReplaceTexts()
		HUDWas = HUDNow
	end

	StackAbilities()
	
	FlagFixes()
	
	if ReadByte(world) == 1 then -- DI Day2 Warp to EotW
		local warpAddr = ReadLong(DIDay2WarpPointer)+0x6F9D
		if ReadByteA(warpAddr)==2 and ReadByteA(warpAddr+4)==1 then
			print("DI to EotW warp")
			WriteByteA(warpAddr,0x10)
			WriteByteA(warpAddr+4,0x1E)
		end
	end
	
	if ReadInt(blackfade) == 0 then
		removeBlackTimer = removeBlackTimer+1
	else
		removeBlackTimer = 0
	end
	
	if ((HUDNow > 0 or removeBlackTimer > 300) and ReadByte(world)==0x10) then
		WriteInt(0x233C450-offset, 128) --Remove black screen
		WriteInt(0x233C454-offset, 128)
		WriteInt(0x233C458-offset, 128)
		WriteInt(0x233C45C-offset, 128)
		if removeBlackTimer > 600 then
			print("Removed black screen")
			removeBlackTimer = 0
		end
	end

	if ReadFloat(soraHUD) > 0 and ReadByte(lockMenu) > 0 then
		WriteByte(lockMenu, 0) -- Unlock menu
	end

	if ReadByte(enableRC) ~= 0x0 then
		WriteByte(enableRC, 0x0)
	end
	
	if ReadByte(0x232A604-offset) and ReadByte(0x2E1CB9C-offset) < 5 and ReadShort(menuState)==62576 then
		OpenGummi()
		WriteByte(0x2E1CC28-offset, 3) --Unlock gummi
		WriteByte(0x2E1CB9C-offset, 5) --Set 5 buttons to save menu
		WriteByte(0x2E8F450-offset, 5) --Set 5 buttons to save menu
		WriteByte(0x2E8F452-offset, 5) --Set 5 buttons to save menu
		for i=0,4 do
			WriteByte(0x2E1CBA0+i*4-offset, i) --Set button types
		end
	end
end