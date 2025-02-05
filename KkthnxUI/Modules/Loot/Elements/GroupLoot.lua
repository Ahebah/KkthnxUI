local K, C, L = KkthnxUI[1], KkthnxUI[2], KkthnxUI[3]
local Module = K:GetModule("Loot")

local unpack, next = unpack, next
local wipe, tinsert, format = wipe, tinsert, format

local CreateFrame = CreateFrame
local GREED, NEED, PASS = GREED, NEED, PASS
local GameTooltip = GameTooltip
local GameTooltip_Hide = GameTooltip_Hide
local GameTooltip_ShowCompareItem = GameTooltip_ShowCompareItem
local GetItemInfo = GetItemInfo
local GetLootRollItemInfo = GetLootRollItemInfo
local GetLootRollItemLink = GetLootRollItemLink
local GetLootRollTimeLeft = GetLootRollTimeLeft
local IsModifiedClick = IsModifiedClick
local IsShiftKeyDown = IsShiftKeyDown
local NUM_GROUP_LOOT_FRAMES = NUM_GROUP_LOOT_FRAMES
local ROLL_DISENCHANT = ROLL_DISENCHANT
local RollOnLoot = RollOnLoot

local rollCache = {}
local rollBars = {}
local rollTypes = { [1] = "need", [2] = "greed", [3] = "disenchant", [4] = "transmog", [0] = "pass" }

local function ClickRoll(button)
	RollOnLoot(button.parent.rollID, button.rolltype)
end

local function SetTip(button)
	GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
	GameTooltip:AddLine(button.tiptext)

	local lineAdded
	if button:IsEnabled() == 0 then
		GameTooltip:AddLine("|cffff3333" .. "Can't Roll")
	end

	local rolls = button.parent.rolls[button.rolltype]
	if rolls then
		for _, infoTable in next, rolls do
			local playerName, className = unpack(infoTable)
			if not lineAdded then
				GameTooltip:AddLine(" ")
				lineAdded = true
			end

			local classColor = K.ClassColors[K.ClassList[className] or className]
			if not classColor then
				classColor = K.ClassColors["PRIEST"]
			end
			GameTooltip:AddLine(playerName, classColor.r, classColor.g, classColor.b)
		end
	end

	GameTooltip:Show()
end

local function SetItemTip(button, event)
	if not button.rollID or (event == "MODIFIER_STATE_CHANGED" and not button:IsMouseOver()) then
		return
	end

	GameTooltip:SetOwner(button, "ANCHOR_TOPLEFT")
	GameTooltip:SetLootRollItem(button.rollID)

	if IsShiftKeyDown() then
		GameTooltip_ShowCompareItem()
	end
end

local function LootClick(button)
	if IsModifiedClick() then
		_G.HandleModifiedItemClick(button.link)
	end
end

local function StatusUpdate(status, elapsed)
	local bar = status.parent
	local rollID = bar.rollID
	if not rollID then
		bar:Hide()
		return
	end

	if status.elapsed and status.elapsed > 0.1 then
		local timeLeft = GetLootRollTimeLeft(rollID)
		if timeLeft <= 0 then -- workaround for other addons auto-passing loot
			-- Module.LootRoll_Cancel(bar, "OnUpdate", rollID)
			Module.LootRoll_Cancel(bar, nil, rollID)
		else
			status:SetValue(timeLeft)
			status.elapsed = 0
		end
	else
		status.elapsed = (status.elapsed or 0) + elapsed
	end
end

local iconCoords = {
	[0] = { 1.05, -0.1, 1.05, -0.1 }, -- pass
	[2] = { 0.05, 1.05, -0.025, 0.85 }, -- greed
	[1] = { 0.05, 1.05, -0.05, 0.95 }, -- need
	[3] = { 0.05, 1.05, -0.05, 0.95 }, -- disenchant
	[4] = { 0, 1, 0, 1 }, -- transmog
}

local function RollTexCoords(button, icon, rolltype, minX, maxX, minY, maxY)
	local offset = icon == button.pushedTex and (rolltype == 0 and -0.05 or 0.05) or 0
	icon:SetTexCoord(minX - offset, maxX, minY - offset, maxY)

	if icon == button.disabledTex then
		icon:SetDesaturated(true)
		icon:SetAlpha(0.25)
	end
end

local function RollButtonTextures(button, texture, rolltype)
	-- Set the texture for the button's normal, pushed, disabled, and highlight states
	button:SetNormalTexture(texture)
	button:SetPushedTexture(texture)
	button:SetDisabledTexture(texture)
	button:SetHighlightTexture(texture)

	-- Store references to the textures for later use
	button.normalTex = button:GetNormalTexture()
	button.disabledTex = button:GetDisabledTexture()
	button.pushedTex = button:GetPushedTexture()
	button.highlightTex = button:GetHighlightTexture()

	-- Apply the texture coordinates to each of the button textures
	local minX, maxX, minY, maxY = unpack(iconCoords[rolltype])
	RollTexCoords(button, button.normalTex, rolltype, minX, maxX, minY, maxY)
	RollTexCoords(button, button.disabledTex, rolltype, minX, maxX, minY, maxY)
	RollTexCoords(button, button.pushedTex, rolltype, minX, maxX, minY, maxY)
	RollTexCoords(button, button.highlightTex, rolltype, minX, maxX, minY, maxY)
end

local function RollMouseDown(button)
	if button.highlightTex then
		button.highlightTex:SetAlpha(0)
	end
end

local function RollMouseUp(button)
	if button.highlightTex then
		button.highlightTex:SetAlpha(1)
	end
end

local function CreateRollButton(parent, texture, rolltype, tiptext)
	local button = CreateFrame("Button", format("$parent_%sButton", tiptext), parent)
	button:SetScript("OnMouseDown", RollMouseDown)
	button:SetScript("OnMouseUp", RollMouseUp)
	button:SetScript("OnClick", ClickRoll)
	button:SetScript("OnEnter", SetTip)
	button:SetScript("OnLeave", GameTooltip_Hide)
	button:SetMotionScriptsWhileDisabled(true)
	button:SetHitRectInsets(3, 3, 3, 3)

	RollButtonTextures(button, texture, rolltype)

	button.parent = parent
	button.rolltype = rolltype
	button.tiptext = tiptext

	button.text = button:CreateFontString(nil, "ARTWORK")
	button.text:SetFontObject(K.UIFontOutline)
	button.text:SetPoint("BOTTOMRIGHT", 2, -2)

	return button
end

function Module:LootRoll_Create(index)
	local bar = CreateFrame("Frame", "KKUI_LootRollFrame" .. index, UIParent)
	bar:SetSize(328, 26)
	bar:SetScript("OnEvent", Module.LootRoll_Cancel)
	bar:RegisterEvent("CANCEL_LOOT_ROLL")
	bar:Hide()

	local status = CreateFrame("StatusBar", nil, bar)
	status:SetAllPoints(bar)
	status:SetFrameLevel(bar:GetFrameLevel())
	status:SetFrameStrata(bar:GetFrameStrata())
	status:CreateBorder()
	status:SetScript("OnUpdate", StatusUpdate)
	status:SetStatusBarTexture(K.GetTexture(C["General"].Texture))
	status.parent = bar
	bar.status = status

	local spark = status:CreateTexture(nil, "ARTWORK", nil, 1)
	spark:SetBlendMode("BLEND")
	spark:SetPoint("RIGHT", status:GetStatusBarTexture())
	spark:SetPoint("BOTTOM")
	spark:SetPoint("TOP")
	spark:SetWidth(2)
	status.spark = spark

	local button = CreateFrame("Button", nil, bar)
	button:CreateBorder()
	button:SetScript("OnEvent", SetItemTip)
	button:SetScript("OnEnter", SetItemTip)
	button:SetScript("OnLeave", GameTooltip_Hide)
	button:SetScript("OnClick", LootClick)
	button:RegisterEvent("MODIFIER_STATE_CHANGED")
	bar.button = button

	button.icon = button:CreateTexture(nil, "OVERLAY")
	button.icon:SetAllPoints(button)
	button.icon:SetTexCoord(K.TexCoords[1], K.TexCoords[2], K.TexCoords[3], K.TexCoords[4])

	button.stack = button:CreateFontString(nil, "OVERLAY")
	button.stack:SetPoint("BOTTOMRIGHT", -1, 1)
	button.stack:SetFontObject(K.UIFontOutline)

	button.ilvl = button:CreateFontString(nil, "OVERLAY")
	button.ilvl:SetPoint("BOTTOMLEFT", 1, 1)
	button.ilvl:SetFontObject(K.UIFontOutline)

	bar.pass = CreateRollButton(bar, [[Interface\Buttons\UI-GroupLoot-Pass-Up]], 0, PASS)
	bar.disenchant = CreateRollButton(bar, [[Interface\Buttons\UI-GroupLoot-DE-Up]], 3, ROLL_DISENCHANT) or nil
	bar.transmog = CreateRollButton(bar, [[Interface\MINIMAP\TRACKING\Transmogrifier]], 4, TRANSMOGRIFY) or nil
	bar.greed = CreateRollButton(bar, [[Interface\Buttons\UI-GroupLoot-Coin-Up]], 2, GREED)
	bar.need = CreateRollButton(bar, [[Interface\Buttons\UI-GroupLoot-Dice-Up]], 1, NEED)

	local name = bar:CreateFontString(nil, "OVERLAY")
	name:SetFontObject(K.UIFontOutline)
	name:SetJustifyH("LEFT")
	name:SetWordWrap(false)
	bar.name = name

	local bind = bar:CreateFontString(nil, "OVERLAY")
	bind:SetFontObject(K.UIFontOutline)
	bar.bind = bind

	bar.rolls = {}

	tinsert(rollBars, bar)

	return bar
end

function Module:LootFrame_GetFrame(i)
	if i then
		return rollBars[i] or Module:LootRoll_Create(i)
	else -- check for a bar to reuse
		for _, bar in next, rollBars do
			if not bar.rollID then
				return bar
			end
		end
	end
end

function Module:LootRoll_Cancel(_, rollID)
	if self.rollID == rollID then
		self.rollID = nil
		self.time = nil
	end
end

function Module:LootRoll_Start(rollID, rollTime)
	local texture, name, count, quality, bop, canNeed, canGreed, canDisenchant, _, _, _, _, canTransmog = GetLootRollItemInfo(rollID)
	if not name then -- also done in GroupLootFrame_OnShow
		for _, rollBar in next, rollBars do
			if rollBar.rollID == rollID then
				Module.LootRoll_Cancel(rollBar, nil, rollID)
			end
		end

		return
	end

	local bar = Module:LootFrame_GetFrame()
	if not bar then
		return
	end -- well this shouldn't happen

	local itemLink = GetLootRollItemLink(rollID)
	local _, _, _, _, _, _, _, _, _, _, _, _, _, bindType = GetItemInfo(itemLink)
	local color = K.QualityColors[quality or 0]
	local level = K.GetItemLevel(itemLink)

	if not bop then
		bop = bindType == 1
	end -- recheck sometimes, we need this from bindType

	wipe(bar.rolls)

	bar.rollID = rollID
	bar.time = rollTime

	bar.button.link = itemLink
	bar.button.rollID = rollID
	bar.button.icon:SetTexture(texture)
	bar.button.stack:SetShown(count > 1)
	bar.button.stack:SetText(count)
	bar.button.ilvl:SetText(level or "")
	bar.button.ilvl:SetTextColor(color.r, color.g, color.b)

	bar.need.text:SetText("")
	bar.greed.text:SetText("")
	bar.pass.text:SetText("")
	bar.need:SetEnabled(canNeed)
	bar.greed:SetEnabled(canGreed and not canTransmog)

	if bar.disenchant then
		bar.disenchant.text:SetText("")
		bar.disenchant:SetEnabled(canDisenchant)
	end

	if bar.transmog then
		bar.transmog.text:SetText("")
		bar.transmog:SetEnabled(canTransmog)
	end

	bar.name:SetText(name)
	bar.name:SetTextColor(color.r, color.g, color.b)

	bar.bind:SetText(bop and L["BoP"] or bindType == 2 and L["BoE"] or bindType == 3 and "BoU" or "")
	bar.bind:SetVertexColor(bop and 1 or 0.3, bop and 0.3 or 1, bop and 0.1 or 0.3)

	bar.status:SetStatusBarColor(color.r, color.g, color.b, 0.7)
	bar.status.spark:SetColorTexture(color.r, color.g, color.b, 0.5)

	bar.status.elapsed = 1
	bar.status:SetMinMaxValues(0, rollTime)
	bar.status:SetValue(rollTime)

	bar:Show()

	_G.AlertFrame:UpdateAnchors()

	-- Add cached roll info, if any
	for rollid, rollTable in next, rollCache do
		if bar.rollID == rollid then -- rollid matches cached rollid
			for rollType, rollerInfo in next, rollTable do
				if not bar.rolls[rollType] then
					bar.rolls[rollType] = {}
				end
				tinsert(bar.rolls[rollType], { rollerInfo[1], rollerInfo[2] }) -- name, playerClass
				bar[rollTypes[rollType]].text:SetText(#bar.rolls[rollType])
			end

			break
		end
	end
end

function Module:UpdateLootRollAnchors(POSITION)
	local spacing, lastFrame, lastShown = 6
	for i, bar in next, rollBars do
		bar:ClearAllPoints()

		local anchor = i ~= 1 and lastFrame or _G.KKUI_AlertFrameHolder
		if POSITION == "TOP" then
			bar:SetPoint("TOP", anchor, "BOTTOM", 0, -spacing)
		else
			bar:SetPoint("BOTTOM", anchor, "TOP", 0, spacing)
		end

		lastFrame = bar

		if bar:IsShown() then
			lastShown = bar
		end
	end

	return lastShown
end

function Module:UpdateLootRollFrames()
	if not C["Loot"].GroupLoot then
		return
	end

	for i = 1, 4 do -- NUM_GROUP_LOOT_FRAMES does is nil now, so we can add this to the config for users to change. Bugged!
		local bar = Module:LootFrame_GetFrame(i)
		bar:SetSize(328, 26)

		bar.status:SetStatusBarTexture(K.GetTexture(C["General"].Texture))

		bar.button:ClearAllPoints()
		bar.button:SetPoint("RIGHT", bar, "LEFT", -6, 0)
		bar.button:SetSize(26, 26)

		bar.name:SetFontObject(K.UIFontOutline)
		bar.bind:SetFontObject(K.UIFontOutline)

		for _, button in next, rollTypes do
			local icon = bar[button]
			if icon then
				icon:SetSize(20, 20)
				icon:ClearAllPoints()
			end
		end

		bar.status:ClearAllPoints()
		bar.name:ClearAllPoints()
		bar.bind:ClearAllPoints()

		bar.status:SetAllPoints()
		bar.status:SetSize(328, 26)

		bar.need:SetPoint("LEFT", bar, "LEFT", 3, 0)
		if bar.disenchant then
			bar.disenchant:SetPoint("LEFT", bar.need, "RIGHT", 3, 0)
		end
		if bar.transmog then
			bar.transmog:SetPoint("LEFT", bar.disenchant or bar.need, "RIGHT", 3, 0)
		end
		bar.greed:SetPoint("LEFT", bar.transmog or bar.disenchant or bar.need, "RIGHT", 3, 0)
		bar.pass:SetPoint("LEFT", bar.greed, "RIGHT", 3, 0)

		bar.name:SetPoint("RIGHT", bar, "RIGHT", -3, 0)
		bar.name:SetPoint("LEFT", bar.bind, "RIGHT", 1, 0)
		bar.bind:SetPoint("LEFT", bar.pass, "RIGHT", 1, 0)
	end
end

function Module:CreateGroupLoot()
	if not C["Loot"].GroupLoot then
		return
	end

	Module:UpdateLootRollFrames()

	K:RegisterEvent("START_LOOT_ROLL", self.LootRoll_Start)

	_G.UIParent:UnregisterEvent("START_LOOT_ROLL")
	_G.UIParent:UnregisterEvent("CANCEL_LOOT_ROLL")
end
