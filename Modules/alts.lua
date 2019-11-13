local addonName, bepgp = ...
local moduleName = addonName.."_alts"
local bepgp_alts = bepgp:NewModule(moduleName)
local ST = LibStub("ScrollingTable")
local C = LibStub("LibCrayon-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local GUI = LibStub("AceGUI-3.0")

local data = { }
local colorHighlight = {r=0, g=0, b=0, a=.9}

function bepgp_alts:OnEnable()
  local container = GUI:Create("Window")
  container:SetTitle(L["BastionEPGP alts"])
  container:SetWidth(455)
  container:SetHeight(290)
  container:EnableResize(false)
  container:SetLayout("Flow")
  container:Hide()
  self._container = container
  local headers = {
    {["name"]=C:Orange(L["Main"]),["width"]=100}, --name
    {["name"]=C:Orange(L["Alts"]),["width"]=300}, --alts
  }
  self._alts_table = ST:CreateST(headers,15,nil,colorHighlight,container.frame) -- cols, numRows, rowHeight, highlight, parent
  self._alts_table.frame:SetPoint("BOTTOMRIGHT",self._container.frame,"BOTTOMRIGHT", -10, 10)
  container:SetCallback("OnShow", function() bepgp_alts._alts_table:Show() end)
  container:SetCallback("OnClose", function() bepgp_alts._alts_table:Hide() end)
  bepgp:make_escable(container,"add")
end

function bepgp_alts:Toggle()
  if self._container.frame:IsShown() then
    self._container:Hide()
  else
    self._container:Show()
  end
  self:Refresh()
end

function bepgp_alts:Refresh()
  local alts = bepgp.db.profile.alts
  table.wipe(data)
  for c_main,t_alts in pairs(alts) do
    local altstring = ""
    for alt,class in pairs(t_alts) do
      local _,_,hexclass = bepgp:getClassData(class)
      local coloredalt = C:Colorize(hexclass, alt)
      if altstring == "" then
        altstring = coloredalt
      else
        altstring = string.format("%s, %s",altstring,coloredalt)
      end
    end    
    table.insert(data,{["cols"]={
      {["value"]=c_main},
      {["value"]=altstring},
    }})
  end
  self._alts_table:SetData(data)  
  if self._alts_table and self._alts_table.showing then
    self._alts_table:SortData()
  end
end
