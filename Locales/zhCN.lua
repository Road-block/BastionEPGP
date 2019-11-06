local addonName, bepgp = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "zhCN")
if not L then return end
  --["Term"] = "术语", -- Example
  -- common
  L["Refresh"] = "刷新"
  L["Refresh window"] = "刷新窗口"
  L["Clear"] = "清除"
  L["Name"] = "名字"
  L["Raid Only"] = "只显示团队"
  L["Only show members in raid."] = "只显示在团队里的成员."
  -- bids
  L["BastionEPGP bids"] = "BastionEPGP 竞拍"
  L["Winning Mainspec Bid: %s (%.03f PR)"] = "副天赋竞标获胜: %s (%.03f PR)"
  L["Winning Offspec Bid: %s (%.03f PR)"] = "副天赋竞标获胜: %s (%.03f PR)"
  -- logs
  L["BastionEPGP logs"] = "BastionEPGP 日志"
  L["Clear Logs."] = "清除日志."
  L["Time"] = "时间"
  L["Action"] = "行为"
  -- loot
  L["BastionEPGP loot info"] = "BastionEPGP 拾取信息"
  L["Clear Loot."] = "清除拾取."
  L["Item"] = "物品"
  L["Binds"] = "竞拍"
  L["Looter"] = "拾取人"
  L["GP Action"] = "GP 行为"
  -- migrations
  L["Updated %d members to v3 storage."] = "更新 %d 成员到v3存储区."
  -- reserves
  L["BastionEPGP reserves"] = "BastionEPGP 替补成员"
  L["Countdown"] = "倒计时"
  L["Rank"] = "Rank"
  L["OnAlt"] = "OnAlt"
     -- standings
  L["Ctrl-C to copy. Esc to close."] = "Ctrl-C 复制. Esc 退出."
  L["Ctrl-V to paste data. Esc to close."] = "Ctrl-V 粘贴数据. Esc 退出."
  L["Imported %d members."] = "导入 %d 成员."
  L["Imported %d members.\n"] = "导入 %d 成员.\n"
  L["%s\nFailed to import:"] = "%s\n未能导入:"
  L["BastionEPGP standings"] = "BastionEPGP 名单列表"
  L["Group by class"] = "职业分组"
  L["Group members by class."] = "按职业分组."
  L["Export"] = "导出"
  L["Export standings to csv."] = "导出排名到CSV文本."
  L["Import"] = "导入"
  L["Import standings from csv."] = "从CSV文本里导入数据."
  L["ep"] = "ep(贡献点)"
  L["gp"] = "gp(装备点)"
  L["pr"] = "pr(优先)"
  L.IMPORT_WARNING = [[警告: 
导入会覆盖所有现有的EPGP值.

粘贴这里的所有CSV数据替换文本, 
然后再导入.
完成后打印结果.]]
  L["Group by armor"] = "Group by armor"
  L["Group members by armor."] = "Group members by armor."
  L["Group by roles"] = "Group by roles"
  L["Group members by roles."] = "Group members by roles."
  L["CLOTH"] = "CLOTH"
  L["LEATHER"] = "LEATHER"
  L["MAIL"] = "MAIL"
  L["PLATE"] = "PLATE"
  L["TANK"] = "TANK"
  L["HEALER"] = "HEALER"
  L["CASTER"] = "CASTER"
  L["PHYS DPS"] = "PHYS DPS"
  -- BastionEPGP
  L["{BEPGP}Type \"+\" if on main, or \"+<YourMainName>\" (without quotes) if on alt within %dsec."] = "{BEPGP}使用 \"+\" 如果你在大号上, 或者 \"+<YourMainName>\" (没有引号) 如果在小号 %d秒."
  L["|cffFF3333|Hbepgpbid:1:$ML|h[Mainspec/NEED]|h|r"] = "|cffFF3333|Hbepgpbid:1:$ML|h[主天赋/需求]|h|r"
  L["|cff009900|Hbepgpbid:2:$ML|h[Offspec/GREED]|h|r"] = "|cff009900|Hbepgpbid:2:$ML|h[副天赋/贪婪]|h|r"
  L["Bids"] = "竞标"
  L["Show Bids Table."] = "显示竞标表."
  L["ClearLoot"] = "清除拾取"
  L["Clear Loot Table."] = "清除拾取表."
  L["ClearLogs"] = "清除日志"
  L["Clear Logs Table."] = "清除日志表."
  L["Standings"] = "排名"
  L["Show Standings Table."] = "显示排名表."
  L["Restart"] = "重新开始"
  L["Restart BastionEPGP if having startup problems."] = "重新开始 BastionEPGP，如果有启动问题."
  L["Standings"] = "排名"
  L["Show Standings Table."] = "显示排名表."
  L["v%s Loaded."] = "v%s 加载."
  L["Alt Click/RClick/MClick"] = "Alt+左键/右键/中键"
  L["Call for: MS/OS/Both"] = "要求: MS/OS/Both"
  L["gp:|cff32cd32%d|r gp_os:|cff20b2aa%d|r"] = "gp:|cff32cd32%d|r 副天赋gp:|cff20b2aa%d|r"
  L["pr:|cffff0000%.02f|r(%.02f) pr_os:|cffff0000%.02f|r(%.02f)"] = "pr:|cffff0000%.02f|r(%.02f) 副天赋pr:|cffff0000%.02f|r(%.02f)"
  L["|cffff0000Finished|r"] = "|cffff0000完成|r"
  L["|cff00ff00%02d|r|cffffffffsec|r"] = "|cff00ff00%02d|r|cffffffff秒|r"
  L["Manually modified %s\'s note. EPGP was %s"] = "手动修改 %s\'s 记录. EPGP 是 %s"
  L["|cffff0000Manually modified %s\'s note. EPGP was %s|r"] = "|cffff0000手动修改 %s\'s 记录. EPGP 是 %s|r"
  L["Whisper %s a + for %s (mainspec)"] = "私聊 %s + 为 %s (主天赋)"
  L["Whisper %s a - for %s (offspec)"] = "私聊 %s - 为 %s (副天赋)"
  L["Whisper %s a + or - for %s (mainspec or offspec)"] = "私聊 %s + 或 - 为 %s (主天赋或副天赋)"
  L["Click $MS or $OS for %s"] = "Click $MS 或 $OS for %s"
  L["or $OS "] = "或 $OS "
  L["$MS or "] = "$MS 或 "
  L["You have received a %d EP penalty."] = "你已经收到了 %d EP 处罚."
  L["You have been awarded %d EP."] = "你被授予 %d EP."
  L["You have gained %d GP."] = "你得到了 %d GP."
  L["%s%% decay to EP and GP."] = "%s%% 递减EP和GP."
  L["%d EP awarded to Raid."] = "%d EP 授予团队."
  L["%d EP awarded to Standby."] = "%d EP 授予替补队员."
  L["New %s version available: |cff00ff00%s|r"] = "新的 %s 版本可用: |cff00ff00%s|r"
  L["Visit %s to update."] = "访问 %s 升级."
  L["New raid progress"] = "新的RAID进度"
  L[", offspec price %"] = ", 副天赋价格 %"
  L["New offspec price %"] = "新的副天赋价格 %"
  L[", decay %"] = ", 递减 %"
  L["New decay %"] = "新的递减 %"
  L[" settings accepted from %s"] = " 设置接受从 %s"
  L["Giving %d ep to all raidmembers"] = "给予 %d ep 到所有团员"
  L["You aren't in a raid dummy"] = "你不在一个团队"
  L["Giving %d ep to active reserves"] = "给予 %d ep 在线的替补队员"
  L["Giving %d ep to %s%s."] = "给予 %d ep 给 %s"
  L["%s EP Penalty to %s%s."] = "%s EP 惩罚 %s."
  L["Giving %d gp to %s%s."] = "给予 %d gp 给 %s"
  L["Awarding %d GP to %s%s. (Previous: %d, New: %d)"] = "奖励 %d GP 给 %s. (以前: %d, 新: %d)"
  L["%s\'s officernote is broken:%q"] = "%s\'s 官员备注无法执行:%q"
  L["All EP and GP decayed by %d%%"] = "所有EP和GP递减 %d%%"
  L["All EP and GP decayed by %s%%"] = "所有EP和GP递减 %s%%"
  L["All GP has been reset to %d."] = "所有GP已重置为 %d."
  L["All EP and GP has been reset to 0/%d."] = "所有EP和GP已重置为 0/%d."
  L["You now have: %d EP %d GP |cffffff00%.03f|r|cffff7f00PR|r."] = "你现在有: %d EP %d GP |cffffff00%.03f|r|cffff7f00PR|r."
  L["Close to EPGP Cap. Next Decay will change your |cffff7f00PR|r by |cffff0000%.4g|r."] = "下次递减会改变你的 |cffff7f00PR|r 从 |cffff0000%.4g|r."
  L["|cffffff00Click|r to toggle Standings.%s \n|cffffff00Right-Click|r for Options."] = "|cffffff00点击|r 切换名单.%s \n|cffffff00右键|r 设置."
  L[" \n|cffffff00Ctrl+Click|r to toggle Standby. \n|cffffff00Alt+Click|r to toggle Bids. \n|cffffff00Shift+Click|r to toggle Loot. \n|cffffff00Ctrl+Alt+Click|r to toggle Alts. \n|cffffff00Ctrl+Shift+Click|r to toggle Logs."] = " \n|cffffff00Ctrl+点击|r 切换到替补队员. \n|cffffff00Alt+点击|r 切换到竞拍. \n|cffffff00Shift+点击|r 切换到拾取. \n|cffffff00Ctrl+Shift+点击|r 切换到日志." -- needs update
  L["Account EPs to %s."] = "记账 EP 到 %s."
  L["Account GPs to %s."] = "记账 GP 到 %s."
  L["BastionEPGP options"] = "BastionEPGP 设置"
  L["+EPs to Member"] = "+EP给成员"
  L["Account EPs for member."] = "记账 EP 给成员."
  L["+EPs to Raid"] = "+EP给团队"
  L["Award EPs to all raid members."] = "奖励 EP 给所有团队成员."
  L["+GPs to Member"] = "+GP给成员"
  L["Account GPs for member."] = "记账 GP给成员."
  L["+EPs to Standby"] = "+EP给替补队员"
  L["Award EPs to all active Standby."] = "奖励EP给所有在线的替补队员."
  L["Enable Standby"] = "激活替补成员"
  L["Participate in Standby Raiders List.\n|cffff0000Requires Main Character Name.|r"] = "参与在备用团队列表.\n|cffff0000要求大号名字.|r"
  L["AFK Check Standby"] = "替补队员AFK检查"
  L["AFK Check Standby List"] = "检查AFK的替补成员"
  L["Set Main"] = "设置大号"
  L["Set your Main Character for Standby List."] = "设置你的大号人物为替补成员列表."
  L["Raid Progress"] = "公会raid进度"
  L["Highest Tier the Guild is raiding.\nUsed to adjust GP Prices.\nUsed for suggested EP awards."] = "设置公会的最高raid进度.\n用于调整GP价格.\n用于自动调整推荐EP奖励值."
  L["4.Naxxramas"] = "4.纳克萨玛斯"
  L["3.Temple of Ahn\'Qiraj"] = "3.安其拉神殿"
  L["2.Blackwing Lair"] = "2.黑翼之巢"
  L["1.Molten Core"] = "1.熔火之心"
  L["Reporting channel"] = "报告频道"
  L["Channel used by reporting functions."] = "报告功能使用的频道."
  L["Decay EPGP"] = "递减 EPGP"
  L["Decays all EPGP by %s%%"] = "递减所有 EPGP 从 %s%%"
  L["Set Decay %"] = "设置递减 %"
  L["Set Decay percentage (Admin only)."] = "设置递减百分比 (只能管理员)."
  L["Offspec Price %"] = "副天赋价值 %"
  L["Set Offspec Items GP Percent."] = "设置副天赋物品 GP 百分比."
  L["Reset EPGP"] = "重置 EPGP"
  L["Resets everyone\'s EPGP to 0/%d (Guild Leader only)."] = "重置所有人的 EPGP 到 0/%d (只能管理员)."
  L["Scanning %d members for EP/GP data. (%s)"] = "扫描 %d 成员 EP/GP 数据. (%s)"
  L["|cffff0000%s|r trying to add %s to Standby, but has already added a member. Discarding!"] = "|cffff0000%s|r 试图添加 %s 给替补成员, 但已经增加了一个成员。"
  L["|cffff0000%s|r has already been added to Standby. Discarding!"] = "|cffff0000%s|r 已经添加到替补成员."
  L["^{BEPGP}Type"] = "^{BEPGP}使用"
  L["Clearing old Bids"] = "结算之前的竞拍"
  L["%s not found in the guild or not raid level!"] = "%s 没有在公会中找到或不是最高级别！"
  L["Molten Core"] = "熔火之心"
  L["Onyxia\'s Lair"] = "奥妮克希亚的巢穴"
  L["Blackwing Lair"] = "黑翼之巢"
  L["Ahn\'Qiraj"] = "安其拉"
  L["Naxxramas"] = "纳克萨玛斯"
  L["There are %d loot drops stored. It is recommended to clear loot info before a new raid. Do you want to clear it now?"] = "这个 %d 掉落是个战利品. 建议在新的RAID之前清除拾取物信息. 你现在想清除它吗？"
  L["Show me"] = "秀出來"
  L["Loot info cleared"] = "战利品信息清除"
  L["Loot info can be cleared at any time from the loot window or '/bepgp clearloot' command"] = "拾取信息可以随时从小地图上下文菜单中清除，或者用 '/shooty clearloot' 命令" -- needs update
  L["Set your main to be able to participate in Standby List EPGP Checks."] = "设定你的主要人物到参与替补成员EPGP检查清单."
  L["Standby AFKCheck. Are you available? |cff00ff00%0d|rsec."] = "替补成员AFK检查. 你在吗? |cff00ff00%0d|r秒."
  L["|cffff0000Are you sure you want to Reset ALL EPGP?|r"] = "|cffff0000您确定要重置全部 EPGP?|r"
  L["Add MainSpec GP"] = "添加主天赋 GP"
  L["Add OffSpec GP"] = "添加副天赋 GP"
  L["Bank or D/E"] = "公会银行或分解师"
  L["%s looted %s. What do you want to do?"] = "%s 拾取了 %s. 你想做什么？"
  L["GP Actions"] = "GP 操作"
  L["Remind me Later"] = "以后提醒我"
  L["Need MasterLooter to perform Bid Calls!"] = "Need MasterLooter to perform Bid Calls!"
  L["BastionEPGP alts"] = "BastionEPGP 小号"
  L["Enable Alts"] = "启用小号"
  L["Main"] = "大号"
  L["Alt"] = "小号"
  L["Allow Alts to use Main\'s EPGP."] = "允许小号使用大号的 EPGP."
  L["Alts EP %"] = "小号 EP %"
  L["Set the % EP Alts can earn."] = "设置 % EP 小号可以赚取."
  L[", alts"] = ", 小号"
  L["New Alts"] = "新小号"
  L[", alts ep %"] = ", 小号 ep %"
  L["New Alts EP %"] = "新小号 EP %"
  L["Manually modified %s\'s note. Previous main was %s"] = "手动调整 %s 的备注. 以前的大号是 %s"
  L["|cffff0000Manually modified %s\'s note. Previous main was %s|r"] = "|cffff0000手动调整 %s 的备注. 以前的大号是 %s|r"
  L[", %s\'s Main."] = ", %s 的大号."
  L["Your main has been set to %s"] = "你的大号设置为 %s"
  L["Alts"] = "小号"
  L["Logs cleared"] = "清除日志"
  L["Restarted"] = "重新启动"
  L["Progress"] = "进度"
  L["Print Progress Multiplier."] = "打印进度调整器."
  L["Offspec"] = "副天赋"
  L["Print Offspec Price."] = "打印副天赋价格."
  L["Progress Setting: %s"] = "进度设置: %s"
  L["Offspec Price: %s%%"] = "副天赋价格: %s%%"
  L["Minimum EP: %s"] = "最小值 EP: %s"
  L["Minimum EP"] = "最小值 EP"
  L["Set Minimum EP"] = "设置最小值 EP"
  L["New Minimum EP"] = "新最小值 EP"
  L["Standby"] = "Standby" -- needs translation
  L["BoP"] = "BoP" -- needs translation
  L["BoE"] = "BoE" -- needs translation
  L["NoBind"] = "NoBind" -- needs translation
  L["Mainspec GP"] = "Mainspec GP" -- needs translation
  L["Offspec GP"] = "Offspec GP" -- needs translation
  L["Bank-D/E"] = "Bank-D/E" -- needs translation
  L["Unassigned"] = "Unassigned" -- needs translation
  L["Admin Options"] = "Admin Options" -- needs translation
  L["Member Options"] = "Member Options" -- needs translation
  L["Hide from Minimap"] = "Hide from Minimap" -- needs translation
  L["You are assigning %s %s to %s."] = "You are assigning %d %s to %s." -- needs translation
  L["Effort Points"] = "Effort Points" -- needs translation
  L["Gear Points"] = "Gear Points" -- needs translation
  L["Armor Class"] = "Armor Class" -- needs translation
  L["(ms)"] = "(ms)" -- needs translation (patterns)
  L["(need)"] = "(need)" -- needs translation (patterns)
  L["(os)"] = "(os)" -- needs translation (patterns)
  L["(greed)"] = "(greed)" -- needs translation (patterns)
  L["Mainspec Bids"] = "Mainspec Bids" -- needs translation
  L["Offspec Bids"] = "Offspec Bids" -- needs translation
  L["Tooltip Info"] = "Tooltip Info" -- needs translation
  L["Add EPGP Information to Item Tooltips"] = "Add EPGP Information to Item Tooltips" -- needs translation
  L["Export Loot"] = "Export Loot" -- needs translation
  L["Export Logs"] = "Export Logs" -- needs translation
  L["Export Standings"] = "Export Standings" -- need translation
  L["Select Price Scheme"] = "Select Price Scheme" -- need translation
  L["Select From Registered Price Systems"] = "Select From Registered Price Systems" -- need translation

  bepgp.L = L