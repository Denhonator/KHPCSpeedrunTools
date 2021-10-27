LUAGUI_NAME = "EnemyRando"
LUAGUI_AUTH = "denhonator"
LUAGUI_DESC = "Randomizes enemies"

local offset = 0x3A0606
local world = 0x233CADC - offset
local room = world + 0x68
local blackfade = 0x4D93B8 - offset
local hasChanged = false

local addrs = {0x617DFA}

local repl = {}

local canExecute = false

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("KH1 detected, running script")
		canExecute = true
		repl["xa_ex_2340"] = "xa_ex_2320"
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function WriteString(addr, s)
	for i=0,#s-1 do
		WriteByte(addr+i, string.byte(s, i+1))
		WriteByte(addr+i+0x20, string.byte(s, i+1))
	end
	ConsolePrint("Replaced")
end

function _OnFrame()
	if canExecute and ReadInt(blackfade) == 0 and not hasChanged then
		local addr = addrs[1]
		local loopcount = 0
		while loopcount < 60 do
			local r = {}
			local empty = ReadByte(addr) < 97 or ReadByte(addr) > 122
			for i=0,9 do
				r[i+1] = string.char(ReadByte(addr+i))
			end
			local s = table.concat(r)
			if not empty then
				if repl[s] ~= nil then
					WriteString(addr, repl[s])
				end
				hasChanged = true
				ConsolePrint(s)
			elseif loopcount > 0 then
				break
			end
			loopcount = loopcount + 1
			addr = addr + 0x40
		end
	end
	if ReadByte(blackfade) == 128 then
		hasChanged = false
	end
end