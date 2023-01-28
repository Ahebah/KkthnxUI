local K, C = unpack(KkthnxUI)
local Module = K:GetModule("Automation")

local CancelDuel = CancelDuel
local StaticPopup_Hide = StaticPopup_Hide
local C_PetBattles_CancelPVPDuel = C_PetBattles.CancelPVPDuel

function Module:DUEL_REQUESTED()
	CancelDuel()
	StaticPopup_Hide("DUEL_REQUESTED")
end

function Module:PET_BATTLE_PVP_DUEL_REQUESTED()
	C_PetBattles_CancelPVPDuel()
	StaticPopup_Hide("PET_BATTLE_PVP_DUEL_REQUESTED")
end

function Module:CreateAutoDeclineDuels()
	if C["Automation"].AutoDeclineDuels then
		K:RegisterEvent("DUEL_REQUESTED", Module.DUEL_REQUESTED)
		K:RegisterEvent("PET_BATTLE_PVP_DUEL_REQUESTED", Module.PET_BATTLE_PVP_DUEL_REQUESTED)
	else
		K:UnregisterEvent("DUEL_REQUESTED", Module.DUEL_REQUESTED)
		K:UnregisterEvent("PET_BATTLE_PVP_DUEL_REQUESTED", Module.PET_BATTLE_PVP_DUEL_REQUESTED)
	end
end
