-- Current Versions are 1.0.0.2 (Steam) and 1.0.0.10 Epic Games Store
-- shared
beepHack = 0x26DF8C
maxHP = 0x2DE9366
menu = 0x232DFA0
dialog = 0x299BB08
blackFade = 0x4DC718
world = 0x233FE94
room = 0x233FE8C
soraHUD = 0x281249C
cutscene = 0x233E808
white = 0x233FE1C
fadeBase = 0x233FDD0
inCutscene = 0x23AB2D0
skippable = 0x2382594
summoning = 0x2D60FAC
minitimer = 0x232E000
animSpeed = 0x233FBCC
dest = 0x507580
inGummi = 0x5075A8 -- differs to cover a change on linux systems
gummiSelect = 0x50707C
gummiStart = 0x506F90
cutsceneFlagBase = 0x2DEA865
soraHP = 0x2D5CC4C
stateFlag = 0x2867364
closeMenu = 0x2E941C0
deathPointer = 0x2382568
warpTrigger = 0x22EC0AC
warpType1 = 0x233FBC0
warpType2 = 0x22EC0B0
inputAddress = 0x23407B4
saveOpenAddress = 0x232DFA4
menuFunction = 0x2E204F8
menuButtonCount = 0x2E2055C
menuMaxButtonCount = 0x2E92DF0
menuItemSlotCount = 0x2E92DF2
buttonTypes = 0x2E20548

-- rando shared
soraStats = 0x2DE9396
khamaActive = 0x2D380B0
theonActive = 0x2D39820
party1 = 0x2DE97EF
OCseed = 0x23BBBF0
worldWarp = 0x23404F0
roomWarp = 0x23404F4
ardOff = 0x2382C60
worldFlagBase = 0x2DEB4B0

-- 4:3
height = 0x3B34A4

-- achievements
ach = 0x21AAE28

-- auto attack
attInp = 0x23407B5
swapped = 0x22DA5EE
attackCommand = 0x52890C
fireState1 = 0x23D3F80
fireState2 = 0x232DDC4

-- rando chaos
anims = 0x2D2D730
commandMenuPointer = 0x2D36D50
attackElement = 0x2D278B8
soraPointer = 0x2537E48
donaldPointer = 0x2D37288
goofyPointer = 0x2D37290
weaponSize = 0xD2E4C0
musicPointer = 0x232DF20
musicSpeedHack = 0xA7A5B
musicBaseSpeed = 32797
moveSpeed = 0x2D5CB18
soraResist = 0x2D5CB88

-- consistent finishers
zantHack = 0x2A6FD8
gravBreak = 0x3EC5A8
zantValue = 48100

-- early skip
skipArray1 = 0x17A55C
skipArray2 = 0x17F3E3
skipFlag1 = 0x233FEE8
skipFlag2 = 0x23404D0

-- rando enemy
cutsceneFlags = 0x2DEA860
inTournament = 0x237F4E4
bittestRender = 0x232DE00
combo = 0x2DE5E34
glideBarrier = 0x506DE8
floorStatus = 0x528C7C
wall = 0x6DBB94
enemyAddresses = {
	0x7E48C0, 0x838FC0, 0x8556C0, 0x8A8640, 0x8A8680,
	0x8A86C0, 0x8CA900, 0x8D31C0, 0x8D4900, 0x8E4640,
	0x918340, 0x91E3C0, 0x926580, 0x951500, 0x953E40,
	0x957140, 0x95D240, 0x95D440, 0x95FAC0, 0x9605C0,
	0x960680, 0x970640, 0x976440, 0x97F3C0, 0x97F400,
	0x9838C0, 0x98C180, 0x98C1C0, 0x98C200, 0x996700,
	0x996740, 0x996780, 0x997300, 0x99FBC0, 0x9A8320,
	0x9A8A00, 0x9A8A80, 0x9ABC40, 0x9B0440, 0x9B6AC0,
	0x9BC2C0, 0x9C4100, 0x9C7BC0, 0x9C7C40, 0x9C7C80,
	0x9C7CC0, 0x9CE040, 0x9CE380, 0x9CEF00, 0x9D2B00,
	0x9D2C40, 0x9D4D80, 0x9D50E0, 0x9D63C0, 0x9DB0C0,
	0x9E1EA0, 0x9E3980, 0x9E3A40, 0x9E7020, 0x9F6BC0,
	0x9F7E00, 0x9FB900, 0x9FDF00, 0xA057C0, 0xA0A840,
	0xA23C00, 0xA23C80, 0xA25D00, 0xA2E2C0, 0xA4BF40,
	0xA57D40, 0xA663C0, 0xA85EC0, 0xA90780, 0xA908C0,
	0xA9B000, 0xA9B040, 0xAC4000, 0xAC4040, 0xAC4100,
	0xAC4140, 0xAC4180, 0xAD3D40, 0xAD3D80, 0xAD3DC0,
	0xAD3E00, 0xAD3E40, 0xAD3E80, 0xAD3EC0, 0xAD4000,
	0xAD40A0, 0xAE9480, 0xB0E3C0, 0xB0E400, 0xB0E4A0,
	0xB1A580, 0xB1AA40, 0xB1CDC0, 0xB5E2C0, 0xB5FA40,
	0xB5FD00, 0xBB43C0
}
bossAdjustAddresses = {
	0x506DE8, 0x528C7C, 0x528C9C, 0x6DBB74, 0x70CC4C,
	0x70D804, 0x2340A94, 0x2D372A0, 0x2D37750, 0x2D37C00,
	0x2D38574, 0x2D38EC0, 0x2D38ED4, 0x2D3A630, 0x2D3AAE0,
	0x2D3AF90, 0x2D3B440, 0x2D3C700, 0x2D3D060, 0x2D3D9C0,
	0x2D424C0, 0x2D461B0, 0x2D5CD4C, 0x2D5CF4C, 0x2D5D04C,
	0x2D5D44C, 0x2DE97F0
}

-- fast camera
curSpeedV = 0x25380EC
curSpeedH = 0x25380F0
cameraCenter = 0x2537EEC
speed = 0x506CDC
cameraInputH = 0x23407E0
cameraInputV = 0x23407E4

-- faster dialogue
textTrans = 0x22EC0E4
textProg = 0x232DF74
textSpeed = 0x233FBDC

-- hook ship
posDebugString = 0x3EA318
hookship = 0xED6A3E
neverland = 0x2DEB257
posDebug1 = 0x232DD20
posDebug2 = 0x2537E40
debug1Value = 1

-- instant gummi
worldWarpBase = 0x50ABBA
worldWarpBase2 = 0x50AC2A
monstro = 0x2DEB25A
normalDrive = 0x268986C

-- rando some logic
superglideBaseSpeed = 1561532
superglideSpeedHack = 0x2B2A84
mermaidKickSpeed = 0x3EFA4C
shopTableBase = 0x4FEE04
worldWarps = 0x50ABA8
warpCount = 0x50AC8C
chestTable = 0x528D60
unequipBlacklist = 0x545330
synthRequirements = 0x5476C0
synthItems = 0x5478A0
randoInitCheck = 0x7AC708
report1 = 0x1D06DA4
warpDefinitions = 0x232DF10
roomWarpRead = 0x232DF18
lockMenu = 0x232DF80
collectedFruits = 0x232E004
terminusTeleUsable = 0x2380954 -- On: 4378 Off: 4294957296
currentTerminus = 0x2380A14
ardoffsetClock = 0x2382FC0
OCCupDialog = 0x2384760
infoBoxNotVisible = 0x23D41F0
textBox = 0x23D4364
instantGummiFix = 0x2538058
terminusTeleVisible = 0x2678448 -- On: 1166594048 Off: 3323740160
itemDropID = 0x284D948
RCName = 0x2866D10
animHalfPointersAddress = 0x2869E18
textPointerBase = 0x2B9C280
jumpHeights = 0x2D22DEC
itemTable = 0x2D24798
soraStatTable = 0x2D26800
soraAbilityTable2 = 0x2D26868
soraAbilityTable3 = 0x2D268D0
soraAbilityTable = 0x2D26938
donaldStatTable = 0x2D26BF8
donaldAbilityTable = 0x2D26C60
goofyStatTable = 0x2D26D90
goofyAbilityTable = 0x2D26DF8
weaponTable = 0x2D2C268
rewardTable = 0x2D2F3E8
evidenceActiveBizarre = 0x2D3CBB0
evidenceActiveForest = 0x2D3D510
slideActive = 0x2D403F0
experienceMult = 0x2D5CB00
soraStats = 0x2DE937D
magicLevels = 0x2DE97F2
inventory = 0x2DE97FA
sharedAbilities = 0x2DE98F9
chestsOpened = 0x2DE9978
summons = 0x2DE9B30
shortcuts = 0x2DE9BA4
enableRC = 0x2DE9BD4
waterwayCutsceneFlag = 0x2DEA072
oppositeTrigger = 0x2DEA07D
summonsReturned = 0x2DEA08C
evidence = 0x2DEA168
poohProgress2 = 0x2DEA780
characters = 0x2DEAA44
chronicles = 0x2DEACFB
reports = 0x2DEAD20
battleLevel = 0x2DEAD24
trinityUnlock = 0x2DEAF7B
magicFlags = 0x2DEAF7E
waterwayGate = 0x2DEAFCD
waterwayTrinity = 0x2DEB011
oppositeState = 0x2DEB018
sliderProgress = 0x2DEB099
savedFruits = 0x2DEB09E
poohProgress = 0x2DEB0A8
OCCupUnlock = 0x2DEB160
emblemCount = 0x2DEB20D
emblemDoor = 0x2DEB21C
gummiFlagBase = 0x2DEB250
unlockedWarps = 0x2DEB25F
worldMapLines = 0x2DEB272
libraryFlag = 0x2DEB483
language = 0x2E1B52B
party2 = 0x2E205A5
menuCheck = 0x2E92838
menuState = 0x2E92C08
halfPointersAddress = 0x2EE3980

-- rando some logic - used in ASL
gummiInventory = 0x2DF51DC
magicUnlock = 0x2DE93D4
soraCurAbilities = 0x2DE93A4

-- save anywhere
deathCheck = 0x29BE30
title = 0x23404E8
continue = 0x2DFFF60
config = 0x2DFF760
cam = 0x506CD8
titlescreenpicture = 0x2EE8BB8
titlescreenamvtimer = 0x2EE8BA4
cutSceneAspect = 0x4DD562
saveAnywhere = 0x2354854

-- unlock 0 volume
volumeZero = 0x3D8AF4
