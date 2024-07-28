local K, C, L = KkthnxUI[1], KkthnxUI[2], KkthnxUI[3]
local Module = K:GetModule("DataText")

local string_format = string.format

local CoordsDataText
local coordX, coordY = 0, 0
local faction
local pvpType
local subzone
local zone

local zoneInfo = {
	arena = { FREE_FOR_ALL_TERRITORY, { 0.84, 0.03, 0.03 } },
	combat = { COMBAT_ZONE, { 0.84, 0.03, 0.03 } },
	contested = { CONTESTED_TERRITORY, { 0.9, 0.85, 0.05 } },
	friendly = { FACTION_CONTROLLED_TERRITORY, { 0.05, 0.85, 0.03 } },
	hostile = { FACTION_CONTROLLED_TERRITORY, { 0.84, 0.03, 0.03 } },
	neutral = { string_format(FACTION_CONTROLLED_TERRITORY, FACTION_STANDING_LABEL4), { 0.9, 0.85, 0.05 } },
	sanctuary = { SANCTUARY_TERRITORY, { 0.035, 0.58, 0.84 } },
}

local function formatCoords()
	return string_format("%.1f, %.1f", coordX * 100, coordY * 100)
end

local function OnUpdate(self, elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed > 0.1 then
		local x, y = K.GetPlayerMapPos(C_Map.GetBestMapForUnit("player"))
		if x then
			coordX, coordY = x, y
			CoordsDataText.Text:SetText(formatCoords())
			CoordsDataText:Show()
		else
			coordX, coordY = 0, 0
			CoordsDataText:Hide()
		end
		self.elapsed = 0
	end
end

local eventList = {
	"ZONE_CHANGED",
	"ZONE_CHANGED_INDOORS",
	"ZONE_CHANGED_NEW_AREA",
	"PLAYER_ENTERING_WORLD",
}

local function OnEvent(_, event, ...)
	if tContains(eventList, event) then
		subzone = GetSubZoneText()
		zone = GetZoneText()
		pvpType, _, faction = GetZonePVPInfo()
		pvpType = pvpType or "neutral"
	end
end

local function OnEnter()
	GameTooltip:SetOwner(CoordsDataText, "ANCHOR_BOTTOM", 0, -15)
	GameTooltip:ClearLines()

	if pvpType and not IsInInstance() then
		local r, g, b = unpack(zoneInfo[pvpType][2])
		if zone and subzone and subzone ~= "" then
			GameTooltip:AddLine(K.GreyColor .. ZONE .. ":|r " .. zone, r, g, b)
			GameTooltip:AddLine(K.GreyColor .. "SubZone" .. ":|r " .. subzone, r, g, b)
		else
			GameTooltip:AddLine(K.GreyColor .. ZONE .. ":|r " .. zone, r, g, b)
		end
		GameTooltip:AddLine(string_format(K.GreyColor .. "PvPType" .. ":|r " .. zoneInfo[pvpType][1], faction or ""), r, g, b)
	end

	GameTooltip:AddLine(" ")
	GameTooltip:AddLine(K.LeftButton .. "Toggle WorldMap", 0.6, 0.8, 1)
	GameTooltip:AddLine(K.RightButton .. "Send My Position", 0.6, 0.8, 1)
	GameTooltip:Show()
end

local function OnLeave()
	GameTooltip:Hide()
end

local function OnMouseUp(_, btn)
	-- Toggle world map if left button is clicked
	if btn == "LeftButton" then
		ToggleWorldMap()
	-- Open chat frame with position and target information if right button is clicked
	elseif btn == "RightButton" then
		local zone = GetZoneText()
		local subzone = GetSubZoneText()
		local mapID = C_Map.GetBestMapForUnit("player")
		local position = C_Map.GetPlayerMapPosition(mapID, "player")
		local coordString = position and format("%.1f, %.1f", position:GetXY()) or "N/A"
		local unitName = UnitExists("target") and not UnitIsPlayer("target") and UnitName("target")

		-- Format chat message with position, subzone, coordinates, and target name (if applicable)
		local chatMsg = format("%s: %s %s (%s) %s", L["My Position"], zone, subzone or "", coordString, unitName or "")

		-- Open chat frame with message and selected dock frame
		ChatFrame_OpenChat(chatMsg, SELECTED_DOCK_FRAME)
	end
end

function Module:CreateCoordsDataText()
	if not C["DataText"].Coords then
		return
	end

	CoordsDataText = CreateFrame("Frame", nil, UIParent)
	CoordsDataText:SetHitRectInsets(0, 0, -10, -10)

	CoordsDataText.Text = K.CreateFontString(CoordsDataText, 12)
	CoordsDataText.Text:ClearAllPoints()
	CoordsDataText.Text:SetPoint("TOP", UIParent, "TOP", 0, -40)

	CoordsDataText.Texture = CoordsDataText:CreateTexture(nil, "ARTWORK")
	CoordsDataText.Texture:SetPoint("BOTTOM", CoordsDataText, "TOP", 0, 0)
	CoordsDataText.Texture:SetTexture("Interface\\AddOns\\KkthnxUI\\Media\\DataText\\coords.blp")
	CoordsDataText.Texture:SetSize(24, 24)
	CoordsDataText.Texture:SetVertexColor(unpack(C["DataText"].IconColor))

	CoordsDataText:SetAllPoints(CoordsDataText.Text)

	local function _OnEvent(...)
		OnEvent(...)
	end

	for _, event in pairs(eventList) do
		CoordsDataText:RegisterEvent(event)
	end

	CoordsDataText:SetScript("OnEvent", _OnEvent)
	CoordsDataText:SetScript("OnEnter", OnEnter)
	CoordsDataText:SetScript("OnLeave", OnLeave)
	CoordsDataText:SetScript("OnMouseUp", OnMouseUp)
	CoordsDataText:SetScript("OnUpdate", OnUpdate)
end
