local addonName, bepgp = ...
local moduleName = addonName.."_io"
local bepgp_io = bepgp:NewModule(moduleName)
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local Dump = LibStub("LibTextDump-1.0")
local Json = LibStub("LibJSON-1.0")

function bepgp_io:OnEnable()
  self._iostandings = Dump:New(L["Export Standings"],250,290)
  self._ioloot = Dump:New(L["Export Loot"],500,320)
  self._iologs = Dump:New(L["Export Logs"],450,320)
end

function bepgp_io:Standings()
  self._iostandings:Clear()
  local members = bepgp:buildRosterTable()
  self._iostandings:AddLine(string.format("%s;%s;%s;%s",L["Name"],L["ep"],L["gp"],L["pr"]))
  for k,v in pairs(members) do
    local ep = bepgp:get_ep(v.name,v.onote) or 0
    if ep > 0 then
      local gp = bepgp:get_gp(v.name,v.onote) or bepgp.VARS.basegp
      local pr = ep/gp
      self._iostandings:AddLine(string.format("%s;%s;%s;%.4g",v.name,ep,gp,pr))
    end
  end
  self._iostandings:Display()
end

function bepgp_io:Loot(loot_indices)
  self._ioloot:Clear()
  self._ioloot:AddLine(string.format("%s;%s;%s;%s;%s",L["Time"],L["Item"],L["Looter"],L["Binds"],L["GP Action"]))
  for i,data in ipairs(bepgp.db.char.loot) do
    local time = data[loot_indices.time]
    local item = data[loot_indices.item]
    local itemColor, itemString, itemName, itemID = bepgp:getItemData(item)
    local looter = data[loot_indices.player]
    local action = data[loot_indices.action]
    if action == bepgp.VARS.msgp or action == bepgp.VARS.osgp then
      self._ioloot:AddLine("%s;%s;%s;%s;%s",time,itemName,looter,action)
    end
  end
  self._ioloot:Display()
end

function bepgp_io:Logs()
  self._iologs:Clear()
  self._iologs:AddLine(string.format("%s;%s",L["Time"],L["Action"]))
  for i,data in ipairs(bepgp.db.char.logs) do
    self._iologs:AddLine(string.format("%s;%s",data[1],data[2]))
  end
  self._iologs:Display()
end

--[[
bepgp:make_escable("shooty_exportframe","add")

function sepgp_standings:Export()
  shooty_export.action:Hide()
  shooty_export.title:SetText(C:Gold(L["Ctrl-C to copy. Esc to close."]))
  local t = {}
  for i = 1, GetNumGuildMembers(1) do
    local name, _, _, _, class, _, note, officernote, _, _ = GetGuildRosterInfo(i)
    local ep = (bepgp:get_ep_v3(name,officernote) or 0) 
    local gp = (bepgp:get_gp_v3(name,officernote) or bepgp.VARS.basegp) 
    if ep > 0 then
      table.insert(t,{name,ep,gp,ep/gp})
    end
  end 
  table.sort(t, function(a,b)
      return tonumber(a[4]) > tonumber(b[4])
    end)
  shooty_export:Show()
  local txt = "Name;EP;GP;PR\n"
  for i,val in ipairs(t) do
    txt = string.format("%s%s;%d;%d;%.4f\n",txt,val[1],val[2],val[3],val[4])
  end
  shooty_export.AddSelectText(txt)
end

function sepgp_standings:Import()
  if not IsGuildLeader() then return end
  shooty_export.action:Show()
  shooty_export.title:SetText(C:Red("Ctrl-V to paste data. Esc to close."))
  shooty_export.AddSelectText(L.IMPORT_WARNING)
  shooty_export:Show()
end

function sepgp_standings.import()
  if not IsGuildLeader() then return end
  local text = shooty_export.edit:GetText()
  local t = {}
  local found
  for line in string.gmatch(text,"[^\r\n]+") do
    local name,ep,gp,pr = bepgp:strsplit(";",line)
    ep,gp,pr = tonumber(ep),tonumber(gp),tonumber(pr)
    if (name) and (ep) and (gp) and (pr) then
      t[name]={ep,gp}
      found = true
    end
  end
  if (found) then
    local count = 0
    shooty_export.edit:SetText("")
    for i=1,GetNumGuildMembers(1) do
      local name, _, _, _, class, _, note, officernote, _, _ = GetGuildRosterInfo(i)
      local name_epgp = t[name]
      if (name_epgp) then
        count = count + 1
        --bepgp:debugPrint(string.format("%s {%s:%s}",name,name_epgp[1],name_epgp[2])) -- Debug
        bepgp:update_epgp_v3(name_epgp[1],name_epgp[2],i,name,officernote)
        t[name]=nil
      end
    end
    bepgp:defaultPrint(string.format(L["Imported %d members."],count))
    local report = string.format(L["Imported %d members.\n"],count)
    report = string.format(L["%s\nFailed to import:"],report)
    for name,epgp in pairs(t) do
      report = string.format("%s%s {%s:%s}\n",report,name,t[1],t[2])
    end
    shooty_export.AddSelectText(report)
  end
end
]]