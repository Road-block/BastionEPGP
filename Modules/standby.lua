local addonName, bepgp = ...
local moduleName = addonName.."_standby"
local bepgp_standby = bepgp:NewModule(moduleName, "AceEvent-3.0", "AceTimer-3.0", "AceHook-3.0")
local C = LibStub("LibCrayon-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local DF = LibStub("LibDeformat-3.0")
local T = LibStub("LibQTip-1.0")

bepgp_standby.roster = {}
local standby_blacklist = {}
local standbycall = string.format(L["{BEPGP}Type \"+\" if on main, or \"+<YourMainName>\" (without quotes) if on alt within %dsec."],bepgp.VARS.timeout)

function bepgp_standby:OnEnable()
  self.qtip = T:Acquire(addonName.."standbyTablet") -- name, class, rank, alt
  self.qtip:SetColumnLayout(3, "LEFT", "RIGHT", "RIGHT")
  self.qtip:ClearAllPoints()
  self.qtip:SetClampedToScreen(true)
  self.qtip:SetClampRectInsets(-100,100,50,-50)
  self.qtip:SetPoint("TOP",UIParent,"TOP",0,-50)  
end

function bepgp_standby:Refresh()
  local frame = self.qtip
  if not frame then return end
  frame:Clear()
  local line
  line = frame:AddHeader()
  frame:SetCell(line,1,L["BastionEPGP standby"],nil,"CENTER",2)
  frame:SetCell(line,3,C:Red("[x]"),nil,"RIGHT")
  frame:SetCellScript(line,3,"OnMouseUp", function() bepgp_standby.qtip:Hide() end)
  
  frame:UpdateScrolling()
end

function bepgp_standby:Toggle(anchor)
  if not T:IsAcquired(addonName.."standbyTablet") then
    self.qtip = T:Acquire(addonName.."standbyTablet") -- Name, ep, gp, pr, Main
    self.qtip:SetColumnLayout(3, "LEFT", "RIGHT", "RIGHT")
    return
  end
  if self.qtip:IsShown() then
    self.qtip:Hide()
  else
    if anchor then
      self.qtip:SmartAnchorTo(anchor)
    else
      self.qtip:ClearAllPoints()
      self.qtip:SetClampedToScreen(true)
      self.qtip:SetClampRectInsets(-100,100,50,-50)
      self.qtip:SetPoint("TOP",UIParent,"TOP",0,-50)      
    end
    self:Refresh()
    self.qtip:Show()
  end
end



--[[
local T = LibStub("LibQTip-1.0")
--local D = AceLibrary("Dewdrop-2.0")
local C = LibStub("LibCrayon-3.0")

--local BC = AceLibrary("Babble-Class-2.2")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
_G[moduleName] = _G[addonName]:NewModule(moduleName)
local sepgp_reserves = _G[moduleName]
--sepgp_reserves = sepgp:NewModule("sepgp_reserves", "AceDB-2.0")

function sepgp_reserves:OnEnable()
  if not T:IsRegistered("sepgp_reserves") then
    T:Register("sepgp_reserves",
      "children", function()
        T:SetTitle(L["BastionEPGP reserves"])
        self:OnTooltipUpdate()
      end,
      "showTitleWhenDetached", true,
      "showHintWhenDetached", true,
      "cantAttach", true,
      "menu", function()
        D:AddLine(
          "text", L["Refresh"],
          "tooltipText", L["Refresh window"],
          "func", function() sepgp_reserves:Refresh() end
        )
      end      
    )
  end
  if not T:IsAttached("sepgp_reserves") then
    T:Open("sepgp_reserves")
  end
end

function sepgp_reserves:OnDisable()
  T:Close("sepgp_reserves")
end

function sepgp_reserves:Refresh()
  T:Refresh("sepgp_reserves")
end

function sepgp_reserves:setHideScript()
  local i = 1
  local tablet = getglobal(string.format("Tablet20DetachedFrame%d",i))
  while (tablet) and i<100 do
    if tablet.owner ~= nil and tablet.owner == "sepgp_reserves" then
      sepgp:make_escable(string.format("Tablet20DetachedFrame%d",i),"add")
      tablet:SetScript("OnHide",nil)
      tablet:SetScript("OnHide",function()
          if not T:IsAttached("sepgp_reserves") then
            T:Attach("sepgp_reserves")
            this:SetScript("OnHide",nil)
          end
        end)
      break
    end    
    i = i+1
    tablet = getglobal(string.format("Tablet20DetachedFrame%d",i))
  end  
end

function sepgp_reserves:Top()
  if T:IsRegistered("sepgp_reserves") and (T.registry.sepgp_reserves.tooltip) then
    T.registry.sepgp_reserves.tooltip.scroll=0
  end  
end

function sepgp_reserves:Toggle(forceShow)
  self:Top()
  if T:IsAttached("sepgp_reserves") then
    T:Detach("sepgp_reserves") -- show
    if (T:IsLocked("sepgp_reserves")) then
      T:ToggleLocked("sepgp_reserves")
    end
    self:setHideScript()
  else
    if (forceShow) then
      sepgp_reserves:Refresh()
    else
      T:Attach("sepgp_reserves") -- hide
    end
  end  
end

function sepgp_reserves:OnClickItem(name)
  ChatFrame_SendTell(name)
end

function sepgp_reserves:BuildReservesTable()
  --{name,class,rank,alt}
  table.sort(sepgp.reserves, function(a,b)
    if (a[2] ~= b[2]) then return a[2] > b[2]
    else return a[1] > b[1] end
  end)
  return sepgp.reserves
end

function sepgp_reserves:OnTooltipUpdate()
  local cdcat = T:AddCategory(
      "columns", 2
    )
  cdcat:AddLine(
      "text", C:Orange(L["Countdown"]),
      "text2", sepgp.timer.cd_text
    )
  local cat = T:AddCategory(
      "columns", 3,
      "text",  C:Orange(L["Name"]),   "child_textR",    1, "child_textG",    1, "child_textB",    1, "child_justify",  "LEFT",
      "text2", C:Orange(L["Rank"]),     "child_text2R",   1, "child_text2G",   1, "child_text2B",   0, "child_justify2", "RIGHT",
      "text3", C:Orange(L["OnAlt"]),  "child_text3R",   0, "child_text3G",   1, "child_text3B",   0, "child_justify3", "RIGHT"
    )
  local t = self:BuildReservesTable()
  for i = 1, table.getn(t) do
    local name, class, rank, alt = unpack(t[i])
    cat:AddLine(
      "text", C:Colorize(BC:GetHexColor(class), name),
      "text2", rank,
      "text3", alt or "",
      "func", "OnClickItem", "arg1", self, "arg2", alt or name
    )
  end
end
]]
-- GLOBALS: sepgp_saychannel,sepgp_groupbyclass,sepgp_groupbyarmor,sepgp_groupbyrole,sepgp_raidonly,sepgp_decay,sepgp_minep,sepgp_reservechannel,sepgp_main,sepgp_progress,sepgp_discount,sepgp_log,sepgp_dbver,sepgp_looted
-- GLOBALS: sepgp,sepgp_prices,sepgp_standings,sepgp_bids,sepgp_loot,sepgp_reserves,sepgp_alts,sepgp_logs
