function _OnInit()

end

function _OnFrame()
	local selection = ReadInt(0x503CEC-0x3A0606)
	local realSelection = selection
	local realWorld = ReadByte(0x503C04-0x3A0606)
	local room = ReadShort(0x2534638-0x3A0606)
	
	local monstroOpen = ReadByte(0x2DE78CA-0x3A0606) > 1
	local neverlandOpen = ReadByte(0x2DE78C7-0x3A0606) > 2

	if not monstroOpen and (selection == 10 or selection == 9) then
		selection = selection == 9 and 18 or 17
		--WriteInt(0x503CEC-0x3A0606, selection)
	end
	if not neverlandOpen and selection == 13 then
		selection = 19
	end
	if selection == 25 then
		selection = 15
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