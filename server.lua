--[[
---------------------------------------------------------------
---------      Gardener Job Script made by --Ax-      ---------
------------        Script made for GitHub         ------------            
-- Feel free to use it on your own server/modify as you wish --
--- For any development partenership contact me on discord  ---
------                 Discord : --Ax-#0018              ------
---------------------------------------------------------------
--]]


local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","Ax_gradinar")

Axc = Tunnel.getInterface("Ax_gradinar","Ax_gradinar")

Axs = {}
Tunnel.bindInterface("Ax_gradinar",Axs)
Proxy.addInterface("Ax_gradinar",Axs)

RegisterServerEvent("ax_gradinar")
AddEventHandler("ax_gradinar",function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if user_id ~= nil and player then
        vRP.giveMoney({user_id,25000}) -- edit the payment
        vRPclient.notify(player,{"You received ~g~$25.000 ~w~Salary ~o~[Gardener]"})
    end
end)