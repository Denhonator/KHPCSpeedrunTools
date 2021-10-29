LUAGUI_NAME = "EnemyRando"
LUAGUI_AUTH = "denhonator"
LUAGUI_DESC = "Randomizes enemies"

local offset = 0x3A0606
local world = 0x233CADC - offset
local room = world + 0x68
local blackfade = 0x4D93B8 - offset
local monitor = 0
local lastMonitor = 0
local hasChanged = false
local lastAddr = 0
local replaced = false

local addrs = {0x617DFA, 0x603F7A, 0x72F8FA}
local cpointer = 0x2967CD0 - offset

local repl = {}

local canExecute = false

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("KH1 detected, running script")
		canExecute = true
		repl["xa_ex_2060"] = "xa_ex_1040"
		repl["xa_ex_2020"] = "xa_ex_2230"
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function WriteString(addr, s)
	for i=0,#s-1 do
		WriteByte(addr+i, string.byte(s, i+1), false)
		WriteByte(addr+i+0x20, string.byte(s, i+1), false)
	end
	ConsolePrint("Replaced")
end

function _OnFrame()
	local input = ReadInt(0x233D034-offset)
	if lastAddr > 0 and lastAddr < 0x86F9FA and replaced then
		WriteByte(lastAddr, 0)
		lastAddr = 0
		replaced = false
	end

	if canExecute and ReadInt(blackfade) == 0 and not hasChanged and input~=8 then
		local addr = 0x46F9FA
		while addr < 0x86F9FA and ReadShort(addr) ~= 0x6178 do
			addr = addr + 0x80
		end
		lastAddr = addr
		local loopcount = 0
		while loopcount < 60 and addr < 0x86F9FA do
			local r = {}
			local empty = ReadByte(addr, false) < 97 or ReadByte(addr, false) > 122
			for i=0,9 do
				r[i+1] = string.char(ReadByte(addr+i, false))
			end
			local s = table.concat(r)
			if not empty then
				if repl[s] ~= nil then
					WriteString(addr, repl[s])
					monitor = addr
					lastMonitor = ReadLong(monitor)
					replaced = true
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
	if ReadByte(blackfade) == 128 or ReadLong(monitor) ~= lastMonitor then
		hasChanged = false
	end
	lastMonitor = ReadLong(monitor)
end