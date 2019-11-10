if SERVER then
    shopExcludedPlayers = {}
    util.AddNetworkString("ttt_rdef_nwaccess")
    local TTTCanOrderEquipmentOld = GAMEMODE.TTTCanOrderEquipment
    
    -- Override TTT2/gamemodes/terrortown/gamemode/server/sv_shop.lua to disable shop for some people
    function GAMEMODE:TTTCanOrderEquipment(ply, id)
        local val = ply:SteamID64() or ply:UserID()
        if (shopExcludedPlayers[tostring(val)]) then
            return false
        else
            if !(TTTCanOrderEquipmentOld) then
                print("The function GM:TTTCanOrderEquipment is null. Please tell the addon creator. This won't impact you, but should be fixed.")
                return true
            end
            return TTTCanOrderEquipmentOld(ply, id)
        end
    end

    function ExcludePlayerFromShop(ply)
        if ply == nil or !ply:IsPlayer() then
            --print("Tried to exclude " .. ply:GetName() .. " from the shop that is either nil or not a player!")
            return false
        end

        local val = ply:SteamID64() or ply:UserID()
        if shopExcludedPlayers[tostring(val)] then
            --print(ply:GetName() .. " is already disallowed from buying.")
            return false
        end

        shopExcludedPlayers[tostring(val)] = true
        --print(ply:GetName() .. " is now disallowed from buying.")
        net.Start("ttt_rdef_nwaccess")
        net.WriteBool(true)
        net.Send(ply)
        return true
    end

    hook.Add("TTTPrepareRound", "ttt_rdef_prep", function()
        --print("Reset excluded players!") 
        shopExcludedPlayers = {} 
    end)
end

if CLIENT then
    hook.Add("TTT2PreventAccessShop", "ttt_rdef_access", function(ply)
        if LocalPlayer().preventAccessShop then
            return true
        end
    end)

    net.Receive("ttt_rdef_nwaccess", function() 
        LocalPlayer().preventAccessShop = net.ReadBool()
        --print("Received " .. tostring(LocalPlayer().preventAccessShop))
    end)

    hook.Add("TTTPrepareRound", "ttt_rdef_prep", function() 
        --print("Reset excluded players!") 
        LocalPlayer().preventAccessShop = nil 
    end)
end