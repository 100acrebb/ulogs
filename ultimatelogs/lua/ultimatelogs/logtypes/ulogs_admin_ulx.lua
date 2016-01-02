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





local INDEX = 23
local GM = 5

ULogs.AddLogType( INDEX, GM, "ULX", function( Cmd, Args, Player )
	
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !Cmd then return end
	if !Args then Args = {} end
	
	local Informations = {}
	local Base = ULogs.RegisterBase( Player )
	table.insert( Informations, { "Copy command", Cmd } )
	local Data = {}
	Data[ 1 ] = " Admin " .. Player:Name()
	Data[ 2 ] = {}
	table.Add( Data[ 2 ], Base )
	table.insert( Informations, Data )
	
	if #Args > 0 then
		local Data2 = {}
		Data2[ 1 ] = "Details"
		Data2[ 2 ] = {}
		Data3 = {}
		for k, v in pairs( Args ) do
			table.insert( Data3, { "Argument " .. k .. " : " .. v, v } )
		end
		table.Add( Data2[ 2 ], Data3 )
		table.insert( Informations, Data2 )
	end
	
	return Informations
	
end)

hook.Add( "ULibCommandCalled", "ULogs_ULibCommandCalled", function( Player, Cmd, Args )
	
	if !SERVER then return end
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !Cmd then return end
	if Cmd:Split( " " )[ 1 ]:lower() != "ulx" then return end
	Cmd = Cmd:Split( " " )
	table.remove( Cmd, 1 )
	local ArgsString = ""
	local CmdString = ""
	for k, v in pairs( Args ) do
		ArgsString = ArgsString .. " " .. v
	end
	for k, v in pairs( Cmd ) do
		CmdString = CmdString .. " " .. v
	end
	
	
	ULogs.AddLog( INDEX, ULogs.PlayerInfo( Player ) .. " used ULX command '" .. CmdString .. ArgsString .. "'",
		ULogs.Register( INDEX, CmdString, Args, Player ) )
	
end)




