LUAGUI_NAME = "1fmConsistentFinishers"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "30% chance finishers are now 100%"

local canExecute = false
local posDebugString = 0x3EB158

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
		if ReadByte(posDebugString) == 0x58 then
			require("EpicGamesGlobal")
		elseif ReadByte(posDebugString - 0x1020) == 0x58 then
			require("EpicGamesJP")
		else
			require("SteamGlobal") -- Global and JP version addresses are shared
			if ReadByte(posDebugString - 0xE40) ~= 0x58 then -- Steam JP specific changes
				gravBreak = gravBreak - 0x80
				zantHack = zantHack - 0x280
				zantValue = zantValue + 512
			end
		end
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		if ReadShort(zantHack) ~= zantValue then
			WriteFloat(gravBreak, -1.0)
			WriteShort(zantHack, zantValue) -- 88 offset from original value
		end
	end
end