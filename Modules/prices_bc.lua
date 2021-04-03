local addonName, bepgp = ...
local moduleName = addonName.."_prices_bc"
local bepgp_prices_bc = bepgp:NewModule(moduleName, "AceEvent-3.0")
local ST = LibStub("ScrollingTable")
local name_version = "BastionEPGPFixed_bc-1.0"
local prices = {}

--[[TODO
Compile lists by
- armor class
- role
- class/spec
- droprate
- itempower
]]

-- Karazhan (IL115-125)
--- Trash
prices[30643] = {1, "T4"} -- Belt of the tracker (Mail - caster)
prices[30641] = {1, "T4"} -- Boots of Elusion (Plate - tank)
prices[30642] = {1, "T4"} -- Drape of the Righteous (Cloth - Holy dmg)
prices[30668] = {1, "T4"} -- Grasp of the Dead (Cloth - Frost dmg)
prices[30644] = {1, "T4"} -- Grips of Deftness (Leather - melee dps)
prices[30673] = {1, "T4"} -- Inferno Waist Cord (Cloth - Fire dmg)
prices[30667] = {1, "T4"} -- Ring of Unrelenting Storms (Nature dmg)
prices[30666] = {1, "T4"} -- Ritssyn's Lost Pendant (Shadow dmg)
prices[30674] = {1, "T4"} -- Zierhut's Lost Treads (Leather - tank)
--- Attumen
prices[28453] = {1, "T4"} -- Bracers of the White Stag (Leather - caster)
prices[30480] = {0, "T4"} -- Fiery Warhorse's Reins (mount)
prices[28505] = {1, "T4"} -- Gauntlets of Renewed Hope (Plate - heal)
prices[28506] = {1, "T4"} -- Gloves of Dexterous Manipulation (Leather - melee dps)
prices[28508] = {1, "T4"} -- Gloves of Saintly Blessings (Cloth - heal)
prices[28507] = {1, "T4"} -- Handwraps of Flowing Thought (Cloth - caster)
prices[28477] = {1, "T4"} -- Harbinger Bands (Cloth - caster)
prices[28510] = {1, "T4"} -- Spectral Band of Innervation (caster)
prices[28454] = {1, "T4"} -- Stalker's War Bands (Mail - physical)
prices[28504] = {1, "T4"} -- Steelhawk Crossbow (xbow - physical)
prices[28502] = {1, "T4"} -- Vambraces of Courage (plate - tank)
prices[28503] = {1, "T4"} -- Whirlwind Bracers (mail - heal)
prices[28509] = {1, "T4"} -- Worgen Claw Necklace (physical)
--- Moroes
prices[28567] = {1, "T4"} -- Belt of Gale Force (Mail - heal)
prices[28569] = {1, "T4"} -- Boots of Valiance (Plate - heal)
prices[28530] = {1, "T4"} -- Brooch of Unquenchable Fury (caster)
prices[28566] = {1, "T4"} -- Crimson Girdle of the Indomitable (Plate - tank)
prices[28545] = {1, "T4"} -- Edgewalker Longboots (Leather - melee dps)
prices[28524] = {1, "T4"} -- Emerald Ripper (physical)
prices[28568] = {1, "T4"} -- Idol of the Avian Heart (Druid - heal)
prices[28528] = {1, "T4"} -- Moroes' Lucky Pocket Watch (tank)
prices[28565] = {1, "T4"} -- Nethershard Girdle (Cloth - caster)
prices[28529] = {1, "T4"} -- Royal Cloak of Arathi Kings (Cloth - melee dps)
prices[28570] = {1, "T4"} -- Shadow-Cloak of Dalaran (Cloth - caster)
prices[28525] = {1, "T4"} -- Signet of Unshakable Faith (heal)
--- Maiden of Virtue
prices[28511] = {1, "T4"} -- Bands of Indwelling (Cloth - heal)
prices[28515] = {1, "T4"} -- Bands of Nefarious Deeds (Cloth - caster)
prices[28516] = {1, "T4"} -- Barbed Choker of Discipline (tank)
prices[28517] = {1, "T4"} -- Boots of Foretelling (Cloth - caster)
prices[28512] = {1, "T4"} -- Bracers of Justice (Plate - heal)
prices[28514] = {1, "T4"} -- Bracers of Maliciousness (Leather - melee dps)
prices[28520] = {1, "T4"} -- Gloves of Centering (Mail - heal)
prices[28519] = {1, "T4"} -- Gloves of Quickening (Mail - Caster)
prices[28518] = {1, "T4"} -- Iron Gauntlets of the Maiden (Plate - tank)
prices[28521] = {1, "T4"} -- Mitts of the Treemender (Leather - heal)
prices[28522] = {1, "T4"} -- Shard of the Virtuous (Mace - heal)
prices[28523] = {1, "T4"} -- Totem of Healing Rains (Shaman - heal)
--- Opera Event
---- Crone
prices[28588] = {1, "T4"} -- Blue Diamond Witchwand (heal)
prices[28587] = {1, "T4"} -- Legacy (2H Axe - physical)
prices[28585] = {1, "T4"} -- Ruby Slippers (Cloth - caster - hearthstone)
prices[28586] = {1, "T4"} -- Wicked Witch's Hat (Cloth - caster)
---- Wolf
prices[28583] = {1, "T4"} -- Big Bad Wolf's Head (Mail - caster)
prices[28584] = {1, "T4"} -- Big Bad Wolf's Paw (physical)
prices[28582] = {1, "T4"} -- Red Riding Hood's Cloak (Cloth - heal)
prices[28581] = {1, "T4"} -- Wolfslayer Sniper Rifle (Hunter)
---- Romulo & Juliane
prices[28572] = {1, "T4"} -- Blade of the Unrequited (physical)
prices[28573] = {1, "T4"} -- Despair (melee dps)
prices[28578] = {1, "T4"} -- Masquerade Gown (Cloth - heal)
prices[28579] = {1, "T4"} -- Romulo's Poison Vial (physical)
---- Shared
prices[28589] = {1, "T4"} -- Beastmaw Pauldrons (Mail - dps)
prices[28591] = {1, "T4"} -- Earthsoul Leggings (Leather - heal)
prices[28593] = {1, "T4"} -- Eternium Greathelm (Plate - tank)
prices[28592] = {1, "T4"} -- Libram of Souls Redeemed (Paladin - heal)
prices[28590] = {1, "T4"} -- Ribbon of Sacrifice (heal)
prices[28594] = {1, "T4"} -- Trial-Fire Trousers (Cloth - caster)
--- Curator
prices[28631] = {1, "T4"} -- Dragon-Quake Shoulderguards (Mail - heal)
prices[28647] = {1, "T4"} -- Forest Wind Shoulderpads (Leather - heal)
prices[28649] = {1, "T4"} -- Garona's Signet Ring (physical)
prices[28612] = {1, "T4"} -- Pauldrons of the Solace-Giver (Cloth - heal)
prices[28633] = {1, "T4"} -- Staff of Infinite Mysteries (caster)
prices[28621] = {1, "T4"} -- Wrynn Dynasty Greaves (Plate - tank)
prices[29757] = {1, "T4"} -- Gloves of the Fallen Champion (T4 Gloves shaman/rogue/pala)
prices[29032] = {1, "T4"} -- Shaman T4 Gloves
prices[29034] = {1, "T4"} -- Shaman
prices[29039] = {1, "T4"} -- Shaman
prices[29048] = {1, "T4"} -- Rogue T4 Gloves
prices[29065] = {1, "T4"} -- Paladin T4 Gloves
prices[29067] = {1, "T4"} -- Paladin
prices[29072] = {1, "T4"} -- Paladin
prices[29758] = {1, "T4"} -- Gloves of the Fallen Defender (T4 Gloves warrior/priest/druid)
prices[29017] = {1, "T4"} -- Warrior T4 Gloves
prices[29020] = {1, "T4"} --
prices[29055] = {1, "T4"} -- Priest T4 Gloves
prices[29057] = {1, "T4"} --
prices[29090] = {1, "T4"} -- Druid T4 Gloves
prices[29092] = {1, "T4"} --
prices[29097] = {1, "T4"} --
prices[29756] = {1, "T4"} -- Gloves of the Fallen Hero (T4 Gloves hunter/mage/warlock)
prices[28968] = {1, "T4"} -- Warlock T4 Gloves
prices[29080] = {1, "T4"} -- Mage T4 Gloves
prices[29085] = {1, "T4"} -- Hunter T4 Gloves
--- Illhoof
prices[28662] = {1, "T4"} -- Breastplate of the Lightbinder (Plate - heal)
prices[28652] = {1, "T4"} -- Cincture of Will (Cloth - heal)
prices[28655] = {1, "T4"} -- Cord of Nature's Sustenance (Leather - heal)
prices[28657] = {1, "T4"} -- Fool's Bane (physical)
prices[28660] = {1, "T4"} -- Gilded Thorium Cloak (Bear > Tank)
prices[28656] = {1, "T4"} -- Girdle of the Prowler (Mail - physical)
prices[28654] = {1, "T4"} -- Malefic Girdle (Cloth - caster)
prices[28661] = {1, "T4"} -- Mender's Heart-Ring (heal)
prices[28653] = {1, "T4"} -- Shadowvine Cloak of Infusion (heal)
prices[28658] = {1, "T4"} -- Terestian's Stranglestaff (druid)
prices[28785] = {1, "T4"} -- The Lightning Capacitor (caster)
prices[28659] = {1, "T4"} -- Xavian Stiletto (melee)
--- Aran
prices[28728] = {1, "T4"} -- Aran's Soothing Sapphire (heal)
prices[28663] = {1, "T4"} -- Boots of the Incorrupt (Cloth - heal)
prices[28670] = {1, "T4"} -- Boots of the Infernal Coven (Cloth - caster)
prices[28672] = {1, "T4"} -- Drape of the Dark Reavers (Cloth - physical)
prices[28726] = {1, "T4"} -- Mantle of the Mind Flayer (Cloth - heal)
prices[28666] = {1, "T4"} -- Pauldrons of the Justice-Seeker (Plate - heal)
prices[28727] = {1, "T4"} -- Pendant of the Violet Eye (heal > caster)
prices[28669] = {1, "T4"} -- Rapscallion Boots (Leather - physical)
prices[28674] = {1, "T4"} -- Saberclaw Talisman (physical)
prices[28675] = {1, "T4"} -- Shermanar Great-Ring (Bear > Tank)
prices[28671] = {1, "T4"} -- Steelspine Faceguard (Mail - physical)
prices[28673] = {1, "T4"} -- Tirisfal Wand of Ascendancy (caster)
--- Chess
prices[28747] = {1, "T4"} -- Battlescar Boots (Plate - tank)
prices[28755] = {1, "T4"} -- Bladed Shoulderpads of the Merciless (Leather - physical)
prices[28746] = {1, "T4"} -- Fiend Slayer Boots (Mail - physical)
prices[28752] = {1, "T4"} -- Forestlord Striders (Leather - heal)
prices[28750] = {1, "T4"} -- Girdle of Treachery (Leather - physical)
prices[28756] = {1, "T4"} -- Headdress of the High Potentate (Cloth - heal)
prices[28751] = {1, "T4"} -- Heart-Flame Leggings (Mail - heal)
prices[28749] = {1, "T4"} -- King's Defender (Tank)
prices[28748] = {1, "T4"} -- Legplates of the Innocent (Plate - heal)
prices[28745] = {1, "T4"} -- Mithril Chain of Heroism (melee)
prices[28753] = {1, "T4"} -- Ring of Recurrence (caster)
prices[28754] = {1, "T4"} -- Triptych Shield of the Ancients (heal)
--- Netherspite
prices[28732] = {1, "T4"} -- Cowl of Defiance (Leather - physical)
prices[28735] = {1, "T4"} -- Earthblood Chestguard (Mail - heal)
prices[28733] = {1, "T4"} -- Girdle of Truth (Plate - heal)
prices[28734] = {1, "T4"} -- Jewel of Infinite Possibilities (caster)
prices[28743] = {1, "T4"} -- Mantle of Abrahmis (Plate - tank)
prices[28730] = {1, "T4"} -- Mithril Band of the Unscarred (melee)
prices[28742] = {1, "T4"} -- Pantaloons of Repentance (Cloth - heal)
prices[28740] = {1, "T4"} -- Rip-Flayer Leggings (Mail - physical)
prices[28731] = {1, "T4"} -- Shining Chain of the Afterworld (heal)
prices[28741] = {1, "T4"} -- Skulker's Greaves (Leather - physical)
prices[28729] = {1, "T4"} -- Spiteblade (physical)
prices[28744] = {1, "T4"} -- Uni-Mind Headdress (Cloth - caster)
--- Prince
prices[28762] = {1, "T4"} -- Adornment of Stolen Souls (caster)
prices[28764] = {1, "T4"} -- Farstrider Wildercloak (physical)
prices[28773] = {1, "T4"} -- Gorehowl (melee)
prices[28763] = {1, "T4"} -- Jade Ring of the Everliving (heal)
prices[28771] = {1, "T4"} -- Light's Justice (heal)
prices[28768] = {1, "T4"} -- Malchazeen (physical)
prices[28770] = {1, "T4"} -- Nathrezim Mindblade (caster)
prices[28757] = {1, "T4"} -- Ring of a Thousand Marks (physical)
prices[28766] = {1, "T4"} -- Ruby Drape of the Mysticant (caster)
prices[28765] = {1, "T4"} -- Stainless Cloak of the Pure Hearted (Cloth - heal)
prices[28772] = {1, "T4"} -- Sunfury Bow of the Phoenix (Hunter > physical)
prices[28767] = {1, "T4"} -- The Decapitator (melee)
prices[29760] = {1, "T4"} -- Helm of the Fallen Champion (T4 Head - pala/rogue/shaman)
prices[29028] = {1, "T4"} -- Shaman T4 Head
prices[29035] = {1, "T4"} --
prices[29040] = {1, "T4"} --
prices[29044] = {1, "T4"} -- Rogue T4 Head
prices[29061] = {1, "T4"} -- Paladin T4 Head
prices[29068] = {1, "T4"} --
prices[29073] = {1, "T4"} --
prices[29761] = {1, "T4"} -- Helm of the Fallen Defender (T4 Head - warrior/priest/druid)
prices[29011] = {1, "T4"} -- Warrior T4 Head
prices[29021] = {1, "T4"} --
prices[29049] = {1, "T4"} -- Priest T4 Head
prices[29058] = {1, "T4"} --
prices[29086] = {1, "T4"} -- Druid T4 Head
prices[29093] = {1, "T4"} --
prices[29098] = {1, "T4"} --
prices[29759] = {1, "T4"} -- Helm of the Fallen Hero (T4 Head - hunter/mage/warlock)
prices[28963] = {1, "T4"} -- Warlock T4 Head
prices[29076] = {1, "T4"} -- Mage T4 Head
prices[29081] = {1, "T4"} -- Hunter T4 Head
--- Nightbane
prices[28601] = {1, "T4"} -- Chestguard of the Conniver (Leather - physical)
prices[28611] = {1, "T4"} -- Dragonheart Flameshield (caster)
prices[28609] = {1, "T4"} -- Emberspur Talisman (heal)
prices[28610] = {1, "T4"} -- Ferocious Swift-Kickers (Mail - physical)
prices[28608] = {1, "T4"} -- Ironstriders of Urgency (Plate - melee)
prices[28604] = {1, "T4"} -- Nightstaff of the Everliving (heal)
prices[28597] = {1, "T4"} -- Panzar'Thar Breastplate (Plate - tank)
prices[28602] = {1, "T4"} -- Robe of the Elder Scribes (Cloth - caster)
prices[28599] = {1, "T4"} -- Scaled Breastplate of Carnage (Mail - physical)
prices[28606] = {1, "T4"} -- Shield of Impenetrable Darkness (tank)
prices[28600] = {1, "T4"} -- Stonebough Jerkin (Leather - heal)
prices[28603] = {1, "T4"} -- Talisman of Nightbane (caster)

-- Magtheridon (IL125)
-- Gruul's (IL125)

-- SSC (IL128-134)

-- EyE (IL128-134)

-- BT (IL141)

-- Hyjal (IL141)

-- ZA (IL133-138)

-- Sunwell (IL154-159)

bepgp_prices_bc._prices_bc = prices