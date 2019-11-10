if SERVER then
	AddCSLuaFile()
	if file.Exists("scripts/sh_convarutil.lua", "LUA") then
		AddCSLuaFile("scripts/sh_convarutil.lua")
		print("[INFO][Role Defibrillator] Using the utility plugin to handle convars instead of the local version")
	else
		AddCSLuaFile("scripts/sh_convarutil_local.lua")
		print("[INFO][Role Defibrillator] Using the local version to handle convars instead of the utility plugin")
	end
end

if file.Exists("scripts/sh_convarutil.lua", "LUA") then
	include("scripts/sh_convarutil.lua")
else
	include("scripts/sh_convarutil_local.lua")
end

-- Must run before hook.Add
local cg = ConvarGroup("RoleDefib", "Role Defibrillator")
Convar(cg, false, "ttt_rdef_healthOnRespawn", 100, {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Amount of health the respawned player has after respawning", "int", 1, 400)
Convar(cg, false, "ttt_rdef_defibTime", 5, {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Amount of time the defibrillation takes", "int", 1, 100)
Convar(cg, true, "ttt_rdef_baseRolesOnly", 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Instead of respawning as a specific subrole respawn as the baserole of that subrole", "bool")
Convar(cg, true, "ttt_rdef_accessShop", 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Grant access to the shop to roles that usually have shop access", "bool")
--
--generateCVTable()
--