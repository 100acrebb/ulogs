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





local INDEX = 20
local GM = 3

ULogs.AddLogType( INDEX, GM, "Round state", function() end)

hook.Add( "TTTPrepareRound", "ULogs_TTTPrepareRound", function()
	
	if !SERVER then return end
	
	ULogs.AddLog( INDEX, "The preparing phase begins", {} )
	
end)

hook.Add( "TTTBeginRound", "ULogs_TTTBeginRound", function()
	
	if !SERVER then return end
	
	ULogs.AddLog( INDEX, "The round begins", {} )
	
end)

hook.Add( "TTTEndRound", "ULogs_TTTEndRound", function( Result )
	
	if !SERVER then return end
	if !Result then return end
	
	local Info = "Nobody has won"
	
	if Result == 2 then
		
		Info = "The traitors have won"
		
	elseif Result == 3 then
		
		Info = "The innocents have won"
		
	elseif Result == 4 then
		
		Info = "The timelimit is up"
		
	end
	
	ULogs.AddLog( INDEX, "The round ended. " .. Info, {} )
	
end)




