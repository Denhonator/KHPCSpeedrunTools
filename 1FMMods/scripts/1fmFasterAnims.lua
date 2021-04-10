local summonSpeedup = true
local speedMult = 2.0

function _OnInit()

end

function _OnFrame()
	local cutscene = ReadInt(0x2378B60-0x3A0606)
	local skippable = ReadInt(0x23944E4-0x3A0606)
	local summoning = ReadInt(0x2D5D62C-0x3A0606)

	if cutscene > 0 and skippable ~= 1025 and (summoning == 0 or summonSpeedup) then
		WriteFloat(0x233C24C-0x3A0606, speedMult)
	else
		WriteFloat(0x233C24C-0x3A0606, 1.0)
	end

end