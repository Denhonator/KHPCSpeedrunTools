local summonSpeedup = true
local speedMult = 2.0
local lastProg = 0
local offset = 0x3A0606
local soraHUD = 0x280EB1C - offset

function _OnInit()

end

function _OnFrame()
	local cutscene = ReadInt(0x2378B60-offset)
	local skippable = ReadInt(0x23944E4-offset)
	local summoning = ReadInt(0x2D5D62C-offset)

	if ReadFloat(soraHUD) == 0 and cutscene > 0 and cutscene ~= 8 
					and skippable ~= 1025 and (summoning == 0 or summonSpeedup) then
		WriteFloat(0x233C24C-offset, speedMult)
	else
		WriteFloat(0x233C24C-offset, 1.0)
	end

	lastProg = textProg
end