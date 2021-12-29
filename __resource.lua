--[[
---------------------------------------------------------------
---------      Gardener Job Script made by --Ax-      ---------
------------        Script made for GitHub         ------------            
-- Feel free to use it on your own server/modify as you wish --
--- For any development partenership contact me on discord  ---
------                 or DM me VIA cfx.re               ------
---------------------------------------------------------------
--]]


fx_version 'adamant'

game 'gta5'

description "vRP gradinar ala AX"

dependencies {
	"vrp",
}

client_scripts{
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	"client.lua"
}

server_scripts{
	"@vrp/lib/utils.lua",
	"server.lua"
}
