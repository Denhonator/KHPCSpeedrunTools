LUAGUI_NAME = "1fmAchievements"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Achievement tracker for plat% speedruns"

local canExecute = false
local prevAch = {0,0}
local curAch = {0,0}
local posDebugString = 0x3EB158

local achievementList = {
"Proud Player         ",
"Final Mix Master     ",
"Novice Player        ",
"Unchanging Armor     ",
"Undefeated           ",
"Speedster            ",
"He Who Doesn't Exist ",
"The Cloaked Shadow   ",
"The Sandy Blade      ",
"Novice Hero          ",
"Artisan Hero         ",
"Hero of the Coliseum ",
"Coliseum Champion    ",
"The Frosty Giant     ",
"One-Winged Angel     ",
"Supreme Soloist      ",
"Time Attacker        ",
"Level Master         ",
"Treasure Hunter      ",
"From Rags to Riches  ",
"Heartless Hunter     ",
"Where the Bells Toll ",
"The Rabbit Hole      ",
"Junior Hero          ",
"Member of the Tribe  ",
"Magic Lamp           ",
"Honest Soul          ",
"Master of the Seas   ",
"Pumpkin Prince       ",
"Pixie Dust           ",
"End of the World     ",
"Pooh's Friend        ",
"Record Keeper        ",
"Storyteller          ",
"Searcher             ",
"Professor            ",
"Top Dog              ",
"Best Friend          ",
"Mini-game Maniac     ",
"Synthesis Master     ",
"First Synthesis      ",
"Synthesis Novice     ",
"Synthesis Amateur    ",
"Synthesis Vet        ",
"Gummi Ship Collector ",
"Flying Ace           ",
"Customizer           ",
"Top Gun              ",
"Test Pilot           ",
"Veteran Pilot        ",
"Ace Pilot            ",
"Oathkeeper           ",
"Blade Master         ",
"Master Magician      ",
"Master Defender      "}

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		Track(-1)
		canExecute = true
		ConsolePrint("KH1 detected, running script")
		if ReadByte(posDebugString) == 0x58 then
			require("EpicGamesGlobal")
		elseif ReadByte(posDebugString - 0x1020) == 0x58 then
			require("EpicGamesJP")
		else
			require("SteamGlobal") -- Global and JP equal
		end
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

local function Track(achID)
	local f = io.open("achievements.txt")
	if not f then
		local fw = io.open("achievements.txt", "w")
		fw:close()
		f = io.open("achievements.txt")
	end
	local contents = f:read("*a"):gsub("-", " ")
	f:close()
	local achCount = 0
	for j=1,#achievementList do
		if string.find(contents, achievementList[j]:gsub("-", " ")) ~= nil then
			achCount = achCount + 1
			--ConsolePrint(achievementList[j] .. " found")
		elseif j == achID then
			--ConsolePrint(achievementList[j] .. " added")
			achCount = achCount + 1
			ConsolePrint(string.format("%s Achievement get: %s", os.date('%Y-%m-%d %H:%M:%S'), achievementList[achID]))
			f = io.open("achievements.txt", "a")
			f:write(string.format("%s %s\n", os.date('%Y-%m-%d %H:%M:%S'), achievementList[achID]))
			f:close()
		end
	end
	ConsolePrint(string.format("Progress: %d/%d", achCount, #achievementList))
end

function _OnFrame()
	if canExecute then
		curAch[1] = ReadInt(ach)
		curAch[2] = ReadInt(ach+4)

		for i=1,2 do
			local dif = curAch[i] - prevAch[i]
			local achID = i*32
			while dif >= 1 do
				if dif & 1 == 1 then
					Track(achID)
				end
				dif = dif >> 1
				--ConsolePrint(string.format("%x", dif))
				achID = achID - 1
			end
			prevAch[i] = curAch[i]
		end
	end
end