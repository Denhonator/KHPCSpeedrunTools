-- Current Versions are 1.0.0.2 (Steam) and 1.0.0.10 Epic Games Store
-- shared
animSpeed = 0x233F54C
beepHack = 0x26BB9C
blackFade = 0x4DC3F8
buttonTypes = 0x2E1FEA0
closeMenu = 0x2E93B20
cutscene = 0x233E174
cutsceneFlagBase = 0x2DEA1E5
deathPointer = 0x23977B8
dest = 0x507280
dialog = 0x299B488
fadeBase = 0x233F750
gummiSelect = 0x506D7C
gummiStart = 0x506C90
hookship = 0xED651E
inCutscene = 0x237BE60
inGummi = 0x5072AD
inputAddress = 0x2340334
maxHP = 0x2DE8CE6
menu = 0x232D900
menuButtonCount = 0x2E1FE9C
menuFunction = 0x2E1FF28
menuItemSlotCount = 0x2E92752
menuMaxButtonCount = 0x2E92750
minitimer = 0x232D984
reports = 0x2DEA6A0
room = 0x233FE44
saveOpenAddress = 0x232D904
skippable = 0x23977E4
soraHP = 0x2D5C5CC
soraHUD = 0x2811E1C
stateFlag = 0x2866C58
summoning = 0x2D6092C
textProg = 0x232D8F4
warpTrigger = 0x22EB9DC
warpType1 = 0x233F540
warpType2 = 0x22EB9E0
white = 0x233F79C
world = 0x233FE4C

-- rando shared
ardOff = 0x237C100
khamaActive = 0x2D37A30
OCseed = 0x238C780
roomWarp = 0x233FE74
soraPointer = 0x2537990
soraStats = 0x2DE8D16
theonActive = 0x2D391A0
worldFlagBase = 0x2DEAE30
worldWarp = 0x233FE70

-- 4:3
height = 0x3B3574

-- achievements
ach = 0x21AA8A8

-- auto attack
attackCommand = 0x52860C
attInp = 0x2340335
fireState1 = 0x23D3900
fireState2 = 0x232D744
swapped = 0x22D9F7E

-- rando chaos
anims = 0x2D2D0B0
attackElement = 0x2D27238
commandMenuPointer = 0x2D366D0
donaldPointer = 0x2D36C08
goofyPointer = 0x2D36C10
moveSpeed = 0x2D5C498
musicBaseSpeed = 32605
musicPointer = 0x232D890
musicSpeedHack = 0xA778B
soraResist = 0x2D5C508
weaponSize = 0xD2DF20

-- consistent finishers
gravBreak = 0x3EC358
zantHack = 0x2A4948
zantValue = 44140

-- early skip
skipArray1 = 0x1781FC
skipArray2 = 0x17D043
skipFlag1 = 0x233F8B8
skipFlag2 = 0x233FDA0

-- rando enemy
bossAdjustAddresses = {
	0x6DB5F4, 0x70D284, 0x233FE94, 0x2D36C20, 0x2D370D0,
	0x2D37580, 0x2D37EF4, 0x2D38840, 0x2D38854, 0x2D39FB0,
	0x2D3A460, 0x2D3A910, 0x2D3ADC0, 0x2D3C080, 0x2D3C9E0,
	0x2D3D340, 0x2D41E40, 0x2D45B30, 0x2D5C6CC, 0x2D5C8CC,
	0x2D5C9CC, 0x2D5CDCC
	
}
enemyAddresses = {
	0x7E4340, 0x838A40, 0x855140, 0x8A80C0, 0x8A8100,
	0x8A8140, 0x8CA380, 0x8D2C40, 0x8D4380, 0x8E40C0,
	0x917DC0, 0x91DE40, 0x926000, 0x950F80, 0x9538C0,
	0x956BC0, 0x95CCC0, 0x95CEC0, 0x95F540, 0x960040,
	0x960100, 0x9700C0, 0x975EC0, 0x97EE40, 0x97EE80,
	0x983340, 0x98BC00, 0x98BC40, 0x98BC80, 0x996180,
	0x9961C0, 0x996200, 0x996D80, 0x99F640, 0x9A7DA0,
	0x9A8480, 0x9A8500, 0x9AB6C0, 0x9AFEC0, 0x9B6540,
	0x9BBD40, 0x9C3B80, 0x9C7640, 0x9C76C0, 0x9C7700,
	0x9C7740, 0x9CDAC0, 0x9CDE00, 0x9CE980, 0x9D2580,
	0x9D26C0, 0x9D4800, 0x9D4B60, 0x9D5E40, 0x9DAB40,
	0x9E1920, 0x9E3400, 0x9E34C0, 0x9E6AA0, 0x9F6640,
	0x9F7880, 0x9FB380, 0x9FD980, 0xA05240, 0xA0A2C0,
	0xA23680, 0xA23700, 0xA25780, 0xA2DD40, 0xA4B9C0,
	0xA577C0, 0xA65E40, 0xA85940, 0xA90200, 0xA90340,
	0xA9AA80, 0xA9AAC0, 0xAC3A80, 0xAC3AC0, 0xAC3B80,
	0xAC3BC0, 0xAC3C00, 0xAD37C0, 0xAD3800, 0xAD3840,
	0xAD3880, 0xAD38C0, 0xAD3900, 0xAD3940, 0xAD3A80,
	0xAD3B20, 0xAE8F00, 0xB0DE40, 0xB0DE80, 0xB0DF20,
	0xB1A000, 0xB1A4C0, 0xB1C840, 0xB5DD40, 0xB5F4C0,
	0xB5F780, 0xBB3E40
}
bittestRender = 0x232D770
combo = 0x2DE57B4
cutsceneFlags = 0x2DEA1E0
floorStatus = 0x52897C
glideBarrier = 0x5069D8
inTournament = 0x238C778
wall = 0x6DC614

-- fast camera
cameraCenter = 0x2537A34
cameraInputH = 0x2340360
cameraInputV = 0x2340364
curSpeedH = 0x25377D4
curSpeedV = 0x25377D0
speed = 0x506AAC

-- faster dialogue
textSpeed = 0x233F55C
textTrans = 0x22EBA44

-- hook ship
debug1Value = 2
neverland = 0x2DEABD7
posDebug1 = 0x232D6A0
posDebug2 = 0x2537964
posDebugString = 0x3EA138

-- instant gummi
monstro = 0x2DEABDA
normalDrive = 0x26891EC
worldWarpBase = 0x50E9FA
worldWarpBase2 = 0x50EA6A

-- rando some logic
animHalfPointersAddress = 0x2869798
ardoffsetClock = 0x2398210
battleLevel = 0x2DEA6A4
characters = 0x2DEA3C4
chestTable = 0x528A60
chestsOpened = 0x2DE92F8
chronicles = 0x2DEA67B
collectedFruits = 0x232D988
currentTerminus = 0x2395C64
donaldAbilityTable = 0x2D265E0
donaldStatTable = 0x2D26578
emblemCount = 0x2DEAB8D
emblemDoor = 0x2DEAB9C
enableRC = 0x2DE9554
evidence = 0x2DE9AE8
evidenceActiveBizarre = 0x2D3C530
evidenceActiveForest = 0x2D3CE90
experienceMult = 0x2D5C480
goofyAbilityTable = 0x2D26778
goofyStatTable = 0x2D26710
gummiFlagBase = 0x2DEABD0
halfPointersAddress = 0x2EE36B0
infoBoxNotVisible = 0x23D3B90
instantGummiFix = 0x2537058
inventory = 0x2DE917A
itemDropID = 0x284D2C8
itemTable = 0x2D24118
jumpHeights = 0x2D2276C
language = 0x2E1AEAB
libraryFlag = 0x2DEAE03
lockMenu = 0x232D90C
magicFlags = 0x2DEA8FE
magicLevels = 0x2DE9172
menuCheck = 0x2E92198
mermaidKickSpeed = 0x3EF80C
OCCupDialog = 0x23999B0
OCCupUnlock = 0x2DEAAE0
oppositeState = 0x2DE99FD
oppositeTrigger = 0x2DE99FD
party2 = 0x2E1FEE5
poohProgress = 0x2DEAA28
poohProgress2 = 0x2DEA100
randoInitCheck = 0x7AC188
RCName = 0x2866690
report1 = 0x1D06804
rewardTable = 0x2D2ED68
roomWarpRead = 0x232D888
savedFruits = 0x2DEAA1E
sharedAbilities = 0x2DE9279
shopTableBase = 0x4FE3C4
shortcuts = 0x2DE9524
slideActive = 0x2D3F410
sliderProgress = 0x2DEAA19
soraAbilityTable = 0x2D262B8
soraAbilityTable2 = 0x2D261E8
soraAbilityTable3 = 0x2D26250
soraStatTable = 0x2D26180
summons = 0x2DE94B0
summonsReturned = 0x2DE9A0C
superglideBaseSpeed = 1569852
superglideSpeedHack = 0x2B03F4
synthItems = 0x547580
synthRequirements = 0x5473A0
terminusTeleUsable = 0x2395BA4  -- On: 4378 Off: 4294957296
terminusTeleVisible = 0x2677DC8 -- On: 1166594048 Off: 3323740160
textBox = 0x23D3364
textPointerBase = 0x2B9BC00
trinityUnlock = 0x2DEA8FB
unequipBlacklist = 0x545020
unlockedWarps = 0x2DEABDF
warpCount = 0x50EACC
warpDefinitions = 0x232D880
waterwayCutsceneFlag = 0x2DE99F2
waterwayGate = 0x2DEA94D
waterwayTrinity = 0x2DEA991
weaponTable = 0x2D2BBE8
worldMapLines = 0x2DEABF2
worldWarps = 0x50E9E8

-- ASL shared
gummiInventory = 0x2DF4B5C
magicUnlock = 0x2DE8D54
party1 = 0x2DE916F
soraCurAbilities = 0x2DE8D24

-- save anywhere
cam = 0x506AA8
config = 0x2DFF0E0
continue = 0x2DFF8E0
cutSceneAspect = 0x4DD242
deathCheck = 0x299A20
saveAnywhere = 0x23541D4
title = 0x233FDB8
titlescreenamvtimer = 0x2EE88D4
titlescreenpicture = 0x2EE45EC

-- unlock 0 volume
volumeZero = 0x3D8B04
