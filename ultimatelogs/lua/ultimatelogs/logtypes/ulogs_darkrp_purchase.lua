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





local INDEX = 13
local GM = 2

ULogs.AddLogType( INDEX, GM, "Purchase", function( Player )
	
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

hook.Add( "playerBoughtCustomEntity", "ULogs_playerBoughtCustomEntity", function( Player, EntTab, Entity )
	
	if !SERVER then return end
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !EntTab then return end
	if !EntTab.name or !EntTab.price then return end
	
	ULogs.AddLog( INDEX, ULogs.PlayerInfo( Player ) .. " bought '" .. EntTab.name .. "' for $" .. EntTab.price,
		ULogs.Register( INDEX, Player ) )
	
end)

hook.Add( "playerBoughtPistol", "ULogs_playerBoughtPistol", function( Player, EntTab, Entity )
	
	if !SERVER then return end
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !EntTab then return end
	if !EntTab.name or !EntTab.price then return end
	
	ULogs.AddLog( INDEX, ULogs.PlayerInfo( Player ) .. " bought '" .. EntTab.name .. "' for $" .. EntTab.price,
		ULogs.Register( INDEX, Player ) )
	
end)

hook.Add( "playerBoughtShipment", "ULogs_playerBoughtShipment", function( Player, EntTab, Entity )
	
	if !SERVER then return end
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !EntTab then return end
	if !EntTab.name or !EntTab.price then return end
	
	ULogs.AddLog( INDEX, ULogs.PlayerInfo( Player ) .. " bought '" .. EntTab.name .. "' shipment for $" .. EntTab.price,
		ULogs.Register( INDEX, Player ) )
	
end)




