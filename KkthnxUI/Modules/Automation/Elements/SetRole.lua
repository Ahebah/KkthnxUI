local K, C = KkthnxUI[1], KkthnxUI[2]
local Module = K:GetModule("Automation")

-- WoW API functions
local GetSpecialization = GetSpecialization
local GetSpecializationRole = GetSpecializationRole
local GetTime = GetTime
local InCombatLockdown = InCombatLockdown
local IsInGroup = IsInGroup
local IsPartyLFG = IsPartyLFG
local UnitGroupRolesAssigned = UnitGroupRolesAssigned
local UnitSetRole = UnitSetRole

-- Local variables
local lastRoleChangeTime = 0
local currentRole = nil
local ROLE_CHANGE_THRESHOLD = 2

-- Change player role function
local function changePlayerRole(role)
	local currentTime = GetTime()
	if not InCombatLockdown() and (currentTime - lastRoleChangeTime > ROLE_CHANGE_THRESHOLD) and (UnitGroupRolesAssigned("player") ~= role) then
		local success = UnitSetRole("player", role)
		if success then
			lastRoleChangeTime = currentTime
			currentRole = role
		end
	end
end

-- Setup auto role function
function Module:SetupAutoRole()
	if K.Level < 10 or InCombatLockdown() or not IsInGroup() or IsPartyLFG() then
		return
	end

	local spec = GetSpecialization()
	if spec then
		local role = GetSpecializationRole(spec)
		if role ~= currentRole then
			changePlayerRole(role)
		end
	else
		changePlayerRole("No Role")
	end
end

-- Create auto set role function
function Module:CreateAutoSetRole()
	if not C["Automation"].AutoSetRole then
		return
	end

	K:RegisterEvent("PLAYER_TALENT_UPDATE", self.SetupAutoRole)
	K:RegisterEvent("GROUP_ROSTER_UPDATE", self.SetupAutoRole)

	RolePollPopup:UnregisterEvent("ROLE_POLL_BEGIN")
end
