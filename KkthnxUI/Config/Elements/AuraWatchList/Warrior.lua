local K = unpack(KkthnxUI)
local Module = K:GetModule("AurasTable")

if K.Class ~= "WARRIOR" then
	return
end

local list = {
	["Player Aura"] = {
		{ AuraID = 32216, UnitID = "player" },
		{ AuraID = 202602, UnitID = "player" },
		{ AuraID = 200954, UnitID = "player" },
		{ AuraID = 202573, UnitID = "player" },
		{ AuraID = 202574, UnitID = "player" },
	},
	["Target Aura"] = {
		{ AuraID = 355, UnitID = "target", Caster = "player" },
		{ AuraID = 772, UnitID = "target", Caster = "player" },
		{ AuraID = 1715, UnitID = "target", Caster = "player" },
		{ AuraID = 1160, UnitID = "target", Caster = "player" },
		{ AuraID = 6343, UnitID = "target", Caster = "player" },
		{ AuraID = 5246, UnitID = "target", Caster = "player" },
		{ AuraID = 12323, UnitID = "target", Caster = "player" },
		{ AuraID = 105771, UnitID = "target", Caster = "player" },
		{ AuraID = 132169, UnitID = "target", Caster = "player" },
		{ AuraID = 132168, UnitID = "target", Caster = "player" },
		{ AuraID = 208086, UnitID = "target", Caster = "player" },
		{ AuraID = 115804, UnitID = "target", Caster = "player" },
		{ AuraID = 280773, UnitID = "target", Caster = "player" },
		{ AuraID = 317491, UnitID = "target", Caster = "player", Value = true },
	},
	["Special Aura"] = {
		{ AuraID = 871, UnitID = "player" },
		{ AuraID = 1719, UnitID = "player" },
		{ AuraID = 7384, UnitID = "player", Stack = 2, Flash = true },
		{ AuraID = 12975, UnitID = "player" },
		{ AuraID = 85739, UnitID = "player" },
		{ AuraID = 46924, UnitID = "player" },
		{ AuraID = 227847, UnitID = "player" },
		{ AuraID = 23920, UnitID = "player" },
		{ AuraID = 18499, UnitID = "player" },
		{ AuraID = 52437, UnitID = "player" },
		{ AuraID = 188783, UnitID = "player" },
		{ AuraID = 207982, UnitID = "player" },
		{ AuraID = 132404, UnitID = "player" },
		{ AuraID = 202289, UnitID = "player" },
		{ AuraID = 107574, UnitID = "player" },
		{ AuraID = 202164, UnitID = "player" },
		{ AuraID = 152277, UnitID = "player" },
		{ AuraID = 184362, UnitID = "player" },
		{ AuraID = 200953, UnitID = "player" },
		{ AuraID = 184364, UnitID = "player" },
		{ AuraID = 200986, UnitID = "player" },
		{ AuraID = 206333, UnitID = "player" },
		{ AuraID = 215570, UnitID = "player" },
		{ AuraID = 202225, UnitID = "player" },
		{ AuraID = 215572, UnitID = "player" },
		{ AuraID = 213284, UnitID = "player" },
		{ AuraID = 202539, UnitID = "player" },
		{ AuraID = 118000, UnitID = "player" },
		{ AuraID = 209706, UnitID = "player" },
		{ AuraID = 197690, UnitID = "player" },
		{ AuraID = 118038, UnitID = "player" },
		{ AuraID = 201009, UnitID = "player" },
		{ AuraID = 225947, UnitID = "player" },
		{ AuraID = 203581, UnitID = "player" },
		{ AuraID = 227744, UnitID = "player" },
		{ AuraID = 209484, UnitID = "player" },
		{ AuraID = 248625, UnitID = "player" },
		{ AuraID = 248622, UnitID = "player" },
		{ AuraID = 190456, UnitID = "player", Value = true },
		{ AuraID = 260708, UnitID = "player" },
		{ AuraID = 262228, UnitID = "player" },
	},
	["Focus Aura"] = {
		{ AuraID = 772, UnitID = "focus", Caster = "player" },
		{ AuraID = 115767, UnitID = "focus", Caster = "player" },
	},
	["Spell Cooldown"] = {
		{ SlotID = 13 },
		{ SlotID = 14 },
	},
}

Module:AddNewAuraWatch("WARRIOR", list)
