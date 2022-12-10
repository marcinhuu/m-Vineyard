fx_version 'cerulean'
author 'marcinhu#0001'
Description 'm-Vineyard'
game 'gta5'

shared_scripts { 
    "config.lua",
}

server_script {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}

client_scripts { 
    'client/*.lua',
    '@PolyZone/client.lua',
    '@PolyZone/PolyZone.lua',
}

escrow_ignore {
    "c_editable.lua",
    "config.lua",
    "README.md",
    "images/**",
}

lua54 'yes'