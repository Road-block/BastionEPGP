local addonName, bepgp = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "enUS", true)
if not L then return end
  --["Term"] = true -- Example
  -- common
  L["Refresh"] = true
  L["Refresh window"] = true
  L["Clear"] = true
  L["Name"] = true
  L["Raid Only"] = true
  L["Only show members in raid."] = true
  L["Restarted"] = true
  L["Progress"] = true
  L["Print Progress Multiplier."] = true
  L["Offspec"] = true
  L["Print Offspec Price."] = true
  L["Progress Setting: %s"] = true
  L["Offspec Price: %s%%"] = true
  L["Minimum EP: %s"] = true
  L["Minimum EP"] = true
  L["Set Minimum EP"] = true
  -- bids
  L["BastionEPGP bids"] = true
  L["Winning Mainspec Bid: %s (%.03f PR)"] = true
  L["Winning Offspec Bid: %s (%.03f PR)"] = true
  -- logs
  L["BastionEPGP logs"] = true
  L["Clear Logs."] = true
  L["Time"] = true
  L["Action"] = true
  -- loot
  L["BastionEPGP loot info"] = true
  L["Clear Loot."] = true
  L["Export Loot"] = true
  L["Item"] = true
  L["Binds"] = true
  L["Looter"] = true
  L["GP Action"] = true
  -- migrations
  L["Updated %d members to v3 storage."] = true
  -- reserves
  L["BastionEPGP reserves"] = true
  L["Countdown"] = true
  L["Rank"] = true
  L["OnAlt"] = true
  -- standings
  L["Ctrl-C to copy. Esc to close."] = true
  L["Ctrl-V to paste data. Esc to close."] = true
  L["Imported %d members."] = true
  L["Imported %d members.\n"] = true
  L["%s\nFailed to import:"] = true
  L["BastionEPGP standings"] = true
  L["Group by class"] = true
  L["Group members by class."] = true
  L["Export"] = true
  L["Export standings to csv."] = true
  L["Export Standings"] = true
  L["Import"] = true
  L["Import standings from csv."] = true
  L["ep"] = true
  L["gp"] = true
  L["pr"] = true
  L.IMPORT_WARNING = [[Warning: 
Import overwrites all existing EPGP values.

Paste all the csv data here replacing this text, 
then hit Import.
Results will print here when done.]]
  L["Group by armor"] = true
  L["Group members by armor."] = true
  L["Group by roles"] = true
  L["Group members by roles."] = true
  L["CLOTH"] = true
  L["LEATHER"] = true
  L["MAIL"] = true
  L["PLATE"] = true
  L["TANK"] = true
  L["HEALER"] = true
  L["CASTER"] = true
  L["PHYS DPS"] = true
  -- BastionEPGP
  L["{BEPGP}Type \"+\" if on main, or \"+<YourMainName>\" (without quotes) if on alt within %dsec."] = true
  L["|cffFF3333|Hbepgpbid:1:$ML|h[Mainspec/NEED]|h|r"] = true
  L["|cff009900|Hbepgpbid:2:$ML|h[Offspec/GREED]|h|r"] = true
  L["Bids"] = true
  L["Show Bids Table."] = true
  L["ClearLoot"] = true
  L["Clear Loot Table."] = true
  L["ClearLogs"] = true
  L["Export Logs"] = true
  L["Clear Logs Table."] = true
  L["Standings"] = true
  L["Show Standings Table."] = true
  L["Restart"] = true  
  L["Restart BastionEPGP if having startup problems."] = true
  L["v%s Loaded."] = true  
  L["Alt Click/RClick/MClick"] = true
  L["Call for: MS/OS/Both"] = true  
  L["gp:|cff32cd32%d|r gp_os:|cff20b2aa%d|r"] = true
  L["pr:|cffff0000%.02f|r(%.02f) pr_os:|cffff0000%.02f|r(%.02f)"] = true  
  L["|cffff0000Finished|r"] = true
  L["|cff00ff00%02d|r|cffffffffsec|r"] = true  
  L["Manually modified %s\'s note. EPGP was %s"] = true
  L["|cffff0000Manually modified %s\'s note. EPGP was %s|r"] = true
  L["Whisper %s a + for %s (mainspec)"] = true
  L["Whisper %s a - for %s (offspec)"] = true
  L["Whisper %s a + or - for %s (mainspec or offspec)"] = true
  L["Click $MS or $OS for %s"] = true
  L["or $OS "] = true
  L["$MS or "] = true
  L["You have received a %d EP penalty."] = true
  L["You have been awarded %d EP."] = true
  L["You have gained %d GP."] = true
  L["%s%% decay to EP and GP."] = true
  L["%d EP awarded to Raid."] = true
  L["%d EP awarded to Standby."] = true
  L["New %s version available: |cff00ff00%s|r"] = true
  L["Visit %s to update."] = true
  L["New raid progress"] = true
  L[", offspec price %"] = true
  L["New offspec price %"] = true
  L[", decay %"] = true
  L["New decay %"] = true
  L[" settings accepted from %s"] = true
  L["Giving %d ep to all raidmembers"] = true
  L["You aren't in a raid dummy"] = true
  L["Giving %d ep to active reserves"] = true
  L["Giving %d ep to %s%s."] = true
  L["%s EP Penalty to %s%s."] = true
  L["Giving %d gp to %s%s."] = true
  L["Awarding %d GP to %s%s. (Previous: %d, New: %d)"] = true
  L["%s\'s officernote is broken:%q"] = true
  L["All EP and GP decayed by %d%%"] = true
  L["All EP and GP decayed by %s%%"] = true
  L["All GP has been reset to %d."] = true
  L["All EP and GP has been reset to 0/%d."] = true
  L["You now have: %d EP %d GP |cffffff00%.03f|r|cffff7f00PR|r."] = true
  L["Close to EPGP Cap. Next Decay will change your |cffff7f00PR|r by |cffff0000%.4g|r."] = true
  L["|cffffff00Click|r to toggle Standings.%s \n|cffffff00Right-Click|r for Options."] = true
  L[" \n|cffffff00Ctrl+Click|r to toggle Standby. \n|cffffff00Alt+Click|r to toggle Bids. \n|cffffff00Shift+Click|r to toggle Loot. \n|cffffff00Ctrl+Alt+Click|r to toggle Alts. \n|cffffff00Ctrl+Shift+Click|r to toggle Logs."] = true
  L["Account EPs to %s."] = true
  L["Account GPs to %s."] = true
  L["BastionEPGP options"] = true
  L["+EPs to Member"] = true
  L["Account EPs for member."] = true
  L["+EPs to Raid"] = true
  L["Award EPs to all raid members."] = true
  L["+GPs to Member"] = true
  L["Account GPs for member."] = true
  L["+EPs to Standby"] = true
  L["Award EPs to all active Standby."] = true
  L["Enable Standby"] = true
  L["Participate in Standby Raiders List.\n|cffff0000Requires Main Character Name.|r"] = true
  L["AFK Check Standby"] = true
  L["AFK Check Standby List"] = true
  L["Set Main"] = true
  L["Set your Main Character for Standby List."] = true
  L["Raid Progress"] = true
  L["Highest Tier the Guild is raiding.\nUsed to adjust GP Prices.\nUsed for suggested EP awards."] = true
  L["4.Naxxramas"] = true
  L["3.Temple of Ahn\'Qiraj"] = true
  L["2.Blackwing Lair"] = true
  L["1.Molten Core"] = true
  L["Reporting channel"] = true
  L["Channel used by reporting functions."] = true
  L["Decay EPGP"] = true
  L["Decays all EPGP by %s%%"] = true
  L["Set Decay %"] = true
  L["Set Decay percentage (Admin only)."] = true
  L["Offspec Price %"] = true
  L["Set Offspec Items GP Percent."] = true
  L["Reset EPGP"] = true
  L["Resets everyone\'s EPGP to 0/%d (Guild Leader only)."] = true
  L["Scanning %d members for EP/GP data. (%s)"] = true
  L["|cffff0000%s|r trying to add %s to Standby, but has already added a member. Discarding!"] = true
  L["|cffff0000%s|r has already been added to Standby. Discarding!"] = true
  L["^{BEPGP}Type"] = true
  L["Clearing old Bids"] = true
  L["%s not found in the guild or not raid level!"] = true
  L["Molten Core"] = true
  L["Onyxia\'s Lair"] = true
  L["Blackwing Lair"] = true
  L["Ahn\'Qiraj"] = true
  L["Naxxramas"] = true
  L["There are %d loot drops stored. It is recommended to clear loot info before a new raid. Do you want to clear it now?"] = true
  L["Show me"] = true
  L["Logs cleared"] = true
  L["Loot info cleared"] = true
  L["Loot info can be cleared at any time from the loot window or '/bepgp clearloot' command"] = true
  L["Set your main to be able to participate in Standby List EPGP Checks."] = true  
  L["Standby AFKCheck. Are you available? |cff00ff00%0d|rsec."] = true
  L["|cffff0000Are you sure you want to Reset ALL EPGP?|r"] = true
  L["Add MainSpec GP"] = true
  L["Add OffSpec GP"] = true
  L["Bank or D/E"] = true
  L["%s looted %s. What do you want to do?"] = true
  L["GP Actions"] = true
  L["Remind me Later"] = true
  L["Need MasterLooter to perform Bid Calls!"] = true
  L["BastionEPGP alts"] = true
  L["Enable Alts"] = true
  L["Main"] = true
  L["Alt"] = true
  L["Allow Alts to use Main\'s EPGP."] = true
  L["Alts EP %"] = true
  L["Set the % EP Alts can earn."] = true
  L[", alts"] = true
  L["New Alts"] = true
  L[", alts ep %"] = true
  L["New Alts EP %"] = true
  L["Manually modified %s\'s note. Previous main was %s"] = true
  L["|cffff0000Manually modified %s\'s note. Previous main was %s|r"] = true
  L[", %s\'s Main."] = true
  L["Your main has been set to %s"] = true
  L["Alts"] = true
  L["New Minimum EP"] = true
  L["Standby"] = true
  L["BoP"] = true
  L["BoE"] = true
  L["NoBind"] = true
  L["Mainspec GP"] = true
  L["Offspec GP"] = true
  L["Bank-D/E"] = true
  L["Unassigned"] = true
  L["Admin Options"] = true
  L["Member Options"] = true
  L["Hide from Minimap"] = true
  L["You are assigning %s %s to %s."] = true
  L["Effort Points"] = true
  L["Gear Points"] = true
  L["Armor Class"] = true
  L["(ms)"] = true
  L["(need)"] = true
  L["(os)"] = true
  L["(greed)"] = true
  L["Mainspec Bids"] = true
  L["Offspec Bids"] = true
  L["Tooltip Info"] = true
  L["Add EPGP Information to Item Tooltips"] = true
  L["Select Price Scheme"] = true
  L["Select From Registered Price Systems"] = true
  

bepgp.L = L