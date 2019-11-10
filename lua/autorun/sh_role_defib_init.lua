if SERVER then
    AddCSLuaFile("gamemodes/terrortown/gamemode/sh_init.lua")
    hook.Add("TTT2FinishedLoading", "ttt_rdef_sh_init", function() include("gamemodes/terrortown/gamemode/sh_init.lua") end)
else
    include("gamemodes/terrortown/gamemode/sh_init.lua")
end