local RSGCore = exports['rsg-core']:GetCoreObject()
local options = {}
local jobaccess
local spawned = false
local bees_cloud_group = "core"
local bees_cloud_name = "ent_amb_insect_bee_swarm"
local cooldownSecondsRemaining = 0
local isBusy = false

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

-------------------------------------------------------------------------------------------
-- prompts and blips if needed
-------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    for _, v in pairs(Config.beekeeperCraftingPoint) do
        exports['rsg-core']:createPrompt(v.location, v.coords, RSGCore.Shared.Keybinds[Config.Keybind], Lang:t('lang_0'), {
            type = 'client',
            event = 'rsg-beekeeper:client:mainmenu',
            args = { v.job },
        })
        if v.showblip == true then
            local CraftMenuBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(CraftMenuBlip,  joaat(Config.beekeeperBlip.blipSprite), true)
            SetBlipScale(Config.beekeeperBlip.blipScale, 0.2)
            Citizen.InvokeNative(0x9CB1A1623062F402, CraftMenuBlip, Config.beekeeperBlip.blipName)
        end
    end
end)

------------------------------------------------------------------------------------------------------
-- beekeeper main menu
------------------------------------------------------------------------------------------------------

RegisterNetEvent('rsg-beekeeper:client:mainmenu', function(job)
    local PlayerData = RSGCore.Functions.GetPlayerData()
    local playerjob = PlayerData.job.name
    jobaccess = job
    if playerjob == jobaccess then
        lib.registerContext({
            id = 'beekeeper_mainmenu',
            title = Lang:t('lang_1'),
            options = {
                {
                    title = Lang:t('lang_13'),
                    description = Lang:t('lang_14'),
                    icon = 'fa-solid fa-screwdriver-wrench',
                    event = 'rsg-beekeeper:client:checkhive',
                    arrow = true
                },
                {
                    title = Lang:t('lang_2'),
                    description = Lang:t('lang_3'),
                    icon = 'fa-solid fa-screwdriver-wrench',
                    event = 'rsg-beekeeper:client:craftingmenu',
                    arrow = true
                },
                {
                    title = Lang:t('lang_4'),
                    description = Lang:t('lang_5'),
                    icon = 'fas fa-box',
                    event = 'rsg-beekeeper:client:storage',
                    arrow = true
                },
                {
                    title = Lang:t('lang_6'),
                    description = Lang:t('lang_7'),
                    icon = 'fa-solid fa-user-tie',
                    event = 'rsg-bossmenu:client:mainmenu',
                    arrow = true
                },
            }
        })
        lib.showContext("beekeeper_mainmenu")
    else
        RSGCore.Functions.Notify(Lang:t('lang_8'), 'error')
    end
end)

------------------------------------------------------------------------------------------------------
-- crafting menu
------------------------------------------------------------------------------------------------------

-- create a table to store menu options by category
local CategoryMenus = {}

-- iterate through recipes and organize them by category
for _, v in ipairs(Config.beekeeperCrafting) do
    local IngredientsMetadata = {}

    for i, ingredient in ipairs(v.ingredients) do
        table.insert(IngredientsMetadata, { label = RSGCore.Shared.Items[ingredient.item].label, value = ingredient.amount })
    end
    local option = {
        title = v.title,
        icon = v.icon,
        event = 'rsg-beekeeper:client:checkingredients',
        metadata = IngredientsMetadata,
        args = {
            title = v.title,
            category = v.category,
            ingredients = v.ingredients,
            crafttime = v.crafttime,
            receive = v.receive,
            giveamount = v.giveamount
        }
    }

    -- check if a menu already exists for this category
    if not CategoryMenus[v.category] then
        CategoryMenus[v.category] = {
            id = 'crafting_menu_' .. v.category,
            title = v.category,
            menu = 'beekeeper_mainmenu',
            onBack = function() end,
            options = { option }
        }
    else
        table.insert(CategoryMenus[v.category].options, option)
    end
end

-- log menu events by category
for category, MenuData in pairs(CategoryMenus) do
    RegisterNetEvent('rsg-beekeeper:client:' .. category)
    AddEventHandler('rsg-beekeeper:client:' .. category, function()
        lib.registerContext(MenuData)
        lib.showContext(MenuData.id)
    end)
end

-- main event to open main menu
RegisterNetEvent('rsg-beekeeper:client:craftingmenu')
AddEventHandler('rsg-beekeeper:client:craftingmenu', function()
    -- show main menu with categories
    local Menu = {
        id = 'crafting_menu',
        title = Lang:t('lang_9'),
        menu = 'beekeeper_mainmenu',
        onBack = function() end,
        options = {}
    }

    for category, MenuData in pairs(CategoryMenus) do
        table.insert(Menu.options, {
            title = category,
            description = Lang:t('lang_10') .. category,
            icon = 'fa-solid fa-pen-ruler',
            event = 'rsg-beekeeper:client:' .. category,
            arrow = true
        })
    end

    lib.registerContext(Menu)
    lib.showContext(Menu.id)
end)

------------------------------------------------------------------------------------------------------
-- do crafting stuff
------------------------------------------------------------------------------------------------------

-- check player has the ingredients to craft
RegisterNetEvent('rsg-beekeeper:client:checkingredients', function(data)
    RSGCore.Functions.TriggerCallback('rsg-beekeeper:server:checkingredients', function(hasRequired)
    if (hasRequired) then
        if Config.Debug == true then
            print("passed")
        end
        TriggerEvent('rsg-beekeeper:client:craftitem', data.title, data.category, data.ingredients, tonumber(data.crafttime), data.receive, data.giveamount)
    else
        if Config.Debug == true then
            print("failed")
        end
        return
    end
    end, data.ingredients)
end)
--do crafting
RegisterNetEvent('rsg-beekeeper:client:craftitem', function(title, category, ingredients, crafttime, receive, giveamount)
    if isBusy == false then
        isBusy = true
        local ped = PlayerPedId(-1)

        -- Request the animation dictionary
        RSGCore.Functions.RequestAnimDict('script_common@shared_scenarios@kneel@mourn@female@a@base')
        LocalPlayer.state:set("inv_busy", true, true)

        -- Start the animation
        TaskPlayAnim(ped, "script_common@shared_scenarios@kneel@mourn@female@a@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)

        -- Show the OxLib progress circle while crafting
        if lib.progressCircle({
            duration = crafttime, -- Adjust the duration as needed
            position = 'bottom',
            label = 'Crafting ' .. title, -- Change the label if desired
            useWhileDead = false,
            canCancel = false,
            anim = {
                dict = 'script_common@shared_scenarios@kneel@mourn@female@a@base',
                clip = 'empathise_headshake_f_001',
                flag = 15,
            },
            disableControl = true,
            text = 'Crafting ' .. title .. '...'
            }) then
            -- Clear the animation immediately
            ClearPedTasksImmediately(ped)

            -- Trigger your server event or other logic here
            TriggerServerEvent('rsg-beekeeper:server:finishcrafting', ingredients, receive, giveamount, jobaccess)

            -- Notify the player that their item is now available
            RSGCore.Functions.Notify(title .. ' ' .. ' is now available to fill up in the shop.', 'success')
            LocalPlayer.state:set("inv_busy", false, true)

            PlaySoundFrontend("SELECT", "RDRO_Character_Creator_Sounds", true, 0)

            -- Cooldown logic here
            cooldownTimer()
            isBusy = false
        else
            -- Handle cancellation or failure
            RSGCore.Functions.Notify("Crafting " .. title .. " " .. category .. " canceled or failed.", 'error')
        end
    else
        RSGCore.Functions.Notify('You are already busy with another task!', 'primary')
    end
end)


------------------------------------------------------------------------------------------------------
-- beekeeper storage
------------------------------------------------------------------------------------------------------

RegisterNetEvent('rsg-beekeeper:client:storage', function()
    local PlayerData = RSGCore.Functions.GetPlayerData()
    local playerjob = PlayerData.job.name
    if playerjob == jobaccess then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", jobaccess, {
            maxweight = Config.StorageMaxWeight,
            slots = Config.StorageMaxSlots,
        })
        TriggerEvent("inventory:client:SetCurrentStash", jobaccess)
    end
end)

--- bee-sting effect
Citizen.CreateThread(function()
    while true do
        Wait(5000)
        for k,v in pairs(Config.BeeHives) do
            if IsEntityAtCoord(PlayerPedId(), v.coords, 3.0, 3.0, 3.0, 0, 1, 0) then
                local ped = PlayerPedId()
                local health = GetEntityHealth(ped)
                if health > 0 then 
                    SetEntityHealth(ped, health - Config.BeeSting)
                    PlayPain(ped, 9, 1, true, true)
                end
            end
        end
    end
end)

---------------------------------------------------------------------------------

-- cooldown timer
function cooldownTimer()
    cooldownSecondsRemaining = Config.Cooldown
    Citizen.CreateThread(function()
        while cooldownSecondsRemaining > 0 do
            Wait(1000)
            cooldownSecondsRemaining = cooldownSecondsRemaining - 1
            --print(cooldownSecondsRemaining)
        end
    end)
end

RegisterNetEvent('rsg-beekeeper:client:checkhive')
AddEventHandler('rsg-beekeeper:client:checkhive', function()
    if isBusy == false and cooldownSecondsRemaining == 0 then
        local hasItems = HasRequirements({'honeyframe'})
        if hasItems then
            isBusy = true
            local ped = PlayerPedId(-1)

            -- Request the animation dictionary
            RSGCore.Functions.RequestAnimDict('script_common@shared_scenarios@kneel@mourn@female@a@base')
            LocalPlayer.state:set("inv_busy", true, true)

            -- Start the animation
            TaskPlayAnim(ped, "script_common@shared_scenarios@kneel@mourn@female@a@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)

            -- Show the OxLib progress circle while collecting honey
            if lib.progressCircle({
                duration = 27000, -- Adjust the duration as needed
                position = 'bottom',
                label = 'Collecting Honey', -- Change the label if desired
                useWhileDead = false,
                canCancel = false,
                anim = {
                    dict = 'script_common@shared_scenarios@kneel@mourn@female@a@base',
                    clip = 'empathise_headshake_f_001',
                    flag = 15,
                },
                disableControl = true,
                text = 'Collecting honey...',
            }) then
                -- Clear the animation immediately
                ClearPedTasksImmediately(ped)

                -- Increase player's health
                local maxHealth = GetEntityMaxHealth(ped)
                local health = GetEntityHealth(ped)
                local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 60))
                SetEntityHealth(ped, newHealth)

                -- Trigger your server event or other logic here
                TriggerServerEvent('rsg-beekeeper::server:givehoney')
                LocalPlayer.state:set("inv_busy", false, true)
                PlaySoundFrontend("SELECT", "RDRO_Character_Creator_Sounds", true, 0)

                -- Cooldown logic here
                cooldownTimer()
                isBusy = false
            else
                -- Handle cancelation or failure
                RSGCore.Functions.Notify("Collecting honey canceled or failed.", 'error')
            end
        end
    else
        RSGCore.Functions.Notify('Bees still busy making more honey!', 'primary')
    end
end)


function HasRequirements(requirements)
    local found_requirements = {}
    local count = 0
    local missing = {}
    for i, require in ipairs(requirements) do
        if RSGCore.Functions.HasItem(require) then
            found_requirements[#found_requirements + 1] = require
            count = count + 1
        else
            missing[#missing + 1] = require
        end
    end

    if count == #requirements then
        return true
    elseif count == 0 then
        RSGCore.Functions.Notify("You are missing all of the requirements: " .. table.concat(missing, ", "), 'error')
        return false
    else
        RSGCore.Functions.Notify("You are missing the following requirements: " .. table.concat(missing, ", "), 'error')
        return false
    end
end