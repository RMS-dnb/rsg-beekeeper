Config = {}
-- settings
Config.Cooldown = 120 -- 3600 -- amount in seconds (3600 = 1hr)
Config.CheckTime = 30000 -- check hive (in milliseconds / 30000 = 30 sec)
Config.BeeSting = 10 -- amount of health to take off each sting (currently every 5 seconds)

-- beehive props
Config.BeeHiveProps = {
    `bee_house_gk_1`,
    `bee_house_gk_2`,
    `bee_house_gk_3`,
    `bee_house_gk_4`,
    `bee_house_gk_5`,
    `bee_house_gk_6`,
}

-- setup beehives
Config.BeeHives = {
    { lable = 'BeeHive', name = 'beehive1', coords = vector3(-471.5865, 860.32104, 126.72114), heading = 82.184577,  model = 'bee_house_gk_1' }, -- near valentine
    { lable = 'BeeHive', name = 'beehive2', coords = vector3(-1642.77, -335.851, 172.22273),   heading = 303.69674,  model = 'bee_house_gk_2' }, -- near strawberry
    { lable = 'BeeHive', name = 'beehive3', coords = vector3(-871.2145, -1083.776, 58.306953), heading = 311.90679,  model = 'bee_house_gk_3' }, -- near blackwater
    { lable = 'BeeHive', name = 'beehive4', coords = vector3(-2300.35, -2385.453, 63.183452),  heading = 248.46266,  model = 'bee_house_gk_4' }, -- near macfarlane's ranch
    { lable = 'BeeHive', name = 'beehive5', coords = vector3(1397.8061, -1117.391, 75.270698), heading = 250.43539,  model = 'bee_house_gk_5' }, -- near rhodes
    { lable = 'BeeHive', name = 'beehive6', coords = vector3(857.7091, -1889.626, 44.464122),  heading = 52.075176,  model = 'bee_house_gk_6' }, -- near braithwaite manor
}

-- beekeeper blip settings
Config.beekeeperBlip = {
    blipName = 'beekeeper Crafting', -- Config.Blip.blipName
    blipSprite = 'blip_shop_beekeeper', -- Config.Blip.blipSprite
    blipScale = 0.2 -- Config.Blip.blipScale
}

-- beekeeper shop blip settings
Config.ShopBlip = {
    blipName = 'beekeeper Shop', -- Config.Blip.blipName
    blipSprite = 'blip_shop_store', -- Config.Blip.blipSprite
    blipScale = 0.2 -- Config.Blip.blipScale
}

-- settings
Config.StorageMaxWeight = 4000000
Config.StorageMaxSlots = 48
Config.Debug = false
Config.Keybind = 'J'

-- beekeeper crafting locations
Config.beekeeperCraftingPoint = {

    {   -- valentine
        name = 'Beekeeper Crafting',
        location = 'valbeekeeper',
        coords = vector3(-471.5865, 860.32104, 126.72114),
        job = 'valbeekeeper',
        showblip = true
    },
    {   -- strawberry
        name = 'Beekeeper Crafting',
        location = 'strawbeekeeper',
        coords = vector3(-1642.77, -335.851, 172.22273),
        job = 'strawbeekeeper',
        showblip = true
    },
    {   -- blackwater
        name = 'Beekeeper Crafting',
        location = 'blackbeekeeper',
        coords = vector3(-871.2145, -1083.776, 58.306953),
        job = 'blackbeekeeper',
        showblip = true
    },
    {   -- mcfarlanes ranch
        name = 'Beekeeper Crafting',
        location = 'mcfarbeekeeper',
        coords = vector3(-2300.35, -2385.453, 63.183452),
        job = 'mcfarbeekeeper',
        showblip = true
    },
    {   -- rhodes
        name = 'Beekeeper Crafting',
        location = 'rhodesbeekeeper',
        coords = vector3(1397.8061, -1117.391, 75.270698),
        job = 'rhodesbeekeeper',
        showblip = true
    },
    {   -- braitewaithe
        name = 'Beekeeper Crafting',
        location = 'braithbeekeeper',
        coords = vector3(857.7091, -1889.626, 44.464122),
        job = 'braithbeekeeper',
        showblip = true
    },

}

-- beekeeper shops
Config.beekeeperShops = {

    {
        shopid = 'valbeekeepershop',
        shopname = 'Valentine Beekeeper Shop',
        coords = vector3(-468.9227, 863.61608, 126.86179),
        jobaccess = 'valbeekeeper',
        showblip = true
    },
    {
        shopid = 'strawbeekeepershop',
        shopname = 'Strawberry Beekeeper Shop',
        coords = vector3(-1642.487, -339.7031, 172.73971),
        jobaccess = 'strawbeekeeper',
        showblip = true
    },
    {
        shopid = 'blackbeekeepershop',
        shopname = 'Blackwater Beekeeper Shop',
        coords = vector3(-877.1653, -1087.674, 58.898277),
        jobaccess = 'blackbeekeeper',
        showblip = true
    },
    {
        shopid = 'mcfarbeekeepershop',
        shopname = 'Mcfarlanes Beekeeper Shop',
        coords = vector3(-2301.846, -2382.233, 63.185764),
        jobaccess = 'mcfarbeekeeper',
        showblip = true
    },
    {
        shopid = 'rhodesbeekeepershop',
        shopname = 'Rhodes Beekeeper Shop',
        coords = vector3(1395.9558, -1115.676, 75.237609),
        jobaccess = 'rhodesbeekeeper',
        showblip = true
    },
    {
        shopid = 'braithbeekeepershop',
        shopname = 'Braithwaite Beekeeper Shop',
        coords = vector3(855.95263, -1893.109, 44.428947),
        jobaccess = 'braithbeekeeper',
        showblip = true
    },
    
}

-- beekeeper crafting
Config.beekeeperCrafting = {

    -- honey
    {
        title =  'Honey',
        category = 'Honey',
        crafttime = 30000,
        icon = 'fa-solid fa-screwdriver-wrench',
        ingredients = { 
            [1] = { item = "honeycomb", amount = 1 },
            [2] = { item = "honeypot",  amount = 1 },
        },
        receive = "honey",
        giveamount = 5
    },

}
