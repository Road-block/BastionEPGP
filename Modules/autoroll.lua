local addonName, bepgp = ...
local moduleName = addonName.."_autoroll"
local bepgp_autoroll = bepgp:NewModule(moduleName, "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local GUI = LibStub("AceGUI-3.0")
--[[
inject options for auto rolling need/greed/pass/ignore
ZG: hakkari coin / hakkari bijou
AQ20: scarabs / idols
AQ40:
instance greens
]]
-- ZG 0=pass, 1=need, 2=greed
local autoroll = {
-- ZG coin
  [19698] = 1, --zulian
  [19699] = 1, --razzashi
  [19700] = 1, --hakkari -- turnin 1
  [19701] = 1, --gurubashi
  [19702] = 1, --vilebranch
  [19703] = 1, --witherbark -- turnin 2
  [19704] = 1, --sandfury
  [19705] = 1, --skullsplitter
  [19706] = 1, --bloodscalp -- turnin 3
-- ZG bijou
  [19707] = 1, --red
  [19708] = 1, --blue
  [19709] = 1, --yellow
  [19710] = 1, --orange
  [19711] = 1, --green
  [19712] = 1, --purple
  [19713] = 1, --bronze
  [19714] = 1, --silver
  [19715] = 1, --gold
-- AQ scarabs
  [20858] = 1, --stone
  [20859] = 1, --gold
  [20860] = 1, --silver
  [20861] = 1, --bronze
  [20862] = 1, --crystal
  [20863] = 1, --clay
  [20864] = 1, --bone
  [20865] = 1, --ivory
-- AQ20 idols
  [20866] = {["HUNTER"]=1,["ROGUE"]=1,["MAGE"]=1}, --azure
  [20867] = {["WARRIOR"]=1,["ROGUE"]=1,["WARLOCK"]=1}, --onyx
  [20868] = {["WARRIOR"]=1,["HUNTER"]=1,["PRIEST"]=1}, --lambent
  [20869] = {["PALADIN"]=1,["HUNTER"]=1,["SHAMAN"]=1,["WARLOCK"]=1}, --amber
  [20870] = {["PRIEST"]=1,["WARLOCK"]=1,["DRUID"]=1}, --jasper
  [20871] = {["PALADIN"]=1,["PRIEST"]=1,["SHAMAN"]=1,["MAGE"]=1}, --obsidian
  [20872] = {["PALADIN"]=1,["ROGUE"]=1,["SHAMAN"]=1,["DRUID"]=1}, --vermillion
  [20873] = {["WARRIOR"]=1,["MAGE"]=1,["DRUID"]=1}, --alabaster
-- AQ40 idols
  [20874] = {["WARRIOR"]=1,["HUNTER"]=1,["ROGUE"]=1,["MAGE"]=1}, --sun
  [20875] = {["WARRIOR"]=1,["ROGUE"]=1,["MAGE"]=1,["WARLOCK"]=1}, --night
  [20876] = {["WARRIOR"]=1,["PRIEST"]=1,["MAGE"]=1,["WARLOCK"]=1}, --death
  [20877] = {["PALADIN"]=1,["PRIEST"]=1,["SHAMAN"]=1,["MAGE"]=1,["WARLOCK"]=1}, --sage
  [20878] = {["PALADIN"]=1,["PRIEST"]=1,["SHAMAN"]=1,["WARLOCK"]=1,["DRUID"]=1}, --rebirth
  [20879] = {["PALADIN"]=1,["HUNTER"]=1,["PRIEST"]=1,["SHAMAN"]=1,["DRUID"]=1}, --life
  [20881] = {["PALADIN"]=1,["HUNTER"]=1,["ROGUE"]=1,["SHAMAN"]=1,["DRUID"]=1}, --strife
  [20882] = {["WARRIOR"]=1,["HUNTER"]=1,["ROGUE"]=1,["DRUID"]=1}, --war
}

function bepgp_autoroll:getAction(itemID,action)
  return (action[self._playerClass]) or 2 -- need my class, greed the rest
end

function bepgp_autoroll:Roll(event, rollID, rollTime, lootHandle)
  local texture, name, count, quality, bindOnPickUp, canNeed, canGreed = GetLootRollItemInfo(rollID)
  if (name) and (canNeed or canGreed) then
    local link = GetLootRollItemLink(rollID)
    local _, _, _, itemID = bepgp:getItemData(link)
    local action = autoroll[itemID]
    if (action) then
      if type(action)=="number" then
        RollOnLoot(rollID,action)
      elseif type(action)=="table" then
        action = self:getAction(itemID,action)
        if action then
          RollOnLoot(rollID,action)
        end
      end
    end
  end
end

function bepgp_autoroll:delayInit()
  self:RegisterEvent("START_LOOT_ROLL","Roll")
  local _
  _, self._playerClass = UnitClass("player")
  self._initDone = true
end

function bepgp_autoroll:CoreInit()
  if not self._initDone then
    self:delayInit()
  end
end

function bepgp_autoroll:OnEnable()
  self:RegisterMessage(addonName.."_INIT_DONE","CoreInit")
  self:delayInit()
end