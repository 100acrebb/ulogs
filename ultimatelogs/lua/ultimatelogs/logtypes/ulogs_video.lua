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





local INDEX = 30
local GM = 6

ULogs.AddLogType( INDEX, GM, "Video Queue", function( Player , Url)
	
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !Video then return end
	
	local Informations = {}
	local Base = ULogs.RegisterBase( Player )
	table.insert( Informations, { "Copy URL", Url } )
	local Data = {}
	Data[ 1 ] = Player:Name()
	Data[ 2 ] = {}
	table.Add( Data[ 2 ], Base )
	table.insert( Informations, Data )
	
	return Informations
	
end)


hook.Add( "PostVideoQueued", "ULogQueuedVideo", function (Video, Theater)

	if !SERVER then return end
	local Player = Video:GetOwner()
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	
	local title = SQLStr(Video:Title())
	--local data = SQLStr(Video:Data())
	
	ULogs.AddLog( INDEX, ULogs.PlayerInfo( Player ) .. " queued "..title, 
		ULogs.Register( INDEX, Player, Video:Data() ) )
end)


hook.Add ("PostVideoQueuedMP", "ULogQueuedVideoMP", function (MediaPlayer, Media, Player )

	if !SERVER then return end
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	
	local title = SQLStr(Media:Title())
	--local data = SQLStr(Video:Data())
	
	ULogs.AddLog( INDEX, ULogs.PlayerInfo( Player ) .. " queued "..title, 
		ULogs.Register( INDEX, Player, Media:Url() ) )

end )





