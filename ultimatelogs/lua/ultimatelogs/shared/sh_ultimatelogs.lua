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





ULogs = ULogs or {}
ULogs.LogTypes = {}
ULogs.GMTypes = {}

local Data = {}
Data.ID = 1
Data.GM = 0
Data.Name = "ALL Logs"
Data.Register = function() end

ULogs.LogTypes[ 1 ] = Data





----------------------------------------------------------------------------------
--
-- Functions
--
----------------------------------------------------------------------------------



ULogs.AddLogType = function( ID, GM, Name, Register )
	
	if !ID then return end
	if !GM then return end
	if !Name then return end
	if type( Register ) != "function" then return end
	
	if ID == 1 then Error( "[UltimateLogs] LogID : " .. ID .. " is invalid \n" ) return end
	if ULogs.LogTypes[ ID ] then Error( "[UltimateLogs] LogID : " .. ID .. " already exists \n" ) end
	
	local Data = {}
	Data.ID = ID
	Data.GM = GM
	Data.Name = Name
	Data.Register = Register
	
	ULogs.LogTypes[ ID ] = Data
	
end

ULogs.AddGMType = function( ID, Name )
	
	if !ID then return end
	if !Name then return end
	
	if ID == 0 then Error( "[UltimateLogs] GM ID : " .. ID .. " is invalid \n" ) return end
	if ULogs.GMTypes[ ID ] then Error( "[UltimateLogs] GM ID : " .. ID .. " already exists \n" ) end
	
	local Data = {}
	Data.ID = ID
	Data.Name = Name
	
	ULogs.GMTypes[ ID ] = Data
	
end




