LUAGUI_NAME = "EnemyRando"
LUAGUI_AUTH = "denhonator"
LUAGUI_DESC = "Randomizes enemies"

local offset = 0x3A0606
local cpointer = 0x2534638 - offset
local world = 0x233CADC - offset
local room = world + 0x68

local addrs = {0x617DFA}

local lastroom = 0

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
		WriteByte(addr+i, string.byte(s, i+1), true)
		WriteByte(addr+i+0x20, string.byte(s, i+1), true)
	end
	ConsolePrint("Replaced")
end

function _OnFrame()
	local nowroom = ReadByte(world)*100 + ReadByte(room)
	if canExecute and nowroom ~= lastroom then
		local addr = ReadLong(cpointer)+0x60
		local loopcount = 0
		while addr > 0x60 and loopcount < 60 do
			local r = {}
			local empty = ReadByte(addr, true) < 97 or ReadByte(addr, true) > 122
			for i=0,9 do
				r[i+1] = string.char(ReadByte(addr+i, true))
			end
			local s = table.concat(r)
			if not empty then
				lastroom = nowroom
				if repl[s] ~= nil then
					WriteString(addr, repl[s])
				end
				ConsolePrint(s)
			elseif lastroom == nowroom then
				break
			end
			loopcount = loopcount + 1
			addr = addr + 0x40
		end
	end
end