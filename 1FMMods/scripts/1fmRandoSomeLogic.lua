-- If you want guaranteed abilities on first level ups, put the hex codes for unequipped abilities here.
-- Maximum 4 or they will replace other abilities.
-- Find ability codes here https://pastebin.com/ZH0L3XXi
-- Scroll down for the Not Equipped versions.
-- For example, early scan and dodge roll would be:
-- local earlyAbilities = {0x8A, 0x96}

local earlyAbilities = {0x8A}

-- Variable below determines how weapon stats will be randomized.
-- 0 = Not at all
-- 1 = Weak weapons buffed
-- 2 = Stats shuffled between keyblades (str and magic only)
-- 3 = Stats shuffled and weak stats buffed

local weaponStatRando = 3

-- Stack abilities. Currently, you can sometimes get duplicate abilities.
-- This will determine if having multiple equipped is beneficial
-- 0 = No stacking. Vanilla. You just have excess abilities in the menu.
-- 1 = High Jump stacks: Jump higher the more you have.
-- 2 = High Jump and Glides. First glide/superglide turns into glide, next into superglide and past that it gets faster.

local stackAbilities = 2

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
local shopTableBase = 0x4FB374 - offset
local chestsOpened = 0x2DE5E00 - offset

local inventory = 0x2DE5E6A - offset
local gummiInventory = 0x2DF1848 - offset
local reports = 0x2DE7390 - offset

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
local CutsceneWarpPointer = 0x23944B8 - offset
local OCCupUnlock = 0x2DE77D0 - offset
local waterwayGate = 0x2DE763D - offset
local waterwayTrinity = 0x2DE7681 - offset
local speedup = 0x233C24C - offset
local sliderProgress = 0x2DE7709 - offset
local minigameTimer = 0x232A684 - offset
local collectedFruits = minigameTimer + 4
local unequipBlacklist = 0x541FA0 - offset

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
local superglideSpeedHack = 0x2AE104 - offset

local soraStats = 0x2DE59D0 - offset
local donaldStats = soraStats + 0x74
local goofyStats = donaldStats + 0x74
local experienceMult = 0x2D59180 - offset

local gotoWorldMap = 0x2E1CC24 - offset
local openMenu = 0x2350CD4 - offset
local closeMenu = 0x2E90820 - offset
local menuCheck = 0x2E8EE98 - offset
local input = 0x233D034 - offset
local menuState = 0x2E8F268 - offset
local report1 = 0x1D03586 - offset
local worldWarp = 0x233CB70 - offset
local roomWarp = worldWarp + 4
local warpTrigger = 0x22E86DC - offset
local warpType1 = 0x233C240 - offset
local warpType2 = 0x22E86E0 - offset

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
local sliderSavedProg = {0,0,0,0,0}
local reportUpdater = 0
local bufferRemove = 0
local bufferRemoveTimer = 10
local HUDWas = 0
local menuWas = 0
local removeBlackTimer = 0
local prevBlack = 128
local introJump = true

local important = {0xB2, 0xB7, 0xC0, 0xC0, 0xC1, 0xC2, 0xC3, 0xC4, 0xC4, 0xC4, 0xC5, 0xC5, 0xC5, 0xC6, 0xC6, 0xC7}
local shopPool = {}
local gummiNames = {}
local itemNames = {}
local chestDetails = {}
local rewardDetails = {}
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
local chests = {}
local chestAccessCheck = {}
local rewardAccessCheck = {}
local itemAccessCheck = {}
local seedstring = ""
local randomized = false
local successfulRando = true
local isValidSeed = false
local initDone = false
local infiniteDetection = 0
local canExecute = false

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

function LoadRewards(fs)
	f = io.open(fs)
	local detailsTable = {}
	while true do
		local line = f:read("*l")
		if not line then
			break
		elseif not string.find(line, "?") then
			local chestID = tonumber(string.sub(line, 1, 3), 16)
			if chestID then
				chestID = chestID + 1
				line = string.sub(line, 5)
				local details = {}
				local loop = 1
				for word in string.gmatch(line, "([^;]+)") do
					details[loop] = word:gsub("^%s*(.-)%s*$", "%1")
					loop = loop+1
				end
				detailsTable[chestID] = details
			end
		end
	end
	f:close()
	return detailsTable
end

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		print("KH1 detected, running script")
	else
		print("KH1 not detected, not running script")
	end

	if canExecute then
		local f = io.open("randofiles/items.txt")
		local f2 = io.open("randofiles/gummis.txt")
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
			chestDetails = LoadRewards("randofiles/Chests.txt")
			rewardDetails = LoadRewards("randofiles/Rewards.txt")
			print(rewardDetails[1][1])
			f:close()
			f2:close()
		end
		for i=1,0xFF do
			itemids[i] = i
			inventoryUpdater[i] = ReadByte(inventory+(i-1))
		end
		
		for i=1, 0x40 do
			gummiUpdater[i] = ReadByte(gummiInventory+(i-1))
		end

		for i=1, 7 do
			magicUpdater[i] = 0
		end
		
		trinityTable = {1,2,3,4,5}
		reportUpdater = ReadShort(reports)
		
		seedfile = io.open("randofiles/seed.txt", "r")
		if seedfile ~= nil then
			text = seedfile:read()
			seedstring = text
			if text == "Disabled" then
				print("Disabling rando because of seed Disabled")
				randomized = true
			end
			seed = tonumber(text)
			if seed == nil then
				seed = Djb2(text)
			end
			math.randomseed(seed)
			print("Found existing seed")
		else
			seedfile = io.open("randofiles/seed.txt", "w")
			local newseed = os.time()
			math.randomseed(newseed)
			seedfile:write(newseed)
			print("Wrote new seed")
		end
		seedfile:close()
		
		initDone = true
		print("Init done.	")
	end
end

function ItemType(i)
	local attributes = ""
	if (i >= 1 and i <= 8 and i~=5) or (i >= 0x98 and i <= 0x9A) or (i >= 0x8E and i <= 0x90) then
		attributes = attributes .. "Use"
	end
	if (i >= 9 and i <= 0x10) or i >= 0xE9 then
		attributes = attributes .. "Synth"
	end
	if (i >= 0x11 and i <= 0x47) and i ~= 0x39 then
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
	if (i == 0xC8 or i == 0xC9 or i==0xCB or i==0xCC) or (i >= 0xD4 and i<= 0xDE) 
								or (i >= 0xE3 and i <= 0xE6) or i==0xD2 or i==0xA8
								or i==0xAA or i==0xAE or i==0xB0 then
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
	if string.find(a, "Weapon") or string.find(b, "Weapon") then
		return a==b
	end
	if string.find(a, "Use") or string.find(a, "Synth") then
		return string.find(b, "Use") or string.find(b, "Synth")
	end
	if string.find(a, "Accessory") or string.find(b, "Accessory") then
		return a==b
	end
	if string.find(a, "Summon") then
		return string.find(b, "Summon")
	end
	return true
end

-- simple string hashing algorithm designed by Daniel J. Bernstein
function Djb2(str)
	hash = 5381

	for c in string.gmatch(str, '.') do
		hash = ((hash << 5) + hash) + string.byte(c)
	end

	return hash
end

function ItemAccessible(i, c)
	infiniteDetection = infiniteDetection + 1
	local accessibleCount = 0
	local oi = i
	
	if infiniteDetection >= 1000 then
		print("Infinite")
		return false
	end

	for j=1,0xFF do
		if i == itemids[j] then
			i = j
			break
		end
	end
	
	local inChestReward = false

	for c=1,0x1FE do
		if chests[c] and chests[c] % 0x10 == 0 and chests[c] // 0x10 == i
						and not chestAccessCheck[c] then
			chestAccessCheck[c] = true
			inChestReward = true
			if IsAccessible(chestDetails, c) then
				accessibleCount = accessibleCount+1
			end
		end
	end

	for r=1,0xA9 do
		if rewards[r] and rewards[r] % 0x100 == 0xF0 and rewards[r] // 0x100 == i
						and not rewardAccessCheck[r] then
			rewardAccessCheck[r] = true
			inChestReward = true
			if IsAccessible(rewardDetails, r) then
				accessibleCount = accessibleCount+1
			end
		end
	end
	
	if not inChestReward then
		if i==0xA8 or i==0xC8 or i==0xC9 or i==0xD2 or (i>=0xD9 and i<=0xDE) or (i>=0xE3 and i<=0xE6) then
			accessibleCount = accessibleCount+1
		elseif i==0xCB and not itemAccessCheck[oi] then
			itemAccessCheck[0xC8] = true
			itemAccessCheck[0xC9] = true
			if ItemAccessible(0xC8, 1) and ItemAccessible(0xC9, 1) and TrinityAccessible("Red Trinity") then
				accessibleCount = accessibleCount+1
			end
		elseif (i==0xCC or i==0xB0) and TrinityAccessible("Green Trinity") then
			accessibleCount = accessibleCount+1
		elseif i==0xAA and AbilityAccessible(2, 1) then
			accessibleCount = accessibleCount+1
		elseif i==0xAE and not itemAccessCheck[oi] then
			itemAccessCheck[0xE4] = true
			if ItemAccessible(0xE4, 1) then
				accessibleCount = accessibleCount+1
			end
		end
	end

	return accessibleCount >= c
end

function AbilityAccessible(a, c)
	local accessibleCount = 0
	for r=1,0xA9 do
		if rewards[r] and rewards[r] % 0x100 ~= 0xF0 and rewards[r] // 0x100 == a and not rewardAccessCheck[r] then
			rewardAccessCheck[r] = true
			if IsAccessible(rewardDetails, r) then
				accessibleCount = accessibleCount+1
				if accessibleCount == c then
					return true
				end
			end
		end
	end
	
	return false
end

function TrinityAccessible(s)
	for i=1,5 do
		if trinityTexts[i] == s then
			if trinityTable[5] == i then
				return ItemAccessible(0xC8, 1) and ItemAccessible(0xC9, 1)
					and ItemAccessible(0xCB, 1) and ItemAccessible(0xCC, 1)
			end
		end
	end
	return true
end

function MagicAccessible(s)
	--magicRef = {"Fir","Blizzar","Thund","Cur","Gravi","Stop","Aero"}
	--for i=1,#magicRef do
	--	
	--end
	if string.find(s, "ga") or string.find(s, "ra") then
		return false
	end
	return true
end

function IsAccessible(t, i)
	if t==chestDetails then
		if chests[i] % 0x10 == 0 then
			print(string.format("%s chest at %s has %s", t[i][1], t[i][2], itemNames[itemids[chests[i]//0x10]]))
		elseif chests[i] % 0x10 == 0xE then
			print(string.format("%s chest at %s has reward %x", t[i][1], t[i][2], chests[i]//0x10))
		end
	elseif t==rewardDetails then
		if rewards[i] % 0x100 == 0xF0 then
			print(string.format("%s reward %x at %s has %s", t[i][1], i-1, t[i][2], itemNames[itemids[rewards[i]//0x100]]))
		else
			print(string.format("%s reward %x at %s has ability %x", t[i][1], i-1, t[i][2], rewards[i]//0x100))
		end
	end
	
	if t[i][3] then
		local canAccess = true
		for k=3,6 do
			if not t[i][k] then
				break
			end
			local thisAccess = false
			if string.find(t[i][k], "Day1") then
				thisAccess = thisAccess or (ItemAccessible(0xC0, 1) and ItemAccessible(0xC1, 1) and ItemAccessible(0xC2, 1))
			end
			if string.find(t[i][k], "High Jumpra") then
				thisAccess = thisAccess or AbilityAccessible(1, 2)
			elseif string.find(t[i][k], "High Jump") then
				thisAccess = thisAccess or AbilityAccessible(1, 1)
			end
			if string.find(t[i][k], "Glide") then
				thisAccess = thisAccess or AbilityAccessible(3) or AbilityAccessible(4)
			end
			if string.find(t[i][k], "Mermaid Kick") then
				thisAccess = thisAccess or AbilityAccessible(2)
			end
			if string.find(t[i][k], "HB1") then
				thisAccess = thisAccess or 
				(ItemAccessible(0xC8, 1) and ItemAccessible(0xC9, 1) and ItemAccessible(0xCB, 1) and ItemAccessible(0xCC, 1))
			end
			if string.find(t[i][k], "Library") then
				thisAccess = thisAccess or (ItemAccessible(0xB2, 1) and ItemAccessible(0xB7, 1))
							or AbilityAccessible(1, 2)
			elseif string.find(t[i][k], "Khama") then
				thisAccess = thisAccess or ItemAccessible(0xB2, 1) or AbilityAccessible(1, 2)
			end
			if string.find(t[i][k], "Jack-In-The-Box") then
				thisAccess = thisAccess or ItemAccessible(0xE4, 1)
			end
			if string.find(t[i][k], "Postcard") then
				thisAccess = thisAccess or ItemAccessible(0xD3, tonumber(string.sub(t[i][k], 9))-5)
			end
			if string.find(t[i][k], "Page") then
				local accessiblePages = 0
				for p=0xD4,0xD8 do
					itemAccessCheck[p] = true
					if ItemAccessible(p, 1) then
						accessiblePages = accessiblePages + 1
					end
				end
				thisAccess = thisAccess or tonumber(string.sub(t[i][k], 5)) <= accessiblePages
			end
			if string.find(t[i][k], "All Summons") then
				thisAccess = thisAccess or (ItemAccessible(0xCE, 1) and 
				ItemAccessible(0xCF, 1) and ItemAccessible(0xD0, 1) and MagicAccessible("Fire Magic"))
			elseif string.find(t[i][k], "Dumbo") then
				thisAccess = thisAccess or (ItemAccessible(0xCE, 1) and MagicAccessible("Fire Magic"))
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
				thisAccess = thisAccess or true
			end
			canAccess = canAccess and thisAccess
		end
		return canAccess
		
	elseif t[i][2] == "Chest" then
		for c=1,0x1FE do
			if chests[c] and chests[c] % 0x10 == 0xE and chests[c] // 0x10 == i-1 then
				return IsAccessible(chestDetails, c)
			end
		end
	else
		return true
	end
	
	return false
end

function Randomize()
	successfulRando = false
	
	if LoadRando() then
		successfulRando = true
		goto loaded
	end

	local missableRewards = {0, 2}
	local addItems = {0x95,0x96,0x97,0xA9,0xAB,0xAC,0xAD,0xAF,0xB1}
	local importantPool = {0x5, 0x39, 0x48, 0x4D, 0x50, 0x91, 0x94, 0x92, 0x93, 0xE8}
	local rewardPool = {}
	local randomGets = {}
	
	for i=1, 0xA9 do
		if rewardDetails[i] then
			rewardPool[(#rewardPool)+1] = ReadShort(rewardTable+((i-1)*2))
		end
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
	
	local chestPool = {}
	
	for i=1, 0x1FF do
		if chestDetails[i] then
			chestPool[(#chestPool)+1] = ReadShort(chestTable+((i-1)*2))
		end
	end
	
	local weaponPool = {}
	local accessoryPool = {}
	for i=0x11, 0x86 do
		if string.find(ItemType(i), "Weapon") then
			weaponPool[(#weaponPool)+1] = i
		elseif string.find(ItemType(i), "Accessory") then
			accessoryPool[(#accessoryPool)+1] = i
		end
	end

	for i=1, 0xFF do
		inventoryUpdater[i] = ReadByte(inventory+(i-1))
		local itype = ItemType(i)
		if string.find(itype, "Use") then
			local rl = #randomGets+1
			randomGets[rl] = i
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

	-- Get rid of normal key items, replace with random good stuff
	for i=0x9B, 0xFF do
		if string.find(ItemType(i), "Important") then
			itemids[i] = randomGets[math.random(#randomGets)]
		end
	end
	
	local toShuffle = {}
	local c = 1
	for i=0xA8, 0xFF do
		if string.find(ItemType(i), "Shuffle") then
			toShuffle[c] = i
			c = c + 1
		end
	end
	
	for i=0xA8, 0xFF do
		if string.find(ItemType(i), "Shuffle") then
			local r = math.random(#toShuffle)
			while ((i==0xCB or i==0xAA) and (r==0xC8 or r==0xC9)) or
					(i==0xAE and r==0xE4) do
				r = math.random(#toShuffle)
			end
			itemids[i] = table.remove(toShuffle, r)
		end
	end
	print("Shuffled some items")
	
	-- Need one of:
	itemids[0x48] = 0xB2
	--itemids[0x4A] = 0xB4
	itemids[0x4D] = 0xB7
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
	
	for i=1, 0xFF do
		if string.find(ItemType(itemids[i]), "Important") then
			WriteArray(itemTable+((i-1)*20), ReadArray(itemTable+((itemids[i]-1)*20), 20))
		end
		if ReadShort(itemTable+((i-1)*20)+8) == 0 then
			WriteShort(itemTable+((i-1)*20)+8, (math.random(9)+1)*250)
		end
		itemData[i] = ReadArray(itemTable+((i-1)*20), 20)
		
		if ((string.find(ItemType(i), "Weapon")
				or string.find(ItemType(i), "Important")
				or string.find(ItemType(itemids[i]), "Accessory"))
				and i~=itemids[i])
				or i==itemids[i] and ItemType(i) ~= "" then
			shopPool[(#shopPool)+1] = i
		end
	end
	
	local extraAbilities = {1,2,3,4,0x15,0x16}
	local order = GetRandomOrder(0xA9)

	for r=1, 0xA9 do
		local i=order[r]
		if rewardDetails[i] then
			rewards[i] = table.remove(rewardPool, math.random(#rewardPool))
			if rewards[i] % 0x100 == 0xF0 and ItemType(rewards[i] // 0x100)=="Synth" then
				if #importantPool > 4 then
					rewards[i] = table.remove(importantPool, math.random(#importantPool)) * 0x100 + 0xF0
				elseif #extraAbilities > 0 then
					rewards[i] = table.remove(extraAbilities, math.random(#extraAbilities)) * 0x100
					if rewards[i] // 0x100 <= 4 then
						rewards[i] = rewards[i] + 0xB1
					else
						rewards[i] = rewards[i] + 1
					end
				end
			end
		end
	end

	print("Randomized reward pool")
	
	order = GetRandomOrder(0x1FF)
	
	for c=1, 0x1FF do
		local i=order[c]
		if chestDetails[i] then
			local r = math.random(#chestPool)
			while i == 0 and chestPool[r] % 0x10 == 4 do
				r = math.random(#chestPool)
			end
			chests[i] = table.remove(chestPool, r)
			if (i >= 0x1BF or i == 0) and ((chests[i]-4) % 0x10) == 0 then
				for j=10, 0x1BE do
					if chests[j] and chests[j] % 0x10 ~= 4 then
						local temp = chests[j]
						chests[j] = chests[i]
						chests[i] = temp
						break
					end
				end
			end
			if (chests[i]-2) % 0x10 == 0 then
				if #importantPool > 0 then
					chests[i] = table.remove(importantPool, math.random(#importantPool)) * 0x10
				elseif #missableRewards > 0 then
					chests[i] = table.remove(missableRewards, 1) * 0x10 + 0xE
					print("Added missable reward to chest")
				elseif #addItems > 0 then
					chests[i] = table.remove(addItems, 1) * 0x10
					print("Added additional reports to chest")
				else
					chests[i] = chests[i] + 4
				end
			end
		end
	end
	print("Randomized chests")
	
	local order = GetRandomOrder(0xA9)
	for j=1, 0x49 do
		local i = order[j]
		if rewards[i] and rewards[i] % 0x100 == 1 then
			local r = math.random(95)+4
			while soraAbilities[r] < 0x81 do
				r = math.random(95)+4
			end
			local ab = soraAbilities[r]
			for l=1,99 do
				replaced = {false,false,false}
				if soraAbilities[l] == ab and not replaced[1] then
					soraAbilities[l] = (rewards[i] // 0x100) + 0x80
					replaced[1] = true
				end
				if soraAbilities2[l] == ab and not replaced[2] then
					soraAbilities2[l] = (rewards[i] // 0x100) + 0x80
					replaced[2] = true
				end
				if soraAbilities3[l] == ab and not replaced[3] then
					soraAbilities3[l] = (rewards[i] // 0x100) + 0x80
					replaced[2] = true
				end
			end
			rewards[i] = ((ab-0x80) * 0x100) + 1
		elseif rewards[i] and rewards[i] % 0x100 == 0x21 then
			local r = math.random(95)+4
			while goofyAbilities[r] < 0x81 do
				r = math.random(95)+4
			end
			local ab = goofyAbilities[r]
			goofyAbilities[r] = (rewards[i] // 0x100) + 0x80
			rewards[i] = ((ab-0x80) * 0x100) + 0x21
		elseif rewards[i] and rewards[i] % 0x100 == 0x11 then
			local r = math.random(95)+4
			while donaldAbilities[r] < 0x81 do
				r = math.random(95)+4
			end
			local ab = donaldAbilities[r]
			donaldAbilities[r] = (rewards[i] // 0x100) + 0x80
			rewards[i] = ((ab-0x80) * 0x100) + 0x21
		end
	end
	print("Mixed level up abilities with reward abilities")
	
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

	local trinityPool = {1,2,3,4,5}
	for i=1,5 do
		trinityTable[i] = table.remove(trinityPool, math.random(#trinityPool))
	end
	print("Randomized trinities")
	
	for i=1,5 do
		print(string.format("trinity %x became %x", i, trinityTable[i]))
	end
	for i=1, 0xFF do
		print(string.format("%x became %x", i, itemids[i]))
	end
	
	for i=0x51,0x85 do
		if string.find(ItemType(i), "Weapon") then
			local tablePos = (itemids[i]-0x51)*0x58
			if weaponStatRando < 2 then
				tablePos = (i-0x51)*0x58
			end
			weaponStr[i] = ReadByte(weaponTable+tablePos+0x30)
			weaponMag[i] = ReadByte(weaponTable+tablePos+0x38)
			local magSigned = (weaponMag[i] > 127) and -(256 - weaponMag[i]) or weaponMag[i]
			if weaponStatRando % 2 == 1 then
				local randomPower = math.random(8)+6
				while weaponStr[i]+magSigned*5 < randomPower do
					weaponStr[i] = weaponStr[i]+1
				end
			end
		end
	end
	print("Randomized equipment")
	
	local shopMap = {}
	for i=0,7 do
		if i == 4 or i == 7 then
			shopMap = {}
		end
		local shopItem = 0
		local shopItemID = ReadInt(shopTableBase+(i*0xD4)+(shopItem*4))
		while shopItemID > 0 do
			if not shopMap[shopItemID] then
				shopMap[shopItemID] = table.remove(shopPool, math.random(#shopPool))
			end
			shops[i*0x100+shopItem+1] = shopMap[shopItemID]
			shopItem = shopItem + 1
			shopItemID = ReadInt(shopTableBase+(i*0xD4)+(shopItem*4))
		end
	end
	print("Randomized shops")

	successfulRando = true
	::loaded::
end

function ValidSeed()
	chestAccessCheck = {}
	rewardAccessCheck = {}
	itemAccessCheck = {[0xC8]=true}
	local g1 = ItemAccessible(0xC8, 1)
	print(g1)
	chestAccessCheck = {}
	rewardAccessCheck = {}
	itemAccessCheck = {[0xC9]=true}
	local g2 = ItemAccessible(0xC9, 1)
	print(g2)
	chestAccessCheck = {}
	rewardAccessCheck = {}
	itemAccessCheck = {[0xCB]=true}
	local g3 = ItemAccessible(0xCB, 1)
	print(g3)
	chestAccessCheck = {}
	rewardAccessCheck = {}
	itemAccessCheck = {[0xCC]=true}
	local g4 = ItemAccessible(0xCC, 1)
	print(g4)
	chestAccessCheck = {}
	rewardAccessCheck = {}
	itemAccessCheck = {}
	local f1 = MagicAccessible("Fire Magic")
	print(f1)
	chestAccessCheck = {}
	rewardAccessCheck = {}
	itemAccessCheck = {}
	local tr = TrinityAccessible("Red Trinity")
	print(tr)
	chestAccessCheck = {}
	rewardAccessCheck = {}
	itemAccessCheck = {}
	local hj2 = AbilityAccessible(1, 2)
	print(hj2)
	chestAccessCheck = {}
	rewardAccessCheck = {}
	itemAccessCheck = {[0xB2]=true}
	local khama = ItemAccessible(0xB2, 1)
	print(khama)
	chestAccessCheck = {}
	rewardAccessCheck = {}
	itemAccessCheck = {[0xB7]=true}
	local theon = ItemAccessible(0xB7, 1)
	print(theon)
	
	local DIWin = true
	for i=0xC0,0xC7 do
		chestAccessCheck = {}
		rewardAccessCheck = {}
		itemAccessCheck = {[i]=true}
		local thisDI = ItemAccessible(i, 1)
		DIWin = DIWin and thisDI
		print(string.format("%x %x", i, thisDI and 1 or 0))
	end
	
	if g1 and g2 and g3 and g4 and f1 and tr and (hj2 or (khama and theon)) then
		print("HBWin")
		-- return true
	end
	if DIWin then
		print("DI Win")
		SaveRando()
		return true
	end
	print("Unwinnable, rerolling")
	return false
end

function GetRandomOrder(size)
	randomOrderPool = {}
	randomOrder = {}
	for i=1, size do
		randomOrderPool[i] = i
	end
	for i=1, size do
		randomOrder[i] = table.remove(randomOrderPool, math.random(#randomOrderPool))
	end
	return randomOrder
end

function SaveRando()
	randosave = io.open("randofiles/" .. string.sub(seedstring, 1, 10) .. ".save", "w")
	randosave:write("Rewards:\n")
	for i=1, 0xA9 do
		if rewards[i] then
			randosave:write(string.format("%03x %04x\n", i, rewards[i]))
		end
	end
	randosave:write("\nChests:\n")
	for i=1, 0x1FF do
		if chests[i] then
			randosave:write(string.format("%03x %04x\n", i, chests[i]))
		end
	end
	randosave:write("\nItem swaps:\n")
	for i=1, 0xFF do
		randosave:write(string.format("%02x %02x\n", i, itemids[i]))
	end
	randosave:write("\nShops:\n")
	for i=1, 0x9FF do
		if shops[i] then
			randosave:write(string.format("%03x %02x\n", i, shops[i]))
		end
	end
	randosave:write("\nMagic:\n")
	for i=1, 0x7 do
		randosave:write(string.format("%x %x\n", i, perMagicShuffle[i]))
	end
	randosave:write("\nTrinities:\n")
	for i=1, 0x5 do
		randosave:write(string.format("%x %x\n", i, trinityTable[i]))
	end
	randosave:write("\nSora stats:\n")
	for i=1, 99 do
		if soraLevels[i] then
			randosave:write(string.format("%02d %x\n", i, soraLevels[i]))
		end
	end
	randosave:write("\nSora abilities1:\n")
	for i=1, 99 do
		if soraAbilities[i] then
			randosave:write(string.format("%02d %x\n", i, soraAbilities[i]))
		end
	end
	randosave:write("\nSora abilities2:\n")
	for i=1, 99 do
		if soraAbilities2[i] then
			randosave:write(string.format("%02d %x\n", i, soraAbilities2[i]))
		end
	end
	randosave:write("\nSora abilities3:\n")
	for i=1, 99 do
		if soraAbilities3[i] then
			randosave:write(string.format("%02d %x\n", i, soraAbilities3[i]))
		end
	end
	randosave:write("\nDonald stats:\n")
	for i=1, 99 do
		if donaldLevels[i] then
			randosave:write(string.format("%02d %x\n", i, donaldLevels[i]))
		end
	end
	randosave:write("\nDonald abilities:\n")
	for i=1, 99 do
		if donaldAbilities[i] then
			randosave:write(string.format("%02d %x\n", i, donaldAbilities[i]))
		end
	end
	randosave:write("\nGoofy stats:\n")
	for i=1, 99 do
		if goofyLevels[i] then
			randosave:write(string.format("%02d %x\n", i, goofyLevels[i]))
		end
	end
	randosave:write("\nGoofy abilities:\n")
	for i=1, 99 do
		if goofyAbilities[i] then
			randosave:write(string.format("%02d %x\n", i, goofyAbilities[i]))
		end
	end
	randosave:write("\nWeapons:\n")
	for i=0x51, 0x86 do
		if weaponStr[i] then
			randosave:write(string.format("%02x %02x %02x\n", i, weaponStr[i], weaponMag[i]))
		end
	end
	randosave:write("\nItem data:\n")
	for i=1, 0xFF do
		randosave:write(string.format("%02x ", i))
		for j=1, 20 do
			randosave:write(string.format("%02x", itemData[i][j]))
		end
		randosave:write("\n")
	end
	randosave:close()
	print("Saved rando")
end

function LoadRando()
	randosave = io.open("randofiles/" .. string.sub(seedstring, 1, 10) .. ".save", "r")
	if not randosave then
		return false
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
			local v = tonumber(string.sub(line, 4, 5), 16)
			shops[i] = v
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
		elseif string.find(loadstate, "tem data") then
			local i = tonumber(string.sub(line, 1, 2), 16)
			itemData[i] = {}
			for j=1, 20 do
				if j<=12 then
					local v = tonumber(string.sub(line, 2+(j*2), 3+(j*2)), 16)
					itemData[i][j] = v
				else
					itemData[i][j] = ReadByte(itemTable+((i-1)*20)+j-1)
				end
			end
		end
	end
	randosave:close()
	print("Loaded saved rando")
	isValidSeed = true
	return true
end

function ApplyRandomization()
	for i=1, 0xA9 do
		if rewards[i] then
			WriteShort(rewardTable+((i-1)*2), rewards[i])
		end
	end
	print("Reward randomization applied")
	
	for i=1, 0x1FF do
		if chests[i] then
			WriteShort(chestTable+((i-1)*2), chests[i])
		end
	end
	print("Chest randomization applied")

	for i=0,7 do
		local shopItem = 0
		while shops[i*0x100+shopItem+1] do
			WriteInt(shopTableBase+(i*0xD4)+(shopItem*4), shops[i*0x100+shopItem+1])
			shopItem = shopItem + 1
		end
	end
	print("Shop randomization applied")
	
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
	print("Level randomization applied")
	
	for i=0x51, 0x85 do
		if weaponStr[i] then
			local tablePos = (i-0x51)*0x58
			WriteByte(weaponTable+tablePos+0x30, weaponStr[i])
			WriteByte(weaponTable+tablePos+0x38, weaponMag[i])
			WriteArray(itemTable+((i-1)*20), itemData[itemids[i]])
		end
	end
	print("Weapon randomization applied")
	
	for i=0x11, 0x47 do
		if i~=itemids[i] and string.find(ItemType(i), "Accessory") then
			WriteArray(itemTable+((i-1)*20), itemData[itemids[i]])
		end
	end
	print("Accessory randomization applied")
	
	randomized = true
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
		if string.find(textFind, "btained") then
			size = #textReplace+1
			garbageCount = 0
		end
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

function MenuNameSwap(menuNow)
	for i=1, 0xFF do
		if (string.find(ItemType(i), "Important") or string.find(ItemType(i), "Shuffle")) and i~=itemids[i] then
			if menuNow > 0 then
				WriteArray(itemTable+((i-1)*20), itemData[i])
			else
				WriteArray(itemTable+((i-1)*20), itemData[itemids[i]])
			end
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
				print(string.format("%x %s", dif, itemNames[i]))
				if dif > 0 and ReadByte(closeMenu) == 0 then
					local curid = itemids[i]
					-- if string.find(ItemType(curid), "Shuffle") or string.find(ItemType(i), "Important") then 
						-- textFind = "btained"
						-- textReplace = "btained " .. itemNames[curid] .. ".   "
					-- end
					idFind = i
					idReplace = curid
					print(string.format("Replacing %x with %x", i, curid))
					-- print(string.format("Replacing %s with %s", textFind, textReplace))

					local otherCount = ReadByte(inventory+(curid-1))
					if (i==0xE0) then
						bufferRemove = i
						bufferRemoveTimer = 360
						inventoryUpdater[i] = itemCount+dif
					else
						WriteByte(inventory+(i-1), itemCount-dif)
					end
					if curid == 0xC0 or curid == 0xC6 then
						dif = 2
					elseif curid == 0xC4 or curid == 0xC5 then
						dif = 3
					end
					WriteByte(inventory+(curid-1), otherCount+dif)
					inventoryUpdater[curid] = otherCount+dif
				else
					inventoryUpdater[i] = itemCount
				end
			elseif string.find(ItemType(itemids[i]), "Important") and itemCount>0 and HUDNow>0 then
				WriteByte(inventory+(itemids[i]-1), itemCount + ReadByte(inventory+(itemids[i]-1)))
				WriteByte(inventory+(i-1), 0)
				inventoryUpdater[i] = 0
				inventoryUpdater[itemids[i]] = itemCount
				print(string.format("Used fallback to replace %x with %s", i, itemNames[itemids[i]]))
			end
		end
	end
	
	for i=1,0x40 do
		local itemCount = ReadByte(gummiInventory+(i-1))
		if itemCount > gummiUpdater[i] then
			if ReadByte(closeMenu) == 0 and ReadByte(world)==3 then
				local magicUp = -1
				if i==2 then
					magicUp = 4
				elseif i==7 then
					magicUp = 6
				elseif i==60 then
					magicUp = 5
				end
				if magicUp > 0 then
					WriteByte(magicFlags+magicUp, math.min(ReadByte(magicFlags+magicUp)+1, 3))
					textFind = "Obtained " .. gummiNames[i]
					textReplace = "Power of " .. magicTexts[perMagicShuffle[magicUp+1]] .. "         "
					print(string.format("Replacing %s with %s", textFind, textReplace))
				end
				magicUp = -1
			end
			gummiUpdater[i] = itemCount
		end
	end
	if ReadByte(inventory+0xCA-1) > 0 then
		WriteByte(inventory+0xC8-1, 0)
		WriteByte(inventory+0xC9-1, 0)
	end
	if ReadByte(inventory+0xCD-1) > 0 then
		WriteByte(inventory+0xCB-1, 0)
		WriteByte(inventory+0xCC-1, 0)
	end
end

function StringToKHText(s, mempos)
	reftable = {[58]=0x6B, [39]=0x71, [45]=0x6E, [46]=0x68, [10]=2}
	for i=1,#s do
		local c = string.byte(s, i)
		if c >= 97 then
			c = c - 97 + 0x45
		elseif c >= 65 then
			c = c - 65 + 0x2B
		elseif c >= 48 and c <=57 then
			c = c - 48 + 0x21
		elseif c == 58 then
			c = 0x6B
		elseif reftable[c] then
			c = reftable[c]
		else
			c = 1
		end
		WriteByte(mempos, c)
		mempos = mempos + 1
	end
	WriteByte(mempos, 0)
	return mempos+1
end

function UpdateReports(HUDNow)
	if HUDNow < 1 then
		local reportTable = {[1]=8, [2]=7, [4]=6, [8]=5, [16]=4, [32]=3, [64]=2, [128]=1, 
						[0x800]=13, [0x1000]=12, [0x2000]=11, [0x4000]=10, [0x8000]=9}
		local receivedReport = reportTable[ReadShort(reports)]
		if receivedReport and HUDWas == HUDNow then
			local i = itemids[0xA7 + receivedReport]
			WriteByte(inventory+(i-1), ReadByte(inventory+(i-1))+1)
			inventoryUpdater[i] = ReadByte(inventory+(i-1))
			print(string.format("Gave %x instead of report", i))
		end
		WriteShort(reports, 0)
	else
		local reportTable = {[8]=1, [7]=2, [6]=4, [5]=8, [4]=16, [3]=32, [2]=64, [1]=128, 
						[13]=0x800, [12]=0x1000, [11]=0x2000, [10]=0x4000, [9]=0x8000}
		local reportStatus = 0
		for i=1, 13 do
			local off = i<=10 and 0xA7 or 0x94-10
			if ReadByte(inventory+(off+i-1)) > 0 then
				reportStatus = reportStatus + reportTable[i]
			end
		end
		WriteShort(reports, reportStatus)
		if ReadByte(report1) == 0x37 then
			local mempos = report1
			local chestProg = 1
			local rewardProg = 1
			local itemhint = {[1]=0xC8, [3]=0xC9, [7]=0xCB, [9]=0xCC}
			for i=1, 13 do
				if itemhint[i] then
					for it=1, 0xFF do
						j = itemids[it]
						if j==itemhint[i] then
							local inchest = false
							for c=1, 0x1FF do
								if chests[c] and chests[c] == it*0x10 then
									mempos = StringToKHText(string.format(
										"Chest at\n%s\nhas %s", 
										chestDetails[c][2], itemNames[j]), mempos)
									inchest = true
									break
								end
							end
							if not inchest then
								mempos = StringToKHText(string.format("%s became\n%s", 
													itemNames[it], itemNames[j]), mempos)
							end
						end
					end
				else
					local putHint = 0
					math.randomseed(0)
					order = GetRandomOrder(0x1FF)
					for ch=chestProg, 0x1FF do
						local c = order[ch]
						if chests[c] then
							local it = 1
							if chests[c]%0x10==0 then
								it = itemids[chests[c]//0x10]
							elseif chests[c]%0x10==0xE and rewards[(chests[c]//0x10)+1] and
														rewards[(chests[c]//0x10)+1]%0x100 == 0xF0 then
								it = itemids[rewards[(chests[c]//0x10)+1] // 0x100]
							end
							local itype = ItemType(it)
							if string.find(itype, "Important") then
								mempos = StringToKHText(string.format(
									"Chest at\n%s\nhas %s", 
									chestDetails[c][2], itemNames[it]), mempos)
								putHint = 1
								chestProg = ch+1
								break
							end
						end
					end
					math.randomseed(0)
					order = GetRandomOrder(0xA9)
					for re=rewardProg+(putHint*999), 0xA9 do
						local r = order[re]
						if rewards[r] and rewards[r] % 0x100 == 0xF0 then
							local it = itemids[rewards[r]//0x100]
							local itype = ItemType(it)
							if string.find(itype, "Important") and rewardDetails[r][2]~="Chest" then
								mempos = StringToKHText(string.format(
									"Reward %s\n%s\nhas %s", rewardDetails[r][1],
									rewardDetails[r][2], itemNames[it]), mempos)
								putHint = 2
								rewardProg = re+1
								break
							end
						end
					end
					if putHint == 0 then
						mempos = StringToKHText("Nothing here\nlol", mempos)
					end
				end
			end
			print("Wrote hints")
		end
	end
end

function ReplaceMagic(HUDNow)
	unlock = 0
	local isUnlocked = {false,false,false,false,false,false,false}
	for i=1,7 do
		local r = perMagicShuffle[i]
		if ReadByte(magicFlags+(i-1)) > 3 then
			WriteByte(magicFlags+(i-1), 3)
		end
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
	for j=0,2 do
		if not isUnlocked[ReadByte(shortcuts+j)+1] then
			WriteByte(0xFF)
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
	if ReadByte(OCTrinityFlag) == 0 and ReadByte(world) == 11 and ReadByte(room) == 1 then
		WriteByte(trinityUnlock, 0)
	else
		WriteByte(trinityUnlock, unlock)
	end
	if HUDNow < 1 then
		i = 0
		if ReadByte(cutsceneFlags+0xB05) == 0x5F then
			i = 2
		elseif ReadByte(cutsceneFlags+0xB08) == 0x6E then
			i = 3
		elseif ReadByte(OCTrinityFlag) > 0 and ReadByte(world) == 11 and ReadByte(room) == 1 then
			i = 4
		elseif ReadByte(cutsceneFlags+0xB0E) == 0x28 then
			i = 5
		end
		if i > 0 then
			textFind = trinityTexts[i]
			textReplace = trinityTexts[trinityTable[i]] .. ".     "
		end
	end
end

function StackAbilities()
	local jumpHeight = ReadFloat(soraJumpHeight)
	if jumpHeight == 290 then
		jumpHeight = jumpHeight-100
		for i=0,9 do
			if ReadByte(sharedAbilities+i) == 1 then
				jumpHeight = jumpHeight + 100
			end
		end
		WriteFloat(soraJumpHeight, jumpHeight)
	end
	
	if stackAbilities > 1 then
		local glides = 0
		local superglides = 0
		for i=0,9 do
			if ReadByte(sharedAbilities+i) % 0x80 == 3 then
				glides = glides + 1
			elseif ReadByte(sharedAbilities+i) % 0x80 == 4 then
				superglides = superglides + 1
			end
		end
		local equippedGlides = 0
		for i=0,9 do
			local ab = ReadByte(sharedAbilities+i)
			if ab == 3 or ab == 4 then
				equippedGlides = equippedGlides+1
			end
			if ab % 0x80 == 3 and glides > 1 then
				WriteByte(sharedAbilities+i, ab+1)
				glides = glides - 1
			end
			if ab % 0x80 == 4 and glides == 0 then
				WriteByte(sharedAbilities+i, ab-1)
			end
		end
		WriteInt(superglideSpeedHack, 0x17F50C + math.max(equippedGlides-2, 0)*4)
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
			WriteByte(unlockedWarps-7, math.max(ReadByte(unlockedWarps-7)+8, 9))
		end
		WriteByte(warpCount+4*3, 4)
	else
		WriteShort(worldWarps+0x18, 4) -- Revert to Wonderland
	end

	if ReadByte(cutsceneFlags+0xB04) >= 0x31 then
		--WriteByte(worldFlagBase+0x1C, 5) -- Cid outside
		WriteByte(worldFlagBase+0x26, 2) -- Cid in accessory shop
	end
	if ReadByte(cutsceneFlags+0xB09) < 0x14 then -- Fix monstro DI cutscene softlock
		WriteByte(cutsceneFlags+0xB09, 0x14)
	end
	
	-- if ReadByte(cutsceneFlags+0xB0E) == 1 then
		-- WriteByte(cutsceneFlags+0xB0E, 0xA)
	-- end
	
	for i=0,3 do
		if ReadByte(OCCupUnlock+i) ~= 0x0A and ReadByte(OCCupUnlock+i) ~= 1 then
			if ReadByte(OCCupUnlock+i) > 0 then
				print(string.format("Changed OC cup status from %x to %x", ReadByte(OCCupUnlock+i), 0x0A))
			end
			WriteByte(OCCupUnlock+i, 0x0A)	-- Unlock cups
		end
	end

	if (ReadByte(waterwayGate) // 0x80) % 2 == 0 then
		WriteByte(waterwayGate, ReadByte(waterwayGate)+0x80)
	end
	
	if (ReadByte(waterwayTrinity) // 0x20) % 2 == 0 then
		WriteByte(waterwayTrinity, ReadByte(waterwayTrinity)+0x20)
	end
	
	if ReadByte(worldFlagBase+0x36) >= 0 then
		if (ReadByte(chestsOpened+0x1F8)//2) % 2 == 0 then
			WriteByte(worldFlagBase+0x36, 0xD)
		elseif (ReadByte(chestsOpened+0x1F8)//4) % 2 == 0 then
			WriteByte(worldFlagBase+0x36, 0xE)
		elseif (ReadByte(chestsOpened+0x1F8)//8) % 2 == 0 then
			WriteByte(worldFlagBase+0x36, 0x10)
		end
	end
	
	if ReadByte(inGummi) > 0 then
		if ReadByte(party1)==0xFF then
			for i=0,1 do
				WriteByte(party1+i, i+1)
				WriteByte(party2+i, i+1)
			end
		end
		
		for i=0,3 do
			WriteByte(unequipBlacklist + (i*4), 0)
		end
		
		if ReadFloat(soraHUD) > 0 and ReadByte(lockMenu) > 0 then
			WriteByte(lockMenu, 0) -- Unlock menu
		end

		if ReadByte(enableRC) ~= 0x0 then
			WriteByte(enableRC, 0x0)
		end
	end
	
	if ReadByte(world) == 1 and ReadByte(blackfade)>0 then -- DI Day2 Warp to EotW
		local warpAddr = ReadLong(CutsceneWarpPointer)+0x6F9D
		if ReadByteA(warpAddr)==2 and ReadByteA(warpAddr+4)==1 then
			print("DI to EotW warp")
			WriteByteA(warpAddr,0x10)
			WriteByteA(warpAddr+4,0x1E)
		end
	end
	
	if ReadByte(cutsceneFlags+0xB0D) == 0x64 then -- Skip HB cutscene at end of Neverland
		local warpAddr = ReadLong(CutsceneWarpPointer)+0x677D
		if ReadByteA(warpAddr)==0xF and ReadByteA(warpAddr+4)==0xB and ReadByte(blackfade)>0 then
			print("Skipping HB cutscenes to avoid story flag conflicts")
			WriteByte(cutsceneFlags+0xB0D, 0x6A)
			WriteByteA(warpAddr,0xD)
			WriteByteA(warpAddr+4,0x9)
		end
	end
	
	if ReadByte(world) == 5 then
		-- if ReadByte(blackfade) < 128 and prevBlack == 128 then
			-- sliderSavedProg = ReadArray(sliderProgress, 5)
			-- WriteArray(sliderProgress, {1,1,1,1,1})
		-- elseif ReadByte(blackfade) == 128 and prevBlack < 128 then
			-- WriteArray(sliderProgress, sliderSavedProg)
		-- end
		if ReadByte(room) == 0xF and ReadByte(sliderProgress) == 1 
								and ReadByte(blackfade) > 100 and ReadByte(collectedFruits) == 0 then
			for i=1,4 do
				if ReadByte(sliderProgress+i) == 0 then
					print(string.format("Warping to jungle slider %x", i+1))
					RoomWarp(5, 0x27+i)
					break
				end
			end
		elseif ReadByte(room) > 0xF then
			WriteByte(collectedFruits, math.max(ReadByte(collectedFruits), (ReadByte(room)-0xF)*10))
		end
	end
	
	if ReadByte(world) == 6 then
		if ReadByte(collectedFruits) >= 100 and ReadByte(room) == 4 then
			WriteInt(minigameTimer, 0)
		end
	end
	
	if ReadByte(gummiFlagBase+11)==0 then
		OpenGummi()
	end
end

function EquipmentFixes()
	local expMult = 1.0
	for p=0,2 do
		local accOff = (p*0x74) + 0x1D
		for i=0,3 do
			local eqID = ReadByte(soraStats + accOff+i)
			local eqName = ReadByte(itemTable+((eqID-1)*20))
			if eqName == 0x56 or eqName == 0x58 then
				expMult = expMult + 0.2
			elseif eqName == 0x59 or eqName == 0x5A then
				expMult = expMult + 0.3
			end
		end
	end
	WriteFloat(experienceMult, expMult)
end

function OpenGummi()
	for i=0,14 do
		if i~=9 then
			WriteByte(gummiFlagBase+i, 3)
		end
	end
	WriteInt(worldMapLines, 0xFFFFFFFF)
end

function RoomWarp(w, r)
	WriteByte(warpType1, 5)
	WriteByte(warpType2, 10)
	WriteByte(worldWarp, w)
	WriteByte(roomWarp, r)
	WriteByte(warpTrigger, 2)
end

function _OnFrame()
	if not canExecute then
		goto done
	end

	if ReadInt(input) == 3848 then
		InstantGummi()
	end

	local HUDNow = ReadFloat(soraHUD)
	if not randomized and initDone then
		if (ReadByte(soraHP) > 0 or ReadInt(0x7A8EE8-offset) == 1) and successfulRando then
			Randomize()
			while not isValidSeed and not ValidSeed() do
				infiniteDetection = 0
				Randomize()
			end
			randomized = true
			ApplyRandomization()
			if #itemNames==0 or #gummiNames==0 then
				print("items.txt or gummis.txt missing! Get them from the Github")
			end
		elseif not successfulRando then
			print("Rando unsuccesful! Try restarting and rolling a new seed")
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

	if stackAbilities > 0 then
		StackAbilities()
	end
	
	EquipmentFixes()
	
	FlagFixes()

	if ReadInt(blackfade) == 0 then
		removeBlackTimer = removeBlackTimer+1
	else
		removeBlackTimer = 0
	end
	
	if removeBlackTimer > 300 and ReadByte(world)==0x10 then
		WriteInt(0x233C450-offset, 128) --Remove black screen
		WriteInt(0x233C454-offset, 128)
		WriteInt(0x233C458-offset, 128)
		WriteInt(0x233C45C-offset, 128)
		if removeBlackTimer > 300 then
			print("Removed black screen")
			removeBlackTimer = 0
		end
	end
	
	prevBlack = ReadByte(blackfade)

	if ReadByte(0x232A604-offset) and ReadByte(0x2E1CB9C-offset) < 5 and ReadShort(menuState)==62576 then
		WriteByte(0x2E1CC28-offset, 3) --Unlock gummi
		WriteByte(0x2E1CB9C-offset, 5) --Set 5 buttons to save menu
		WriteByte(0x2E8F450-offset, 5) --Set 5 buttons to save menu
		WriteByte(0x2E8F452-offset, 5) --Set 5 buttons to save menu
		for i=0,4 do
			WriteByte(0x2E1CBA0+i*4-offset, i) --Set button types
		end
	end
	
	::done::
end
