local K = unpack(KkthnxUI)
local bar_UpdateFrame = CreateFrame("Frame")

-- ls_UI, lightspark

local math_abs = math.abs

local Lerp = Lerp
local next = next

local activeObjects = {}
local handledObjects = {}

local TARGET_FPS = 60
local AMOUNT = 0.33

local function clamp(v, min, max)
	min = min or 0
	max = max or 1
	v = tonumber(v)

	if v > max then
		return max
	elseif v < min then
		return min
	end

	return v
end

local function isCloseEnough(new, target, range)
	if range > 0 then
		return math_abs((new - target) / range) <= 0.001
	end

	return true
end

local function onUpdate(_, elapsed)
	for object, target in next, activeObjects do
		local new = Lerp(object._value, target, clamp(AMOUNT * elapsed * TARGET_FPS))
		if isCloseEnough(new, target, object._max - object._min) then
			new = target
			activeObjects[object] = nil
		end

		object:SetValue_(new)
		object._value = new
	end
end

local function bar_SetSmoothedValue(self, value)
	self._value = self:GetValue()
	activeObjects[self] = clamp(value, self._min, self._max)
end

local function bar_SetSmoothedMinMaxValues(self, min, max)
	self:SetMinMaxValues_(min, max)

	if self._max and self._max ~= max then
		local ratio = 1
		if max ~= 0 and self._max and self._max ~= 0 then
			ratio = max / (self._max or max)
		end

		local target = activeObjects[self]
		if target then
			activeObjects[self] = target * ratio
		end

		local cur = self._value
		if cur then
			self:SetValue_(cur * ratio)
			self._value = cur * ratio
		end
	end

	self._min = min
	self._max = max
end

function K:SmoothBar(bar)
	bar._min, bar._max = bar:GetMinMaxValues()
	bar._value = bar:GetValue()

	bar.SetValue_ = bar.SetValue
	bar.SetMinMaxValues_ = bar.SetMinMaxValues
	bar.SetValue = bar_SetSmoothedValue
	bar.SetMinMaxValues = bar_SetSmoothedMinMaxValues

	handledObjects[bar] = true

	if not bar_UpdateFrame:GetScript("OnUpdate") then
		bar_UpdateFrame:SetScript("OnUpdate", onUpdate)
	end
end

function K:DesmoothBar(bar)
	if activeObjects[bar] then
		bar:SetValue_(activeObjects[bar])
		activeObjects[bar] = nil
	end

	if bar.SetValue_ then
		bar.SetValue = bar.SetValue_
		bar.SetValue_ = nil
	end

	if bar.SetMinMaxValues_ then
		bar.SetMinMaxValues = bar.SetMinMaxValues_
		bar.SetMinMaxValues_ = nil
	end

	handledObjects[bar] = nil

	if not next(handledObjects) then
		bar_UpdateFrame:SetScript("OnUpdate", nil)
	end
end

function K:SetSmoothingAmount(amount)
	AMOUNT = clamp(amount, 0.1, 1)
end
