--[[
    
     _   _  _  _    _                    _           _                        
    | | | || || |  (_)                  | |         | |                       
    | | | || || |_  _  _ __ ___    __ _ | |_   ___  | |      ___    __ _  ___ 
    | | | || || __|| || '_ ` _ \  / _` || __| / _ \ | |     / _ \  / _` |/ __|
    | |_| || || |_ | || | | | | || (_| || |_ |  __/ | |____| (_) || (_| |\__ \
     \___/ |_| \__||_||_| |_| |_| \__,_| \__| \___| \_____/ \___/  \__, ||___/
                                                                    __/ |     
                                                                   |___/      
    
    
]]--





include( "ultimatelogs/configuration.lua" )





if SERVER then
	
	
	AddCSLuaFile( "ultimatelogs/configuration.lua" )
	
	include( "ultimatelogs/configurationMySQL.lua" )
	include( "ultimatelogs/server/mysqlite.lua" )
	include( "ultimatelogs/server/sv_ultimatelogs.lua" )
	
	for k, v in pairs( file.Find( "ultimatelogs/client/*.lua", "LUA" ) ) do
		
		AddCSLuaFile( "ultimatelogs/client/" .. v )
		
	end
	
	
else
	
	
	for k, v in pairs( file.Find( "ultimatelogs/client/*.lua", "LUA" ) ) do
		
		include( "ultimatelogs/client/" .. v )
		
	end
	
	
end





for k, v in pairs( file.Find( "ultimatelogs/shared/*.lua", "LUA" ) ) do
	
	if SERVER then
		AddCSLuaFile( "ultimatelogs/shared/" .. v )
	end
	include( "ultimatelogs/shared/" .. v )
	
end
for k, v in pairs( file.Find( "ultimatelogs/logtypes/*.lua", "LUA" ) ) do
	
	if SERVER then
		AddCSLuaFile( "ultimatelogs/logtypes/" .. v )
	end
	include( "ultimatelogs/logtypes/" .. v )
	
end




