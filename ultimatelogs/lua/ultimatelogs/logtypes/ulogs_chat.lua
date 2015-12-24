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





local INDEX = 2
local GM = 0

ULogs.AddLogType( INDEX, GM, "Chat", function( Message, Player )
	
	if !Message then return end
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	
	local Informations = {}
	local Base = ULogs.RegisterBase( Player )
	table.insert( Informations, { "Copy message", Message } )
	local Data = {}
	Data[ 1 ] = Player:Name()
	Data[ 2 ] = {}
	table.Add( Data[ 2 ], Base )
	table.insert( Informations, Data )
	
	return Informations
	
end)

hook.Add( "PlayerSay", "ULogs_PlayerSay", function( Player, Message, Team )
	
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !Message then return end
	local Log = true
	if !ULogs.config.LogChatCommand and ( string.sub( string.lower( Message ), 1, string.len( ULogs.config.ChatCommand ) ) == ULogs.config.ChatCommand ) then
		return
	end
	local Prefix = ""
	if Team then Prefix = "TEAM Chat : " end
	ULogs.AddLog( INDEX, Prefix .. ULogs.PlayerInfo( Player ) .. " said '" .. Message .. "'",
		ULogs.Register( INDEX, Message, Player ) )
	
end)




