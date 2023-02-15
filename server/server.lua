local RSGCore = exports['rsg-core']:GetCoreObject()

RegisterNetEvent('rsg-beekeeper::server:givehoney', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local firstname = Player.PlayerData.charinfo.firstname
    local lastname = Player.PlayerData.charinfo.lastname
    local chance = math.random(1,100)
    -- reward (95% chance)
    if chance <= 95 then -- reward : 1 x honeycomb 1 x beeswax
        -- add item honeycomb
        Player.Functions.AddItem('honeycomb', 1)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['honeycomb'], "add")
        Player.Functions.AddItem('beeswax', 1)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['beeswax'], "add")
        -- remove item 
        Player.Functions.RemoveItem('honeyframe', 1)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['honeyframe'], "remove")
        -- webhook
        TriggerEvent('rsg-log:server:CreateLog', 'beekeeper', 'Honey Collected', 'yellow', firstname..' '..lastname..' collected 1 honeycomb')
    end
    -- reward (5% chance)
    if chance > 95 then -- reward : 2 x honeycomb and 2 x beeswax
        -- add item honeycomb
        Player.Functions.AddItem('honeycomb', 2)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['honeycomb'], "add")
        Player.Functions.AddItem('beeswax', 2)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['beeswax'], "add")
        -- remove item 
        Player.Functions.RemoveItem('honeyframe', 1)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['honeyframe'], "remove")
        -- webhook
        TriggerEvent('rsg-log:server:CreateLog', 'beekeeper', 'Honey Collected', 'yellow', firstname..' '..lastname..' collected 2 honeycomb')
    end
end)
