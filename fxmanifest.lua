fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Kakarot'
description 'Allows players to work at the vineyard for items to sell'
version '1.5.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
    'config.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    'client.lua'
}

server_script 'server.lua'
