local K, C, L = unpack(select(2, ...))
if C["ActionBar"].Enable ~= true then
	return
end

local _G = _G

local ActionBar5 = CreateFrame("Frame", "Bar5Holder", K.PetBattleHider)
if C["ActionBar"].RightBars < 3 then
	if C["ActionBar"].SplitBars == true then
		ActionBar5:SetAllPoints(SplitBarLeft)
	else
		ActionBar5:SetAllPoints(ActionBarAnchor)
	end
else
	ActionBar5:SetAllPoints(RightActionBarAnchor)
end
MultiBarBottomRight:SetParent(ActionBar5)
ActionBar5:SetFrameStrata("LOW")

for i = 1, 12 do
	local b = _G["MultiBarBottomRightButton" .. i]
	local b2 = _G["MultiBarBottomRightButton" .. i - 1]
	b:ClearAllPoints()
	if C["ActionBar"].SplitBars == true and C["ActionBar"].RightBars < 3 then
		if i == 1 then
			b:SetPoint("TOPLEFT", SplitBarLeft, "TOPLEFT", 0, 0)
		elseif i == 4 then
			b:SetPoint("BOTTOMLEFT", SplitBarLeft, "BOTTOMLEFT", 0, 0)
		elseif i == 7 then
			b:SetPoint("TOPLEFT", SplitBarRight, "TOPLEFT", 0, 0)
		elseif i == 10 then
			b:SetPoint("BOTTOMLEFT", SplitBarRight, "BOTTOMLEFT", 0, 0)
		else
			b:SetPoint("LEFT", b2, "RIGHT", C["ActionBar"].ButtonSpace, 0)
		end
	else
		if i == 1 then
			if C["ActionBar"].RightBars < 3 then
				b:SetPoint("TOPLEFT", Bar1Holder, 0, 0)
			else
				b:SetPoint("TOPLEFT", RightActionBarAnchor, "TOPLEFT", 0, 0)
			end
		else
			if C["ActionBar"].RightBars < 3 then
				b:SetPoint("LEFT", b2, "RIGHT", C["ActionBar"].ButtonSpace, 0)
			else
				b:SetPoint("TOP", b2, "BOTTOM", 0, -C["ActionBar"].ButtonSpace)
			end
		end
	end
end

if C["ActionBar"].RightBars < 3 and C["ActionBar"].BottomBars < 3 then
	ActionBar5:Hide()
end
