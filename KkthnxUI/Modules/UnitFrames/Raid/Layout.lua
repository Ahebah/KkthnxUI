local K, C, L = select(2, ...):unpack()
if C.Unitframe.Enable ~= true then return end

-- Credits to Neav, Renstrom, Grimsbain
local _, ns = ...
local oUF = ns.oUF or oUF
local config = ns.config

local Movers = K.Movers

-- oUF_AuraWatch
-- Class buffs { spell ID, position [, {r, g, b, a}][, anyUnit][, hideCount] }

local indicatorList
do
	indicatorList = {
		DRUID = {
			{774, "BOTTOMRIGHT", {1, 0.2, 1}}, -- Rejuvenation
			{155777, "RIGHT", {0.4, 0.9, 0.4}}, -- Rejuvenation (Germination)
			{33763, "BOTTOM", {0.5, 1, 0.5}}, -- Lifebloom
			{48438, "BOTTOMLEFT", {0.7, 1, 0}}, -- Wild Growth
		},
		MONK = {
			{115151, "BOTTOMRIGHT", {0, 1, 0}}, -- Renewing Mist
			{124682, "BOTTOMLEFT", {0.15, 0.98, 0.64}}, -- Enveloping Mist
			{116849, "TOPLEFT", {1, 1, 0}}, -- Life Cocoon
			{124081, "BOTTOMLEFT", {0.7, 0.8, 1}}, -- Zen Sphere
		},
		PALADIN = {
			{53563, "BOTTOMRIGHT", {0, 1, 0}}, -- Beacon of Light
			{156910, "BOTTOMRIGHT", {0, 1, 0}}, -- Beacon of Faith
			{200025, "BOTTOMRIGHT", {0, 1, 0}}, -- Beacon of Virtue
		},
		PRIEST = {
			{17, "BOTTOMRIGHT", {1, 1, 0}}, -- Power Word: Shield
			{41635, "TOPRIGHT", {1, 0.6, 0.6}}, -- Prayer of Mending
			{139, "BOTTOMLEFT", {0, 1, 0}}, -- Renew
			{194384, "TOPLEFT", {1, 0, 0}}, -- Atonement
			{47788, "TOPLEFT", {0, 1,0 }}, -- Guardian Spirit
		},
		SHAMAN = {
			{61295, "TOPLEFT", {0.7, 0.3, 0.7}}, -- Riptide
			{204288, "BOTTOMRIGHT", {0.7, 0.4, 0}}, -- Earth Shield (PvP Only)
		},
		WARLOCK = {
			{20707, "BOTTOMRIGHT", {0.7, 0, 1}, true}, -- Soulstone
		},
		ALL = {
			{23333, "TOPLEFT", {1, 0, 0}, true}, -- Warsong flag, Horde
			{23335, "TOPLEFT", {0, 0, 1}, true}, -- Warsong flag, Alliance
			{34976, "TOPLEFT", {1, 0, 1}, true}, -- Netherstorm Flag
		},
	}
end

local function AuraIcon(self, icon)
	if (icon.cd) then
		icon.cd:SetReverse(true)
		icon.cd:SetDrawEdge(true)
		icon.cd:SetAllPoints(icon.icon)
		icon.cd:SetHideCountdownNumbers(true)
	end
end

local offsets
do
	local space = 2

	offsets = {
		TOPLEFT = {
			icon = {space, -space},
			count = {"TOP", icon, "BOTTOM", 0, 0},
		},

		TOPRIGHT = {
			icon = {-space, -space},
			count = {"TOP", icon, "BOTTOM", 0, 0},
		},

		BOTTOMLEFT = {
			icon = {space, space},
			count = {"LEFT", icon, "RIGHT", 1, 0},
		},

		BOTTOMRIGHT = {
			icon = {-space, space},
			count = {"RIGHT", icon, "LEFT", -1, 0},
		},

		LEFT = {
			icon = {space, 0},
			count = {"LEFT", icon, "RIGHT", 1, 0},
		},

		RIGHT = {
			icon = {-space, 0},
			count = {"RIGHT", icon, "LEFT", -1, 0},
		},

		TOP = {
			icon = {0, -space},
			count = {"CENTER", icon, 0, 0},
		},

		BOTTOM = {
			icon = {0, space},
			count = {"CENTER", icon, 0, 0},
		},
	}
end

local function CreateIndicators(self, unit)

	self.AuraWatch = CreateFrame("Frame", nil, self)

	local Auras = {}
	Auras.icons = {}
	Auras.customIcons = true
	Auras.presentAlpha = 1
	Auras.missingAlpha = 0
	Auras.PostCreateIcon = AuraIcon

	local buffs = {}

	if (indicatorList["ALL"]) then
		for key, value in pairs(indicatorList["ALL"]) do
			tinsert(buffs, value)
		end
	end

	if (indicatorList[K.Class]) then
		for key, value in pairs(indicatorList[K.Class]) do
			tinsert(buffs, value)
		end
	end

	if (buffs) then
		for key, spell in pairs(buffs) do

			local icon = CreateFrame("Frame", nil, self.AuraWatch)
			icon:SetWidth(config.units.raid.indicatorSize)
			icon:SetHeight(config.units.raid.indicatorSize)
			icon:SetPoint(spell[2], self.Health, unpack(offsets[spell[2]].icon))

			icon.spellID = spell[1]
			icon.anyUnit = spell[4]
			icon.hideCount = spell[5]

			local cd = CreateFrame("Cooldown", nil, icon, "CooldownFrameTemplate")
			cd:SetAllPoints(icon)
			icon.cd = cd

			-- Indicator
			local tex = icon:CreateTexture(nil, "OVERLAY")
			tex:SetAllPoints(icon)
			tex:SetTexture("Interface\\AddOns\\KkthnxUI\\Media\\Unitframes\\Raid\\borderIndicator")
			icon.icon = tex

			-- Color Overlay
			if (spell[3]) then
				icon.icon:SetVertexColor(unpack(spell[3]))
			else
				icon.icon:SetVertexColor(0.8, 0.8, 0.8)
			end

			if (not icon.hideCount) then
				local count = icon:CreateFontString(nil, "OVERLAY")
				count:SetShadowColor(0, 0, 0)
				count:SetShadowOffset(1, -1)
				count:SetPoint(unpack(offsets[spell[2]].count))
				count:SetFont(C.Media.Font, 13)
				icon.count = count
			end

			Auras.icons[spell[1]] = icon
		end
	end
	self.AuraWatch = Auras
end

local function UpdateThreat(self, _, unit)
	if (self.unit ~= unit or self.unit ~= "player" or self.unit ~= "pet" or self.unit ~= "raid") then
		return
	end

	local threatStatus = UnitThreatSituation(self.unit)
	if (threatStatus == 3) then
		if (self.ThreatText) then
			self.ThreatText:Show()
		end
	end

	if (threatStatus and threatStatus >= 2) then
		local r, g, b = GetThreatStatusColor(threatStatus)
		self.ThreatGlow:SetBackdropBorderColor(r, g, b, 1)
	else
		self.ThreatGlow:SetBackdropBorderColor(0, 0, 0, 0)

		if (self.ThreatText) then
			self.ThreatText:Hide()
		end
	end
end

local function UpdatePower(self, _, unit)
	if (self.unit ~= unit) then
		return
	end

	local _, powerToken = UnitPowerType(unit)

	if (powerToken == "MANA" and UnitHasMana(unit)) then
		if (not self.Power:IsVisible()) then
			self.Health:ClearAllPoints()
			if (config.units.raid.manabar.horizontalOrientation) then
				self.Health:SetPoint("BOTTOMLEFT", self, 0, 3)
				self.Health:SetPoint("TOPRIGHT", self)
			else
				self.Health:SetPoint("BOTTOMLEFT", self)
				self.Health:SetPoint("TOPRIGHT", self, -3.5, 0)
			end

			self.Power:Show()
		end
	else
		if (self.Power:IsVisible()) then
			self.Health:ClearAllPoints()
			self.Health:SetAllPoints(self)
			self.Power:Hide()
		end
	end
end

local function DeficitValue(self)
	if (self >= 1000) then
		return format("-%.1f", self/1000)
	else
		return self
	end
end

local function GetUnitStatus(unit)
	if (UnitIsDead(unit)) then
		return DEAD
	elseif (UnitIsGhost(unit)) then
		return "Ghost"
	elseif (not UnitIsConnected(unit)) then
		return PLAYER_OFFLINE
	else
		return ""
	end
end

local function GetHealthText(unit, cur, max)
	local healthString
	if (UnitIsDeadOrGhost(unit) or not UnitIsConnected(unit)) then
		healthString = GetUnitStatus(unit)
	else
		if ((cur/max) < config.units.raid.deficitThreshold) then
			healthString = format("|cff%02x%02x%02x%s|r", 0.9*255, 0*255, 0*255, DeficitValue(max-cur))
		else
			healthString = ""
		end
	end

	return healthString
end

local function UpdateHealth(Health, unit, cur, max)
	if (not UnitIsPlayer(unit)) then
		local r, g, b = 0, 0.82, 1
		Health:SetStatusBarColor(r, g, b)
		Health.bg:SetVertexColor(r * 0.25, g * 0.25, b * 0.25)
	end

	Health.Value:SetText(GetHealthText(unit, cur, max))
end

local function CreateRaidLayout(self, unit)
	self:RegisterForClicks("AnyUp")

	self:SetScript("OnEnter", function(self)
		UnitFrame_OnEnter(self)

		if (self.Mouseover) then
			self.Mouseover:SetAlpha(0.175)
		end
	end)

	self:SetScript("OnLeave", function(self)
		UnitFrame_OnLeave(self)

		if (self.Mouseover) then
			self.Mouseover:SetAlpha(0)
		end
	end)

	self:SetBackdrop({
		bgFile = C.Media.Blank,
		insets = {
			left = -1,
			right = -1,
			top = -1,
			bottom = -1
		}
	})

	K.CreateBorder(self, 10, 3)
	self:SetBorderTexture("white")
	self:SetBorderColor(0.38, 0.38, 0.38)

	self:SetBackdropColor(unpack(C.Media.Backdrop_Color))

	-- Health bar
	self.Health = CreateFrame("StatusBar", nil, self)
	self.Health:SetStatusBarTexture(C.Media.Texture, "ARTWORK")
	self.Health:SetAllPoints(self)
	self.Health:SetOrientation(config.units.raid.horizontalHealthBars and "HORIZONTAL" or "VERTICAL")

	self.Health.PostUpdate = UpdateHealth
	self.Health.frequentUpdates = true

	self.Health.colorClass = true
	self.Health.colorDisconnected = true

	if (config.units.raid.smoothUpdates) then
		self.Health.Smooth = true
	end

	-- Health background
	self.Health.bg = self.Health:CreateTexture(nil, "BORDER")
	self.Health.bg:SetAllPoints(self.Health)
	self.Health.bg:SetTexture(C.Media.Texture)

	self.Health.bg.multiplier = 0.3

	-- Health text
	self.Health.Value = self.Health:CreateFontString(nil, "OVERLAY")
	self.Health.Value:SetPoint("TOP", self.Health, "CENTER", 0, 2)
	self.Health.Value:SetFont(C.Media.Font, 11)
	self.Health.Value:SetShadowOffset(1, -1)

	-- Name text
	self.Name = self.Health:CreateFontString(nil, "OVERLAY")
	self.Name:SetPoint("BOTTOM", self.Health, "CENTER", 0, 3)
	self.Name:SetFont(C.Media.Font, C.Media.Font_Size)
	self.Name:SetShadowOffset(1, -1)
	self.Name:SetTextColor(1, 0.82, 0, 1)
	self:Tag(self.Name, "[name:raid]")

	-- Power bar
	if (config.units.raid.manabar.show) then
		self.Power = CreateFrame("StatusBar", nil, self)
		self.Power:SetStatusBarTexture(C.Media.Texture, "ARTWORK")

		if (config.units.raid.manabar.horizontalOrientation) then
			self.Power:SetPoint("TOPLEFT", self.Health, "BOTTOMLEFT", 0, -1)
			self.Power:SetPoint("TOPRIGHT", self.Health, "BOTTOMRIGHT", 0, -1)
			self.Power:SetOrientation("HORIZONTAL")
			self.Power:SetHeight(2.5)
		else
			self.Power:SetPoint("TOPLEFT", self.Health, "TOPRIGHT", 1, 0)
			self.Power:SetPoint("BOTTOMLEFT", self.Health, "BOTTOMRIGHT", 1, 0)
			self.Power:SetOrientation("VERTICAL")
			self.Power:SetWidth(2.5)
		end

		self.Power.colorPower = true
		self.Power.Smooth = true

		self.Power.bg = self.Power:CreateTexture(nil, "BORDER")
		self.Power.bg:SetAllPoints(self.Power)
		self.Power.bg:SetColorTexture(1, 1, 1)

		self.Power.bg.multiplier = 0.3

		table.insert(self.__elements, UpdatePower)
		self:RegisterEvent("UNIT_DISPLAYPOWER", UpdatePower)
		UpdatePower(self, _, unit)
	end

	-- Heal prediction
	local myBar = CreateFrame("StatusBar", "$parentMyHealPredictionBar", self)
	myBar:SetStatusBarTexture(C.Media.Texture, "OVERLAY")
	myBar:SetStatusBarColor(0, 0.827, 0.765, 1)

	if (config.units.raid.smoothUpdates) then
		myBar.Smooth = true
	end

	if (config.units.raid.horizontalHealthBars) then
		myBar:SetOrientation("HORIZONTAL")
		myBar:SetPoint("TOPLEFT", self.Health:GetStatusBarTexture(), "TOPRIGHT")
		myBar:SetPoint("BOTTOMLEFT", self.Health:GetStatusBarTexture(), "BOTTOMRIGHT")
		myBar:SetWidth(self:GetWidth())
	else
		myBar:SetOrientation("VERTICAL")
		myBar:SetPoint("BOTTOMLEFT", self.Health:GetStatusBarTexture(), "TOPLEFT")
		myBar:SetPoint("BOTTOMRIGHT", self.Health:GetStatusBarTexture(), "TOPRIGHT")
		myBar:SetHeight(self:GetHeight())
	end

	local otherBar = CreateFrame("StatusBar", "$parentOtherHealPredictionBar", self)
	otherBar:SetStatusBarTexture(C.Media.Texture, "OVERLAY")
	otherBar:SetStatusBarColor(0.0, 0.631, 0.557, 1)

	if (config.units.raid.smoothUpdates) then
		otherBar.Smooth = true
	end

	if (config.units.raid.horizontalHealthBars) then
		otherBar:SetOrientation("HORIZONTAL")
		otherBar:SetPoint("TOPLEFT", myBar:GetStatusBarTexture(), "TOPRIGHT")
		otherBar:SetPoint("BOTTOMLEFT", myBar:GetStatusBarTexture(), "BOTTOMRIGHT")
		otherBar:SetWidth(self:GetWidth())
	else
		otherBar:SetOrientation("VERTICAL")
		otherBar:SetPoint("BOTTOMLEFT", myBar:GetStatusBarTexture(), "TOPLEFT")
		otherBar:SetPoint("BOTTOMRIGHT", myBar:GetStatusBarTexture(), "TOPRIGHT")
		otherBar:SetHeight(self:GetHeight())
	end

	local healAbsorbBar = CreateFrame("StatusBar", "$parentHealAbsorbBar", self)
	healAbsorbBar:SetStatusBarTexture("Interface\\Buttons\\WHITE8x8")
	healAbsorbBar:SetStatusBarColor(0.9, 0.1, 0.3, 1)

	if (config.units.raid.smoothUpdates) then
		healAbsorbBar.Smooth = true
	end

	if (config.units.raid.horizontalHealthBars) then
		healAbsorbBar:SetOrientation("HORIZONTAL")
		healAbsorbBar:SetPoint("TOPLEFT", self.Health:GetStatusBarTexture(), "TOPRIGHT")
		healAbsorbBar:SetPoint("BOTTOMLEFT", self.Health:GetStatusBarTexture(), "BOTTOMRIGHT")
		healAbsorbBar:SetWidth(self:GetWidth())
	else
		healAbsorbBar:SetOrientation("VERTICAL")
		healAbsorbBar:SetPoint("BOTTOMLEFT", self.Health:GetStatusBarTexture(), "TOPLEFT")
		healAbsorbBar:SetPoint("BOTTOMRIGHT", self.Health:GetStatusBarTexture(), "TOPRIGHT")
		healAbsorbBar:SetHeight(self:GetHeight())
	end

	local absorbBar = CreateFrame("StatusBar", "$parentTotalAbsorbBar", self)
	absorbBar:SetStatusBarTexture("Interface\\Buttons\\WHITE8x8")
	absorbBar:SetStatusBarColor(0.85, 0.85, 0.9, 1)

	if (config.units.raid.smoothUpdates) then
		absorbBar.Smooth = true
	end

	if (config.units.raid.horizontalHealthBars) then
		absorbBar:SetOrientation("HORIZONTAL")
		absorbBar:SetPoint("TOPLEFT", self.Health:GetStatusBarTexture(), "TOPRIGHT")
		absorbBar:SetPoint("BOTTOMLEFT", self.Health:GetStatusBarTexture(), "BOTTOMRIGHT")
		absorbBar:SetWidth(self:GetWidth())
	else
		absorbBar:SetOrientation("VERTICAL")
		absorbBar:SetPoint("BOTTOMLEFT", self.Health:GetStatusBarTexture(), "TOPLEFT")
		absorbBar:SetPoint("BOTTOMRIGHT", self.Health:GetStatusBarTexture(), "TOPRIGHT")
		absorbBar:SetHeight(self:GetHeight())
	end

	absorbBar.Overlay = absorbBar:CreateTexture("$parentOverlay", "ARTWORK", "TotalAbsorbBarOverlayTemplate", 1)
	absorbBar.Overlay:SetAllPoints(absorbBar:GetStatusBarTexture())

	self.HealPrediction = {
		myBar = myBar,
		otherBar = otherBar,
		healAbsorbBar = healAbsorbBar,
		absorbBar = absorbBar,
		maxOverflow = 1.0,
		frequentUpdates = true
	}

	-- Afk /offline timer, using frequentUpdates function from oUF tags
	if (config.units.raid.showNotHereTimer) then
		self.NotHere = self.Health:CreateFontString(nil, "OVERLAY")
		self.NotHere:SetPoint("CENTER", self, "BOTTOM")
		-- self.NotHere:SetFont(C.Media.Font, 11)
		self.NotHere:SetFont(C.Media.Font, 11, "THINOUTLINE")
		self.NotHere:SetShadowOffset(0, 0)
		self.NotHere:SetTextColor(0, 1, 0)
		self.NotHere.frequentUpdates = 1
		self:Tag(self.NotHere, "[status:raid]")
	end

	-- Mouseover darklight
	if (config.units.raid.showMouseoverHighlight) then
		self.Mouseover = self.Health:CreateTexture(nil, "OVERLAY")
		self.Mouseover:SetAllPoints(self.Health)
		self.Mouseover:SetTexture(C.Media.Texture)
		self.Mouseover:SetVertexColor(0, 0, 0)
		self.Mouseover:SetAlpha(0)
	end

	-- Threat glow
	self.ThreatGlow = CreateFrame("Frame", nil, self)
	self.ThreatGlow:SetPoint("TOPLEFT", self, "TOPLEFT", -4, 4)
	self.ThreatGlow:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 4, -4)
	self.ThreatGlow:SetBackdrop({edgeFile = C.Media.Glow, edgeSize = 3})
	self.ThreatGlow:SetBackdropBorderColor(0, 0, 0, 0)
	self.ThreatGlow:SetFrameLevel(self:GetFrameLevel() - 1)
	self.ThreatGlow.ignore = true

	-- Threat text
	if (config.units.raid.showThreatText) then
		self.ThreatText = self.Health:CreateFontString(nil, "OVERLAY")
		self.ThreatText:SetPoint("CENTER", self, "BOTTOM")
		self.ThreatText:SetFont(C.Media.Font, 11, "THINOUTLINE")
		self.ThreatText:SetShadowOffset(0, 0)
		self.ThreatText:SetTextColor(1, 0, 0)
		self.ThreatText:SetText("AGGRO")
	end

	table.insert(self.__elements, UpdateThreat)
	self:RegisterEvent("UNIT_THREAT_LIST_UPDATE", UpdateThreat)
	self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", UpdateThreat)

	-- Masterlooter icons
	self.MasterLooter = self.Health:CreateTexture(nil, "OVERLAY", self)
	self.MasterLooter:SetSize(11, 11)
	self.MasterLooter:SetPoint("RIGHT", self, "TOPRIGHT", -1, 1)

	-- Leader icons
	self.Leader = self.Health:CreateTexture(nil, "OVERLAY", self)
	self.Leader:SetSize(12, 12)
	self.Leader:SetPoint("LEFT", self.Health, "TOPLEFT", 1, 2)

	-- Raid icons
	self.RaidIcon = self.Health:CreateTexture(nil, "OVERLAY")
	self.RaidIcon:SetSize(16, 16)
	self.RaidIcon:SetPoint("CENTER", self, "TOP")

	-- Readycheck icons
	self.ReadyCheck = self.Health:CreateTexture(nil, "OVERLAY")
	self.ReadyCheck:SetPoint("CENTER")
	self.ReadyCheck:SetSize(20, 20)
	self.ReadyCheck.delayTime = 2
	self.ReadyCheck.fadeTime = 1

	-- Debuff icons, using freebAuras from oUF_Freebgrid
	self.FreebAuras = CreateFrame("Frame", nil, self)
	self.FreebAuras:SetSize(config.units.raid.iconSize, config.units.raid.iconSize)
	self.FreebAuras:SetPoint("CENTER", self.Health)

	-- Create indicators
	CreateIndicators(self, unit)

	-- Role indicator
	if (config.units.raid.showRolePrefix) then
		self.LFDRoleText = self.Health:CreateFontString(nil, "ARTWORK")
		self.LFDRoleText:SetPoint("TOPLEFT", self.Health, 0, 4)
		self.LFDRoleText:SetFont(C.Media.Font, 15)
		self.LFDRoleText:SetShadowOffset(0.5, -0.5)
		self.LFDRoleText:SetTextColor(1, 0, 1)
		self:Tag(self.LFDRoleText, "[role:raid]")
	end

	-- Ressurection icon....ehm text!
	if (config.units.raid.showResurrectText) then
		self.ResurrectIcon = self.Health:CreateFontString(nil, "OVERLAY")
		self.ResurrectIcon:SetPoint("CENTER", self, "BOTTOM", 0, 1)
		self.ResurrectIcon:SetFont(C.Media.Font, 11, "THINOUTLINE")
		self.ResurrectIcon:SetShadowOffset(0, 0)
		self.ResurrectIcon:SetTextColor(0.1, 1, 0.1)
		self.ResurrectIcon:SetText("RES") -- RESURRECT

		self.ResurrectIcon.Override = function()
			local incomingResurrect = UnitHasIncomingResurrection(self.unit)

			if (incomingResurrect) then
				self.ResurrectIcon:Show()

				if (self.NotHere) then
					self.NotHere:Hide()
				end
			else
				self.ResurrectIcon:Hide()

				if (self.NotHere) then
					self.NotHere:Show()
				end
			end
		end
	end

	-- Playertarget border
	if (config.units.raid.showTargetBorder) then
		--self.TargetBorder = self.Health:CreateTexture(nil, "OVERLAY", self)
		--self.TargetBorder:SetAllPoints(self.Health)
		--self.TargetBorder:SetTexture("Interface\\AddOns\\KkthnxUI\\Media\\Unitframes\\Raid\\borderTarget")
		--self.TargetBorder:SetVertexColor(unpack(config.units.raid.targetBorderColor))
		--self.TargetBorder:Hide()

		self:RegisterEvent("PLAYER_TARGET_CHANGED", function()
			if (UnitIsUnit("target", self.unit)) then
				self:SetBorderColor(1, 1, 1)
			else
				self:SetBorderTexture("white")
				self:SetBorderColor(0.38, 0.38, 0.38)
			end
		end)
	end

	-- Range check
	self.Range = {
		insideAlpha = 1,
		outsideAlpha = 0.3,
	}

	self.SpellRange = {
		insideAlpha = 1,
		outsideAlpha = 0.3,
	}

	return self
end

oUF:RegisterStyle("oUF_Kkthnx_Raid", CreateRaidLayout)
oUF:RegisterStyle("oUF_Kkthnx_Raid_MT", CreateRaidLayout)
oUF:SetActiveStyle("oUF_Kkthnx_Raid")

local rlayout = config.units.raid.layout
local relpoint, anchpoint, xOffset, yOffset

if (rlayout.orientation == "HORIZONTAL") then
	if (rlayout.initialAnchor == "TOPRIGHT" or rlayout.initialAnchor == "TOPLEFT") then
		relpoint = "LEFT"
		anchpoint = "TOP"
		xOffset = rlayout.frameSpacing
		yOffset = rlayout.frameSpacing
	elseif (rlayout.initialAnchor == "BOTTOMLEFT" or rlayout.initialAnchor == "BOTTOMRIGHT") then
		relpoint = "BOTTOM"
		anchpoint = "LEFT"
		xOffset = -rlayout.frameSpacing
		yOffset = rlayout.frameSpacing
	end
elseif (rlayout.orientation == "VERTICAL") then
	if (rlayout.initialAnchor == "TOPRIGHT") then
		relpoint = "TOP"
		anchpoint = "RIGHT"
		xOffset = -rlayout.frameSpacing
		yOffset = -rlayout.frameSpacing
	elseif (rlayout.initialAnchor == "TOPLEFT") then
		relpoint = "TOP"
		anchpoint = "LEFT"
		xOffset = rlayout.frameSpacing
		yOffset = -rlayout.frameSpacing
	elseif (rlayout.initialAnchor == "BOTTOMLEFT") then
		relpoint = "BOTTOM"
		anchpoint = "LEFT"
		xOffset = rlayout.frameSpacing
		yOffset = rlayout.frameSpacing
	elseif (rlayout.initialAnchor == "BOTTOMRIGHT") then
		relpoint = "BOTTOM"
		anchpoint = "RIGHT"
		xOffset = -rlayout.frameSpacing
		yOffset = rlayout.frameSpacing
	end
end

local raid = oUF:SpawnHeader("oUF_Raid", nil, "raid,party,solo",
"showSolo", config.units.raid.showSolo,
"showParty", config.units.raid.showParty,
"showRaid", true,
"showPlayer", true,
"point", relpoint,
"groupFilter", "1,2,3,4,5,6,7,8",
"groupingOrder", "1,2,3,4,5,6,7,8",
"groupBy", "GROUP",
"maxColumns", 8,
"unitsPerColumn", 5,
"columnAnchorPoint", anchpoint,
"columnSpacing", rlayout.frameSpacing,
"yOffset", yOffset,
"xOffset", xOffset,
"templateType", "Button",
"oUF-initialConfigFunction", ([[
self:SetWidth(%d)
self:SetHeight(%d)
]]):format(config.units.raid.width, config.units.raid.height))

raid:SetPoint(rlayout.initialAnchor, raidFrames)
raid:SetScale(config.units.raid.scale)
raid:SetFrameStrata("LOW")
Movers:RegisterFrame(raid)

-- Main Tank/Assist Frames

if config.units.raid.showMainTankFrames then
	oUF:SetActiveStyle("oUF_Kkthnx_Raid_MT")

	local offset = rlayout.frameSpacing

	local tanks = oUF:SpawnHeader("oUF_Kkthnx_Raid_MT", nil, "solo,party,raid",
	"showRaid", true,
	"showParty", false,
	"yOffset", -offset,
	"template", "oUF_KkthnxRaid_MT_Target_Template", -- Target
	"sortMethod", "INDEX",
	"groupFilter", "MAINTANK, MAINASSIST",
	"oUF-initialConfigFunction", ([[
	self:SetWidth(%d)
	self:SetHeight(%d)
	]]):format(config.units.raid.width, config.units.raid.height))

	tanks:SetPoint("TOPLEFT", tankFrames, "TOPLEFT")
	tanks:SetScale(config.units.raid.scale)
	tanks:SetFrameStrata("LOW")
	Movers:RegisterFrame(tanks)
end