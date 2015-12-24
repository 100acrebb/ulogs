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





local INDEX = 12
local GM = 2

ULogs.AddLogType( INDEX, GM, "Name", function( Player )
	
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	
	local Informations = {}
	local Base = ULogs.RegisterBase( Player )
	local Data = {}
	Data[ 1 ] = Player:Name()
	Data[ 2 ] = {}
	table.Add( Data[ 2 ], Base )
	table.insert( Informations, Data )
	
	return Informations
	
end)

hook.Add( "onPlayerChangedName", "ULogs_onPlayerChangedName", function( Player, OldName, NewName )
	
	if !SERVER then return end
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !OldName then return end
	if !NewName then return end
	
	ULogs.AddLog( INDEX, ULogs.PlayerInfo( Player ) .. " changed his name from '" .. OldName .. "' to '" .. NewName .. "'",
		ULogs.Register( INDEX, Player ) )
	
end)




