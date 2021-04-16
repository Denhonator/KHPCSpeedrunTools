local lasttitle = 0
local offset = 0x3A0606
local addgummi = 0

function _OnInit()

end

function _OnFrame()
	local input = ReadInt(0x233D034-offset)
	local savemenuopen = ReadByte(0x232A604-offset)
	
	if (input == 1793) and savemenuopen~=4 then 
		WriteByte(0x2350CD4-offset, 0x1)
		addgummi = 5
	end
	
	if savemenuopen == 4 and addgummi==1 then
		WriteByte(0x2E1CC28-offset, 3) --Unlock gummi
		WriteByte(0x2E1CB9C-offset, 5) --Set 5 buttons to save menu
		WriteByte(0x2E8F450-offset, 5) --Set 5 buttons to save menu
		WriteByte(0x2E8F452-offset, 5) --Set 5 buttons to save menu
		for i=0,4 do
			WriteByte(0x2E1CBA0+i*4-offset, i) --Set button types
		end
	end
	
	addgummi = addgummi > 0 and addgummi-1 or addgummi
	
	local titletest = ReadInt(0x7A8EE8-offset)
	if titletest == 0 and lasttitle ~= 0 then 
		print("Remember to type 'reload' after restarting or going to title screen")
	end
	lasttitle = titletest
end