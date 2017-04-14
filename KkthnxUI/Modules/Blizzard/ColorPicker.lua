local K, C, L = unpack(select(2, ...))
if C.Misc.ColorPicker ~= true then return end

-- Credit to Jaslm, most of this code is his from the addon ColorPickerPlus
-- Lua API
local _G = _G
local floor = math.floor
local format, strsub = string.format, strsub
local tonumber, collectgarbage = tonumber, collectgarbage

-- Lua Wow
local CALENDAR_COPY_EVENT, CALENDAR_PASTE_EVENT = _G.CALENDAR_COPY_EVENT, _G.CALENDAR_PASTE_EVENT
local CLASS, DEFAULT = _G.CLASS, _G.DEFAULT
local CreateFrame = _G.CreateFrame
local CUSTOM_CLASS_COLORS = _G.CUSTOM_CLASS_COLORS
local RAID_CLASS_COLORS =_G. RAID_CLASS_COLORS

-- Global variables that we don't cache, list them here for mikk"s FindGlobals script
-- GLOBALS: ColorPickerFrame, OpacitySliderFrame, ColorPPBoxA, ColorPPBoxR, ColorPPBoxG
-- GLOBALS: ColorPickerOkayButton, ColorPickerCancelButton
-- GLOBALS: ColorPPBoxB, ColorPPBoxH, ColorSwatch, ColorPickerFrameHeader, ColorPPPaste
-- GLOBALS: ColorPPCopyColorSwatch, ColorPPBoxLabelA, ColorPPOldColorSwatch

local initialized = nil
local colorBuffer = {}
local editingText

local function UpdateAlphaText()
	local a = OpacitySliderFrame:GetValue()
	a = (1 - a) * 100
	a = floor(a +.05)
	ColorPPBoxA:SetText(("%d"):format(a))
end

local function UpdateAlpha(tbox)
	local a = tbox:GetNumber()
	if a > 100 then
		a = 100
		ColorPPBoxA:SetText(("%d"):format(a))
	end
	a = 1 - (a / 100)
	editingText = true
	OpacitySliderFrame:SetValue(a)
	editingText = nil
end

local function UpdateColorTexts(r, g, b)
	if not r then r, g, b = ColorPickerFrame:GetColorRGB() end
	r = r*255
	g = g*255
	b = b*255
	ColorPPBoxR:SetText(("%d"):format(r))
	ColorPPBoxG:SetText(("%d"):format(g))
	ColorPPBoxB:SetText(("%d"):format(b))
	ColorPPBoxH:SetText(("%.2x%.2x%.2x"):format(r, g, b))
end

local function UpdateColor(tbox)
	local r, g, b = ColorPickerFrame:GetColorRGB()
	local id = tbox:GetID()

	if id == 1 then
		r = format("%d", tbox:GetNumber())
		if not r then r = 0 end
		r = r/255
	elseif id == 2 then
		g = format("%d", tbox:GetNumber())
		if not g then g = 0 end
		g = g/255
	elseif id == 3 then
		b = format("%d", tbox:GetNumber())
		if not b then b = 0 end
		b = b/255
	elseif id == 4 then
		-- hex values
		if tbox:GetNumLetters() == 6 then
			local rgb = tbox:GetText()
			r, g, b = tonumber("0x"..strsub(rgb, 0, 2)), tonumber("0x"..strsub(rgb, 3, 4)), tonumber("0x"..strsub(rgb, 5, 6))
			if not r then r = 0 else r = r/255 end
			if not g then g = 0 else g = g/255 end
			if not b then b = 0 else b = b/255 end
		else
			return
		end
	end

	-- This takes care of updating the hex entry when changing rgb fields and vice versa
	UpdateColorTexts(r,g,b)

	editingText = true
	ColorPickerFrame:SetColorRGB(r, g, b)
	ColorSwatch:SetColorTexture(r, g, b)
	editingText = nil
end

local EnhanceColorPicker = CreateFrame("Frame")
EnhanceColorPicker:RegisterEvent("PLAYER_LOGIN")
EnhanceColorPicker:SetScript("OnEvent", function(self, event)
	if K.CheckAddOn("ColorPickerPlus") then
		return
	end
	ColorPickerFrame:SetClampedToScreen(true)

	-- Move default buttons into place
	ColorPickerCancelButton:ClearAllPoints()
	ColorPickerOkayButton:ClearAllPoints()
	ColorPickerCancelButton:SetPoint("BOTTOMRIGHT", ColorPickerFrame, "BOTTOMRIGHT", -12, 12)
	ColorPickerCancelButton:SetPoint("BOTTOMLEFT", ColorPickerFrame, "BOTTOM", 0, 12)
	ColorPickerOkayButton:SetPoint("BOTTOMLEFT", ColorPickerFrame, "BOTTOMLEFT", 12, 12)
	ColorPickerOkayButton:SetPoint("RIGHT", ColorPickerCancelButton, "LEFT", -10, 0)
	ColorPickerFrame:HookScript("OnShow", function(self)
		-- Get color that will be replaced
		local r, g, b = ColorPickerFrame:GetColorRGB()
		ColorPPOldColorSwatch:SetColorTexture(r, g, b)

		-- show/hide the alpha box
		if ColorPickerFrame.hasOpacity then
			ColorPPBoxA:Show()
			ColorPPBoxLabelA:Show()
			ColorPPBoxH:SetScript("OnTabPressed", function(self) ColorPPBoxA:SetFocus() end)
			UpdateAlphaText()
			self:SetWidth(405)
		else
			ColorPPBoxA:Hide()
			ColorPPBoxLabelA:Hide()
			ColorPPBoxH:SetScript("OnTabPressed", function(self) ColorPPBoxR:SetFocus() end)
			self:SetWidth(345)
		end
	end)

	-- Memory Fix, Colorpicker will call the self.func() 100x per second, causing fps/memory issues,
	-- this little script will make you have to press ok for you to notice any changes.
	ColorPickerFrame:SetScript("OnColorSelect", function(s, r, g, b)
		ColorSwatch:SetColorTexture(r, g, b)
		if not editingText then
			UpdateColorTexts(r, g, b)
		end
	end)

	ColorPickerOkayButton:HookScript("OnClick", function()
		collectgarbage("collect"); --Couldn't hurt to do this, this button usually executes a lot of code.
		end)

		OpacitySliderFrame:HookScript("OnValueChanged", function(self)
			if not editingText then
				UpdateAlphaText()
			end
		end)

		-- make the Color Picker dialog a bit taller, to make room for edit boxes
		ColorPickerFrame:SetHeight(ColorPickerFrame:GetHeight() + 40)

		-- move the Color Swatch
		ColorSwatch:ClearAllPoints()
		ColorSwatch:SetPoint("TOPLEFT", ColorPickerFrame, "TOPLEFT", 215, -45)

		-- add Color Swatch for original color
		local t = ColorPickerFrame:CreateTexture("ColorPPOldColorSwatch")
		local w, h = ColorSwatch:GetSize()
		t:SetSize(w * 0.75,h * 0.75)
		t:SetColorTexture(0, 0, 0)
		-- OldColorSwatch to appear beneath ColorSwatch
		t:SetDrawLayer("BORDER")
		t:SetPoint("BOTTOMLEFT", "ColorSwatch", "TOPRIGHT", -(w / 2), -(h / 3))

		-- add Color Swatch for the copied color
		t = ColorPickerFrame:CreateTexture("ColorPPCopyColorSwatch")
		t:SetSize(w, h)
		t:SetColorTexture(0, 0, 0)
		t:Hide()

		-- add copy button to the ColorPickerFrame
		local b = CreateFrame("Button", "ColorPPCopy", ColorPickerFrame, "UIPanelButtonTemplate")
		b:SetText(CALENDAR_COPY_EVENT)
		b:SetWidth(60)
		b:SetHeight(22)
		b:SetPoint("TOPLEFT", "ColorSwatch", "BOTTOMLEFT", -2, -5)

		-- copy color into buffer on button click
		b:SetScript("OnClick", function(self)
			-- copy current dialog colors into buffer
			colorBuffer.r, colorBuffer.g, colorBuffer.b = ColorPickerFrame:GetColorRGB()

			-- enable Paste button and display copied color into swatch
			ColorPPPaste:Enable()
			ColorPPCopyColorSwatch:SetColorTexture(colorBuffer.r, colorBuffer.g, colorBuffer.b)
			ColorPPCopyColorSwatch:Show()

			if ColorPickerFrame.hasOpacity then
				colorBuffer.a = OpacitySliderFrame:GetValue()
			else
				colorBuffer.a = nil
			end
		end)

		-- class color button
		b = CreateFrame("Button", "ColorPPClass", ColorPickerFrame, "UIPanelButtonTemplate")
		b:SetText(CLASS)
		b:SetWidth(80)
		b:SetHeight(22)
		b:SetPoint("TOP", "ColorPPCopy", "BOTTOMRIGHT", 0, -7)

		b:SetScript("OnClick", function()
			local color = K.Class == "PRIEST" and K.PriestColors or (CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[K.Class] or RAID_CLASS_COLORS[K.Class])
			ColorPickerFrame:SetColorRGB(color.r, color.g, color.b)
			ColorSwatch:SetColorTexture(color.r, color.g, color.b)
			if ColorPickerFrame.hasOpacity then
				OpacitySliderFrame:SetValue(0)
			end
		end)

		-- add paste button to the ColorPickerFrame
		b = CreateFrame("Button", "ColorPPPaste", ColorPickerFrame, "UIPanelButtonTemplate")
		b:SetText(CALENDAR_PASTE_EVENT)
		b:SetWidth(60)
		b:SetHeight(22)
		b:SetPoint("TOPLEFT", "ColorPPCopy", "TOPRIGHT", 1, 0)
		b:Disable() -- enable when something has been copied

		-- paste color on button click, updating frame components
		b:SetScript("OnClick", function(self)
			ColorPickerFrame:SetColorRGB(colorBuffer.r, colorBuffer.g, colorBuffer.b)
			ColorSwatch:SetColorTexture(colorBuffer.r, colorBuffer.g, colorBuffer.b)
			if ColorPickerFrame.hasOpacity then
				if colorBuffer.a then --color copied had an alpha value
					OpacitySliderFrame:SetValue(colorBuffer.a)
				end
			end
		end)

		-- add defaults button to the ColorPickerFrame
		b = CreateFrame("Button", "ColorPPDefault", ColorPickerFrame, "UIPanelButtonTemplate")
		b:SetText(DEFAULT)
		b:SetWidth(80)
		b:SetHeight(22)
		b:SetPoint("TOPLEFT", "ColorPPClass", "BOTTOMLEFT", 0, -7)
		b:Disable() -- enable when something has been copied
		b:SetScript("OnHide", function(self)
			self.colors = nil
		end)
		b:SetScript("OnShow", function(self)
			if(self.colors) then
				self:Enable()
			else
				self:Disable()
			end
		end)

		-- paste color on button click, updating frame components
		b:SetScript("OnClick", function(self)
			local colorBuffer = self.colors
			ColorPickerFrame:SetColorRGB(colorBuffer.r, colorBuffer.g, colorBuffer.b)
			ColorSwatch:SetColorTexture(colorBuffer.r, colorBuffer.g, colorBuffer.b)
			if ColorPickerFrame.hasOpacity then
				if colorBuffer.a then
					OpacitySliderFrame:SetValue(colorBuffer.a)
				end
			end
		end)

		-- position Color Swatch for copy color
		ColorPPCopyColorSwatch:SetPoint("BOTTOM", "ColorPPPaste", "TOP", 0, 10)

		-- move the Opacity Slider Frame to align with bottom of Copy ColorSwatch
		OpacitySliderFrame:ClearAllPoints()
		OpacitySliderFrame:SetPoint("BOTTOM", "ColorPPDefault", "BOTTOM", 0, 0)
		OpacitySliderFrame:SetPoint("RIGHT", "ColorPickerFrame", "RIGHT", -35, 18)

		-- set up edit box frames and interior label and text areas
		local boxes = { "R", "G", "B", "H", "A" }
		for i = 1, #boxes do

			local rgb = boxes[i]
			local box = CreateFrame("EditBox", "ColorPPBox"..rgb, ColorPickerFrame, "InputBoxTemplate")
			box:SetID(i)
			box:SetFrameStrata("DIALOG")
			box:SetAutoFocus(false)
			box:SetTextInsets(0,7,0,0)
			box:SetJustifyH("RIGHT")
			box:SetHeight(24)

			if i == 4 then
				-- Hex entry box
				box:SetMaxLetters(6)
				box:SetWidth(56)
				box:SetNumeric(false)
			else
				box:SetMaxLetters(3)
				box:SetWidth(40)
				box:SetNumeric(true)
			end
			box:SetPoint("TOP", "ColorPickerWheel", "BOTTOM", 0, -15)

			-- label
			local label = box:CreateFontString("ColorPPBoxLabel"..rgb, "ARTWORK", "GameFontNormalSmall")
			label:SetTextColor(1, 1, 1)
			label:SetPoint("RIGHT", "ColorPPBox"..rgb, "LEFT", -5, 0)
			if i == 4 then
				label:SetText("#")
			else
				label:SetText(rgb)
			end

			-- set up scripts to handle event appropriately
			if i == 5 then
				box:SetScript("OnEscapePressed", function(self)	self:ClearFocus() UpdateAlphaText() end)
				box:SetScript("OnEnterPressed", function(self) self:ClearFocus() UpdateAlphaText() end)
				box:SetScript("OnTextChanged", function(self) UpdateAlpha(self) end)
			else
				box:SetScript("OnEscapePressed", function(self)	self:ClearFocus() UpdateColorTexts() end)
				box:SetScript("OnEnterPressed", function(self) self:ClearFocus() UpdateColorTexts() end)
				box:SetScript("OnTextChanged", function(self) UpdateColor(self) end)
			end

			box:SetScript("OnEditFocusGained", function(self) self:SetCursorPosition(0) self:HighlightText() end)
			box:SetScript("OnEditFocusLost", function(self)	self:HighlightText(0,0) end)
			box:SetScript("OnTextSet", function(self) self:ClearFocus() end)
			box:Show()
		end

		-- finish up with placement
		ColorPPBoxA:SetPoint("RIGHT", "OpacitySliderFrame", "RIGHT", 10, 0)
		ColorPPBoxH:SetPoint("RIGHT", "ColorPPDefault", "RIGHT", -10, 0)
		ColorPPBoxB:SetPoint("RIGHT", "ColorPPDefault", "LEFT", -40, 0)
		ColorPPBoxG:SetPoint("RIGHT", "ColorPPBoxB", "LEFT", -25, 0)
		ColorPPBoxR:SetPoint("RIGHT", "ColorPPBoxG", "LEFT", -25, 0)

		-- define the order of tab cursor movement
		ColorPPBoxR:SetScript("OnTabPressed", function(self) ColorPPBoxG:SetFocus() end)
		ColorPPBoxG:SetScript("OnTabPressed", function(self) ColorPPBoxB:SetFocus() end)
		ColorPPBoxB:SetScript("OnTabPressed", function(self) ColorPPBoxH:SetFocus() end)
		ColorPPBoxA:SetScript("OnTabPressed", function(self) ColorPPBoxR:SetFocus() end)

		-- make the color picker movable.
		local mover = CreateFrame("Frame", nil, ColorPickerFrame)
		mover:SetPoint("TOPLEFT", ColorPickerFrame, "TOP", -60, 0)
		mover:SetPoint("BOTTOMRIGHT", ColorPickerFrame, "TOP", 60, -15)
		mover:EnableMouse(true)
		mover:SetScript("OnMouseDown", function() ColorPickerFrame:StartMoving() end)
		mover:SetScript("OnMouseUp", function() ColorPickerFrame:StopMovingOrSizing() end)
		ColorPickerFrame:SetUserPlaced(true)
		ColorPickerFrame:EnableKeyboard(false)
	end)