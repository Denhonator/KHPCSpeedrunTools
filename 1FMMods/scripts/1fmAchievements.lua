LUAGUI_NAME = "1fmAchievements"
LUAGUI_AUTH = "denhonator"
LUAGUI_DESC = "Achievement tracker for plat% speedruns"

local offset = 0x3A0606
local ach = 0x21A7628 - offset

local canExecute = false
local prevAch = {0,0}
local curAch = {0,0} 

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
		ConsolePrint("KH1 detected, running script")
		canExecute = true
	else
		ConsolePrint("KH1 not detected, not running script")
	end
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
					ConsolePrint(string.format("%s Achievement get: %s", os.date('%Y-%m-%d %H:%M:%S'), achievementList[achID]))
					
					local f = io.open("achievements.txt")
					if not f then
						local fw = io.open("achievements.txt", "w")
						fw:close()
						f = io.open("achievements.txt")
					end
					local contents = f:read("*a")
					f:close()
					local achCount = 0
					for j=1,#achievementList do
						if string.find(contents, achievementList[j]) ~= nil then
							achCount = achCount + 1
						elseif j == achID then
							achCount = achCount + 1
							f = io.open("achievements.txt", "a")
							f:write(string.format("%s %s\n", os.date('%Y-%m-%d %H:%M:%S'), achievementList[achID]))
							f:close()
						end
					end
					ConsolePrint(string.format("Progress: %d/%d", achCount, #achievementList))
				end
				dif = dif >> 1
				--ConsolePrint(string.format("%x", dif))
				achID = achID - 1
			end
			prevAch[i] = curAch[i]
		end
	end
end