local addonName, bepgp = ...
local moduleName = addonName.."_standings"
local bepgp_standings = bepgp:NewModule(moduleName)
local ST = LibStub("ScrollingTable")
local C = LibStub("LibCrayon-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local GUI = LibStub("AceGUI-3.0")
local LW = LibStub("LibWindow-1.1")

local PLATE, MAIL, LEATHER, CLOTH = 4,3,2,1
local DPS, CASTER, HEALER, TANK = 4,3,2,1
local class_to_armor = {
  PALADIN = PLATE,
  WARRIOR = PLATE,
  HUNTER = MAIL,
  SHAMAN = MAIL,
  DRUID = LEATHER,
  ROGUE = LEATHER,
  MAGE = CLOTH,
  PRIEST = CLOTH,
  WARLOCK = CLOTH,
}
local armor_text = {
  [CLOTH] = L["CLOTH"],
  [LEATHER] = L["LEATHER"],
  [MAIL] = L["MAIL"],
  [PLATE] = L["PLATE"],
}
local class_to_role = {
  PALADIN = {HEALER,DPS,TANK,CASTER},
  PRIEST = {HEALER,CASTER},
  DRUID = {HEALER,TANK,DPS,CASTER},
  SHAMAN = {HEALER,DPS,CASTER},
  MAGE = {CASTER},
  WARLOCK = {CASTER},
  ROGUE = {DPS},
  HUNTER = {DPS},
  WARRIOR = {TANK,DPS},
}
local role_text = {
  [TANK] = L["TANK"],
  [HEALER] = L["HEALER"],
  [CASTER] = L["CASTER"],
  [DPS] = L["PHYS DPS"],
}
local data = { }
local colorHighlight = {r=0, g=0, b=0, a=.9}

local function st_sorter_numeric(st,rowa,rowb,col)
  local cella = st.data[rowa].cols[col].value
  local cellb = st.data[rowb].cols[col].value
  local sort = st.cols[col].sort or st.cols[col].defaultsort
  if bepgp.db.char.classgroup then
    local classa = st.data[rowa].cols[5].value
    local classb = st.data[rowb].cols[5].value
    if classa == classb then
      if cella == cellb then
        local sortnext = st.cols[col].sortnext
        if sortnext then
          return st.data[rowa].cols[sortnext].value < st.data[rowb].cols[sortnext].value
        end
      else
        return tonumber(cella) > tonumber(cellb)
      end      
    else
      if sort == ST.SORT_DSC then
        return classa < classb
      else
        return classa > classb
      end
    end
  else
    if cella == cellb then
      local sortnext = st.cols[col].sortnext
      if sortnext then
        return st.data[rowa].cols[sortnext].value < st.data[rowb].cols[sortnext].value
      end
    else
      if sort == ST.SORT_DSC then
        return tonumber(cella) > tonumber(cellb)
      else
        return tonumber(cella) < tonumber(cellb)
      end
    end
  end
end

function bepgp_standings:OnEnable()
  local container = GUI:Create("Window")
  container:SetTitle(L["BastionEPGP standings"])
  container:SetWidth(430)
  container:SetHeight(290)
  container:EnableResize(false)
  container:SetLayout("List")
  container:Hide()
  self._container = container
  local headers = {
    {["name"]=C:Orange(_G.NAME),["width"]=100}, --name
    {["name"]=C:Orange(L["ep"]:upper()),["width"]=50,["comparesort"]=st_sorter_numeric}, --ep
    {["name"]=C:Orange(L["gp"]:upper()),["width"]=50,["comparesort"]=st_sorter_numeric}, --gp
    {["name"]=C:Orange(L["pr"]:upper()),["width"]=50,["comparesort"]=st_sorter_numeric,["sortnext"]=1,["sort"]=ST.SORT_DSC}, --pr
  }
  self._standings_table = ST:CreateST(headers,15,nil,colorHighlight,container.frame) -- cols, numRows, rowHeight, highlight, parent
  self._standings_table.frame:SetPoint("BOTTOMRIGHT",self._container.frame,"BOTTOMRIGHT", -10, 10)
  container:SetCallback("OnShow", function() bepgp_standings._standings_table:Show() end)
  container:SetCallback("OnClose", function() bepgp_standings._standings_table:Hide() end)
  
  local export = GUI:Create("Button")
  export:SetAutoWidth(true)
  export:SetText(L["Export"])
  export:SetCallback("OnClick",function()
    local iof = bepgp:GetModule(addonName.."_io")
    if iof then
      iof:Standings()
    end
  end)
  container:AddChild(export)

  local raid_only = GUI:Create("CheckBox")
  raid_only:SetLabel(L["Raid Only"])
  raid_only:SetValue(bepgp.db.char.raidonly)
  raid_only:SetCallback("OnValueChanged", function(widget,callback,value)
    bepgp.db.char.raidonly = value
    bepgp_standings:Refresh()
  end)
  container:AddChild(raid_only)
  self._widgetraid_only = raid_only

  local class_grouping = GUI:Create("CheckBox")
  class_grouping:SetLabel(L["Group by class"])
  class_grouping:SetValue(bepgp.db.char.classgroup)
  class_grouping:SetCallback("OnValueChanged", function(widget,callback,value)
    bepgp.db.char.classgroup = value
    bepgp_standings:Refresh()
  end)
  container:AddChild(class_grouping)
  self._widgetclass_grouping = class_grouping
  bepgp:make_escable(container,"add")

end

function bepgp_standings:Toggle()
  if self._container.frame:IsShown() then
    self._container:Hide()
  else
    self._container:Show()
  end
  self:Refresh()
end

function bepgp_standings:Refresh()
  local members = bepgp:buildRosterTable()
  table.wipe(data)
  for k,v in pairs(members) do
    local ep = bepgp:get_ep(v.name,v.onote) or 0
    if ep > 0 then
      local gp = bepgp:get_gp(v.name,v.onote) or bepgp.VARS.basegp
      local pr = ep/gp
      local eClass, class, hexclass = bepgp:getClassData(v.class)
      local color = RAID_CLASS_COLORS[eClass]
      --local armor_class = armor_text[class_to_armor[eClass]]
      table.insert(data,{["cols"]={
        {["value"]=v.name,["color"]=color},
        {["value"]=string.format("%.4g", ep)},
        {["value"]=string.format("%.4g", gp)},
        {["value"]=string.format("%.4g", pr),["color"]={r=1.0,g=215/255,b=0,a=1.0}},
        {["value"]=eClass}
      }})
    end
  end
  self._standings_table:SetData(data)  
  if self._standings_table and self._standings_table.showing then
    self._standings_table:SortData()
  end
end

--[[
local T = LibStub("LibQTip-1.0")
--local D = AceLibrary("Dewdrop-2.0")
local C = LibStub("LibCrayon-3.0")

--local BC = AceLibrary("Babble-Class-2.2")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
_G[moduleName] = bepgp:NewModule(moduleName)
local sepgp_standings = _G[moduleName]

--sepgp_standings = bepgp:NewModule("sepgp_standings", "AceDB-2.0")
local groupings = {
  "sepgp_groupbyclass",
  "sepgp_groupbyarmor",
  "sepgp_groupbyrole",
}
local PLATE, MAIL, LEATHER, CLOTH = 4,3,2,1
local DPS, CASTER, HEALER, TANK = 4,3,2,1
local class_to_armor = {
  PALADIN = PLATE,
  WARRIOR = PLATE,
  HUNTER = MAIL,
  SHAMAN = MAIL,
  DRUID = LEATHER,
  ROGUE = LEATHER,
  MAGE = CLOTH,
  PRIEST = CLOTH,
  WARLOCK = CLOTH,
}
local armor_text = {
  [CLOTH] = L["CLOTH"],
  [LEATHER] = L["LEATHER"],
  [MAIL] = L["MAIL"],
  [PLATE] = L["PLATE"],
}
local class_to_role = {
  PALADIN = {HEALER,DPS,TANK,CASTER},
  PRIEST = {HEALER,CASTER},
  DRUID = {HEALER,TANK,DPS,CASTER},
  SHAMAN = {HEALER,DPS,CASTER},
  MAGE = {CASTER},
  WARLOCK = {CASTER},
  ROGUE = {DPS},
  HUNTER = {DPS},
  WARRIOR = {TANK,DPS},
}
local role_text = {
  [TANK] = L["TANK"],
  [HEALER] = L["HEALER"],
  [CASTER] = L["CASTER"],
  [DPS] = L["PHYS DPS"],
}

local class_cache = setmetatable({},{__index = function(t,k)
  local class
  if BC:HasReverseTranslation(k) then
    class = string.upper(BC:GetReverseTranslation(k))
  else
    class = string.upper(k)
  end
  if (class) then
    rawset(t,k,class)
    return class
  end
  return k
end})
function sepgp_standings:getArmorClass(class)
  class = class_cache[class]
  return class_to_armor[class] or 0
end

function sepgp_standings:getRolesClass(roster)
  local roster_num = table.getn(roster)
  for i=1,roster_num do
    local player = roster[i]
    local name, lclass, armor_class, ep, gp, pr = unpack(player)
    local class = class_cache[lclass]
    local roles = class_to_role[class]
    if not (roles) then
      player[3]=0
    else
      for i,role in ipairs(roles) do
        if i==1 then
          player[3]=role
        else
          table.insert(roster,{player[1],player[2],role,player[4],player[5],player[col]})
        end
      end      
    end
  end
  return roster
end 

function sepgp_standings:OnEnable()
  if not T:IsRegistered("sepgp_standings") then
    T:Register("sepgp_standings",
      "children", function()
        T:SetTitle(L["BastionEPGP standings"])
        self:OnTooltipUpdate()
      end,
  		"showTitleWhenDetached", true,
  		"showHintWhenDetached", true,
  		"cantAttach", true,
  		"menu", function()
        D:AddLine(
          "text", L["Raid Only"],
          "tooltipText", L["Only show members in raid."],
          "checked", sepgp_raidonly,
          "func", function() sepgp_standings:ToggleRaidOnly() end
        )      
        D:AddLine(
          "text", L["Group by class"],
          "tooltipText", L["Group members by class."],
          "checked", sepgp_groupbyclass,
          "func", function() sepgp_standings:ToggleGroupBy("sepgp_groupbyclass") end
        )
        D:AddLine(
          "text", L["Group by armor"],
          "tooltipText", L["Group members by armor."],
          "checked", sepgp_groupbyarmor,
          "func", function() sepgp_standings:ToggleGroupBy("sepgp_groupbyarmor") end
        )
        D:AddLine(
          "text", L["Group by roles"],
          "tooltipText", L["Group members by roles."],
          "checked", sepgp_groupbyrole,
          "func", function() sepgp_standings:ToggleGroupBy("sepgp_groupbyrole") end
        )
        D:AddLine(
          "text", L["Refresh"],
          "tooltipText", L["Refresh window"],
          "func", function() sepgp_standings:Refresh() end
        )
        D:AddLine(
          "text", L["Export"],
          "tooltipText", L["Export standings to csv."],
          "func", function() sepgp_standings:Export() end
        )
        if IsGuildLeader() then
          D:AddLine(
          "text", L["Import"],
          "tooltipText", L["Import standings from csv."],
          "func", function() sepgp_standings:Import() end
        )
        end
  		end
    )
  end
  if not T:IsAttached("sepgp_standings") then
    T:Open("sepgp_standings")
  end
end

function sepgp_standings:OnDisable()
  T:Close("sepgp_standings")
end

function sepgp_standings:Refresh()
  T:Refresh("sepgp_standings")
end

function sepgp_standings:setHideScript()
  local i = 1
  local tablet = getglobal(string.format("Tablet20DetachedFrame%d",i))
  while (tablet) and i<100 do
    if tablet.owner ~= nil and tablet.owner == "sepgp_standings" then
      bepgp:make_escable(string.format("Tablet20DetachedFrame%d",i),"add")
      tablet:SetScript("OnHide",nil)
      tablet:SetScript("OnHide",function()
          if not T:IsAttached("sepgp_standings") then
            T:Attach("sepgp_standings")
            this:SetScript("OnHide",nil)
          end
        end)
      break
    end    
    i = i+1
    tablet = getglobal(string.format("Tablet20DetachedFrame%d",i))
  end  
end

function sepgp_standings:Top()
  if T:IsRegistered("sepgp_standings") and (T.registry.sepgp_standings.tooltip) then
    T.registry.sepgp_standings.tooltip.scroll=0
  end  
end

function sepgp_standings:Toggle(forceShow)
  self:Top()
  if T:IsAttached("sepgp_standings") then -- hidden
    T:Detach("sepgp_standings") -- show
    if (T:IsLocked("sepgp_standings")) then
      T:ToggleLocked("sepgp_standings")
    end
    self:setHideScript()
  else
    if (forceShow) then
      sepgp_standings:Refresh()
    else
      T:Attach("sepgp_standings") -- hide
    end
  end  
end

function sepgp_standings:ToggleGroupBy(setting)
  for _,value in ipairs(groupings) do
    if value ~= setting then
      _G[value] = false
    end
  end
  _G[setting] = not _G[setting]
  self:Top()
  self:Refresh()
end

function sepgp_standings:ToggleRaidOnly()
  sepgp_raidonly = not sepgp_raidonly
  self:Top()
  bepgp:SetRefresh(true)
end

local pr_sorter_standings = function(a,b)
  if sepgp_minep > 0 then
    local a_over = a[4]-sepgp_minep >= 0
    local b_over = b[4]-sepgp_minep >= 0
    if a_over and b_over or (not a_over and not b_over) then
      if a[col] ~= b[col] then
        return tonumber(a[col]) > tonumber(b[col])
      else
        return tonumber(a[4]) > tonumber(b[4])
      end
    elseif a_over and (not b_over) then
      return true
    elseif b_over and (not a_over) then
      return false
    end
  else
    if a[col] ~= b[col] then
      return tonumber(a[col]) > tonumber(b[col])
    else
      return tonumber(a[4]) > tonumber(b[4])
    end
  end
end
-- Builds a standings table with record:
-- name, class, armor_class, roles, EP, GP, PR
-- and sorted by PR
function sepgp_standings:BuildStandingsTable()
  local t = { }
  local r = { }
  if (sepgp_raidonly) and GetNumRaidMembers() > 0 then
    for i = 1, GetNumRaidMembers(true) do
      local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i) 
      r[name] = true
    end
  end
  bepgp.alts = {}
  for i = 1, GetNumGuildMembers(1) do
    local name, _, _, _, class, _, note, officernote, _, _ = GetGuildRosterInfo(i)
    local ep = (bepgp:get_ep_v3(name,officernote) or 0) 
    local gp = (bepgp:get_gp_v3(name,officernote) or bepgp.VARS.basegp)
    local main, main_class, main_rank = bepgp:parseAlt(name,officernote)
    if (main) then
      if ((self._playerName) and (name == self._playerName)) then
        if (not sepgp_main) or (sepgp_main and sepgp_main ~= main) then
          sepgp_main = main
          self:defaultPrint(L["Your main has been set to %s"],sepgp_main)
        end
      end
      main = C:Colorize(BC:GetHexColor(main_class), main)
      bepgp.alts[main] = bepgp.alts[main] or {}
      bepgp.alts[main][name] = class
    end
    local armor_class = self:getArmorClass(class)
    if ep > 0 then
      if (sepgp_raidonly) and next(r) then
        if r[name] then
          table.insert(t,{name,class,armor_class,ep,gp,ep/gp})
        end
      else
      	table.insert(t,{name,class,armor_class,ep,gp,ep/gp})
      end
    end
  end
  if (sepgp_groupbyclass) then
    table.sort(t, function(a,b)
      if (a[2] ~= b[2]) then return a[2] > b[2]
      else return pr_sorter_standings(a,b) end
    end)
  elseif (sepgp_groupbyarmor) then
    table.sort(t, function(a,b)
      if (a[3] ~= b[3]) then return a[3] > b[3]
      else return pr_sorter_standings(a,b) end
    end)
  elseif (sepgp_groupbyrole) then
    t = self:getRolesClass(t) -- we are subbing role into armor_class to avoid extra table creation
    table.sort(t, function(a,b)
    if (a[3] ~= b[3]) then return a[3] > b[3]
      else return pr_sorter_standings(a,b) end
    end)   
  else
    table.sort(t, pr_sorter_standings)
  end
  return t
end

function sepgp_standings:OnTooltipUpdate()
  local cat = T:AddCategory(
      "columns", 4,
      "text",  C:Orange(L["Name"]),   "child_textR",    1, "child_textG",    1, "child_textB",    1, "child_justify",  "LEFT",
      "text2", C:Orange(L["ep"]),     "child_text2R",   1, "child_text2G",   1, "child_text2B",   1, "child_justify2", "RIGHT",
      "text3", C:Orange(L["gp"]),     "child_text3R",   1, "child_text3G",   1, "child_text3B",   1, "child_justify3", "RIGHT",
      "text4", C:Orange(L["pr"]),     "child_text4R",   1, "child_text4G",   1, "child_text4B",   0, "child_justify4", "RIGHT"
    )
  local t = self:BuildStandingsTable()
  local separator
  for i = 1, table.getn(t) do
    local name, class, armor_class, ep, gp, pr = unpack(t[i])
    if (sepgp_groupbyarmor) or (sepgp_groupbyrole) then
      if not (separator) then
        if (sepgp_groupbyarmor) then
          separator = armor_text[armor_class]
        elseif (sepgp_groupbyrole) then
          separator = role_text[armor_class]
        end
        if (separator) then
          cat:AddLine(
            "text", C:Green(separator),
            "text2", "",
            "text3", "",
            "text4", ""
          )
        end
      else
        local last_separator = separator
        if (sepgp_groupbyarmor) then
          separator = armor_text[armor_class]
        elseif (sepgp_groupbyrole) then
          separator = role_text[armor_class]
        end
        if (separator) and (separator ~= last_separator) then
          cat:AddLine(
            "text", C:Green(separator),
            "text2", "",
            "text3", "",
            "text4", ""
          )          
        end
      end
    end
    local text = C:Colorize(BC:GetHexColor(class), name)
    local text2, text4
    if sepgp_minep > 0 and ep < sepgp_minep then
      text2 = C:Red(string.format("%.4g", ep))
      text4 = C:Red(string.format("%.4g", pr))
    else
      text2 = string.format("%.4g", ep)
      text4 = string.format("%.4g", pr)
    end
    local text3 = string.format("%.4g", gp)    
    if ((bepgp._playerName) and bepgp._playerName == name) or ((sepgp_main) and sepgp_main == name) then
      text = string.format("(*)%s",text)
      local pr_decay = bepgp:capcalc(ep,gp)
      if pr_decay < 0 then
        text4 = string.format("%s(|cffff0000%.4g|r)",text4,pr_decay)
      end
    end
    cat:AddLine(
      "text", text,
      "text2", text2,
      "text3", text3,
      "text4", text4
    )
  end
end
]]
-- GLOBALS: sepgp_saychannel,sepgp_groupbyclass,sepgp_groupbyarmor,sepgp_groupbyrole,sepgp_raidonly,sepgp_decay,sepgp_minep,sepgp_reservechannel,sepgp_main,sepgp_progress,sepgp_discount,sepgp_log,sepgp_dbver,sepgp_looted
-- GLOBALS: bepgp,sepgp_prices,sepgp_standings,sepgp_bids,sepgp_loot,sepgp_reserves,sepgp_alts,sepgp_logs
