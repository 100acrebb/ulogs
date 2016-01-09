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





local INDEX = 10
local GM = 2

ULogs.AddLogType( INDEX, GM, "Demote", function( Reason, Demoter, Demotee )
	
	if !Reason then Reason = "unknown reason" end
	if !Demoter or !Demoter:IsValid() or !Demoter:IsPlayer() then return end
	if !Demotee or !Demotee:IsValid() or !Demotee:IsPlayer() then return end
	
	local Informations = {}
	local Base = ULogs.RegisterBase( Demoter )
	table.insert( Informations, { "Copy reason", Reason } )
	local Data = {}
	Data[ 1 ] = "Demoter " .. Demoter:Name()
	Data[ 2 ] = {}
	table.Add( Data[ 2 ], Base )
	table.insert( Informations, Data )
	
	local Base = ULogs.RegisterBase( Demotee )
	local Data = {}
	Data[ 1 ] = "Demotee " .. Demotee:Name()
	Data[ 2 ] = {}
	table.Add( Data[ 2 ], Base )
	table.insert( Informations, Data )
	
	return Informations
	
end)

hook.Add( "onPlayerDemoted", "ULogs_onPlayerDemoted", function( Demoter, Demotee, Reason )
	
	if !SERVER then return end
	if !Demoter or !Demoter:IsValid() or !Demoter:IsPlayer() then return end
	if !Demotee or !Demotee:IsValid() or !Demotee:IsPlayer() then return end
	if !Reason then Reason = "unknown reason" return end
	
	ULogs.AddLog( INDEX, ULogs.PlayerInfo( Demoter ) .. " demoted " .. ULogs.PlayerInfo( Demotee ) .. " for '" .. Reason .. "'",
		ULogs.Register( INDEX, Reason, Demoter, Demotee ) )
	
end)




