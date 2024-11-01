LUAGUI_NAME = "2fmLoadSaveMenu"
LUAGUI_AUTH = "Sonicshadowsilver2 (edited by deathofall84)"
LUAGUI_DESC = "Open the load/save menu from inside game where possible"

local loadFunc = 2326724609
local saveFunc = 3307995153
local canOpenTable = {
	{6, 140}, {6, 141}, -- Phil's Training (Story)
	{7, 108}, -- SB Sand Slider
	{262, 53}, {262, 73}, -- The Hunny Pot
	{518, 142}, {518, 143}, -- Phil's Training (Minigame)
	{528, 88}, -- SB Time Attack
	{529, 61}, {529, 62}, {529, 63}, -- Light Cycle
	{1026, 182}, {1026, 183}, {1026, 184}, -- Struggle Competitions
	{1545, 55}, {1545, 69}, -- A Blustery Rescue
	{1538, 89}, {1538, 190}, {1538, 193}, -- Cargo Climb
	{1538, 90}, {1538, 191}, {1538, 194}, -- Grandstander
	{1538, 91}, {1538, 192}, {1538, 195}, -- Mail Delivery
	{1794, 100}, {1794, 197}, -- Junk Sweep
	{1794, 101}, {1794, 198}, -- Bumble-Buster
	{1794, 102}, {1794, 199}, -- Poster Duty
	{1801, 57}, {1801, 70}, -- Hunny Slider
	{2308, 100}, -- SB Freestyle
	{2057, 59}, {2057, 71}, -- SB Freestyle
	{2313, 61}, {2313, 72}, -- The Expotition
	{2318, 75}, -- SB Workshop Rave
	{2574, 72} -- Gift Wrapping (Wrap Over 150 Presents)
}

function _OnInit()
	if GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then
		require("VersionCheck")
	end
end

-- Check for world, room, door, map, btl, and evt
local function event(w, r, d, m, b, e)
	return (
		(world == w or not w) and
		(room == r or not r) and
		(door == d or not d) and
		(map == m or not m) and
		(btl == b or not b) and
		(evt == e or not e)
	)
end

local function isBit(address, bit)
	return ReadByte(address) & bit == bit
end

-- Check if the Load/Save Menu can be opened
local function canOpen()
	if ReadByte(loading) ~= 0 then -- Loading
		return false
	elseif ReadByte(cutscene) == 1 then -- Cutscene
		return false
	elseif place == 2310 and evt ~= 124 and evt ~= 125 then -- The Underdrome Cups
		return false
	else
		for i=1, #canOpenTable do
			if place == canOpenTable[i][1] and evt == canOpenTable[i][2] then
				return false
			end
		end
	end
	return true
end

--Check the Menu Type (Load Game/Save or Load Only)
local function MenuType()
	if world == 2 and isBit(save, 4) and not isBit(save + 1, 16) then -- New Game ~ Before Chasing Dusk
		return 'Load'
	elseif world == 2 and isBit(save + 1, 16) and not isBit(save + 1, 32) then -- Chasing Dusk
		return 'LoadSave'
	elseif world == 2 and isBit(save + 3, 3) and not isBit(save + 3, 16) then -- Save Tutorial ~ It's a Promise event
		return 'LoadSave'
	elseif event(2, 10, 0, 120, 120, 120) then -- Head to the Wall While Avoiding the Balls!
		return 'Load'
	elseif event(2, 12, 0, 125, 125, 125) then -- Stop the Moving Bag!
		return 'Load'
	elseif event(8, 3, 0, 71, 71, 71) then -- Hurry to the Mountain Summit!
		return 'Load'
	elseif event(6, 5, 0, 111, 111, 111) then -- Hades Escape
		return 'Load'
	elseif event(11, 2, 0, 52, 52, 52) then -- Swimming Tutorial
		return 'Load'
	elseif event(17, 1, 0, 51, 51, 51) then -- Find the Real Parts!
		return 'Load'
	elseif place == 4100 and (evt == 62 or evt == 63 or evt == 64 or evt == 65) then -- Ravine Trail Battles
		return 'Load'
	elseif event(16, 9, nil, 1, 22, 0) and ReadByte(menu) > 1 then -- Medallion (Isla de Muerta: Cave Mouth)
		return 'LoadSave'
	elseif event(16, 12, nil, 1, 22, 0) and ReadByte(menu) > 1 then -- Medallion (Isla de Muerta: Powder Store)
		return 'LoadSave'
	elseif event(16, 13, nil, 0, 22, 0) and ReadByte(menu) > 1 then -- Medallion (Isla de Muerta: Moonlight Nook)
		return 'LoadSave'
	elseif event(16, 10, nil, 2, 22, 0) and ReadByte(menu) > 1 then -- Medallion (Isla de Muerta: Treasure Heap)
		return 'LoadSave'
	elseif event(16, 14, nil, 0, 22, 0) and ReadByte(menu) > 1 then -- Medallion (Ship Graveyard: Seadrift Keep)
		return 'LoadSave'
	elseif event(16, 15, nil, 0, 22, 0) and ReadByte(menu) > 1 then -- Medallion (Ship Graveyard: Seadrift Row)
		return 'LoadSave'
	elseif event(7, 14, nil, 1, 10, 11) then -- Head towards Jafar's shadow!
		return 'LoadSave'
	elseif event(7, 14, nil, 4, 14, 17) or event(7, 14, nil, 4, 18, 18) then -- Examine the monument!
		return 'LoadSave'
	elseif event(7, 14, 0, 100, 100, 100) then -- Hurry to the Tower Before the Door Shuts!
		return 'Load'
	elseif place == 3591 and (evt == 61 or evt == 111) then -- Magic Carpet
		return 'Load'
	elseif event(14, 10, 0, 63, 63, 63) then -- Gift Wrapping (Wrap 100 Presents)
		return 'Load'
	elseif event(17, 4, 0, 56, 56, 56) then -- I/O Tower: Hallway Battle
		return 'Load'
	elseif ReadByte(btlTyp) == 1 then -- Normal Battle
		return 'LoadSave'
	elseif ReadByte(btlTyp) == 2 then -- Forced Battle
		return 'Load'
	end
	return false
end

-- Check if World Map should be shown in Save Menu
local function showWorldMap()
	-- World Map
	if world == 15 then
		return false
	-- Before visiting Merlin's House for the first time
	elseif not isBit(save + 61, 64) then
		return false
	-- TLoD1 (Village Cave after Cave Battle)
	elseif event(8, 5, nil, 1, 0, 0) then
		return false
	-- TLoD1 (Summit ~ Village after Summit Battle)
	elseif world == 8 and isBit(save + 196, 8) and not isBit(save + 196, 16) then
		return false
	-- OC1 (Talking Hercules in The Coliseum)
	elseif event(6, 0, nil, 0, 0, 4) then
		return false
	-- First 100 Acre Wood events
	elseif (world == 4 or world == 9) and isBit(save + 67, 8) and not isBit(save + 68, 8) then
		return false
	-- HT1 (Graveyard (1st Arrival))
	elseif event(14, 2, nil, 5, 0, 21) then
		return false
	-- TT2 (Before clearing or entering The Usual Spot)
	elseif world == 2 and isBit(save + 19, 2) and not isBit(save + 19, 128) and	not isBit(save + 546, 128) then
		return false
	-- HB2 (Before visiting Merlin's House)
	elseif world == 4 and isBit(save + 62, 4) and not isBit(save + 62, 32) then
		return false
	-- HB2/SP1 (Entering Ansem's Study ~ Going back to Research Lab from Pit Cell)
	elseif (world == 4 or world == 17) and isBit(save + 63, 2) and not isBit(save + 63, 32) then
		return false
	-- SP1 (Before going back to Research Lab after Hostile Program Battle)
	elseif event(17, 5, nil, 0, 0, 3) then
		return false
	-- BC2 (Before entering Beast's Room or any Savepoint areas)
	elseif world == 5 and isBit(save + 96, 2) and not isBit(save + 96, 128) and not isBit(save + 541, 128)
					  and not isBit(save + 542, 1) and not isBit(save + 542, 4) then
		return false
	-- BC2 (Before leaving The West Wing after entering Beast's Room)
	elseif world == 5 and isBit(save + 96, 128) and not isBit(save + 97, 2) then
		return false
	-- PR2 (Before entering Stone Hollow)
	elseif world == 10 and isBit(save + 256, 4) and not isBit(save + 545, 16) then
		return false
	-- HB3 (Before entering Merlin's House)
	elseif world == 4 and isBit(save + 73, 8) and not isBit(save + 73, 64) then
		return false
	end
	return true
end

-- Load/Save Menu
local function LoadSaveMenu()
	-- Open Pause Menu
	if canOpen() then
		-- Set Save Menu Slots
		if showWorldMap() then
			WriteByte(saveMenuSlot, 3) -- 3 Save Menu Slots (With World Map)
		-- else
		-- 	WriteByte(saveMenuSlot, 2) -- 2 Save Menu Slots (Without World Map)
		end
		-- Pause HUD Pop-Up
		if ReadByte(menu + 22) ~= 15 then
			WriteByte(menu + 22, 15)
		end
		-- Prepare Pause Menu Slots
		if MenuType() and ReadByte(menu) == 0 then
			WriteByte(menu, 1) -- Pause with Slots
			WriteInt(menu + 24, 0) -- No Pause Text
		end
		-- Set Pause Menu Functions
		if world == 15 then -- World Map
			WriteInt(menu + 8, loadFunc) -- Slot 2: Load Game
		elseif MenuType() == 'LoadSave' then -- Load Game/Save
			WriteShort(menu + 2, 2) -- 2 Pause Menu Slot
			WriteInt(menu + 4, loadFunc) -- Slot 1: Load Game
			WriteInt(menu + 8, saveFunc) -- Slot 2: Save
		elseif MenuType() == 'Load' then -- Load Game
			WriteShort(menu + 2, 1) -- 1 Pause Menu Slot
			WriteInt(menu + 4, loadFunc) -- Slot 1: Load Game
		elseif ReadByte(btlTyp) == 0 then -- Out-of-Battle (When Status Menu can be opened)
			-- R2
			if ReadInt(inputAddress) == 65536 then -- Hold R2 and press Start
				WriteByte(menu, 1) -- Pause with Slots
				WriteInt(menu + 24, 0) -- No Pause Text
				WriteShort(menu + 2, 2) -- 2 Pause Menu Slots
				WriteInt(menu + 4, loadFunc) -- Slot 1: Load Game
				WriteInt(menu + 8, saveFunc) -- Slot 2: Save
			else -- Press Start
				if ReadByte(menu) ~= 0 then
					WriteByte(menu, 0) -- Status Menu
				end
			end
		end
	end
	-- Set the appropriate Door ID when going to World Map from some Worlds
	if world == 15 then
		local worldMapDoor = false
		local preWorld = ReadByte(location + 48)
		if preWorld == 9 or preWorld == 17 then -- 100 Acre Wood or Space Paranoids
			worldMapDoor = 2 -- Door -> Hollow Bastion/Radiant Garden
		elseif preWorld == 13 then -- Timeless River
			worldMapDoor = 6 -- Door -> Disney Castle
		end
		if worldMapDoor then
			WriteByte(location + 2, worldMapDoor)
		end
	end
end

function _OnFrame()
	if canExecute then
		world = ReadByte(location)
		place = ReadShort(location)
		room  = ReadByte(location + 1)
		door  = ReadByte(location + 2)
		map   = ReadByte(location + 4)
		btl   = ReadByte(location + 6)
		evt   = ReadByte(location + 8)
		LoadSaveMenu()
	end
end
