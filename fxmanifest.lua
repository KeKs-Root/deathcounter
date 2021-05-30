
-- Resource Metadata
fx_version 'cerulean'
games { 'gta5' }

author 'Iso & Marco'
description 'Simple resource to count player deaths and kick if exceeded.'
version '1.0.0'

server_scripts { 
    '@mysql-async/lib/MySQL.lua',
    'main.lua',
    'config.lua'
}

dependencies {
	'es_extended'
}
