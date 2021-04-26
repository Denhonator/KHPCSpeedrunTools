local offset = 0x3A0606
-- For some reason can't write to these addresses
local accel = 0x3E7F58 - offset
local deaccel = 0x3E7F5C - offset
-----
local snap = 0x1DD0E9 - offset
local accelHack = 0x1E2924 - offset
local deaccelHack = 0x1E291B - offset
local speed = 0x503A1C - offset

function _OnInit()
	-- Enables instant camera centering
	WriteInt(snap, 0x02357637)
	-- Changes it to read acceleration values from elsewhere
	WriteInt(accelHack, 0x0020563C)
	WriteInt(deaccelHack, 0x00205645)
end

function _OnFrame()
	if math.abs(ReadFloat(speed)) == 1.0 then -- This way it works for inverted camera
		-- You can change the 1.4 to anything you wish. Bigger = faster.
		WriteFloat(speed, ReadFloat(speed) * 1.4)
	end
end