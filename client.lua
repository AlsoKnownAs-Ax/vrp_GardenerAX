--[[
---------------------------------------------------------------
---------      Gardener Job Script made by --Ax-      ---------
------------        Script made for GitHub         ------------            
-- Feel free to use it on your own server/modify as you wish --
--- For any development partenership contact me on discord  ---
------                 Discord : --Ax-#0018              ------
---------------------------------------------------------------
--]]

--[[ 
    I have tried to comment it as best as i could, i hope i`ve done a good enough job.
    This is not a hard script so a lot of people could do this
    I don`t know if another variant of this job is posted on the internet but i have done it in my way
    Enjoy it !
]]

Tunnel.bindInterface("Ax_gradinar",Axc)
Proxy.addInterface("Ax_gradinar",Axc)
Axs = Tunnel.getInterface("Ax_gradinar","Ax_gradinar")
vRP = Proxy.getInterface("vRP")
cAx = Tunnel.getInterface("vRP","Ax_gradinar")

local spatula = nil
local spotstodo = 5
local spots = 0
local started = false
local job = false
local ready = false
local jobMadeBy_Ax = true


Citizen.CreateThread(function() -- Here you can edit the blip
    local blip = AddBlipForCoord(850.63983154297,-588.68255615234,58.151695251465)
    SetBlipSprite(blip, 351) -- You can edit the blip here  ( https://docs.fivem.net/docs/game-references/blips/ )
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.9)
    SetBlipColour(blip, 25)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Job [Gardener]") -- Blip`s text
    EndTextCommandSetBlipName(blip)
end)

function DrawText3D(x,y,z, text, scl) -- Here i`ve made the display for the 3D text because there is no native that does that

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then -- You can edit here and make it as you wish
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

locations = {
    -- Insert more location here if you want / Change them
    -- if you insert more location, make sure to raise the spots as well
    {846.06268310547,-592.23034667969,58.150760650635},
    {852.16009521484,-596.18328857422,58.082748413086},
    {857.28491210938,-606.15148925781,58.03689956665},
    {854.03509521484,-603.64196777344,58.14673614502}, 
    {847.52850341797,-598.40765380859,58.039428710938}, 
}


Citizen.CreateThread(function()
while true do
    Citizen.Wait(0) -- prevent crashing
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local dist = math.floor(GetDistanceBetweenCoords(850.63983154297,-588.68255615234,58.151695251465, GetEntityCoords(GetPlayerPed(-1))))
    if dist < 20 then
        DrawMarker(20, 850.63983154297,-588.68255615234,58.151695251465, 0, 0, 0, 0, 0, 0, 0.6001,0.6001,0.6001, 255, 152, 80, 100, 0, 0, 0, 1, 0, 0, 0)
        DrawText3D(850.63983154297,-588.68255615234,58.151695251465+1, "JOB: Gardener", 1) -- Job text where you start the job
    end
    if job == true then
        for i,v in pairs(locations) do
            local meters = math.floor(GetDistanceBetweenCoords(v[1],v[2],v[3], GetEntityCoords(GetPlayerPed(-1))))
            if spots == 1 or spots == 2 or spots == 3 or spots == 4 then
                DrawText3D(pos.x,pos.y,pos.z, "Tasks: "..spots.."/5", 1)
            end
            if locations[i] ~= nil then
                if meters <= 5 then
                    DrawMarker(20, v[1],v[2],v[3], 0, 0, 0, 0, 0, 0, 0.6001,0.6001,0.6001, 57, 120, 255, 100, 0, 0, 0, 1, 0, 0, 0) -- We mark the spots where you can work
                    DrawText3D(v[1],v[2],v[3]+0.7, "Work Here", 1) -- Text display
                end
            end
            if locations[i] ~= nil then
                if meters <= 0.5 then
                    table.remove(locations,i)
                    if spots <= 2 then -- i used this in order to play different animations
                        vRP.playAnim({false, {task="WORLD_HUMAN_GARDENER_PLANT"}, false})
                        vRP.notify({"~g~You started working"})
                    else
                        vRP.playAnim({false, {task="WORLD_HUMAN_GARDENER_LEAF_BLOWER"}, false})
                        vRP.notify({"~g~You started working"})
                    end
                    SetTimeout(10000, function()
                    vRP.stopAnim({false})
                    spots = spots + 1
                        if spots == 5 then
                            vRP.notify({"~g~Go and get your reward"})
                            ready = true
                        end
                    end)
                end
            end
        end
    end
    if dist <= 1 then
        DrawText3D(850.63983154297,-588.68255615234,58.151695251465+0.6, "Press [E] to start the job\n Press [Z] to receive the reward",1.2)
        if IsControlJustPressed(1,51) then
            if job == false then
                vRP.notify({"~o~Work at the 5 locations"})
                job = true
            elseif job == true then
                vRP.notify({"~o~Work at the 5 locations"})
            end
        elseif IsControlJustPressed(1,20) then
            if ready == true then
                if spots == 5 then
                    TriggerServerEvent("ax_gradinar") -- we give the reward
                    spots = 0
                    job = false
                    ready = false
                    table.insert(locations,{846.06268310547,-592.23034667969,58.150760650635})
                    table.insert(locations,{852.16009521484,-596.18328857422,58.082748413086})
                    table.insert(locations,{857.28491210938,-606.15148925781,58.03689956665})
                    table.insert(locations,{854.03509521484,-603.64196777344,58.14673614502})
                    table.insert(locations,{847.52850341797,-598.40765380859,58.039428710938})
                end
            else
                vRP.notify({"~r~You haven't finished the tour"}) -- In case he haven`t finished yet
            end
        end
    end
end
end)







----------------- Below is just another try of starting the job, i will leave this here in case it gives you any idea -------------


--[[function start(task)
    vRP.playAnim({false, {task = task.anim}, false})
    SetTimeout(12000, function()
        vRP.stopAnim({false})
        task.active = true
        spotstodo = spotstodo - 1
        SetTimeout(1000 * 10, function()task.active = false; end) 
    end)
end]]

--[[function Axc.startGardener()
    Citizen.CreateThread(function()
        Citizen.Wait(1)
            while (spots < spotstodo) do
                Wait(0)
                local playerPos = GetEntityCoords(PlayerPedId(), true)
                local px, py, pz = playerPos.x, playerPos.y, playerPos.z
                for k, v in pairs(quests) do
                    local once = false;
                    while not v.active and spots < spotstodo do
                        Wait(1)
                        local playerPos = GetEntityCoords(PlayerPedId(), true)
                        DrawMarker(20, v.pos, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 255, 165, 0, 500, 1, 0, 0, 1)
                        if #(playerPos - v.pos) <= 1.0 and not once  then 
                            once = true
                            spots = spots + 1
                            start(v)
                        end
                    end
                end
            end
    end)
end]]

