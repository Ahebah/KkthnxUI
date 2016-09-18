﻿local K, C, L, _ = select(2, ...):unpack()
if C.Tooltip.Enable ~= true then return end

-- LUA API
local _G = _G
local gsub, find, format = string.gsub, string.find, string.format
local unpack = unpack

-- WOW API
local CHAT_FLAG_AFK = CHAT_FLAG_AFK
local CHAT_FLAG_DND = CHAT_FLAG_DND
local LEVEL = LEVEL
local RaidColors = RAID_CLASS_COLORS

local BackdropColor = {0, 0, 0}
local HealthBar = GameTooltipStatusBar
local HealthBarBG = CreateFrame("Frame", "StatusBarBG", HealthBar)
local Short = K.ShortValue
local Texture = C.Media.Texture
local Tooltip = CreateFrame("Frame")

Tooltip.ItemRefTooltip = ItemRefTooltip

Tooltip.Tooltips = {
	GameTooltip,
	ItemRefShoppingTooltip1,
	ItemRefShoppingTooltip2,
	ItemRefShoppingTooltip3,
	ShoppingTooltip1,
	ShoppingTooltip2,
	ShoppingTooltip3,
	--WorldMapTooltip.BackdropFrame, -- This is currently throwing an error.
	WorldMapCompareTooltip1,
	WorldMapCompareTooltip2,
	WorldMapCompareTooltip3,
	ItemRefTooltip,
}

local Classification = {
	worldboss = "|cffAF5050B |r",
	rareelite = "|cffAF5050R+ |r",
	elite = "|cffAF5050+ |r",
	rare = "|cffAF5050R |r",
}

function Tooltip:CreateAnchor()
	local Movers = K.Movers

	local Anchor = CreateFrame("Frame", "TooltipAnchor", UIParent)
	Anchor:SetSize(200, 36)
	Anchor:SetFrameStrata("TOOLTIP")
	Anchor:SetFrameLevel(20)
	Anchor:SetClampedToScreen(true)
	Anchor:SetPoint(unpack(C.Position.Tooltip))
	Anchor:SetMovable(true)

	self.Anchor = Anchor

	Movers:RegisterFrame(Anchor)
end

function Tooltip:SetTooltipDefaultAnchor(parent)
	local Anchor = TooltipAnchor

	if C.Tooltip.Cursor then self:SetAnchorType("ANCHOR_CURSOR", 0, 5) else self:SetOwner(Anchor) self:SetAnchorType("ANCHOR_TOPRIGHT", 0, -36) end
	if (self:GetOwner() ~= UIParent and InCombatLockdown() and C.Tooltip.HideUF) then
		self:Hide()
		return
	end
end

function Tooltip:GetColor(unit)
	if (not unit) then
		return
	end

	if (UnitIsPlayer(unit) and not UnitHasVehicleUI(unit)) then
		local Class = select(2, UnitClass(unit))
		local Color = RaidColors[Class]

		if (not Color) then
			return
		end

		return "|c"..Color.colorStr, Color.r, Color.g, Color.b
	else
		local Reaction = UnitReaction(unit, "player")
		local Color = BETTER_REACTION_COLORS[Reaction]

		if (not Color) then
			return
		end

		local Hex = K.RGBToHex(unpack(Color))

		return Hex, Color[1], Color[2], Color[3]
	end
end

function Tooltip:OnTooltipSetUnit()
	local NumLines = self:NumLines()
	local GetMouseFocus = GetMouseFocus()
	local Unit = (select(2, self:GetUnit())) or (GetMouseFocus and GetMouseFocus:GetAttribute("unit"))

	if (not Unit) and (UnitExists("mouseover")) then Unit = "mouseover" end
	if (not Unit) then self:Hide() return end
	if (self:GetOwner() ~= UIParent and C.Tooltip.HideUF) then
		self:Hide()
		return
	end
	if (UnitIsUnit(Unit, "mouseover")) then Unit = "mouseover" end

	local Line1 = GameTooltipTextLeft1
	local Line2 = GameTooltipTextLeft2
	local Race = UnitRace(Unit)
	local Class = UnitClass(Unit)
	local Level = UnitLevel(Unit)
	local Guild = GetGuildInfo(Unit)
	local Name, Realm = UnitName(Unit)
	local CreatureType = UnitCreatureType(Unit)
	local Classification = UnitClassification(Unit)
	local Title = UnitPVPName(Unit)
	local R, G, B = GetQuestDifficultyColor(Level).r, GetQuestDifficultyColor(Level).g, GetQuestDifficultyColor(Level).b
	local Color = Tooltip:GetColor(Unit)

	if not Color then Color = "|CFFFFFFFF" end
	if Title or Name then
		if Realm then
			Line1:SetFormattedText("%s%s%s", Color, (Title or Name), Realm and Realm ~= "" and " - ".. Realm .."|r" or "|r")
		else
			Line1:SetFormattedText("%s%s%s", Color, (Title or Name), "|r")
		end
	end

	if UnitIsPlayer(Unit) then
		if (UnitIsAFK(Unit)) then self:AppendText((" %s"):format(CHAT_FLAG_AFK)) elseif UnitIsDND(Unit) then  self:AppendText((" %s"):format(CHAT_FLAG_DND)) end

		local Offset = 2
		if Guild then
			local guildName, guildRankName, guildRankIndex = GetGuildInfo(Unit)
			Line2:SetFormattedText("%s [%s]", IsInGuild() and GetGuildInfo("player") == Guild and "|cff0090ff".. Guild .."|r" or "|cff00ff10".. Guild .."|r", "|cffFFD700"..guildRankName.."|r")
			Offset = Offset + 1
		end

		for i = Offset, NumLines do
			local Line = _G["GameTooltipTextLeft"..i]
			if Line:GetText():find("^" .. LEVEL) then
				if Race then
					Line:SetFormattedText("|cff%02x%02x%02x%s|r %s %s%s", R * 255, G * 255, B * 255, Level > 0 and Level or "??", Race, Color, Class .."|r")
				else
					Line:SetFormattedText("|cff%02x%02x%02x%s|r %s%s", R * 255, G * 255, B * 255, Level > 0 and Level or "??", Color, Class .."|r")
				end
				break
			end
		end
	else
		for i = 2, NumLines do
			local Line = _G["GameTooltipTextLeft"..i]
			if Line:GetText():find("^" .. LEVEL) or (CreatureType and Line:GetText():find("^" .. CreatureType)) then
				if Level == -1 and Classification == "elite" then Classification = "worldboss" end
				Line:SetFormattedText("|cff%02x%02x%02x%s|r%s %s", R * 255, G * 255, B * 255, Classification ~= "worldboss" and Level ~= 0 and Level or "", Classification[Classification] or "", CreatureType or "")
				break
			end
		end
	end

	for i = 1, NumLines do
		local Line = _G["GameTooltipTextLeft"..i]
		if Line:GetText() and Text == PVP_ENABLED then
			_G["GameTooltipTextLeft"..i]:SetText()
			break
		end
	end

	if (UnitExists(Unit .. "target") and Unit ~= "player") then
		local Hex, R, G, B = Tooltip:GetColor(Unit .. "target")

		if (not R) and (not G) and (not B) then R, G, B = 1, 1, 1 end
		GameTooltip:AddLine(UnitName(Unit .. "target"), R, G, B)
	end

	if (C.Tooltip.HealthValue and Health and MaxHealth) then
		HealthBar.Text:SetText(Short(Health) .. " / " .. Short(MaxHealth))
	end

	self.fadeOut = nil
end

function Tooltip:SetColor()
	local GetMouseFocus = GetMouseFocus()
	local Unit = (select(2, self:GetUnit())) or (GetMouseFocus and GetMouseFocus:GetAttribute("unit"))

	if (not Unit) and (UnitExists("mouseover")) then
		Unit = "mouseover"
	end

	self:SetBackdropColor(unpack(C.Media.Backdrop_Color))
	self:SetBackdropBorderColor(unpack(C.Media.Border_Color))

	local Reaction = Unit and UnitReaction(Unit, "player")
	local Player = Unit and UnitIsPlayer(Unit)
	local Friend = Unit and UnitIsFriend("player", Unit)
	local R, G, B

	if Player and Friend then
		local Class = select(2, UnitClass(Unit))
		local Color = BETTER_RAID_CLASS_COLORS[Class]

		R, G, B = Color[1], Color[2], Color[3]
		HealthBar:SetStatusBarColor(R, G, B)
		HealthBar:SetBackdropBorderColor(R, G, B)
		self:SetBackdropBorderColor(R, G, B)
	elseif Reaction then
		local Color = BETTER_REACTION_COLORS[Reaction]

		R, G, B = Color[1], Color[2], Color[3]
		HealthBar:SetStatusBarColor(R, G, B)
		HealthBar:SetBackdropBorderColor(R, G, B)
		self:SetBackdropBorderColor(R, G, B)
	else
		local Link = select(2, self:GetItem())
		local Quality = Link and select(3, GetItemInfo(Link))

		if (Quality and Quality >= 2) then
			R, G, B = GetItemQualityColor(Quality)
			self:SetBackdropBorderColor(R, G, B)
		else
			local Color = Colors

			HealthBar:SetStatusBarColor(unpack(BETTER_REACTION_COLORS[5]))
			HealthBar:SetBackdropBorderColor(unpack(C.Media.Border_Color))
			self:SetBackdropBorderColor(unpack(C.Media.Border_Color))
		end
	end
end

function Tooltip:OnUpdate(elapsed)
	local Owner = self:GetOwner()
	if not Owner then return end
	if Owner:IsForbidden() then return end

	local Red, Green, Blue = self:GetBackdropColor()
	local Owner = self:GetOwner():GetName()
	local Anchor = self:GetAnchorType()

	if (Owner == "UIParent" and Anchor == "ANCHOR_CURSOR") and (Red ~= BackdropColor[1] or Green ~= BackdropColor[2] or Blue ~= BackdropColor[3]) then
		BackdropColor[1] = Red
		BackdropColor[2] = Green
		BackdropColor[3] = Blue
		self:SetBackdropColor(unpack(C.Media.Backdrop_Color))
		self:SetBackdropBorderColor(unpack(C.Media.Border_Color))
	end
end

function Tooltip:Skin()
	if not self.IsSkinned then
		self:SetTemplate("Transparent")
		self.IsSkinned = true
	end
	Tooltip.SetColor(self)
end

function Tooltip:OnTooltipSetItem()
	if IsShiftKeyDown() then
		local Item, Link = self:GetItem()
		local ItemCount = GetItemCount(Link)
		local ID = "|cFFCA3C3CID|r "..Link:match(":(%w+)")
		local Count = "|cFFCA3C3C"..TOTAL.."|r "..ItemCount

		self:AddLine(" ")
		self:AddDoubleLine(Link and Link ~= nil and ID, ItemCount and ItemCount > 1 and Count)
	end
end

function Tooltip:OnValueChanged()
	if (not C.Tooltip.HealthValue) then
		return
	end

	local unit = select(2, self:GetParent():GetUnit())
	if(not unit) then
		local GMF = GetMouseFocus()
		if(GMF and GMF:GetAttribute("unit")) then
			unit = GMF:GetAttribute("unit")
		end
	end

	local _, Max = HealthBar:GetMinMaxValues()
	local Value = HealthBar:GetValue()
	if (Max == 1) then
		self.Text:Hide()
	else
		self.Text:Show()
	end

	if (Value == 0 or (unit and UnitIsDeadOrGhost(unit))) then
		self.Text:SetText("|cffd94545"..DEAD.."|r")
	else
		self.Text:SetText(Short(Value) .. " / " .. Short(Max))
	end
end

function Tooltip:Enable()
	if (not C.Tooltip.Enable) then
		return
	end

	self:CreateAnchor()

	hooksecurefunc("GameTooltip_SetDefaultAnchor", self.SetTooltipDefaultAnchor)

	for _, Tooltip in pairs(Tooltip.Tooltips) do
		if Tooltip == GameTooltip then
			Tooltip:HookScript("OnUpdate", self.OnUpdate)
			Tooltip:HookScript("OnTooltipSetUnit", self.OnTooltipSetUnit)
			Tooltip:HookScript("OnTooltipSetItem", self.OnTooltipSetItem)
		end

		Tooltip:HookScript("OnShow", self.Skin)
	end

	HealthBar:SetScript("OnValueChanged", self.OnValueChanged)
	HealthBar:SetStatusBarTexture(Texture)
	HealthBar:CreatePixelShadow()
	HealthBar:ClearAllPoints()
	HealthBar:SetPoint("BOTTOMLEFT", HealthBar:GetParent(), "TOPLEFT", 4, 2)
	HealthBar:SetPoint("BOTTOMRIGHT", HealthBar:GetParent(), "TOPRIGHT", -4, 2)

	HealthBarBG:SetFrameLevel(HealthBar:GetFrameLevel() - 1)
	HealthBarBG:SetPoint("TOPLEFT", -1, 1)
	HealthBarBG:SetPoint("BOTTOMRIGHT", 1, -1)
	HealthBarBG:SetBackdrop(K.BorderBackdrop)
	HealthBarBG:SetBackdropColor(unpack(C.Media.Backdrop_Color))

	if C.Tooltip.HealthValue then
		HealthBar.Text = HealthBar:CreateFontString(nil, "OVERLAY")
		HealthBar.Text:SetFont(C.Media.Font, C.Media.Font_Size, C.Media.Font_Style)
		HealthBar.Text:SetPoint("CENTER", HealthBar, "CENTER", 0, 6)
	end
end

function Tooltip:OnEvent(event)
	if (event == "PLAYER_LOGIN") then
		Tooltip:Enable()
	end
end

Tooltip:RegisterEvent("PLAYER_LOGIN")
Tooltip:SetScript("OnEvent", Tooltip.OnEvent)