LUAGUI_NAME = "1fmChaos"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Randomizes many things in a chaotic way"

local lastBlack = 0
local airStatuses = {0, 8, 24}
local validCommands = {
	[75] = true, [87] = true, [88] = true, [90] = true,
	[94] = true, [98] = true, [99] = true
}
local musics = {184}
local musicExists = {[184] = true}
local animsData = {}
local commandData = {}
local lastRoom = 99
local baseSeed = 0

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		require("VersionCheck")
		if canExecute then
			for off = 0, 511 do
				local anim = ReadArray(anims + (off * 20), 20)
				if anim[1] >= 200 and anim[1] < 221 and anim[1] ~= 219 then
					animsData[off + 1] = anim
				end
			end

			for i = 7, 52 do
				if (i < 28) or (i > 30 and i < 39) or (i > 46) then
					validCommands[i] = true
				end
			end

			local commsA = ReadLong(commandMenuPointer)
			for i = 0, 99 do
				if validCommands[i] then
					commandData[i + 1] = ReadArray(commsA + (i * 16), 16, true)
				end
			end

			for i = 100, 157 do
				if not ((i >= 106 and i <= 109) or (i >= 113 and i <= 115)
				or (i >= 132 and i <= 139) or i == 126 or i == 142
				or i == 145 or i == 150 or i == 151 or i == 156) then
					musics[(#musics) + 1] = i
					musicExists[i] = true
				end
			end

			lastBlack = ReadByte(blackFade)
		end
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

local function Randomize()
	local pool = {}
	for i = 0, 511 do
		pool[(#pool) + 1] = animsData[i + 1]
	end

	for i = 0, 511 do
		if animsData[i+1] and #pool > 0 then
			WriteByte(anims + (i * 20), table.remove(pool, math.random(#pool))[1])
		end
	end

	for i = 0, 9 do
		WriteByte(attackElement + 4 + (i * 112), math.random(5))
	end

	pool = {}
	for i = 0, 99 do
		if commandData[i + 1] then
			pool[(#pool) + 1] = commandData[i + 1]
		end
	end

	local commsA = ReadLong(commandMenuPointer)
	for i = 0, 99 do
		if commandData[i + 1] then
			local command = table.remove(pool, math.random(#pool))
			WriteArray(commsA + (i * 16), command, true)
		end
	end

	r = math.random(60) * 0.1
	r = r > 5 and 1 or r < 0.5 and 1 or r
	s = math.random(10) * 0.1 + 0.4
	d = math.random(10) * 0.1 + 0.4
	g = math.random(10) * 0.1 + 0.4
	for i = 0, 2 do
		WriteFloat(ReadLong(soraPointer) + 64 + (i * 4), s, true)
		WriteFloat(ReadLong(donaldPointer) + 64 + (i * 4), d, true)
		WriteFloat(ReadLong(goofyPointer) + 64 + (i * 4), g, true)
		WriteFloat(weaponSize + (i * 4), r)
	end

	math.randomseed(baseSeed + ReadByte(world))
	local musicA = ReadLong(musicPointer) + 8
	local music1 = musics[math.random(#musics)]
	local music2 = musics[math.random(#musics)]
	for _=1, 40 do
		if musicExists[ReadInt(musicA, true)] then
			WriteByte(musicA, music1, true)
		end
		if musicExists[ReadInt(musicA + 4, true)] then
			WriteByte(musicA + 4, music2, true)
		end
		musicA = musicA + 32
	end

	math.randomseed(baseSeed + ReadByte(room) + ReadByte(world) * 256 + ReadByte(soraStats) * 65536)
	if ReadByte(musicSpeedHack) == 243 then
		r = math.random(10)
		n = r == 10 and 12 or r == 1 and -32 or 0
		WriteShort(musicSpeedHack + 4, musicBaseSpeed + n)
	end

	-- Movement speed
	WriteFloat(moveSpeed, math.random(11) + 5)

	for i = 0, 5 do
		resist = soraResist + i * 4
		WriteFloat(resist, ReadFloat(resist) + (math.random(20) * 0.1) - 1.0)
	end

	WriteFloat(ReadLong(soraPointer) + 644, 0.7 + math.random(6) * 0.1, true)

	local soraAirA = ReadLong(soraPointer) + 112
	local soraAir = ReadByte(soraAirA, true)
	if math.random(10) == 10 and (soraAir == 0 or soraAir == 8 or soraAir == 24) then
		WriteByte(soraAirA, airStatuses[math.random(3)], true)
	end
end

local function Revert()
	local commsA = ReadLong(commandMenuPointer)
	for i = 0, 511 do
		if i < 3 then
			WriteFloat(ReadLong(soraPointer) + 64 + (i * 4), 1, true)
			WriteFloat(ReadLong(donaldPointer) + 64 + (i * 4), 1, true)
			WriteFloat(ReadLong(goofyPointer) + 64 + (i * 4), 1, true)
			WriteFloat(weaponSize + (i * 4), 1)
		end
		if i < 6 then
			WriteFloat(soraResist + i * 4, 1)
		end
		if i < 10 then
			WriteByte(attackElement + 4 + (i * 112), math.random(5))
		end
		if i < 100 and commandData[i + 1] then
			WriteArray(commsA + (i * 16), commandData[i + 1], true)
		end
		if animsData[i + 1] then
			WriteByte(anims + (i * 20), animsData[i + 1])
		end
	end

	if ReadByte(musicSpeedHack) == 243 then
		WriteByte(musicSpeedHack + 4, musicBaseSpeed)
	end

	-- Movement speed
	WriteFloat(moveSpeed, 8)

	WriteFloat(ReadLong(soraPointer) + 644, 1.0, true)
end

function _OnFrame()
	if canExecute then
		local nowRoom = ReadByte(room)

		if ReadFloat(soraHUD) > 0 and ReadFloat(soraResist) == 1.0 then
			math.randomseed(baseSeed + nowRoom + ReadByte(world) * 256 + ReadByte(soraStats) * 65536)
			if nowRoom ~= lastRoom then
				Randomize()
				lastRoom = nowRoom
				ConsolePrint("Chaos! Randomized animations among other things")
			end
		end

		-- if ReadByte(blackFade) < 128 and lastBlack == 128 then
		-- 	Revert()
		-- 	ConsolePrint("Reverted chaos to avoid crashes")
		-- end

		lastBlack = ReadByte(blackFade)
	end
end
