fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

author 'RexShack#3041'
description 'rsg-beekeeper'

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}

shared_scripts {
    'config.lua'
}

dependency 'rsg-core'

files {
    'stream/bee_house_gk_ytyp.ytyp'
}

data_file 'DLC_ITYP_REQUEST' 'stream/bee_house_gk_ytyp.ytyp'

escrow_ignore {
    'stream/*/*.ydr'
}

lua54 'yes'
