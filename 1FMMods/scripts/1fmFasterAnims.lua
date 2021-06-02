local summonSpeedup = true
local speedMult = 2.0
local offset = 0x3A0606
local soraHUD = 0x280EB1C - offset

local canExecute = false

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		print("KH1 detected, running script")
	else
		print("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if not canExecute then
		goto done
	end

	local cutscene = ReadInt(0x2378B60-offset)
	local skippable = ReadInt(0x23944E4-offset)
	local summoning = ReadInt(0x2D5D62C-offset)

	if ReadFloat(soraHUD) < 1 and cutscene > 0 and cutscene ~= 8 
					and skippable ~= 1025 and (summoning == 0 or summonSpeedup) then
		WriteFloat(0x233C24C-offset, speedMult)
	else
		WriteFloat(0x233C24C-offset, 1.0)
	end

	::done::
end