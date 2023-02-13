local RSGCore = exports['rsg-core']:GetCoreObject()
local spawned = false

---------------------------------------------------------------------------------

-- spawn beehives
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
                spawned = true
            end
        end
    end
end)

local bees_cloud_group = "core"
local bees_cloud_name = "ent_amb_insect_bee_swarm"
local beesactive = false
local bees = {}

CreateThread(function()
    while true do
        local sleep = 5000
        for beehive, v in pairs(Config.BeeHives) do
            local ped = GetEntityCoords(PlayerPedId())
            local beehive = GetClosestObjectOfType(ped, 2.0, GetHashKey(v.model), false)
            local beehivecoords = GetEntityCoords(beehive)
            local distance = GetDistanceBetweenCoords(ped, beehivecoords)
            if distance < 2.0 and beesactive == false then
                print('trigger bees')
                triggerbees()
            else
                print('no bees')
                nobees()
            end
        end
        Wait(sleep)
    end
end)

function triggerbees()
    for beehive, v in pairs(Config.BeeHives) do
        if not Citizen.InvokeNative(0x65BB72F29138F5D6, GetHashKey(bees_cloud_group)) then -- HasNamedPtfxAssetLoaded
            Citizen.InvokeNative(0xF2B2353BBC0D4E8F, GetHashKey(bees_cloud_group))  -- RequestNamedPtfxAsset
            local counter = 0
            while not Citizen.InvokeNative(0x65BB72F29138F5D6, GetHashKey(bees_cloud_group)) and counter <= 300 do  -- while not HasNamedPtfxAssetLoaded
                Citizen.Wait(0)
            end
        end
        if Citizen.InvokeNative(0x65BB72F29138F5D6, GetHashKey(bees_cloud_group)) then  -- HasNamedPtfxAssetLoaded
            Citizen.InvokeNative(0xA10DB07FC234DD12, bees_cloud_group) -- UseParticleFxAsset
            bees = Citizen.InvokeNative(0xBA32867E86125D3A , bees_cloud_name, v.coords, 0.0, 0.0, 0.0, 1.0, false, false, false, false) -- StartParticleFxLoopedAtCoord
            beesactive = true
        else
            print("can't load ptfx dictionary!")
        end
    end
end

function nobees()
    if bees then
        if Citizen.InvokeNative(0x9DD5AFF561E88F2A, bees) then   -- DoesParticleFxLoopedExist
            Citizen.InvokeNative(0x459598F579C98929, bees, false)   -- RemoveParticleFx
        end
    end
    beesactive = false
end

