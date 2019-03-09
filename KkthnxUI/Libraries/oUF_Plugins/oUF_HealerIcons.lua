local _, ns = ...
local oUF = ns.oUF or oUF

local _G = _G

local gsub = gsub
local format = format

local UnitName = _G.UnitName
local GetNumBattlefieldScores = _G.GetNumBattlefieldScores
local GetBattlefieldScore = _G.GetBattlefieldScore
local GetNumArenaOpponentSpecs = _G.GetNumArenaOpponentSpecs
local GetArenaOpponentSpec = _G.GetArenaOpponentSpec
local GetSpecializationInfoByID = _G.GetSpecializationInfoByID
local IsInInstance = _G.IsInInstance
local UNKNOWN = _G.UNKNOWN

local healerSpecIDs = {
	65,		-- Paladin Holy
	105,	-- Druid Restoration
	256,	-- Priest Discipline
	257,	-- Priest Holy
	264,	-- Shaman Restoration
	270,	-- Monk Mistweaver
}

local Healers, HealerSpecs = {}, {}

for _, specID in pairs(healerSpecIDs) do
	local _, name = GetSpecializationInfoByID(specID)
	if name and not HealerSpecs[name] then
		HealerSpecs[name] = true
	end
end

local function Event(self)
	local inInstance, instanceType = IsInInstance()
	if inInstance and (instanceType == "pvp" or instanceType == "arena") then
		if instanceType == "pvp" then
			local name, _, talentSpec
			for i = 1, GetNumBattlefieldScores() do
				name, _, _, _, _, _, _, _, _, _, _, _, _, _, _, talentSpec = GetBattlefieldScore(i)
				if name then
					name = gsub(name,"%-"..gsub(E.myrealm,"[%s%-]",""),"") -- name = match(name,"([^%-]+).*")
					if name and self.HealerSpecs[talentSpec] then
						Healers[name] = talentSpec
					elseif name and self.Healers[name] then
						Healers[name] = nil
					end
				end
			end
		else
			local numOpps = GetNumArenaOpponentSpecs()
			if not (numOpps > 1) then return end

			for i = 1, 5 do
				local name, realm = UnitName(format("arena%d", i))
				if name and name ~= UNKNOWN then
					realm = (realm and realm ~= "") and gsub(realm,"[%s%-]","")
					if realm then name = name.."-"..realm end
					local s = GetArenaOpponentSpec(i)
					local _, talentSpec = nil, UNKNOWN
					if s and s > 0 then
						_, talentSpec = GetSpecializationInfoByID(s)
					end

					if talentSpec and talentSpec ~= UNKNOWN and self.HealerSpecs[talentSpec] then
						Healers[name] = talentSpec
					end
				end
			end
		end
	end
end

local function Update(self)
	local element = self.HealerSpecs

	local inInstance, instanceType = IsInInstance()

	if (element.PreUpdate) then
		element:PreUpdate()
	end

	if inInstance and (instanceType == "pvp" or instanceType == "arena") then
		local name, realm = UnitName(self.unit)
		realm = (realm and realm ~= "") and gsub(realm,"[%s%-]","")
		if realm then name = name.."-"..realm end

		if Healers[name] then
			element:Show()
		else
			element:Hide()
		end
	end

	if (element.PostUpdate) then
		return element:PostUpdate(instanceType)
	end
end

local function Path(self, ...)
	return (self.HealerSpecs.Override or Update) (self, ...)
end

local function ForceUpdate(element)
	return Path(element.__owner, "ForceUpdate", element.__owner.unit)
end

local function Enable(self)
	local element = self.HealerSpecs
	if (element) then
		element.__owner = self
		element.ForceUpdate = ForceUpdate

		if (element:IsObjectType("Texture") and not element:GetTexture()) then
			element:SetTexture([[Interface\AddOns\KkthnxUI\Media\Nameplates\UI-Plate-Healer.tga]])
		end

		self:RegisterEvent("UNIT_TARGET", Path)
		self:RegisterEvent("PLAYER_TARGET_CHANGED", Path, true)
		self:RegisterEvent("UNIT_NAME_UPDATE", Path)
		self:RegisterEvent("ARENA_OPPONENT_UPDATE", Event, true)
		self:RegisterEvent("UPDATE_BATTLEFIELD_SCORE", Event, true)

		return true
	end
end

local function Disable(self)
	local element = self.HealerSpecs
	if (element) then
		element:Hide()

		self:UnregisterEvent("UNIT_NAME_UPDATE")
		self:UnregisterEvent("ARENA_OPPONENT_UPDATE")
		self:UnregisterEvent("UPDATE_BATTLEFIELD_SCORE")
	end
end

oUF:AddElement("HealerSpecs", Path, Enable, Disable)