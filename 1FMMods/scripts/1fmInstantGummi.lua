local worldWarpBase = 0x50B940
local djProgressFlag = 0x2DE79D0+0x6C+0x40
local neverlandProgressFlag = 0x2DE79D0+0x6C+0xED
local offset = 0x3A0606

function _OnInit()
	--if ReadByte(0x2DE78C7-offset) > 2 then
	--	neverlandOpen = 0
	--end
	--
	--if ReadByte(0x2DE78C3-offset) > 2 then
	--	djOpen = 0
	--end
end

function _OnFrame()
	local selection = ReadInt(0x503CEC-offset)
	local realSelection = selection
	local realWorld = ReadByte(0x503C04-offset)
	local soraWorld = ReadByte(0x233CADC-offset)
	local room = ReadByte(0x25346D0-offset)
	
	local monstroOpen = ReadByte(0x2DE78CA-offset) > 1
	local neverlandState = ReadByte(neverlandProgressFlag-offset)
	local deepJungleState = ReadByte(djProgressFlag-offset)

	WriteByte(worldWarpBase+0x2A-offset, deepJungleState==0 and 0 or 0xE)
	WriteByte(worldWarpBase+0x2C-offset, deepJungleState==0 and 0 or 0x2D)
	WriteByte(worldWarpBase+0x9A-offset, neverlandState==0 and 6 or 0x7)
	WriteByte(worldWarpBase+0x9C-offset, neverlandState==0 and 0x18 or 0x25)

	if room > 0 and soraWorld ~= selection then
		WriteInt(0x503CEC-offset, soraWorld)
	end
	
	-- Replace HT and Atlantica with Monstro at first
	if not monstroOpen and (selection == 10 or selection == 9) then
		selection = selection == 9 and 18 or 17
		--WriteInt(0x503CEC-offset, selection)
	end
	-- Change warp to Hollow Bastion
	if selection == 25 then 
		selection = 15
		WriteInt(0x503CEC-offset, selection)
	end
	-- Change warp to Agrabah
	if selection == 21 then
		selection = 8
		WriteInt(0x503CEC-offset, selection)
	end
	
	-- Go directly to location
	local curDest = ReadInt(0x5041F0-offset)
	if curDest < 40 then
		selection = selection > 20 and 0 or selection
		WriteInt(0x5041F0-offset, selection)
		WriteInt(0x503C00-offset, selection)
		WriteInt(0x2685EEC-offset, 0)
	else
		WriteInt(0x503C00-offset, realSelection)
	end
end