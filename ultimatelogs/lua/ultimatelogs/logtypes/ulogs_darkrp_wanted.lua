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





local INDEX = 15
local GM = 2

ULogs.AddLogType( INDEX, GM, "(Un)Wanted", function( Player, Officer )
	
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !Officer or !Officer:IsValid() or !Officer:IsPlayer() then return end
	
	local Informations = {}
	local Base = ULogs.RegisterBase( Player )
	local Data = {}
	Data[ 1 ] = "Criminal " .. Player:Name()
	Data[ 2 ] = {}
	table.Add( Data[ 2 ], Base )
	local Base = {}
	for k, v in pairs ( Player:GetWeapons() ) do
		
		if !v or !v:IsValid() then return end
		table.insert( Base, { v:GetClass(), v:GetClass() } )
		
	end
	
	if Player:GetActiveWeapon():IsValid() then
		
		table.insert( Data[ 2 ], { "Active Weapon : " .. Player:GetActiveWeapon():GetClass(), Player:GetActiveWeapon():GetClass() } )
		
	end
	if #Base > 0 then
		table.insert( Data[ 2 ], { "Weapons : ", Base } )
	end
	table.insert( Informations, Data )
	
	local Base = ULogs.RegisterBase( Officer )
	local Data = {}
	Data[ 1 ] = "Officer " .. Officer:Name()
	Data[ 2 ] = {}
	table.Add( Data[ 2 ], Base )
	table.insert( Informations, Data )
	
	return Informations
	
end)

hook.Add( "playerWanted", "ULogs_playerWanted", function( Player, Officer, Reason )
	
	if !SERVER then return end
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !Officer or !Officer:IsValid() or !Officer:IsPlayer() then return end
	if !Reason then Reason = "unknown reason" end
	
	ULogs.AddLog( INDEX, ULogs.PlayerInfo( Officer ) .. " wanted " .. ULogs.PlayerInfo( Player ) .. " for '" .. Reason .. "'",
		ULogs.Register( INDEX, Player, Officer ) )
	
end)

hook.Add( "PlayerWanted", "ULogs_PlayerWanted", function( Player, Officer, Reason )
	
	if !SERVER then return end
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !Officer or !Officer:IsValid() or !Officer:IsPlayer() then return end
	if !Reason then Reason = "unknown reason" end
	
	ULogs.AddLog( INDEX, ULogs.PlayerInfo( Officer ) .. " wanted " .. ULogs.PlayerInfo( Player ) .. " for '" .. Reason .. "'",
		ULogs.Register( INDEX, Player, Officer ) )
	
end)

hook.Add( "playerUnWanted", "ULogs_playerUnWanted", function( Player, Officer )
	
	if !SERVER then return end
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !Officer or !Officer:IsValid() or !Officer:IsPlayer() then return end
	
	ULogs.AddLog( INDEX, ULogs.PlayerInfo( Officer ) .. " unwanted " .. ULogs.PlayerInfo( Player ),
		ULogs.Register( INDEX, Player, Officer ) )
	
end)

hook.Add( "PlayerUnWanted", "ULogs_PlayerUnWanted", function( Player, Officer )
	
	if !SERVER then return end
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !Officer or !Officer:IsValid() or !Officer:IsPlayer() then return end
	
	ULogs.AddLog( INDEX, ULogs.PlayerInfo( Officer ) .. " unwanted " .. ULogs.PlayerInfo( Player ),
		ULogs.Register( INDEX, Player, Officer ) )
	
end)




