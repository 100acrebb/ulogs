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





local INDEX = 24
local GM = 2

ULogs.AddLogType( INDEX, GM, "Door ram", function( Player, Entity )
	
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !Entity or !Entity:IsValid() then return end
	
	local Informations = {}
	local Base = ULogs.RegisterBase( Player )
	table.insert( Informations, { "Copy entity class", Entity:GetClass() } )
	local Data = {}
	Data[ 1 ] = Player:Name()
	Data[ 2 ] = {}
	table.Add( Data[ 2 ], Base )
	table.insert( Informations, Data )
	
	return Informations
	
end)

hook.Add( "onDoorRamUsed", "ULogs_onDoorRamUsed", function( Success, Player, Trace )
	
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if type( Success ) != "boolean" then return end
	if !Trace then return end
	if !Trace.Entity or !Trace.Entity:IsValid() then return end
	local SuccessString = "no"
	if Success then SuccessString = "yes" end -- I don't know why the other method didn't work so I do it with a statement here
	
	ULogs.AddLog( INDEX, ULogs.PlayerInfo( Player ) .. " used door ram on '" .. Trace.Entity:GetClass() .. "'. Success : '" .. SuccessString .. "'",
		ULogs.Register( INDEX, Player, Trace.Entity ) )
	
end)




