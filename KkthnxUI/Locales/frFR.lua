local K, _, L = unpack(select(2, ...))

local _G = _G

local GetLocale = _G.GetLocale

if GetLocale() ~= "frFR" then
    return
end

-- Module Locales
L["%s players"] = "%s players"
L["AP"] = "AP:"
L["AddContactTip"] = "|nModify the contact list you need, the input format is 'UnitName-RealmName'.|nYou only need to enter name if unit is in the same realm with you.|nYou can customize text color for classify." -- need translation
L["AddToIgnoreList"] = "%s SpellID %s is now added to the ignored AuraWatch list. You can hold CTRL+ALT and click unit aura icon to remove from list."
L["All Buffs Ready"] = "[KkthnxUI] All Buffs Ready!"
L["Attach List"] = "Mail Attach List:"
L["AttackSpeed"] = "AS"
L["AuraWatch List"] = "Custom List"
L["AuraWatch Switcher"] = "Block preset auras"
L["AuraWatchGUI Tips"] = "|nGet more tips by mouseover each option header.|n|nYou need to reload UI after setting changed.|n|nYou can hold CTRL+ALT, and click AuraWatch icon to add spell into ignore list, or click UnitAura icon to remove spell from ignore list."
L["AuraWatchGUI Title"] = "KkthnxUI AuraWatch GUI"
L["Auto Quest Disabled Desc"] = "Enable to use auto questing. |n|nHolding SHIFT will temporarily disable the auto accept/turnin"
L["Auto Quest Disabled"] = "Status: |CFFFF0000Disabled|r"
L["Auto Quest Enabled Desc"] = "Disable to not use auto questing. |n|nHolding SHIFT will temporarily disable the auto accept/turnin"
L["Auto Quest Enabled"] = "Status: |CFF008000Enabled|r"
L["Auto Quest"] = "Auto Quest"
L["BFA Invasion"] = "Faction Assault"
L["BN"] = "BN"
L["Bars"] = "Bars"
L["BoE"] = "BoE"
L["BoP"] = "BoP"
L["CD"] = "CD"
L["CPU Usage"] = "CPU Usage"
L["Can't Buy Slot"] = "Can't buy anymore slots!"
L["Caster Intro"] = "|nFilter the spell caster.|n|nplayer: caster is player.|n|ntarget: caster is target.|n|npet: caster is pet.|n|nAll auras would be watched if blank."
L["Caster"] = "Caster"
L["Changelog"] = "Changelog"
L["Changes Reload"] = "One or more of the changes you have made require a UI Reload."
L["Check Flask Food"] = "Check Flask & Food"
L["CheckQuestComplete"] = " has been completed!"
L["CheckQuestInfo"] = "\nEnter questID found in Wowhead URL\nhttp://wowhead.com/quest=ID\nExample: /checkquest 12045\n"
L["CheckQuestNotComplete"] = " has not been completed!"
L["Choose a Type"] = "You need to select a type."
L["Clear Binds"] = "|CFFFFCC66All keybinds cleared for|r %s"
L["Collect All"] = "Open All"
L["Collect Gold"] = "Collect Gold"
L["Collect Letters"] = "Receive"
L["Collect Memory"] = "Collect Memory"
L["Combat Intro"] = "|nIf checked, the spell only shows in combat."
L["Combat"] = "Combat"
L["CombatLog"] = "Log"
L["Combo"] = "Com"
L["ContactList"] = "Contact List"
L["Copy Name"] = "Copy Name"
L["Crit"] = "Crit"
L["Ctrl Key"] = "(Ctrl) "
L["Current Invasion"] = "Current: "
L["Delete Mode Enabled"] = "|nYou can destroy container item by holding CTRL+ALT. |n|nThe item quality must be lower than |cff0070ddRare|r"
L["Disable to hide areas."] = "Disable to hide areas|nyou have not yet discovered."
L["Disband Group"] = "Disband Group"
L["Discard KeyBinds"] = "Keybinds discarded."
L["Discord URL"] = "https://discord.gg/YUmxqQm"
L["Discord"] = "|cff7289daDiscord|r"
L["Download"] = "Download"
L["Duration Intro"] = "|nThe duration of the timer that triggered."
L["Duration*"] = "Duration*"
L["Empty Slot"] = "Empty Slot"
L["Enable to show hidden areas."] = "Enable to show hidden areas|nyou have not yet discovered."
L["Enchant Aura"] = "Enchant"
L["Everyone"] = "Everyone"
L["ExRT Potion Check"] = "ExRT Potion Check"
L["Existing ID"] = "The SpellID is existed."
L["Experience"] = "Experience"
L["Extrabar"] = "Extra Actionbar"
L["FPS"] = "FPS"
L["Favourite Mode Enabled"] = "|nYou can now star items.|n|nIf 'Bags ItemFilter' is enabled, the item you starred will be added to the 'Preferences' filter slots.|n|nThis is not available to |cff9d9d9dTrash|r"
L["Favourite Mode"] = "Favourite Mode"
L["Fishy Loot"] = "Fishy Loot"
L["FixParty"] = "\n|cff669dff".."If you are still stuck in party, try the following".."|r\n\n|cff00ff001.|r Invite someone to a group and have them accept.\n|cff00ff002.|r Convert your group to a raid.\n|cff00ff003.|r Use the previous leave party command again.\n|cff00ff004.|r Invite your friend back to a group.\n\n"
L["Flash Intro"] = "|nIf checked, a highlight glow will show on icon when activated."
L["Flash"] = "Glow"
L["Flask"] = "Flask"
L["Focus Aura"] = "FocusAura"
L["Food"] = "Food"
L["From"] = "From"
L["General"] = "General"
L["Get Close"] = "Get Close"
L["Get Out"] = "Get out!"
L["Ghost"] = "Ghost"
L["Groups"] = "Groups"
L["Hidden"] = "Hidden"
L["Hide Undiscovered Areas"] = "Hide Undiscovered Areas"
L["Hold Shift"] = "Hold Shift"
L["Home Latency"] = "Home Latency"
L["Home Protocol"] = "Home Protocol"
L["Honor Remaining"] = "Honor Remaining:"
L["Honor XP"] = "Honor XP:"
L["ID Intro"] = "|nSpell ID, must be a number.|n|nYou can get ID on spell's GameTooltip.|n|nSpellname is not supported."
L["Incomplete Input"] = "You need to complete all * optinos."
L["Incorrect SpellID"] = "Incorrect SpellID."
L["Install"] = "Install"
L["IntID Intro"] = "|nThe spellID that triggers the timer, must be a number.|n|nYou can get ID on spell's GameTooltip.|n|nSpellname is not supported."
L["IntID*"] = "Spells*"
L["InternalCD"] = "CustomCD"
L["Interrupted Message"] = "Interrupted %s's \124cff71d5ff\124Hspell:%d:0\124h[%s]\124h\124r!"
L["Invalid Target"] = "Invalid Target"
L["Invite"] = "Invite"
L["Item Delete Mode"] = "Item Delete Mode"
L["Item Placed"] = "%s has placed down %s"
L["ItemID Intro"] = "|nThe item name of the timer that triggered.|n|nThe spellName would take place if blank."
L["ItemID"] = "Name"
L["Join or Invite"] = "Join or Invite"
L["KKUI_CustomBar"] = "CustomBar"
L["Key Binding"] = "Key"
L["Key Bound To"] = "bound to"
L["Key Index"] = "Index"
L["Keybind Mode"] = "Hover, your mouse over any action button, to bind it. Press the escape key or right click to clear the current action button's keybinding."
L["KkthnxUI Help"] = "KkthnxUI Help"
L["KkthnxUI Outdated"] = "Your version of KkthnxUI v"..K.Version.." ".."is out of date."
L["Lack"] = "Lack of"
L["Latency"] = "Latency"
L["Leeeeeroy!"] = "Leeeeeroy!"
L["Left Click"] = "Left Click"
L["Legion Invasion"] = "Legion Invasion"
L["Local Time"] = "Local Time"
L["Loot"] = "Loot"
L["MS"] = "MS"
L["Main Actionbar"] = "Main Actionbar"
L["Memory Collected"] = "Memory Collected"
L["Middle Click"] = "Middle Click:"
L["Missing DBM BigWigs"] = "You can't do it without DBM or BigWigs."
L["MoveUI"] = "MoveUI"
L["Next Invasion"] = "Next: "
L["No Guild"] = "No Guild"
L["No Key Set"] = "No key set"
L["Player Aura"] = "PlayerAura"
L["Power"] = "PW"
L["Press To Copy"] = "|nPress <CTRL/C> to copy."
L["Profile"] = "Profile "
L["ProfileDel"] = " Deleted: "
L["ProfileInfo"] = "\n/profile list\n/profile #\n/profile delete #\n\n"
L["ProfileNotFound"] = "Profile not found"
L["ProfileSelection"] = "Please type a profile # to use (example: /profile 5)"
L["Profiles"] = "Profiles"
L["Pull ABORTED!"] = "Pull ABORTED!"
L["Pulling In"] = "Pulling %s in %s.."
L["Quick Split"] = "Quick Split"
L["Raid Buff Checker"] = "[KkthnxUI] Raid Buff Checker:"
L["Raid Buff"] = "RaidBuff"
L["Raid Debuff"] = "RaidDebuff"
L["Raid Disbanding"] = "[KkthnxUI] Raid Disbanding"
L["Rare Spotted"] = "Rare Spotted "
L["Realm Time"] = "Realm Time"
L["Remaining"] = "Remaining:"
L["RemoveFromIgnoreList"] = "%s SpellID %s is now removed from the ignored AuraWatch list. You can hold CTRL+ALT and click AuraWatch icon to rejoin the list."
L["Repaired Failed"] = "You don't have enough money to repair,|r "
L["Repaired Items Guild"] = "Your items have been repaired using guild bank funds for: "
L["Repaired Items"] = "Your items have been repaired for:|r "
L["Reset Details"] = "Reset Details"
L["Reset KkthnxUI"] = "Are you sure you want to reset all the settings on this profile?"
L["Reset your AuraWatch List?"] = "Are you sure to wipe all your groups of custom list?"
L["Restart Graphics"] = "One or more of the changes you have made require a restart of the graphics engine."
L["Rested"] = "Rested:"
L["Reveal Hidden Areas"] = "Reveal Hidden Areas"
L["Reveal"] = "Reveal"
L["Right Click"] = "Right Click"
L["Sapped"] = "Sapped"
L["SappedBy"] = "Sapped by: "
L["Save KeyBinds"] = "Keybinds saved."
L["Saved Raid(s)"] = "Saved Raid(s)"
L["Show Hide Details"] = "Show/Hide Details"
L["Show Hide Skada"] = "Show/Hide Skada"
L["Slot Intro"] = "|nShow itemslot cooldown.|n|ne.g. Engeneering enchant on waist or cloak.|n|nIt only supports activated trinket."
L["Slot*"] = "Slot*"
L["Special Aura"] = "SpecialAura"
L["Spell Cooldown"] = "Cooldown"
L["Split Count"] = "Split Count"
L["Stack Buying Check"] = "Are you sure to buy |cffff0000a stack|r of these?"
L["Stack Cap"] = "Stack Caps"
L["Stack Intro"] = "|nSpell stack, must be number.|n|nThe spell only shows once it reach the stack you set.|n|nThe stack would be ignored if blank."
L["Stack"] = "Stack"
L["StackSplitEnable"] = "|nClick to split stacked items in you bags, you can change 'split count' for each click thru the editbox."
L["Start Stop Countdown"] = "Start/Stop Countdown"
L["Stranger"] = "Stranger"
L["Strike"] = "SS"
L["Summon From"] = "The summon from"
L["Summon Warning"] = "will be automatically accepted in 10 seconds unless cancelled."
L["SwitchMode"] = "Switch Mode"
L["System"] = "System"
L["Target Aura"] = "TargetAura"
L["Targeted By"] = "Targeted By:"
L["Text Intro"] = "|nShow text on spell.|n|nWhen the spell activated, it would show the text you set.|n|nThe text would be hidden when VALUE enabled or leave it blank."
L["Text"] = "Text"
L["Timeless Intro"] = "|nIf checked, the spell timer would be hidden."
L["Timeless"] = "Timeless"
L["Tips"] = "Tips"
L["To"] = "To"
L["Toggle KkthnxUI Config"] = "Toggle KkthnxUI Config"
L["Toggle Quick Menu"] = "Toggle Quick Menu"
L["Totem Intro"] = "|nShow the totem duration within the slot."
L["Totem*"] = "Totem*"
L["TotemSlot"] = "TotemSlot"
L["Trade"] = "Trade"
L["Trait"] = "Trait"
L["Trigger"] = "Trigger"
L["Tutorial Page1"] = "Welcome to the install tutorial!|n|nClick the apply button (bottom right) to apply some default settings. This includes (not limited to) Nameplates, Actionbars, Unitframes and more.|n|n|cffff0000These are always recommended.|r"
L["Tutorial Page2"] = "You made it to the next step!|n|nHere we are going to load some relevant settings for the ChatFrame! These are important as these settings are tailored for KkthnxUI|n|n|cffff0000CAUTIONS:|r|n|n|cff00ccffYou can scroll to top or bottom of the chat by holding key SHIFT on the Chatframe.|r"
L["Tutorial Page3"] = "Still here? Good!|n|nThis is the section to apply recommended scale based on your current resolution.|n|nYou can change the UIScale in |cffffcc00KkthnxUI Config Settings (General Tab)|r later."
L["Tutorial Page4"] = "At the end, profile settings for Skada/DBM/BigWigs and a few other addOns will be imported if they are loaded/enabled right now.|n|nYou can switch their skins off in |cffffcc00KkthnxUI Config (Skins Tab)|r."
L["Tutorial Page5"] = "Well you made it to the end! You have completed the tutorial.|n|n|cffff0000CAUTIONS:|r|n|nYou can easily set focus by holding SHIFT and LEFT click on the unit;|n|nMost of the settings can be changed in |cffffcc00KkthnxUI Config|r.|r Good luck and have fun "..K.Name
L["Type Intro"] = "|nAuraID: monitor the Buff/Debuff status.|n|nSpellID: monitor spell cooldown.|n|nSlotID: monitor itemslot cooldown.|n|nTotemID: monitor activated totem duration."
L["Type*"] = "Type*"
L["Unit Intro"] = "|nThe spell's unit info.|n|nplayer: unit is player.|n|ntarget: unit is target.|n|nfocus: unit is focus.|n|npet: unit is pet."
L["Unit*"] = "Unit*"
L["Value Intro"] = "|nIf checked, spell value would be visible.|n|ne.g. Priest's Shield would show its remaining absorb amount.|n|nIt has higher priority than TEXT."
L["Value"] = "Value"
L["Vendored Items"] = "Vendored gray items for:|r "
L["Warning"] = "Warning"
L["Whisper"] = "Whisper"
L["WoW"] = "WoW"
L["World Latency"] = "World Latency"
L["World Protocol"] = "World Protocol"
L["XP"] = "XP:"

-- GUI Group Title Locales
L["ActionBar"] = "ActionBar"
L["Announcements"] = "Announcements"
L["Arena"] = "Arena"
L["Auras"] = "Auras"
L["Automation"] = "Automation"
L["Boss"] = "Boss"
L["Chat"] = "Chat"
L["DataBars"] = "DataBars"
L["DataText"] = "DataText"
L["AuraWatch"] = "AuraWatch"
L["Inventory"] = "Inventory"
L["Minimap"] = "Minimap"
L["Misc"] = "Misc"
L["Nameplate"] = "Nameplate"
L["Party"] = "Party"
L["PulseCooldown"] = "PulseCooldown"
L["QuestNotifier"] = "QuestNotifier"
L["Raid"] = "Raid"
L["Skins"] = "Skins"
L["Tooltip"] = "Tooltip"
L["UIFonts"] = "UIFonts"
L["UITextures"] = "UITextures"
L["Unitframe"] = "Unitframe"
L["WorldMap"] = "WorldMap"

-- GUI Group Options Description Locals
L["Enable ActionBar"] = "Enable ActionBar"
L["Show Cooldowns"] = "Show Cooldowns"
L["Enable Count"] = "Enable Count"
L["Format Cooldowns As Decimals"] = "Format Cooldowns As Decimals"
L["Mouseover PetBar"] = "Mouseover PetBar"
L["Mouseover RightBar 1"] = "Mouseover RightBar 1"
L["Mouseover RightBar 2"] = "Mouseover RightBar 2"
L["Mouseover StanceBar"] = "Mouseover StanceBar"
L["Enable Hotkey"] = "Enable Hotkey"
L["Enable Macro"] = "Enable Macro"
L["Enable MicroBar"] = "Enable MicroBar"
L["Enable MicroBarMouseover"] = "Enable MicroBarMouseover"
L["Enable OverrideWA"] = "Enable OverrideWA"
L["Show PetBar"] = "Show PetBar"
L["Show StanceBar"] = "Show StanceBar"
L["Enable CustomBar"] = "Enable CustomBar"
L["Set CustomBar Button Size"] = "Set CustomBar Button Size"
L["Set CustomBar Num Buttons"] = "Set CustomBar Num Buttons"
L["Set CustomBar Num PerRow"] = "Set CustomBar Num PerRow"
L["Set MainBars Button Size"] = "Set MainBars Button Size"
L["Set RightBars Button Size"] = "Set RightBars Button Size"
L["Set Stance/Pet Button Size"] = "Set Stance/Pet Button Size"
L["Choose Your Layout"] = "Choose Your Layout"

L["Announce Items Being Placed"] = "Announce Items Being Placed"
L["Announce Pull Countdown (/pc #)"] = "Announce Pull Countdown (/pc #)"
L["Announce Rares, Chests & War Supplies"] = "Announce Rares, Chests & War Supplies"
L["Alert Group After Instance Resetting"] = "Alert Group After Instance Resetting"
L["Announce When Sapped"] = "Announce When Sapped"
L["Announce Interrupts"] = "Announce Interrupts"
L["Blocks Invites From Strangers"] = "Blocks Invites From Strangers"
L["Auto Collapse Objective Tracker"] = "Auto Collapse Objective Tracker"
L["Decline PvP Duels"] = "Decline PvP Duels"
L["Decline Pet Duels"] = "Decline Pet Duels"
L["Say Goodbye After Dungeon Completion."] = "Say Goodbye After Dungeon Completion."
L["Accept Invites From Friends & Guild Members"] = "Accept Invites From Friends & Guild Members"
L["Accept PartySync From Friends & Guild Members"] = "Accept PartySync From Friends & Guild Members"
L["Auto Release in Battlegrounds & Arenas"] = "Auto Release in Battlegrounds & Arenas"
L["Auto Accept Resurrect Requests"] = "Auto Accept Resurrect Requests"
L["Say 'Thank You' When Resurrected"] = "Say 'Thank You' When Resurrected"
L["Auto Select Quest Rewards Best Value"] = "Auto Select Quest Rewards Best Value"
L["Auto Screenshot Achievements"] = "Auto Screenshot Achievements"
L["Auto Set Your Role In Groups"] = "Auto Set Your Role In Groups"
L["Auto Skip All Cinematic/Movies"] = "Auto Skip All Cinematic/Movies"
L["Auto Accept Summon Requests"] = "Auto Accept Summon Requests"
L["Only Tab Target Enemy Players"] = "Only Tab Target Enemy Players"
L["Automatically Remove Annoying Buffs"] = "Automatically Remove Annoying Buffs"
L["Auto Accept Invite Keyword"] = "Auto Accept Invite Keyword"
L["Milling, Prospecting & Disenchanting by Alt + Click"] = "Milling, Prospecting & Disenchanting by Alt + Click"

L["Enable Inventory"] = "Enable Inventory"
L["Auto Vendor Grays"] = "Auto Vendor Grays"
L["Enable Bagbar"] = "Enable Bagbar"
L["Fade Bagbar"] = "Fade Bagbar"
L["Display Item Level"] = "Display Item Level"
L["Bags Delete Button"] = "Bags Delete Button"
L["Show New Item Glow"] = "Show New Item Glow"
L["Show Upgrade Icon"] = "Show Upgrade Icon"
L["Umm Reverse The Sorting"] = "Umm Reverse The Sorting"
L["Auto Repair Gear"] = "Auto Repair Gear"
L["Gather Empty Slots Into One Button"] = "Gather Empty Slots Into One Button"
L["Filter Items Into Categories"] = "Filter Items Into Categories"
L["Filter EquipmentSets"] = "Filter EquipmentSets"
L["Filter Azerite Items"] = "Filter Azerite Items"
L["Filter Consumable Items"] = "Filter Consumable Items"
L["Filter Equipment Items"] = "Filter Equipment Items"
L["Filter Favourite Items"] = "Filter Favourite Items"
L["Filter Goods Items"] = "Filter Goods Items"
L["Filter Junk Items"] = "Filter Junk Items"
L["Filter Legendary Items"] = "Filter Legendary Items"
L["Filter Mount Items"] = "Filter Mount Items"
L["Filter Quest Items"] = "Filter Quest Items"
L["Bags Width"] = "Bags Width"
L["Bank Width"] = "Bank Width"
L["Slot Icon Size"] = "Slot Icon Size"

L["Enable Auras"] = "Enable Auras"
L["Auras Reminder (Shout/Intellect/Poison)"] = "Auras Reminder (Shout/Intellect/Poison)"
L["Buffs Grow Right"] = "Buffs Grow Right"
L["Debuffs Grow Right"] = "Debuffs Grow Right"
L["Buff Icon Size"] = "Buff Icon Size"
L["Buffs per Row"] = "Buffs per Row"
L["DeBuff Icon Size"] = "DeBuff Icon Size"
L["DeBuffs per Row"] = "DeBuffs per Row"
L["Enable TotemBar"] = "Enable TotemBar"
L["Vertical TotemBar"] = "Vertical TotemBar"
L["Totems IconSize"] = "Totems IconSize"

L["AuraWatch GUI"] = "AuraWatch GUI"
L["Enable AuraWatch"] = "Enable AuraWatch"
L["Disable AuraWatch Tooltip (ClickThrough)"] = "Disable AuraWatch Tooltip (ClickThrough)"
L["Track Auras From Previous Expansions"] = "Track Auras From Previous Expansions"
L["Alert On M+ Quake"] = "Alert On M+ Quake"
L["AuraWatch IconScale"] = "AuraWatch IconScale"

L["Enable Chat"] = "Enable Chat"
L["Lock Chat"] = "Lock Chat"
L["Show Chat Background"] = "Show Chat Background"
L["Show ItemLevel on ChatFrames"] = "Show ItemLevel on ChatFrames"
L["Show Chat Menu Buttons"] = "Show Chat Menu Buttons"
L["Disable Chat Language Filter"] = "Disable Chat Language Filter"
L["Show Chat Loot Icons"] = "Show Chat Loot Icons"
L["Use Default Channel Names"] = "Use Default Channel Names"
L["Stick On Channel If Whispering"] = "Stick On Channel If Whispering"
L["Fade Chat Tabs"] = "Fade Chat Tabs"
L["Differ Whipser Colors"] = "Differ Whipser Colors"
L["Whisper Sound"] = "Whisper Sound"
L["Custom Chat Timestamps"] = "Custom Chat Timestamps"
L["Lock Chat Width"] = "Lock Chat Width"
L["Lock Chat Height"] = "Lock Chat Height"
L["Fade Chat Text"] = "Fade Chat Text"
L["Fading Chat Visible Time"] = "Fading Chat Visible Time"
L["Enable Chat Filter"] = "Enable Chat Filter"
L["ChatFilter BlackList"] = "ChatFilter BlackList"
L["ChatFilter WhiteList"] = "ChatFilter WhiteList"
L["Block 'Some' AddOn Alerts"] = "Block 'Some' AddOn Alerts"
L["Block Whispers From Strangers"] = "Block Whispers From Strangers"
L["Allow Spam From Friends"] = "Allow Spam From Friends"
L["Filter Matches Number"] = "Filter Matches Number"

L["Enable DataBars"] = "Enable DataBars"
L["Fade DataBars"] = "Fade DataBars"
L["Show Text"] = "Show Text"
L["Track Honor"] = "Track Honor"
L["Pick Text Formatting"] = "Pick Text Formatting"
L["DataBars Width"] = "DataBars Width"
L["DataBars Height"] = "DataBars Height"
L["Azerite Bar Color"] = "Azerite Bar Color"
L["Experience Bar Color"] = "Experience Bar Color"
L["Honor Bar Color"] = "Honor Bar Color"
L["Rested Bar Color"] = "Rested Bar Color"

L["Enable Currency Info"] = "Enable Currency Info"
L["Enable Friends Info"] = "Enable Friends Info"
L["Enable Guild Info"] = "Enable Guild Info"
L["Enable Latency Info"] = "Enable Latency Info"
L["Enable Minimap Location"] = "Enable Minimap Location"
L["Enable System Info"] = "Enable System Info"
L["Enable Minimap Time"] = "Enable Minimap Time"

L["Import a profile from another character"] = "Import a profile from another character"
L["Auto Scale"] = "Auto Scale"
L["Color 'Most' KkthnxUI Borders"] = "Color 'Most' KkthnxUI Borders"
L["Move Blizzard Frames"] = "Move Blizzard Frames"
L["Disable 'Some' Blizzard Tutorials"] = "Disable 'Some' Blizzard Tutorials"
L["Replace 'Some' Blizzard Fonts"] = "Replace 'Some' Blizzard Fonts"
L["Replace Blizzard Combat Font"] = "Replace Blizzard Combat Font"
L["Enable Version Checking"] = "Enable Version Checking"
L["Show Welcome Message"] = "Show Welcome Message"
L["Adjust 'Some' Font Sizes"] = "Adjust 'Some' Font Sizes"
L["Number Prefix Style"] = "Number Prefix Style"
L["Set UI scale"] = "Set UI scale"
L["Textures Color"] = "Textures Color"

L["Enable Loot"] = "Enable Loot"
L["Enable Group Loot"] = "Enable Group Loot"
L["Auto Confirm Loot Dialogs"] = "Auto Confirm Loot Dialogs"
L["Auto Greed Green Items"] = "Auto Greed Green Items"
L["Faster Auto-Looting"] = "Faster Auto-Looting"

L["Enable Minimap"] = "Enable Minimap"
L["Show Minimap Calendar"] = "Show Minimap Calendar"
L["Show Garrison Button"] = "Show Garrison Button"
L["Show Minimap Button Collector"] = "Show Minimap Button Collector"
L["Location Text Style"] = "Location Text Style"
L["Blip Icon Styles"] = "Blip Icon Styles"
L["Minimap Size"] = "Minimap Size"

L["AFK Camera"] = "AFK Camera"
L["Enhanced Color Picker"] = "Enhanced Color Picker"
L["EasyMarking by Ctrl + LeftClick"] = "EasyMarking by Ctrl + LeftClick"
L["Enhanced Colors (Friends/Guild +)"] = "Enhanced Colors (Friends/Guild +)"
L["Character/Inspect Gem/Enchant Info"] = "Character/Inspect Gem/Enchant Info"
L["Hide RaidBoss EmoteFrame"] = "Hide RaidBoss EmoteFrame"
L["Hide BossBanner"] = "Hide BossBanner"
L["Display Character Frame Full Stats"] = "Display Character Frame Full Stats"
L["Show Character/Inspect ItemLevel Info"] = "Show Character/Inspect ItemLevel Info"
L["Show Your Killing Blow Info"] = "Show Your Killing Blow Info"
L["Remove And Hide The TalkingHead Frame"] = "Remove And Hide The TalkingHead Frame"
L["Auto Emote On Your Killing Blow"] = "Auto Emote On Your Killing Blow"
L["Show Wowhead Links Above Questlog Frame"] = "Show Wowhead Links Above Questlog Frame"
L["Show Slot Durability %"] = "Show Slot Durability %"
L["Add Spellbook-Like Tabs On TradeSkillFrame"] = "Add Spellbook-Like Tabs On TradeSkillFrame"
L["World Markers Bar"] = "World Markers Bar"

L["Enable Nameplates"] = "Enable Nameplates"
L["Show AngryKeystones Progress"] = "Show AngryKeystones Progress"
L["Show Enemy Class Icons"] = "Show Enemy Class Icons"
L["Colored Custom Units"] = "Colored Custom Units"
L["Revert Threat Color If Not Tank"] = "Revert Threat Color If Not Tank"
L["Scale Nameplates for Explosives"] = "Scale Nameplates for Explosives"
L["Show Friendly ClassColor"] = "Show Friendly ClassColor"
L["Show Health Value"] = "Show Health Value"
L["Show Hostile ClassColor"] = "Show Hostile ClassColor"
L["Interacted Nameplate Stay Inside"] = "Interacted Nameplate Stay Inside"
L["Show Only Names For Friendly"] = "Show Only Names For Friendly"
L["Target Nameplate ClassPower"] = "Target Nameplate ClassPower"
L["Quest Progress Indicator"] = "Quest Progress Indicator"
L["Smooth Bars Transition"] = "Smooth Bars Transition"
L["Force TankMode Colored"] = "Force TankMode Colored"
L["Auras Filter Style"] = "Auras Filter Style"
L["TargetIndicator Style"] = "TargetIndicator Style"
L["Auras Size"] = "Auras Size"
L["Nameplete MaxDistance"] = "Nameplete MaxDistance"
L["Unit Execute Ratio"] = "Unit Execute Ratio"
L["HealthText FontSize"] = "HealthText FontSize"
L["Max Auras"] = "Max Auras"
L["Non-Target Nameplate Alpha"] = "Non-Target Nameplate Alpha"
L["Non-Target Nameplate Scale"] = "Non-Target Nameplate Scale"
L["NameText FontSize"] = "NameText FontSize"
L["Nameplate Height"] = "Nameplate Height"
L["Nameplate Width"] = "Nameplate Width"
L["Nameplate Vertical Spacing"] = "Nameplate Vertical Spacing"
L["Enable Personal Resource"] = "Enable Personal Resource"
L["Track Personal Class Auras"] = "Track Personal Class Auras"
L["Enable GCD Ticker"] = "Enable GCD Ticker"
L["Only Visible in Combat"] = "Only Visible in Combat"
L["Show Power Value"] = "Show Power Value"
L["Classpower/Healthbar Height"] = "Classpower/Healthbar Height"
L["PlayerPlate IconSize"] = "PlayerPlate IconSize"
L["PlayerPlate Powerbar Height"] = "PlayerPlate Powerbar Height"
L["Custom Color"] = "Custom Color"
L["Insecure Color"] = "Insecure Color"
L["Off-Tank Color"] = "Off-Tank Color"
L["Secure Color"] = "Secure Color"
L["TargetIndicator Color"] = "TargetIndicator Color"
L["Transition Color"] = "Transition Color"

L["Enable PulseCooldown"] = "Enable PulseCooldown"
L["Play Sound On Pulse"] = "Play Sound On Pulse"
L["Animation Scale"] = "Animation Scale"
L["How Long To Display"] = "How Long To Display"
L["Icon Size"] = "Icon Size"
L["Minimal Threshold Time"] = "Minimal Threshold Time"

L["Bartender4 Skin"] = "Bartender4 Skin"
L["BigWigs Skin"] = "BigWigs Skin"
L["Skin Some Blizzard Frames & Objects"] = "Skin Some Blizzard Frames & Objects"
L["ChatBubbles Skin"] = "ChatBubbles Skin"
L["ChocolateBar Skin"] = "ChocolateBar Skin"
L["Deadly Boss Mods Skin"] = "Deadly Boss Mods Skin"
L["Details Skin"] = "Details Skin"
L["Hekili Skin"] = "Hekili Skin"
L["Skada Skin"] = "Skada Skin"
L["Spy Skin"] = "Spy Skin"
L["TalkingHead Skin"] = "TalkingHead Skin"
L["TellMeWhen Skin"] = "TellMeWhen Skin"
L["TitanPanel Skin"] = "TitanPanel Skin"
L["WeakAuras Skin"] = "WeakAuras Skin"
L["Reset Details"] = "Reset Details"
L["ChatBubbles Background Alpha"] = "ChatBubbles Background Alpha"

L["Quality Color Border"] = "Quality Color Border"
L["Hide Tooltip in Combat"] = "Hide Tooltip in Combat"
L["Follow Cursor"] = "Follow Cursor"
L["Show Faction Icon"] = "Show Faction Icon"
L["Abbreviate Guild Names"] = "Abbreviate Guild Names"
L["Hide Guild Rank"] = "Hide Guild Rank"
L["Show realm name by SHIFT"] = "Show realm name by SHIFT"
L["Hide Player Title"] = "Hide Player Title"
L["Item Icons"] = "Item Icons"
L["Show Roles Assigned Icon"] = "Show Roles Assigned Icon"
L["Show Tooltip IDs"] = "Show Tooltip IDs"
L["Show Spec/ItemLevel by SHIFT"] = "Show Spec/ItemLevel by SHIFT"
L["Show Player Targeted By"] = "Show Player Targeted By"

L["Set ActionBar Font"] = "Set ActionBar Font"
L["Set Auras Font"] = "Set Auras Font"
L["Set Chat Font"] = "Set Chat Font"
L["Set DataBars Font"] = "Set DataBars Font"
L["Set DataText Font"] = "Set DataText Font"
L["Set Filger Font"] = "Set Filger Font"
L["Set General Font"] = "Set General Font"
L["Set Inventory Font"] = "Set Inventory Font"
L["Set Minimap Font"] = "Set Minimap Font"
L["Set Nameplate Font"] = "Set Nameplate Font"
L["Set QuestTracker Font"] = "Set QuestTracker Font"
L["Set Skins Font"] = "Set Skins Font"
L["Set Tooltip Font"] = "Set Tooltip Font"
L["Set Unitframe Font"] = "Set Unitframe Font"

L["Set DataBars Texture"] = "Set DataBars Texture"
L["Set Filger Texture"] = "Set Filger Texture"
L["Set General Texture"] = "Set General Texture"
L["Set HealPrediction Texture"] = "Set HealPrediction Texture"
L["Set Loot Texture"] = "Set Loot Texture"
L["Set Nameplate Texture"] = "Set Nameplate Texture"
L["Set QuestTracker Texture"] = "Set QuestTracker Texture"
L["Set Skins Texture"] = "Set Skins Texture"
L["Set Tooltip Texture"] = "Set Tooltip Texture"
L["Set Unitframe Texture"] = "Set Unitframe Texture"

L["Class Color Castbars"] = "Class Color Castbars"
L["Reaction Color Castbars"] = "Reaction Color Castbars"
L["Show Castbar Latency"] = "Show Castbar Latency"
L["Enable Castbars"] = "Enable Castbars"
L["Show Class Resources"] = "Show Class Resources"
L["Fade Unitframes"] = "Fade Unitframes"
L["Show Health Debuff Highlight"] = "Show Health Debuff Highlight"
L["Enable Unitframes"] = "Enable Unitframes"
L["Show Global Cooldown"] = "Show Global Cooldown"
L["Only Show Your Debuffs"] = "Only Show Your Debuffs"
L["Portrait Spell Timers"] = "Portrait Spell Timers"
L["Show PvP Indicator on Player / Target"] = "Show PvP Indicator on Player / Target"
L["Sound Played When You Are Resurrected"] = "Sound Played When You Are Resurrected"
L["Show HealPrediction Statusbars"] = "Show HealPrediction Statusbars"
L["Smooth Bars"] = "Smooth Bars"
L["Show |CFF00FF96Monk|r Stagger Bar"] = "Show |CFF00FF96Monk|r Stagger Bar"
L["Unitframe Swingbar"] = "Unitframe Swingbar"
L["Unitframe Swingbar Timer"] = "Unitframe Swingbar Timer"
L["Enable Simple CombatText"] = "Enable Simple CombatText"
L["Show AutoAttack Damage"] = "Show AutoAttack Damage"
L["Show Full OverHealing"] = "Show Full OverHealing"
L["Show Hots and Dots"] = "Show Hots and Dots"
L["Pet's Healing/Damage"] = "Pet's Healing/Damage"
L["Show Additional Mana Power (|CFFFF7D0ADruid|r, |CFFFFFFFFPriest|r, |CFF0070DEShaman|r)"] = "Show Additional Mana Power (|CFFFF7D0ADruid|r, |CFFFFFFFFPriest|r, |CFF0070DEShaman|r)"
L["Show Player Frame Buffs"] = "Show Player Frame Buffs"
L["Show Player Frame Debuffs"] = "Show Player Frame Debuffs"
L["Show Player Power Prediction"] = "Show Player Power Prediction"
L["Show Player Frame Level"] = "Show Player Frame Level"
L["Show Player Frame Name"] = "Show Player Frame Name"
L["Show Target Frame Buffs"] = "Show Target Frame Buffs"
L["Show Target Frame Debuffs"] = "Show Target Frame Debuffs"
L["Number of Buffs Per Row"] = "Number of Buffs Per Row"
L["Number of Debuffs Per Row"] = "Number of Debuffs Per Row"
L["Hide TargetofTarget Frame"] = "Hide TargetofTarget Frame"
L["Hide TargetofTarget Level"] = "Hide TargetofTarget Level"
L["Hide TargetofTarget Name"] = "Hide TargetofTarget Name"
L["Player Castbar Height"] = "Player Castbar Height"
L["Player Castbar Width"] = "Player Castbar Width"
L["Target Castbar Height"] = "Target Castbar Height"
L["Target Castbar Width"] = "Target Castbar Width"
L["Health Color Format"] = "Health Color Format"
L["Unitframe Portrait Style"] = "Unitframe Portrait Style"

L["Enable Party"] = "Enable Party"
L["Show Castbars"] = "Show Castbars"
L["Portrait Spell Timers"] = "Portrait Spell Timers"
L["Show Party Buffs"] = "Show Party Buffs"
L["Show HealPrediction Statusbars"] = "Show HealPrediction Statusbars"
L["Show Party Pets"] = "Show Party Pets"
L["Show Player In Party"] = "Show Player In Party"
L["Smooth Bar Transition"] = "Smooth Bar Transition"
L["Show Highlighted Target"] = "Show Highlighted Target"
L["Health Color Format"] = "Health Color Format"

L["Enable Boss"] = "Enable Boss"
L["Show Castbars"] = "Show Castbars"
L["Smooth Bar Transition"] = "Smooth Bar Transition"
L["Health Color Format"] = "Health Color Format"

L["Enable Arena"] = "Enable Arena"
L["Show Castbars"] = "Show Castbars"
L["Smooth Bar Transition"] = "Smooth Bar Transition"
L["Health Color Format"] = "Health Color Format"

L["Enable Raidframes"] = "Enable Raidframes"
-- L["AuraWatch"] = "AuraWatch"
L["Show AuraWatch Icons"] = "Show AuraWatch Icons"
L["Horizontal Raid Frames"] = "Horizontal Raid Frames"
L["Show Manabars"] = "Show Manabars"
L["Show Raid Utility Frame"] = "Show Raid Utility Frame"
L["Reverse Raid Frame Growth"] = "Reverse Raid Frame Growth"
L["Show HealPrediction Statusbars"] = "Show HealPrediction Statusbars"
L["Show Away/DND Status"] = "Show Away/DND Status"
L["Show Group Number Team Index"] = "Show Group Number Team Index"
L["Smooth Bar Transition"] = "Smooth Bar Transition"
L["Save Raid Positions Based On Specs"] = "Save Raid Positions Based On Specs"
L["Show Highlighted Target"] = "Show Highlighted Target"
L["Aura Debuff Icon Size"] = "Aura Debuff Icon Size"
L["AuraWatch Icon Size"] = "AuraWatch Icon Size"
L["Raidframe Height"] = "Raidframe Height"
L["Number Of Groups to Show"] = "Number Of Groups to Show"
L["Raidframe Width"] = "Raidframe Width"
L["Health Color Format"] = "Health Color Format"
L["Health Format"] = "Health Format"

L["Enable QuestNotifier"] = "Enable QuestNotifier"
L["Only Play Complete Quest Sound"] = "Only Play Complete Quest Sound"
L["Alert QuestProgress In Chat"] = "Alert QuestProgress In Chat"

L["Show Player/Mouse Coordinates"] = "Show Player/Mouse Coordinates"
L["Fade Worldmap When Moving"] = "Fade Worldmap When Moving"
L["Show Zones You Have Yet to Discover"] = "Show Zones You Have Yet to Discover"
L["Show Map Reveal Overlay Shadow"] = "Show Map Reveal Overlay Shadow"
L["Show Smaller Worldmap"] = "Show Smaller Worldmap"
L["Alpha When Moving"] = "Alpha When Moving"

-- GUI Config Tooltip Locales
L["ExecuteRatioTip"] = "If unit health percentage is lower than the execute cap value you set, its name turns red.|n|nThe execute indicator will be disabled on 0."