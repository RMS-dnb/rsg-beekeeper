local RSGCore = exports['rsg-core']:GetCoreObject()

-----------------------------------------------------------------------
-- version checker
-----------------------------------------------------------------------
local function versionCheckPrint(_type, log)
    local color = _type == 'success' and '^2' or '^1'

    print(('^5['..GetCurrentResourceName()..']%s %s^7'):format(color, log))
end

local function CheckVersion()
    PerformHttpRequest('https://raw.githubusercontent.com/Rexshack-RedM/rsg-beekeeper/main/version.txt', function(err, text, headers)
        local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')

        if not text then 
            versionCheckPrint('error', 'Currently unable to run a version check.')
            return 
        end

        --versionCheckPrint('success', ('Current Version: %s'):format(currentVersion))
        --versionCheckPrint('success', ('Latest Version: %s'):format(text))
        
        if text == currentVersion then
            versionCheckPrint('success', 'You are running the latest version.')
        else
            versionCheckPrint('error', ('You are currently running an outdated version, please update to version %s'):format(text))
        end
    end)
end

-----------------------------------------------------------------------

-- check player has the ingredients
RSGCore.Functions.CreateCallback('rsg-beekeeper:server:checkingredients', function(source, cb, ingredients)
    local src = source
    local hasItems = false
    local icheck = 0
    local Player = RSGCore.Functions.GetPlayer(src)
    for k, v in pairs(ingredients) do
        if Player.Functions.GetItemByName(v.item) and Player.Functions.GetItemByName(v.item).amount >= v.amount then
            icheck = icheck + 1
            if icheck == #ingredients then
                cb(true)
            end
        else
            TriggerClientEvent('RSGCore:Notify', src, Lang:t('lang_12'), 'error')
            cb(false)
            return
        end
    end
end)

-- finish crafting
RegisterServerEvent('rsg-beekeeper:server:finishcrafting')
AddEventHandler('rsg-beekeeper:server:finishcrafting', function(ingredients, receive, giveamount, job)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    -- remove ingredients
    for k, v in pairs(ingredients) do
        if Config.Debug == true then
            print(v.item)
            print(v.amount)
        end
        Player.Functions.RemoveItem(v.item, v.amount)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[v.item], "remove")
    end
    -- add stock to weaponsmith
    MySQL.query('SELECT * FROM beekeeper_stock WHERE beekeeper = ? AND item = ?',{job, receive} , function(result)
        if result[1] ~= nil then
            local stockadd = result[1].stock + giveamount
            MySQL.update('UPDATE beekeeper_stock SET stock = ? WHERE beekeeper = ? AND item = ?',{stockadd, job, receive})
        else
            MySQL.insert('INSERT INTO beekeeper_stock (`beekeeper`, `item`, `stock`) VALUES (?, ?, ?);', {job, receive, giveamount})
        end
    end)
end)



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


--------------------------------------------------------------------------------------------------
-- start version check
--------------------------------------------------------------------------------------------------
CheckVersion()
