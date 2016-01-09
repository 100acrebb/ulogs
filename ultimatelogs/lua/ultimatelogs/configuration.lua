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





ULogs = ULogs or {}                                    -- Please don't edit this line
ULogs.config = {}                                      -- Please don't edit this line



ULogs.config.Title          = "Ultimate Logs"          -- The addon name

if (THABID == nil) then THABID = "unknown" end
ULogs.config.TableName      = "ulogs_" .. THABID                 -- The database table name

ULogs.config.Lines          = 32                       -- Set how many lines are visible per page

ULogs.config.ChatCommand    = "!logs"                  -- Set the chat command to open the logs menu
ULogs.config.ConCommand     = "ulogs"                  -- Set the console command to open the logs menu
                                                       -- You can bind this console command to a key

ULogs.config.MaxLoadTime    = 5                        -- After how many seconds it will timeout if
                                                       -- no data is received

ULogs.config.CanSee         = {                        -- ULX ranks that can open the logs menu

"superadmin",
"headadmin",
"senioradmin",
"admin",
"operator",
"moderator",
}

ULogs.config.SeeIP          = {                        -- ULX ranks that can see IP addresses

"superadmin",
"headadmin",
"senioradmin",
"admin",


}

ULogs.config.Delete         = {                        -- ULX ranks that can delete logs

"superadmin",
"headadmin",
}

ULogs.config.IgnoreCommands = {                        -- Don't log these console commands

"_FAdmin",
"_FAdmin_SpectatePosUpdate",
"wire_expression_ops_sync",
"wepswitch",
"_ttt_request_serverlang",
"_ttt_request_rolelist",
"ttt_spectate",
"+menu_context",
"-menu_context",
"+menu",
"-menu",
"undo",
"gmod_tool",
"ttt_order_equipment",
"fas2_togglegunpimper",
"fas2_detach",
"darkrp",
"vote",
"_sendDarkRPvars",
"_sendAllDoorData",
"_DarkRP_AnimationMenu",
"gmod_undo",
"gm_spawn",
"__playLockpickSound",
"_lockpickSuccess",
"EGP_ScrWH",
"ulx",
"ulib_cl_ready",
"ulib_update_cvar",
"_xgui",
"xgui",
"level_networkvars",
"_u",
"___askDoor",
"ans",
"cs_askholders",
"cs_menu",
"E2_FinishChat",
"E2_StartChat",
"wire_expression2_friend_status",
"fas2_attach",
"wac_setseat",
"SetMechPlayerWepKey",
"wire_expression2_event",
"vc_els_manual",
"vc_horn",
"vc_els_lights",
"vc_els_sound",
"vc_headlights_onoff",
"vc_lights_onoff",
"wire_pod_bind",
"billiard_strike",
"wac_air_input",
"slotm_spin",


ULogs.config.ConCommand -- Don't log the command to open the logs menu. Please don't edit this line

}

ULogs.config.LogChatCommand = false                    -- Set to 'true' if you want to log the chat command to open the logs menu


ULogs.config.Limit          = 5000                     -- Set the logs lines limit in the database
                                                       -- This is very important if you want to keep your server stable
													   -- If the limit is reached, the oldest lines will be
													   -- deleted.
													   -- In all case all logs are available in the 'data' folder
													   -- (See the settings below)


ULogs.config.Block = {                                 -- Don't touch this if you don't know what it does please. Uncomment these lines if you want to block a log from being recorded
                                                       -- You can find the log ID in the 'logtypes/' folder

-- 2,
-- 3,
-- 4,
-- 5,
-- 6,
-- 7,
-- 8,
-- 9,
-- 10,
-- 11,
-- 12,
-- 13,
-- 14,
-- 15,
-- 16,
-- 17,
-- 18,
-- 19,
-- 20,
-- 21,
-- 22,

}

ULogs.config.SaveToData      = false                    -- Set to 'true' if you want to save a copy of the logs in the data folder
                                                       -- In all cases the logs will be at least saved in the database





----------------------------------------------------------------------------------
--
-- Advanced configuration
--
----------------------------------------------------------------------------------



ULogs.config.OnlyUseCustom  = false                      -- Set this to 'true' if you want to use
                                                         -- custom function instead of ULX

ULogs.config.CanSeeCustom   = function( Player )         -- If ULX is not installed or if 'OnlyUseCustom'
                                                         -- is set to 'true' then call this function to
														 -- check if a player can see the logs menu

return Player:IsSuperAdmin() or Player:IsAdmin()         -- By default if the player is at least admin
	                                                     -- he can open the logs menu

end

ULogs.config.SeeIPCustom    = function( Player )         -- If ULX is not installed or if 'OnlyUseCustom'
                                                         -- is set to 'true' then call this function to
														 -- check if a player can see IP addresses

return Player:IsSuperAdmin() or Player:IsAdmin()                             -- By default only superadmins can open see
	                                                     -- IP addresses

end

ULogs.config.DeleteCustom   = function( Player )         -- If ULX is not installed or if 'OnlyUseCustom'
                                                         -- is set to 'true' then call this function to
														 -- check if a player can delete logs

return Player:IsSuperAdmin()                             -- By default only superadmins can delete logs

end




