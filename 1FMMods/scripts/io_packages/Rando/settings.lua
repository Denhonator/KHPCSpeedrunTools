-- Prevent select key items from being randomized
-- Item IDs are listed in itemNames.lua
-- Available options: 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 206, 230
-- For example, if you want to unrandomize Entry Pass and Navi-Gummi:
-- Unrandomize = {206, 230}

unrandomize = {}

-- Define how many slides are required to progress Deep Jungle
-- And how many evidence is required to progress Wonderland
-- All 4 evidence and 6 slides will be randomized and accessible regardless
-- Slides must be picked up in Deep Jungle after meeting the condition, and must be picked up to progress
-- This is to avoid rare softlocks that happened previously
-- Evidence also becomes available for pick up after meeting condition, but is unnecessary to pick up

requiredSlides = 1

requiredEvidence = 1

-- If you want guaranteed abilities on first level ups, put the hex codes for unequipped abilities here.
-- Maximum 4 or they will replace other abilities.
-- Find ability codes here https://pastebin.com/ZH0L3XXi
-- Scroll down for the Not Equipped versions.
-- For example, early scan and dodge roll would be:
-- EarlyAbilities = {0x8A, 0x96}

earlyAbilities = {0x8A}

-- Variable below determines how weapon stats will be randomized.
-- 0 = Not at all
-- 1 = Weak weapons buffed
-- 2 = Stats shuffled between keyblades (str and magic only)
-- 3 = Stats shuffled and weak stats buffed

weaponStatRando = 2

-- Stack abilities. Currently, you can sometimes get duplicate abilities.
-- This will determine if having multiple equipped is beneficial
-- 0 = No stacking. Vanilla. You just have excess abilities in the menu.
-- 1 = High Jump stacks: Jump higher the more you have.
-- 2 = High Jump, Glides, Mermaid Kick, Dodge Roll.
-- First glide/superglide turns into glide, next into superglide and past that it gets faster.

stackAbilities = 2

-- Allow warping with SaveAnywhere
-- Warping at inopportune times can lead to crashes, audio bugs, softlocks or other issues with story progression
-- Use at your own responsibility
-- 0 = You can only warp from a save point
-- 1 = You can warp in normal, non-combat state. Should circuvment most issues
-- 2 = No restrictions

warpAnywhere = 0

-- HB2 unlocks EotW World Terminus warp
-- Allows skipping a large portion of End of the World
-- Still requires Navi Gummi as usual, so only speeds things up after necessary items have been found
-- 0 = Disabled
-- 1 = Enabled

eotWSkip = 1

-- Shop randomization
-- 0 = Vanilla shops
-- 1 = Shops can have anything but important key items
-- 2 = Shops can have anything, including extra out of logic key items

randomShops = 2

-- Unrandomize rewards
-- List the reward IDs from Rewards.lua that you want to unrandomize
-- List them in VanillaRewards and set them to true to keep it vanilla,
-- or false to put in a potion and keep the reward in the pool
-- For example, if you want to unrandomize Sephiroth and Unknown
-- VanillaRewards = {[150] = false, [152] = false}

vanillaRewards = {[150] = false, [152] = false}

-- Unrandomize chests
-- List the chest IDs from Chests.lua that you want to unrandomize
-- For example, if you want to unrandomize 100 acre wood chests
-- VanillaChests = {[168] = false, [169] = false, [170] = false, [171] = false}
-- However note that if the chest contains a reward, you should unrandomize that reward as well,
-- else whatever ends up on that reward will be inaccessible
-- So you should also include 77, 156, 78 in VanillaRewards set to false

vanillaChests = {}

-- Language for hints in Ansem's Reports
-- "auto" detects a supported language automatically
-- You can also manually define the language here
-- In that case, a txt file with the given name must exist, and translations will be read from there

hintLanguage = "auto"
