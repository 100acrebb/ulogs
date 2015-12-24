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





local INDEX = 6
local GM = 0

ULogs.AddLogType( INDEX, GM, "Team", function( Player )
	
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

hook.Add( "OnPlayerChangedTeam", "ULogs_OnPlayerChangedTeam", function( Player, OldTeam, NewTeam )
	
	if !SERVER then return end
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !OldTeam then return end
	if !NewTeam then return end
	
	ULogs.AddLog( INDEX, ULogs.PlayerInfo( Player ) .. " changed his team from '" .. team.GetName( OldTeam ) .. "' to '" .. team.GetName( NewTeam ) .. "'",
		ULogs.Register( INDEX, Player ) )
	
end)




