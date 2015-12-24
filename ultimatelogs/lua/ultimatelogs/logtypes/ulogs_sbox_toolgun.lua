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





local INDEX = 8
local GM = 1

ULogs.AddLogType( INDEX, GM, "Toolgun", function( Tool, Player )
	
	if !Tool then return end
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	
	local Informations = {}
	local Base = ULogs.RegisterBase( Player )
	table.insert( Informations, { "Copy tool", Tool } )
	local Data = {}
	Data[ 1 ] = Player:Name()
	Data[ 2 ] = {}
	table.Add( Data[ 2 ], Base )
	table.insert( Informations, Data )
	
	return Informations
	
end)

hook.Add( "CanTool", "ULogs_CanTool", function( Player, _, Tool )
	
	if !SERVER then return end
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !Tool then return end
	
	ULogs.AddLog( INDEX, ULogs.PlayerInfo( Player ) .. " used '" .. Tool .. "'",
		ULogs.Register( INDEX, Tool, Player ) )
	
end)




