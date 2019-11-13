local addonName, bepgp = ...
local moduleName = addonName.."_loot"
local bepgp_loot = bepgp:NewModule(moduleName,"AceEvent-3.0","AceHook-3.0","AceTimer-3.0")
local ST = LibStub("ScrollingTable")
local LD = LibStub("LibDialog-1.0")
local C = LibStub("LibCrayon-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local GUI = LibStub("AceGUI-3.0")
local G = LibStub("LibGratuity-3.0")
local DF = LibStub("LibDeformat-3.0")

local data = { }
local colorSilver = {r=199/255, g=199/255, b=207/255, a=1.0}
local colorHidden = {r=0.0, g=0.0, b=0.0, a=0.0}
local colorHighlight = {r=0, g=0, b=0, a=.9}
local nop = function() end

local item_bind_patterns = {
  CRAFT = "("..USE_COLON..")",
  BOP = "("..ITEM_BIND_ON_PICKUP..")",
  QUEST = "("..ITEM_BIND_QUEST..")",
  BOU = "("..ITEM_BIND_ON_EQUIP..")",
  BOE = "("..ITEM_BIND_ON_USE..")",
  BOUND = "("..ITEM_SOULBOUND..")"
}
local loot_indices = {
  time=1,
  player=2,
  player_c=3,
  item=4,
  item_id=5,
  bind=6,
  price=7,
  off_price=8,
  action=9,
  update=10
}
local itemCache = {}
local function st_sorter_numeric(st,rowa,rowb,col)
  local cella = st.data[rowa].cols[7].value
  local cellb = st.data[rowb].cols[7].value
  return tonumber(cella) > tonumber(cellb)
end

function bepgp_loot:OnEnable()
  local container = GUI:Create("Window")
  container:SetTitle(L["BastionEPGP loot info"])
  container:SetWidth(555)
  container:SetHeight(320)
  container:EnableResize(false)
  container:SetLayout("Flow")
  container:Hide()
  self._container = container  
  local headers = {
    {["name"]=C:Orange(L["Time"]),["width"]=100,["comparesort"]=st_sorter_numeric,["sort"]=ST.SORT_DSC}, -- server time
    {["name"]=C:Orange(L["Item"]),["width"]=150,["comparesort"]=st_sorter_numeric}, -- item name
    {["name"]=C:Orange(L["Looter"]),["width"]=100,["comparesort"]=st_sorter_numeric}, -- looter
    {["name"]=C:Orange(L["Binds"]),["width"]=50,["comparesort"]=st_sorter_numeric}, -- binds
    {["name"]=C:Orange(L["GP Action"]),["width"]=100,["comparesort"]=st_sorter_numeric}, -- action
    --{["name"]="",["width"]=1,["comparesort"]=st_sorter_numeric,["sort"]=ST.SORT_DSC} -- order
  }
  self._loot_table = ST:CreateST(headers,15,nil,colorHighlight,container.frame) -- cols, numRows, rowHeight, highlight, parent
  self._loot_table.frame:SetPoint("BOTTOMRIGHT",self._container.frame,"BOTTOMRIGHT", -10, 10)
  container:SetCallback("OnShow", function() bepgp_loot._loot_table:Show() end)
  container:SetCallback("OnClose", function() bepgp_loot._loot_table:Hide() end)
  
  local clear = GUI:Create("Button")
  clear:SetAutoWidth(true)
  clear:SetText(L["Clear"])
  clear:SetCallback("OnClick",function()
    bepgp_loot:Clear()
  end)
  container:AddChild(clear)

  local export = GUI:Create("Button")
  export:SetAutoWidth(true)
  export:SetText(L["Export"])
  export:SetCallback("OnClick",function()
    local iof = bepgp:GetModule(addonName.."_io")
    if iof then
      iof:Loot(loot_indices)
    end
  end)
  container:AddChild(export)
  bepgp:make_escable(container,"add")
  LD:Register(addonName.."DialogItemPoints", bepgp:templateCache("DialogItemPoints"))

  -- loot awarded
  self:RegisterEvent("CHAT_MSG_LOOT","captureLoot")
  self:SecureHook("GiveMasterLoot")
  -- trade
  self:SecureHook("InitiateTrade","tradeUnit") -- we are trading
  self:RegisterEvent("TRADE_REQUEST","tradeName") -- another is trading
  self:SecureHookScript(TradeFrameTradeButton, "OnClick", "tradeItemAccept")
  -- bid call handlers
  self:RegisterEvent("LOOT_OPENED","clickHandlerLoot")
  self:clickHandlerMasterLoot()
  self:SecureHook("ToggleBag","clickHandlerBags") -- default bags
  self._bagsTimer = self:ScheduleTimer("hookBagAddons",30)
end

function bepgp_loot:Toggle()
  if self._container.frame:IsShown() then
    self._container:Hide()
  else
    self._container:Show()
  end
  self:Refresh()
end

function bepgp_loot:Refresh()
  table.wipe(data)
  for i,v in ipairs(bepgp.db.char.loot) do
    table.insert(data,{["cols"]={
      {["value"]=v[loot_indices.time],["color"]=colorSilver},
      {["value"]=v[loot_indices.item]},
      {["value"]=v[loot_indices.player_c]},
      {["value"]=v[loot_indices.bind]},
      {["value"]=v[loot_indices.action]},
      {["value"]=v[loot_indices.item_id]}, -- 6
      {["value"]=i,} -- 7
    }})
  end
  self._loot_table:SetData(data)  
  if self._loot_table and self._loot_table.showing then
    self._loot_table:SortData()
  end
end

function bepgp_loot:Clear()
  table.wipe(bepgp.db.char.loot)
  self:Refresh()
  bepgp:Print(L["Loot info cleared"])
end

function bepgp_loot:itemBinding(itemString)
  G:SetHyperlink(itemString)
  if G:Find(item_bind_patterns.CRAFT,2,4,nil,true) then
  else
    if G:Find(item_bind_patterns.BOP,2,4,nil,true) then
      return bepgp.VARS.bop
    elseif G:Find(item_bind_patterns.QUEST,2,4,nil,true) then
      return bepgp.VARS.bop
    elseif G:Find(item_bind_patterns.BOE,2,4,nil,true) then
      return bepgp.VARS.boe
    elseif G:Find(item_bind_patterns.BOU,2,4,nil,true) then
      return bepgp.VARS.boe
    else
      return bepgp.VARS.nobind
    end
  end
  return
end

function bepgp_loot:GiveMasterLoot(slot, index)
  if LootSlotHasItem(slot) then
    local icon, itemname, quantity, currencyID, quality, locked, isQuestItem, questId, isActive = GetLootSlotInfo(slot)
    if quantity == 1 and quality >= LE_ITEM_QUALITY_RARE then -- not a stack and rare or higher
      local itemLink = GetLootSlotLink(slot)
      local player = GetMasterLootCandidate(slot, index)
      if not (player and itemLink) then return end
      self:processLoot(player,itemLink,"masterloot")
    end
  end
end

-- /run BastionEPGP:GetModule("BastionEPGP_loot"):captureLoot("You receive loot: \124cffa335ee\124Hitem:16864:0:0:0:0:0:0:0:0\124h[Belt of Might]\124h\124r.")
-- /run BastionEPGP:GetModule("BastionEPGP_loot"):captureLoot("Jerv receives loot: \124cffa335ee\124Hitem:16846::::::::60:::::\124h[Giantstalker's Helmet]\124h\124r.")
-- /run BastionEPGP:GetModule("BastionEPGP_loot"):captureLoot("You receive loot: \124cffa335ee\124Hitem:16960::::::::60:::::\124h[Waistband of Wrath]\124h\124r.")
-- /run BastionEPGP:GetModule("BastionEPGP_loot"):captureLoot("You receive loot: \124cffa335ee\124Hitem:16857::::::::60:::::\124h[Lawbringer Bracers]\124h\124r.")
function bepgp_loot:captureLoot(message)
  if not self:raidLootAdmin() then return end
  local who,what,amount,player,itemLink
  who,what,amount = DF.Deformat(message,LOOT_ITEM_MULTIPLE)
  if (amount) then -- skip multiples / stacks
  else
    player, itemLink = DF.Deformat(message,LOOT_ITEM)
  end
  who,what,amount = bepgp._playerName, DF.Deformat(message,LOOT_ITEM_SELF_MULTIPLE)
  if (amount) then -- skip multiples / stacks
  else
    if not (player and itemLink) then
      player, itemLink = bepgp._playerName, DF.Deformat(message,LOOT_ITEM_SELF)
    end
  end
  if not (player and itemLink) then return end
  self:processLoot(player,itemLink,"chat")
end

function bepgp_loot:processLootDupe(player,itemName,source)
  local now = GetTime()
  local player_item = string.format("%s%s",player,itemName)
  if ((self._lastPlayerItem) and self._lastPlayerItem == player_item)
  and ((self._lastPlayerItemTime) and (now - self._lastPlayerItemTime) < 2)
  and ((self._lastPlayerItemSource) and self._lastPlayerItemSource ~= source) then
    return true, player_item, now
  end
  return false, player_item, now
end

function bepgp_loot:processLootCallback(player,itemLink,source,itemColor,itemString,itemName,itemID)
  itemCache[itemID] = true
  local dupe, player_item, now = self:processLootDupe(player,itemName,source)
  if dupe then
    return
  end
  local bind = self:itemBinding(itemString)
  if not (bind) then return end
  local price = bepgp:GetPrice(itemString, bepgp.db.profile.progress)
  if (not (price)) or (price == 0) then
    return
  end
  local class,_
  if player == bepgp._playerName then 
    class = UnitClass("player") -- localized
  else
    _, class = bepgp:verifyGuildMember(player,true) -- localized
  end
  if not (class) then return end
  local _,_,hexclass = bepgp:getClassData(class)
  self._lastPlayerItem, self._lastPlayerItemTime, self._lastPlayerItemSource = player_item, now, source
  local player_color = C:Colorize(hexclass,player)
  local off_price = math.floor(price*bepgp.db.profile.discount)
  local epoch, timestamp = bepgp:getServerTime()
  local data = {[loot_indices.time]=timestamp,[loot_indices.player]=player,[loot_indices.player_c]=player_color,[loot_indices.item]=itemLink,[loot_indices.item_id]=itemID,[loot_indices.bind]=bind,[loot_indices.price]=price,[loot_indices.off_price]=off_price,loot_indices=loot_indices}
  LD:Spawn(addonName.."DialogItemPoints", data)
end

function bepgp_loot:processLoot(player,itemLink,source)
  local itemColor, itemString, itemName, itemID = bepgp:getItemData(itemLink)
  if itemName then
    if itemCache[itemID] then
      self:processLootCallback(player,itemLink,source,itemColor,itemString,itemName,itemID)
    else
      local item = Item:CreateFromItemID(itemID)
      item:ContinueOnItemLoad(function()
        bepgp_loot:processLootCallback(player,itemLink,source,itemColor,itemString,itemName,itemID)
      end)
    end
  end
end

-- /run local _,link = GetItemInfo(16857)local data=BastionEPGP:GetModule("BastionEPGP_loot"):findLootUnassigned(link)print(data[8] or "nodata")
function bepgp_loot:findLootUnassigned(itemID)
  for i,data in ipairs(bepgp.db.char.loot) do
    if data[loot_indices.item_id] == itemID and data[loot_indices.action] == bepgp.VARS.unassigned then
      return data
    end
  end
end

function bepgp_loot:addOrUpdateLoot(data,update)
  if not (update) then
    table.insert(bepgp.db.char.loot,data)
  end
  self:Refresh()
end

function bepgp_loot:tradeLootCallback(tradeTarget,itemColor,itemString,itemName,itemID,itemLink)
  itemCache[itemID] = true
  local price = bepgp:GetPrice(itemString, bepgp.db.profile.progress)
  if not (price) or price == 0 then
    return
  end
  local bind = self:itemBinding(itemString)
  if (not bind) or (bind ~= bepgp.VARS.boe) then return end
  local _, class = bepgp:verifyGuildMember(tradeTarget,true)
  if not class then return end
  local _,_,hexclass = bepgp:getClassData(class)
  local target_color = C:Colorize(hexclass,tradeTarget)
  local epoch, timestamp = bepgp:getServerTime()
  local data = self:findLootUnassigned(itemLink)
  if (data) then
    data[loot_indices.time] = timestamp
    data[loot_indices.player] = tradeTarget
    data[loot_indices.player_c] = target_color
    data["loot_indices"] = loot_indices
    data[loot_indices.update] = 1
    LD:Spawn(addonName.."DialogItemPoints", data)
  end
end

function bepgp_loot:raidLootAdmin()
  return (bepgp:GroupStatus()=="RAID" and bepgp:lootMaster() and bepgp:admin())
end

function bepgp_loot:tradeLoot()
  if self._tradeTarget and self._itemLink then
    local tradeTarget, itemLink = self._tradeTarget, self._itemLink
    local itemColor, itemString, itemName, itemID = bepgp:getItemData(itemLink)
    if (itemName) then
      if itemCache[itemID] then
        self:tradeLootCallback(tradeTarget,itemColor,itemString,itemName,itemID,itemLink)
      else
        local item = Item:CreateFromItemID(itemID)
        item:ContinueOnItemLoad(function()
          bepgp_loot:tradeLootCallback(tradeTarget,itemColor,itemString,itemName,itemID,itemLink)
        end)
      end       
    end
  end
  self:tradeReset()
end
function bepgp_loot:tradeUnit(unit)
  if self:raidLootAdmin() then
    self._tradeTarget = GetUnitName(unit)
  end
end
function bepgp_loot:tradeName(event, name)
  if self:raidLootAdmin() then
    local name = Ambiguate(name,"short")
    self._tradeTarget = name
  end
end
function bepgp_loot:tradeItemAccept()
  if self:raidLootAdmin() then
    if self._tradeTarget then
      local itemLink
      for id=1,MAX_TRADABLE_ITEMS do
        itemLink = GetTradePlayerItemLink(id)
        if (itemLink) then
          self._itemLink = itemLink
          self:RegisterEvent("TRADE_REQUEST_CANCEL","tradeReset")
          self:RegisterEvent("TRADE_CLOSED","awaitTradeLoot")        
          return  
        end
      end
      self._itemLink = nil
    end    
  end
end
function bepgp_loot:awaitTradeLoot() -- TRADE_CLOSED
  self._awaitTradeTimer = self:ScheduleTimer("tradeLoot",2)
end
function bepgp_loot:tradeReset() -- TRADE_REQUEST_CANCEL
  self._tradeTarget = nil
  self._itemLink = nil  
  if self._awaitTradeTimer then
    self:CancelTimer(self._awaitTradeTimer)
    self._awaitTradeTimer = nil
  end
  self:UnregisterEvent("TRADE_REQUEST_CANCEL")
  self:UnregisterEvent("TRADE_CLOSED")
end

function bepgp_loot:bidCall(frame, button)
  if not IsAltKeyDown() then return end
  if not self:raidLootAdmin() then return end
  local slot = frame.slot -- lootframe/MasterLooterFrame
  local hasItem = frame.hasItem -- default bags & Bagnon
  local bagID, slotID = frame.bagID, frame.slotID -- cargBags_Nivaya
  if not (slot or hasItem or (bagID and slotID)) then return end
  local itemLink
  if hasItem then
    local bag, slot = frame:GetParent():GetID(), frame:GetID() -- get from ItemButton (default bags, Bagnon, BaudManifest, tdBag2)
    itemLink = GetContainerItemLink(bag, slot)
    if not itemLink then 
      itemLink = frame.itemLink -- AdiBags
    end
    if not itemLink then -- ArkInventory
      if frame.ARK_Data then
        local bag, slot = frame.ARK_Data.blizzard_id, frame.ARK_Data.slot_id
        if bag and slot then
          itemLink = GetContainerItemLink(bag, slot)
        end
      end
    end
  elseif slot then
    if not LootSlotHasItem(slot) then return end
    itemLink = GetLootSlotLink(slot)
  elseif bagID and slotID then
    itemLink = GetContainerItemLink(bagID, slotID) -- cargBags_Nivaya
  end
  if not itemLink then return end
  local itemColor, itemString, itemName, itemID = bepgp:getItemData(itemLink)
  local price = bepgp:GetPrice(itemString)
  if (not (price)) or (price == 0) then
    return
  end
  if button == "LeftButton" then
    bepgp:widestAudience(string.format(L["Whisper %s a + for %s (mainspec)"],bepgp._playerName,itemLink))
  elseif button == "RightButton" then
    bepgp:widestAudience(string.format(L["Whisper %s a - for %s (offspec)"],bepgp._playerName,itemLink))
  elseif button == "MiddleButton" then
    bepgp:widestAudience(string.format(L["Whisper %s a + or - for %s (mainspec or offspec)"],bepgp._playerName,itemLink))
  end
end

local bag_addons = {
  ["Bagnon"] = false,
  ["Combuctor"] = false,
  ["AdiBags"] = false,
  ["ArkInventory"] = false,
  ["cargBags_Nivaya"] = false,
  ["tdBag2"] = false,
}
function bepgp_loot:hookBagAddons()
  for k,v in pairs(bag_addons) do
    if IsAddOnLoaded(k) and v == false then
      self:clickHandlerBags(k)
      break
    end
  end
end

function bepgp_loot:hookContainerButton(itemButton)
  if itemButton and not itemButton._bepgpclicks then
    if type(itemButton:GetScript("OnClick")) == "function" then
      itemButton:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp")
      itemButton.RegisterForClicks = nop
      if not self:IsHooked(itemButton,"OnClick") then
        self:SecureHookScript(itemButton,"OnClick", "bidCall")
      end
      itemButton._bepgpclicks = true
    end
  end
end

-- /run BastionEPGP:GetModule("BastionEPGP_loot"):clickHandlerBags()
function bepgp_loot:clickHandlerBags(id)
  if tonumber(id) then -- default bags
    for b = BACKPACK_CONTAINER,NUM_BAG_FRAMES do
      local containerName = "ContainerFrame"..(b+1)
      local numslots = GetContainerNumSlots(b)
      if numslots > 0 then
        for i = 1,numslots do
          local itemButton = _G[containerName.."Item"..i]
          self:hookContainerButton(itemButton)
        end
      end
    end
  else
    local addon = id
    if addon == "Bagnon" or addon == "Combuctor" then
      for b = BACKPACK_CONTAINER,NUM_BAG_FRAMES do
        local containerName = "ContainerFrame"..(b+1)
        for i = 1, MAX_CONTAINER_ITEMS do
          local itemButton = _G[containerName.."Item"..i]
          self:hookContainerButton(itemButton)
        end
      end
      bag_addons[addon] = true
    elseif addon == "tdBag2" then
      for b = 1, NUM_CONTAINER_FRAMES do
        local containerName = "ContainerFrame"..b
        for i = 1, MAX_CONTAINER_ITEMS do
          local itemButton = _G[containerName.."Item"..i]
          self:hookContainerButton(itemButton)
        end
      end
      bag_addons[addon] = true
    elseif addon == "AdiBags" then
      for i = 1, 160 do
        local itemButton = _G["AdiBagsItemButton"..i]
        self:hookContainerButton(itemButton)
      end
      bag_addons[addon] = true
    elseif addon == "ArkInventory" then
      for i=1,NUM_CONTAINER_FRAMES do
        for j=1,MAX_CONTAINER_ITEMS do
          local itemButton = _G["ARKINV_Frame1ScrollContainerBag"..i.."Item"..j]
          self:hookContainerButton(itemButton)
        end
      end
      bag_addons[addon] = true
    elseif addon == "cargBags_Nivaya" then
      local slotcount = 0
      for bagID = -3, 11, 1 do
        local slots = GetContainerNumSlots(bagID)
        for slot=1, slots do
          slotcount = slotcount + 1
          if BACKPACK_CONTAINER <= bagID or bagID <= NUM_BAG_FRAMES then
            local itemButton = _G["NivayaSlot"..slotcount]
            self:hookContainerButton(itemButton)
          end
        end
      end
      bag_addons[addon] = true
    end
  end
end

function bepgp_loot:clickHandlerMasterLoot()
  MasterLooterFrame.Item:EnableMouse(true)
  MasterLooterFrame.Item:SetScript("OnMouseUp", function(self,button)
    local frame = self
    frame.slot = LootFrame.selectedSlot
    if frame.slot then
      bepgp_loot:bidCall(frame, button)
    end
  end)
  MasterLooterFrame.Item:SetScript("OnEnter", function(self)
    local slot = LootFrame.selectedSlot
    if slot then
      GameTooltip:SetOwner(self,"ANCHOR_TOP")
      GameTooltip:SetLootItem(slot)
      GameTooltip:Show()
    end
  end)
  MasterLooterFrame.Item:SetScript("OnLeave", function(self)
    if GameTooltip:IsOwned(self) then
      GameTooltip_Hide()
    end
  end)
end

function bepgp_loot:clickHandlerLoot()
  for i=1,GetNumLootItems() do
    local button = _G["LootButton"..i]
    if button and not button._bepgpclicks then
      button:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp")
      button.RegisterForClicks = nop
      if not self:IsHooked(button,"OnClick") then
        self:HookScript(button,"OnClick", "bidCall")
      end
      button._bepgpclicks = true
    end
  end
end

