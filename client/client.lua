local RSGCore = exports['rsg-core']:GetCoreObject()
local spawned = false
local bees_cloud_group = "core"
local bees_cloud_name = "ent_amb_insect_bee_swarm"

---------------------------------------------------------------------------------

-- spawn beehives / bees
Citizen.CreateThread(function()
    while true do
    Wait(0)
        if spawned == false then
            for k,v in pairs(Config.BeeHives) do
                local hash = GetHashKey(v.model)
                while not HasModelLoaded(hash) do
                    Wait(10)
                    RequestModel(hash)
                end
                RequestModel(hash)
                beehive = CreateObject(hash, v.coords -1, true, false, false)
                SetEntityHeading(beehive, v.heading)
                SetEntityAsMissionEntity(beehive, true)
                PlaceObjectOnGroundProperly(beehive, true)
                FreezeEntityPosition(beehive, true)
                Citizen.InvokeNative(0xA10DB07FC234DD12, bees_cloud_group)
                bees = Citizen.InvokeNative(0xBA32867E86125D3A , bees_cloud_name, v.coords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
                spawned = true
            end
        end
    end
end)
