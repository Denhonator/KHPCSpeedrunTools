-- Current Versions are 1.0.0.2 (Steam) and 1.0.0.10 Epic Games Store
-- shared
animSpeed = 0x233FBCC
beepHack = 0x26DF8C
blackFade = 0x4DC718
buttonTypes = 0x2E20548
closeMenu = 0x2E941C0
cutscene = 0x233E808
cutsceneFlagBase = 0x2DEA865
deathPointer = 0x2382568
dest = 0x507580
dialog = 0x299BB08
fadeBase = 0x233FDD0
gummiSelect = 0x50707C
gummiStart = 0x506F90
hookship = 0xED6A1E
inCutscene = 0x23AB2D0
inGummi = 0x5075A8 -- differs to cover a change on linux systems
inputAddress = 0x23407B4
maxHP = 0x2DE9366
menu = 0x232DFA0
menuButtonCount = 0x2E2055C
menuFunction = 0x2E204F8
menuItemSlotCount = 0x2E92DF2
menuMaxButtonCount = 0x2E92DF0
minitimer = 0x232E000
reports = 0x2DEAD20
room = 0x233FE8C
saveOpenAddress = 0x232DFA4
skippable = 0x2382594
soraHP = 0x2D5CC4C
soraHUD = 0x281249C
stateFlag = 0x2867364
summoning = 0x2D60FAC
textProg = 0x232DF74
warpTrigger = 0x22EC0AC
warpType1 = 0x233FBC0
warpType2 = 0x22EC0B0
white = 0x233FE1C
world = 0x233FE94

-- rando shared
ardOff = 0x2382C60
khamaActive = 0x2D380B0
OCseed = 0x23BBBF0
roomWarp = 0x23404F4
soraPointer = 0x2537E48
soraStats = 0x2DE9396
theonActive = 0x2D39820
worldFlagBase = 0x2DEB4B0
worldWarp = 0x23404F0

-- 4:3
height = 0x3B34A4

-- achievements
ach = 0x21AAE28

-- auto attack
attackCommand = 0x52890C
fireState1 = 0x23D3F80
fireState2 = 0x232DDC4
attInp = 0x23407B5
swapped = 0x4D8632

-- rando chaos
anims = 0x2D2D730
attackElement = 0x2D278B8
commandMenuPointer = 0x2D36D50
donaldPointer = 0x2D37288
goofyPointer = 0x2D37290
moveSpeed = 0x2D5CB18
musicBaseSpeed = 32925
musicPointer = 0x232DF20
musicSpeedHack = 0xA771B
soraResist = 0x2D5CB88
soraStats = 0x2DE9396
weaponSize = 0xD2E4C0

-- consistent finishers
gravBreak = 0x3EC538
zantHack = 0x2A6D58
zantValue = 35340

-- early skip
skipArray1 = 0x17A55C
skipArray2 = 0x17F3E3
skipFlag1 = 0x233FEE8
skipFlag2 = 0x23404D0

-- rando enemy
bossAdjustAddresses = {
	0x506DE8, 0x528C7C, 0x528C9C, 0x6DBBF4, 0x70CCCC,
	0x70D884, 0x2340A94, 0x2D372A0, 0x2D37750, 0x2D37C00,
	0x2D38574, 0x2D38EC0, 0x2D38ED4, 0x2D3A630, 0x2D3AAE0,
	0x2D3AF90, 0x2D3B440, 0x2D3C700, 0x2D3D060, 0x2D3D9C0,
	0x2D424C0, 0x2D461B0, 0x2D5CD4C, 0x2D5CF4C, 0x2D5D04C,
	0x2D5D44C
}
enemyAddresses = {
	0x7E4940, 0x839040, 0x855740, 0x8A86C0, 0x8A8700,
	0x8A8740, 0x8CA980, 0x8D3240, 0x8D4980, 0x8E46C0,
	0x9183C0, 0x91E440, 0x926600, 0x951580, 0x953EC0,
	0x9571C0, 0x95D2C0, 0x95D4C0, 0x95FB40, 0x960640,
	0x960700, 0x9706C0, 0x9764C0, 0x97F440, 0x97F480,
	0x983940, 0x98C200, 0x98C240, 0x98C280, 0x996780,
	0x9967C0, 0x996800, 0x997380, 0x99FC40, 0x9A83A0,
	0x9A8A80, 0x9A8B00, 0x9ABCC0, 0x9B04C0, 0x9B6B40,
	0x9BC340, 0x9C4180, 0x9C7C40, 0x9C7CC0, 0x9C7D00,
	0x9C7D40, 0x9CE0C0, 0x9CE400, 0x9CEF80, 0x9D2B80,
	0x9D2CC0, 0x9D4E00, 0x9D5160, 0x9D6440, 0x9DB140,
	0x9E1F20, 0x9E3A00, 0x9E3AC0, 0x9E70A0, 0x9F6C40,
	0x9F7E80, 0x9FB980, 0x9FDF80, 0xA05840, 0xA0A8C0,
	0xA23C80, 0xA23D00, 0xA25D80, 0xA2E340, 0xA4BFC0,
	0xA57DC0, 0xA66440, 0xA85F40, 0xA90800, 0xA90940,
	0xA9B080, 0xA9B0C0, 0xAC4080, 0xAC40C0, 0xAC4180,
	0xAC41C0, 0xAC4200, 0xAD3DC0, 0xAD3E00, 0xAD3E40,
	0xAD3E80, 0xAD3EC0, 0xAD3F00, 0xAD3F40, 0xAD4080,
	0xAD4120, 0xAE9500, 0xB0E440, 0xB0E480, 0xB0E520,
	0xB1A600, 0xB1AAC0, 0xB1CE40, 0xB5E340, 0xB5FAC0,
	0xB5FD80, 0xBB4440
}
bittestRender = 0x232DE00
combo = 0x2DE5E34
cutsceneFlags = 0x2DEA860
floorStatus = 0x528C7C
glideBarrier = 0x506DE8
inTournament = 0x237F4E0
wall = 0x6DBC14

-- fast camera
cameraCenter = 0x2537EEC
cameraInputH = 0x23407E0
cameraInputV = 0x23407E4
curSpeedH = 0x25380F0
curSpeedV = 0x25380EC
speed = 0x506CDC

-- faster dialogue
textSpeed = 0x233FBDC
textTrans = 0x22EC194

-- hook ship
debug1Value = 2
neverland = 0x2DEB257
posDebug1 = 0x232DD20
posDebug2 = 0x2537E40
posDebugString = 0x3EA318

-- instant gummi
monstro = 0x2DEB25A
normalDrive = 0x268986C
worldWarpBase = 0x50ABBA
worldWarpBase2 = 0x50AC2A

-- rando some logic
animHalfPointersAddress = 0x2869E18
ardoffsetClock = 0x2382FC0
battleLevel = 0x2DEAD24
characters = 0x2DEAA44
chestTable = 0x528D60
chestsOpened = 0x2DE9978
chronicles = 0x2DEACFB
collectedFruits = 0x232E004
currentTerminus = 0x2380A14
donaldAbilityTable = 0x2D26C60
donaldStatTable = 0x2D26BF8
emblemCount = 0x2DEB20D
emblemDoor = 0x2DEB21C
enableRC = 0x2DE9BD4
evidence = 0x2DEA168
evidenceActiveBizarre = 0x2D3CBB0
evidenceActiveForest = 0x2D3D510
experienceMult = 0x2D5CB00
goofyAbilityTable = 0x2D26DF8
goofyStatTable = 0x2D26D90
gummiFlagBase = 0x2DEB250
halfPointersAddress = 0x2EE3980
infoBoxNotVisible = 0x23D41F0
instantGummiFix = 0x2538058
inventory = 0x2DE97FA
itemDropID = 0x284D948
itemTable = 0x2D24798
jumpHeights = 0x2D22DEC
language = 0x2E1B52B
libraryFlag = 0x2DEB483
lockMenu = 0x232DF80
magicFlags = 0x2DEAF7E
magicLevels = 0x2DE97F2
menuCheck = 0x2E92838
mermaidKickSpeed = 0x3EF9DC
OCCupDialog = 0x2384760
OCCupUnlock = 0x2DEB160
oppositeState = 0x2DEB018
oppositeTrigger = 0x2DEA07D
party2 = 0x2E205A5
poohProgress = 0x2DEB0A8
poohProgress2 = 0x2DEA780
randoInitCheck = 0x7AC788
RCName = 0x2866D10
report1 = 0x1D06DA4
rewardTable = 0x2D2F3E8
roomWarpRead = 0x232DF18
savedFruits = 0x2DEB09E
sharedAbilities = 0x2DE98F9
shopTableBase = 0x4FEE04
shortcuts = 0x2DE9BA4
slideActive = 0x2D403F0
sliderProgress = 0x2DEB099
soraAbilityTable = 0x2D26938
soraAbilityTable2 = 0x2D26868
soraAbilityTable3 = 0x2D268D0
soraStatTable = 0x2D26800
summons = 0x2DE9B30
summonsReturned = 0x2DEA08C
superglideBaseSpeed = 1560828
superglideSpeedHack = 0x2B2804
synthItems = 0x5478A0
synthRequirements = 0x5476C0
terminusTeleUsable = 0x2380954 -- On: 4378 Off: 4294957296
terminusTeleVisible = 0x2678448 -- On: 1166594048 Off: 3323740160
textBox = 0x23D4364
textPointerBase = 0x2B9C280
trinityUnlock = 0x2DEAF7B
unequipBlacklist = 0x545330
unlockedWarps = 0x2DEB25F
warpCount = 0x50AC8C
warpDefinitions = 0x232DF10
waterwayCutsceneFlag = 0x2DEA072
waterwayGate = 0x2DEAFCD
waterwayTrinity = 0x2DEB011
weaponTable = 0x2D2C268
worldMapLines = 0x2DEB272
worldWarps = 0x50ABA8

-- ASL shared
gummiInventory = 0x2DF51DC
magicUnlock = 0x2DE93D4
party1 = 0x2DE97EF
soraCurAbilities = 0x2DE93A4

-- save anywhere
cam = 0x506CD8
config = 0x2DFF760
continue = 0x2DFFF60
cutSceneAspect = 0x4DD562
deathCheck = 0x29BE30
saveAnywhere = 0x2354854
title = 0x23404E8
titlescreenamvtimer = 0x2EE8BA4
titlescreenpicture = 0x2EE8BB8

-- unlock 0 volume
volumeZero = 0x3D8AF4
