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





local INDEX = 11
local GM = 2

ULogs.AddLogType( INDEX, GM, "Hit", function( Player, Target, Customer )
	
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !Target or !Target:IsValid() or !Target:IsPlayer() then return end
	
	local Informations = {}
	local Base = ULogs.RegisterBase( Player )
	local Data = {}
	Data[ 1 ] = "Hitman " .. Player:Name()
	Data[ 2 ] = {}
	table.Add( Data[ 2 ], Base )
	table.insert( Informations, Data )
	
	local Base = ULogs.RegisterBase( Target )
	local Data = {}
	Data[ 1 ] = "Target " .. Target:Name()
	Data[ 2 ] = {}
	table.Add( Data[ 2 ], Base )
	table.insert( Informations, Data )
	
	if Customer and Customer:IsValid() and Customer:IsPlayer() then
		
		local Base = ULogs.RegisterBase( Customer )
		local Data = {}
		Data[ 1 ] = "Customer " .. Customer:Name()
		Data[ 2 ] = {}
		table.Add( Data[ 2 ], Base )
		table.insert( Informations, Data )
		
	end
	
	return Informations
	
end)

hook.Add( "onHitAccepted", "ULogs_onHitAccepted", function( Player, Target, Customer )
	
	if !SERVER then return end
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !Target or !Target:IsValid() or !Target:IsPlayer() then return end
	if !Customer or !Customer:IsValid() or !Customer:IsPlayer() then return end
	
	ULogs.AddLog( INDEX, ULogs.PlayerInfo( Player ) .. " accepted a hit on " .. ULogs.PlayerInfo( Target ) .. " ordered by " .. ULogs.PlayerInfo( Customer ),
		ULogs.Register( INDEX, Player, Target, Customer ) )
	
end)

hook.Add( "onHitCompleted", "ULogs_onHitCompleted", function( Player, Target, Customer )
	
	if !SERVER then return end
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !Target or !Target:IsValid() or !Target:IsPlayer() then return end
	if !Customer or !Customer:IsValid() or !Customer:IsPlayer() then return end
	
	ULogs.AddLog( INDEX, ULogs.PlayerInfo( Player ) .. " completed the hit on " .. ULogs.PlayerInfo( Target ) .. " ordered by " .. ULogs.PlayerInfo( Customer ),
		ULogs.Register( INDEX, Player, Target, Customer ) )
	
end)

hook.Add( "onHitFailed", "ULogs_onHitFailed", function( Player, Target, Reason )
	
	if !SERVER then return end
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !Target or !Target:IsValid() or !Target:IsPlayer() then return end
	if !Reason then Reason = "unknown reason" end
	
	ULogs.AddLog( INDEX, ULogs.PlayerInfo( Player ) .. " failed the hit on " .. ULogs.PlayerInfo( Target ) .. " for '" .. Reason .. "'",
		ULogs.Register( INDEX, Player, Target ) )
	
end)




