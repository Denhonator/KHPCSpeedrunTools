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

local normal = {"xa_ew_2010", "xa_ew_2020", "xa_ew_2030", "xa_ew_2040", "xa_ew_2050",
				"xa_ex_2010", "xa_ex_2020", "xa_ex_2030", "xa_ex_2040",
				"xa_ex_2050", "xa_ex_2060", "xa_ex_2070", "xa_ex_2080", "xa_ex_2090",
				"xa_ex_2100", "xa_ex_2110", "xa_ex_2120", "xa_ex_2130", "xa_ex_2140",
				"xa_ex_2150", "xa_ex_2160", "xa_ex_2170", "xa_ex_2180",
				"xa_ex_2190", "xa_ex_2200", "xa_ex_2210",
				"xa_ex_2220", "xa_ex_2230", "xa_ex_2240",
				"xa_ex_2250", "xa_ex_2260", "xa_ex_2270", "xa_ex_2280",
				"xa_ex_2290", "xa_ex_2320", "xa_ex_2330",
				"xa_ex_2340", "xa_ex_2350", "xa_ex_2380",
				"xa_ex_2390", "xa_pp_3020"}
				
local bosses = {}

local repl = {}

local canExecute = false

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("KH1 detected, running script")
		canExecute = true
		local pool = {}
		for i=1,#normal do
			pool[i] = normal[i]
		end
		for i=1,#normal do
			local r = math.random(#pool)
			repl[normal[i]] = table.remove(pool, r)
			ConsolePrint(string.format("Replacing %s with %s", normal[i], repl[normal[i]]))
		end
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function WriteString(addr, s)
	for i=0,#s-1 do
		WriteByte(addr+i, string.byte(s, i+1), false)
	end
end

function _OnFrame()
	local input = ReadInt(0x233D034-offset)
	
	if canExecute and ReadInt(blackfade) == 0 and not hasChanged then
		local addr = 0x46F9FA
		while addr < 0x86F9FA do
			while addr < 0x86F9FA and ReadShort(addr) ~= 0x6178 or ReadShort(addr-0x20) ~= 0 do
				addr = addr + 0x80
			end
			if addr < 0x86F9FA then
				ConsolePrint(string.format("%x", addr+offset))
			end
			lastAddr = addr
			local loopcount = 0
			while loopcount < 120 and addr < 0x86F9FA do
				local r = {}
				local empty = ReadByte(addr, false) < 97 or ReadByte(addr, false) > 122
				for i=0,9 do
					r[i+1] = string.char(ReadByte(addr+i, false))
				end
				local s = table.concat(r)
				if not empty then
					if repl[s] ~= nil and ReadByte(addr+10) == 0x2E then
						if input~=8 then
							WriteString(addr, repl[s])
						end
						ConsolePrint(string.format("Replaced %s with %s", s, repl[s]))
						monitor = addr+2
						lastMonitor = ReadLong(monitor)
						replaced = true
					end
					hasChanged = true
					--ConsolePrint(s)
				elseif loopcount > 0 then
					break
				end
				loopcount = loopcount + 1
				addr = addr + 0x20
			end
			addr = addr - (addr%0x100) + 0xFA
		end
	end
	if ReadByte(blackfade) == 128 or ReadLong(monitor) ~= lastMonitor then
		hasChanged = false
	end
	lastMonitor = ReadLong(monitor)
end