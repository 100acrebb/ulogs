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





ULogs = ULogs or {}                                             -- Please don't edit this line
ULogs.MySQLite_config = {}                                      -- Please don't edit this line



ULogs.MySQLite_config.EnableMySQL      = false                  -- Set to true if you want to use an external MySQL database, false if you want to use the built in SQLite database (garrysmod/sv.db) of Garry's mod

ULogs.MySQLite_config.Host             = "127.0.0.1"            -- The IP address of the MySQL host
ULogs.MySQLite_config.Username         = "username"             -- The username to log in on the MySQL server
ULogs.MySQLite_config.Password         = "password"             -- The password to log in on the MySQL server

ULogs.MySQLite_config.Database_name    = "databasename"         -- The name of the Database on the MySQL server
ULogs.MySQLite_config.Database_port    = 3306                   -- The port of the MySQL server
ULogs.MySQLite_config.Preferred_module = "mysqloo"              -- Preferred module, case sensitive, must be either "mysqloo" or "tmysql4". Only applies when both are installed





