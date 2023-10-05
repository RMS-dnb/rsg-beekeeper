-- FX Information
fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'
author 'RexShack#3041 & RMS_dnb'
description 'rsg-blacksmith'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    '@rsg-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
    'config.lua',
}

client_script {
    'client/client.lua',
    'client/client_shop.lua',
}

server_script {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua',
    'server/server_shop.lua'
}

files {
    'stream/bee_house_gk_ytyp.ytyp'
}

data_file 'DLC_ITYP_REQUEST' 'stream/bee_house_gk_ytyp.ytyp'


dependencies {
    'rsg-core',
    'ox_lib',
}
