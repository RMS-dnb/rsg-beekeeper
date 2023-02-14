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
