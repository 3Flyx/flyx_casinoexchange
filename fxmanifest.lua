fx_version 'cerulean'
game 'gta5'
lua54 'yes'

title 'Simple casino Exchange script made with ox_lib and ox_inv'
author 'Flyx'
version '1.0'

dependencies {
    'ox_lib',
    'ox_inventory'
}

client_scripts{  
    'client/**.lua',
    'bridge/client/**.lua'
}

shared_scripts{
    '@ox_lib/init.lua',
    'config.lua'
} 

server_scripts{
    'server/**.lua',
    'bridge/server/**.lua'
}

files {
    'locales/*.json'
}