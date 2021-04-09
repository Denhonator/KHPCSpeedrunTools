local warpTo0 = 0
local prevWarp = 0
local warpAdd = 0

function _OnInit()

end

function _OnFrame()
	local selection = ReadInt(0x503CEC-0x3A0606)
	local realSelection = selection
	local realWorld = ReadByte(0x503C04-0x3A0606)
	local room = ReadShort(0x2534638-0x3A0606)
	
	local monstroOpen = ReadByte(0x2DE78CA-0x3A0606) > 1
	local neverlandOpen = ReadByte(0x2DE78C7-0x3A0606) > 2
	local deepJungleOpen = ReadByte(0x2DE78C3-0x3A0606) > 2

	if not deepJungleOpen and realWorld == 5 then
		warpTo0 = realWorld
	end
	if not neverlandOpen and (realWorld == 13 or realWorld == 7) then
		warpTo0 = realWorld
	end
	if warpTo0 > 0 and (room ~= 0 or selection ~= warpTo0) then
		warpTo0 = 0
		WriteByte(warpAdd-0x3A0606, prevWarp) --room mod
	end
	if warpTo0 > 0 then
		warpAdd = realWorld==5 and 0x6A8640 or 0x6A8640-0x400
		WriteByte(warpAdd-0x3A0606, realWorld==5 and 0 or 6) --room mod
	end
	
	if not monstroOpen and (selection == 10 or selection == 9) then
		selection = selection == 9 and 18 or 17
		--WriteInt(0x503CEC-0x3A0606, selection)
	end
	if selection == 25 then
		selection = 15
		WriteInt(0x503CEC-0x3A0606, selection)
	end
	if selection == 21 then
		selection = 8
		WriteInt(0x503CEC-0x3A0606, selection)
	end
	local curDest = ReadInt(0x5041F0-0x3A0606)
	if curDest < 40 then
		selection = selection > 20 and 0 or selection
		WriteInt(0x5041F0-0x3A0606, selection)
		WriteInt(0x503C00-0x3A0606, selection)
		WriteInt(0x2685EEC-0x3A0606, 0)
	else
		WriteInt(0x503C00-0x3A0606, realSelection)
	end
end