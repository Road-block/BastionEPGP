local addonName, prices = ...
local addon = LibStub("AceAddon-3.0"):NewAddon(prices, addonName)

local name_version = "CEPGP"
function prices:OnEnable()
  if BastionEPGP and CEPGP_calcGP and BastionEPGP.RegisterPriceSystem then
    if not _G.OVERRIDE_INDEX then OVERRIDE_INDEX = {} end
    if not _G.SLOTWEIGHTS then 
      SLOTWEIGHTS = {
        ["2HWEAPON"] = 2,
        ["WEAPONMAINHAND"] = 1.5,
        ["WEAPON"] = 1.5,
        ["WEAPONOFFHAND"] = 0.5,
        ["HOLDABLE"] = 0.5,
        ["SHIELD"] = 0.5,
        ["RANGED"] = 0.5,
        ["RANGEDRIGHT"] = 0.5,
        ["THROWN"] = 0.5,
        ["RELIC"] = 0.5,
        ["HEAD"] = 1,
        ["NECK"] = 0.5,
        ["SHOULDER"] = 0.75,
        ["CLOAK"] = 0.5,
        ["CHEST"] = 1,
        ["ROBE"] = 1,
        ["WRIST"] = 0.5,
        ["HAND"] = 0.75,
        ["WAIST"] = 0.75,
        ["LEGS"] = 1,
        ["FEET"] = 0.75,
        ["FINGER"] = 0.5,
        ["TRINKET"] = 0.75,
        ["EXCEPTION"] = 1
      }
    end
    if not _G.MOD_COEF then MOD_COEF = 2 end
    if not _G.COEF then COEF = 4.83 end
    if not _G.MOD then MOD = 1 end
    BastionEPGP:RegisterPriceSystem(name_version, prices.GetPrice)
  end
end

function prices:GetPrice(item)
  local price = CEPGP_calcGP(item, 1)
  return price
end

_G[addonName]=prices
