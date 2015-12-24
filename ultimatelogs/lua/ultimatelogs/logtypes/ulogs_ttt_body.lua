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





local INDEX = 16
local GM = 3

ULogs.AddLogType( INDEX, GM, "Body", function( Player, Target )
	
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !Target or !Target:IsValid() or !Target:IsPlayer() then return end
	
	local Informations = {}
	local Base = ULogs.RegisterBase( Player )
	local Data = {}
	Data[ 1 ] = Player:Name()
	Data[ 2 ] = {}
	table.Add( Data[ 2 ], Base )
	table.insert( Informations, Data )
	
	local Base = ULogs.RegisterBase( Target )
	local Data = {}
	Data[ 1 ] = Target:Name()
	Data[ 2 ] = {}
	table.Add( Data[ 2 ], Base )
	table.insert( Informations, Data )
	
	return Informations
	
end)

hook.Add( "TTTBodyFound", "ULogs_TTTBodyFound", function( Player, Target )
	
	if !SERVER then return end
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !Target or !Target:IsValid() or !Target:IsPlayer() then return end
	
	ULogs.AddLog( INDEX, ULogs.PlayerInfo( Player ) .. " found the body of " .. ULogs.PlayerInfo( Target ),
		ULogs.Register( INDEX, Player, Target ) )
	
end)




