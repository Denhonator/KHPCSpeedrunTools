LUAGUI_NAME = "1fmFasterAnims"
LUAGUI_AUTH = "denhonator"
LUAGUI_DESC = "Speeds up animations during which you can't play"

local summonSpeedup = true
local speedMult = 2.0
local offset = 0x3A0606
local soraHUD = 0x280EB1C - offset

local canExecute = false

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if not canExecute then
		goto done
	end

	local cutscene = ReadInt(0x2378B60-offset)
	local skippable = ReadInt(0x23944E4-offset)
	local summoning = ReadInt(0x2D5D62C-offset)
	local world = ReadByte(0x233CADC-offset)
	local room = ReadByte(0x233CB44-offset)
	local minitimer = ReadInt(0x232A684-offset)
	local camstate = ReadByte(0x2998188-offset)

	if ReadFloat(soraHUD) < 1 and cutscene > 0 and cutscene ~= 8 
		and skippable ~= 1025 and (summoning == 0 or summonSpeedup)
		and not (world==6 and room==8 and minitimer>=18000.0/speedMult)
		and not (world==1 and room==2 and (camstate>=1 and camstate<=5)) then
		WriteFloat(0x233C24C-offset, speedMult)
	else
		WriteFloat(0x233C24C-offset, 1.0)
	end

	::done::
end