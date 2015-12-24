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





local INDEX = 22
local GM = 4

ULogs.AddLogType( INDEX, GM, "Round state", function() end)

hook.Add( "OnStartRound", "ULogs_OnStartRound", function()
	
	if !SERVER then return end
	
	ULogs.AddLog( INDEX, "The round begins", {} )
	
end)

hook.Add( "OnEndRound", "ULogs_OnEndRound", function()
	
	if !SERVER then return end
	
	ULogs.AddLog( INDEX, "The round ended", {} )
	
end)




