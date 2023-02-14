Config = {}

-- settings
Config.Cooldown = 120 -- 3600 -- amount in seconds (3600 = 1hr)
Config.CheckTime = 30000 -- check hive (in milliseconds / 30000 = 30 sec)

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
    { lable = 'BeeHive', name = 'beehive1', coords = vector3(-467.33, 862.36, 126.91), heading = 268.1,  model = 'bee_house_gk_2' },
    { lable = 'BeeHive', name = 'beehive2', coords = vector3(-468.93, 859.02, 126.77), heading = 246.86, model = 'bee_house_gk_3' },
}
