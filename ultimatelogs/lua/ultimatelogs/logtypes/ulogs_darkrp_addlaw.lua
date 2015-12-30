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





local INDEX = 25
local GM = 2

ULogs.AddLogType( INDEX, GM, "Law", function( Player, Law )
	
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !Law then return end
	
	local Informations = {}
	local Base = ULogs.RegisterBase( Player )
	table.insert( Informations, { "Copy law", Law } )
	local Data = {}
	Data[ 1 ] = Player:Name()
	Data[ 2 ] = {}
	table.Add( Data[ 2 ], Base )
	table.insert( Informations, Data )
	
	return Informations
	
end)

local function findTheMayor()
	
	local Result = {}
	
	for k, v in pairs( player.GetAll() ) do
		if v:Team() == TEAM_MAYOR then
			table.insert( Result, v )
		end
	end
	
	if #Result == 1 and Result[ 1 ] then -- Return when there is only a Mayor
		return Result[ 1 ]
	end
	
end

hook.Add( "addLaw", "ULogs_addLaw", function( Index, Law )
	
	if !SERVER then return end
	if !Index then return end
	if !Law then return end
	if !TEAM_MAYOR then return end
	-- This hooks doesn't give the player
	local Player = findTheMayor()
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	
	ULogs.AddLog( INDEX, ULogs.PlayerInfo( Player ) .. " added a law :  '" .. Law .. "'",
		ULogs.Register( INDEX, Player, Law ) )
	
end)




