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

surface.CreateFont( "ULogs_Title", 
	{ font = "Arial", size = 20 } )

surface.CreateFont( "ULogs_Page",
	{ font = "Arial", size = 16 } )

ULogs.Block = {}
ULogs.VersionAdvert = false





----------------------------------------------------------------------------------
--
-- Functions
--
----------------------------------------------------------------------------------



ULogs.GetOptions = function()
	
	local Data = LocalPlayer():GetPData( "ulogs_block", "[]" ) -- I don't like convars

	if (type(Data) == "string") then
		ULogs.Block = util.JSONToTable( Data )
		ULogs.Block[ 1 ] = false
	end
	
end

ULogs.Request = function( Mode, ID, Page, Option )
	
	ULogs.RefreshCategory = true
	
	if !Mode or !ID or !Page then return end
	
	net.Start( "ULogs_Request" )
		net.WriteString( tostring( Mode ) )
		net.WriteString( tostring( ID ) )
		net.WriteString( tostring( Page ) )
		net.WriteString( tostring( Option ) )
	net.SendToServer()
	
	ULogs.NeedLogClear = true
	ULogs.IsLoading = true
	ULogs.LoadingTime = CurTime() + ULogs.config.MaxLoadTime
	
end

ULogs.UpdateLog = function( Logs, Pages )
	
	if !Logs then return end
	if !Pages then Pages = 1 end
	
	ULogs.Logs = Logs
	ULogs.NeedLogUpdate = true
	ULogs.Pages = Pages
	
end

ULogs.Copy = function( Str )
	
	chat.AddText( Color( 255, 100, 0 ), "[" .. ULogs.config.Title .. "] ", Color( 255, 255, 255 ), "'" .. Str .. "' copied" )
	SetClipboardText( Str )
	
end

ULogs.FindPlayer = function( Name )
	
	if !Name then return end
	
	for k, v in pairs( player.GetAll() ) do
		
		if v:Name() == Name then
			
			return v
			
		end
		
	end
	
end

ULogs.CheckUpdate = function( CurrentVersion )
	
	timer.Simple(.5, function()
		
		http.Fetch( "https://raw.githubusercontent.com/myrage2000/ulogs/master/VERSION", function( Body )
			
			Version = tonumber( Body )
			
			if Version != CurrentVersion and ULogs.VersionAdvert then
				
				ULogs_Delete_Derma_Query( "A new update is available", "ULogs update", "Remind me next at my next connection", function() ULogs.VersionAdvert = false end, "Ok", function() end, 
					"Download page", function() gui.OpenURL( "https://facepunch.com/showthread.php?t=1498803" ) end )
				
			end
			
			
		end)
		
	end)
	
end





----------------------------------------------------------------------------------
--
-- Net
--
----------------------------------------------------------------------------------



net.Receive( "ULogs_Notify", function()
	
	local Str = net.ReadString()
	
	chat.AddText( Color( 255, 100, 0 ), "[" .. ULogs.config.Title .. "] ", Color( 255, 255, 255 ), Str )
	
end)

net.Receive( "ULogs_OpenMenu", function()
	
	local Delete = tobool( net.ReadBit() )
	local CurrentVersion = tonumber( net.ReadString( "1" ) )
	
	ULogs.CheckUpdate( CurrentVersion )
	ULogs.OpenMenu( Delete )
	
end)

net.Receive( "ULogs_SendLogs", function()
	
	local Pages = tonumber( net.ReadString() )
	local Count = tonumber( net.ReadString() )
	local Log = {}
	
	for k = 1, Count do
		local Table = net.ReadTable()
		if Table[ 3 ] then Table[ 3 ] = Table[ 3 ] end
		table.insert( Log, Table )
	end
	
	ULogs.UpdateLog( Log, Pages )
	ULogs.IsLoading = false
	
end)





----------------------------------------------------------------------------------
--
-- GUI
--
----------------------------------------------------------------------------------



ULogs.OpenMenu = function( Delete )
	
	if ULogs.Main and ULogs.Main:IsValid() then return end
	
	ULogs.GetOptions()
	
	local Buttons = {}
	local Mode = 1
	local Page = 1
	local SelectedButton = 0
	local SelectedButtonText = ""
	ULogs.Pages = 1
	
	local Main = vgui.Create( "ULogs_DFrame" )
	Main:SetSize( 800, 500 )
	Main:Center()
	Main:SetTitle( "" )
	Main:MakePopup()
	Main:ShowCloseButton( false )
	Main:SetSizable( false )
	Main:SetDraggable( true )
	ULogs.Main = Main
	
	local CloseButton = vgui.Create( "ULogs_DButton", Main )
	CloseButton:SetSize( 30, 20 )
	CloseButton:SetPos( Main:GetWide() - 33, 3 )
	CloseButton:SetText( "X" )
	CloseButton.DoClick = function()
		Main:Close()
	end
	
	local Title = vgui.Create( "DLabel", Main )
	Title:SetColor( Color( 255, 255, 255, 255 ) )
	Title:SetFont( "ULogs_Title" )
	Title:SetText( ULogs.config.Title )
	Title:SizeToContents()
	Title:SetPos( Main:GetWide() / 2 - Title:GetWide() / 2, 3 )
	
	local List = vgui.Create( "DPanelList", Main )
	List:SetPos( 3, 23 )
	List:SetSize( 150, Main:GetTall() - 54 )
	List:SetSpacing( 1 )
	List:EnableHorizontal( false )
	List:EnableVerticalScrollbar( true )
	
	local LogList = vgui.Create( "ULogs_DListView", Main )
	LogList:SetPos( 155, 55 )
	LogList:SetSize( Main:GetWide() - 158, Main:GetTall() - 85 )
	LogList:SetMultiSelect( false )
	local DateColumn = LogList:AddColumn( "Date / Time" )
	LogList:AddColumn( "Action / Log" )
	DateColumn:SetFixedWidth( 150 )
	timer.Simple( .1, function()
		if !DateColumn then return end
		DateColumn:SetMinWidth( 10 )
		DateColumn:SetMaxWidth( 1920 * 10 )
	end)
	
	LogList.OnRowRightClick = function( panel , line )
		
		local Menu = ULogs_DermaMenu()
		Menu:AddOption( "Copy line", function()
			
			ULogs.Copy( "[" .. panel:GetLine( line ):GetValue( 1 ) .. "] " .. panel:GetLine( line ):GetValue( 2 ) )
			
		end)
		Menu:AddOption( "Copy date", function()
			
			ULogs.Copy( panel:GetLine( line ):GetValue( 1 ) )
			
		end)
		
		if ULogs.Logs[ line ] and ULogs.Logs[ line ][ 3 ] then
			
			local Log = ULogs.Logs[ line ][ 3 ]
			
			if type( Log ) == "table" then
				
				for k, v in pairs( Log ) do
					
					if v[ 2 ] and type( v[ 2 ] ) == "table" then
						
						local Category = Menu:AddSubMenu( v[ 1 ] )
						
						for x, p in pairs( v[ 2 ] ) do
							
							if p[ 2 ] and type( p[ 2 ] ) == "table" then
								
								local SubCategory = Category:AddSubMenu( p[ 1 ] )
								
								for l, b in pairs( p[ 2 ] ) do
									
									if b[ 2 ] and type( b[ 2 ] ) == "string" then
										
										SubCategory:AddOption( b[ 1 ], function()
											
											ULogs.Copy( b[ 2 ] )
											
										end)
										
									end
									
								end
								
							elseif p[ 2 ] and type( p[ 2 ] ) == "string" then
								
								Category:AddOption( p[ 1 ], function()
									
									ULogs.Copy( p[ 2 ] )
									
								end)
								
							end
							
						end
						
					elseif v[ 2 ] and type( v[ 2 ] ) == "string" then
						
						Menu:AddOption( v[ 1 ], function()
							
							ULogs.Copy( v[ 2 ] )
							
						end)
						
					end
					
				end
				
			end
			
		end
		
		Menu:Open()
		
	end
	
	local SearchDefaultText = "Search ALL Logs ..."
	local Search = vgui.Create( "ULogs_DTextEntry", Main )
	Search:SetMultiline( false )
	Search:SetPos( 3, Main:GetTall() - 28 )
	Search:SetSize( 250, 25 )
	Search:SetText( SearchDefaultText )
	Search:SetTextColor( Color( 255, 255, 255 ) )
	Search.OnGetFocus = function()
		if Search:GetValue() == SearchDefaultText then
			Search:SetText( "" )
		end
	end
	Search.OnLoseFocus = function()
		if Search:GetValue() == "" then
			Search:SetText( SearchDefaultText )
		end
	end
	
	local ChoosePlayer = vgui.Create( "ULogs_DComboBox", Main )
	ChoosePlayer:SetPos( 256, Main:GetTall() - 28 )
	ChoosePlayer:SetSize( 200, 25 )
	ChoosePlayer:SetValue( "Choose Player" )
	ChoosePlayer:AddChoice( "Choose Player" )
	
	Search.OnEnter = function()
		ChoosePlayer:SetText( ChoosePlayer:GetOptionText( 1 ) )
		ChoosePlayer.selected = 1
		Mode = 2
		ULogs.Pages = 1
		Page = 1
		ULogs.Request( Mode, SelectedButton, Page, Search:GetValue() )
	end
	ChoosePlayer.OnSelect = function( Panel, Index, Value )
		
		if Index != 1 then
			Search:SetText( SearchDefaultText )
			Mode = 3
		else
			Mode = 1
		end
		ULogs.Pages = 1
		Page = 1
		local Player = ULogs.FindPlayer( ChoosePlayer:GetValue() )
		
		if Player and Player:IsValid() and Player:IsPlayer() and !Player:IsBot() then
		
			ULogs.Request( Mode, SelectedButton, Page, Player:SteamID() )
			
		else
			
			if Mode == 3 then
				chat.AddText( Color( 255, 100, 0 ), "[" .. ULogs.config.Title .. "] ", Color( 255, 255, 255 ), "Selected player is invalid" )
				ChoosePlayer:SetText( ChoosePlayer:GetOptionText( 1 ) )
				ChoosePlayer.selected = 1
				Mode = 1
			end
			
			ULogs.Request( Mode, SelectedButton, Page )
			
		end
		
	end
	
	local function RefreshButtons()
		
		for k,v in pairs( Buttons ) do
			
			if v[ 1 ] != SelectedButton then
				v[ 2 ].Selected = false
			end
			
		end
		
	end
	local function ChangePage()
		
		local Option = nil
		if Mode == 2 then Option = Search:GetValue() end
		if Mode == 3 then Option = ChoosePlayer:GetValue() end
		ULogs.Request( Mode, SelectedButton, Page, Option )
		
	end
	
	local Players = {}
	for k, v in pairs( player.GetAll() ) do
		
		table.insert( Players, { v:Nick() } )
		
	end
	
	table.SortByMember( Players, 1, function(a, b) return a > b end )
	
	for k, v in ipairs( Players ) do
		
		ChoosePlayer:AddChoice( v[ 1 ] )
		
	end
	
	local CategoryTitle = vgui.Create( "DLabel", Main )
	CategoryTitle:SetColor( Color( 255, 255, 255, 255 ) )
	CategoryTitle:SetFont( "Default" )
	CategoryTitle:SetPos( 160, 35 )
	CategoryTitle.Think = function()
		if ULogs.RefreshCategory then
			
			ULogs.RefreshCategory = false
			
			local Options = ""
			if Mode == 2 then
				Options = " - Search for " .. Search:GetValue()
			elseif Mode == 3 then
				Options = " - Search for " .. ChoosePlayer:GetValue()
			end
			CategoryTitle:SetText( SelectedButtonText .. Options )
			CategoryTitle:SizeToContents()
			
		end
	end
	
	local ResetButton = vgui.Create( "ULogs_DButton", Main )
	ResetButton:SetSize( 40, 25 )
	ResetButton:SetPos( 459, Main:GetTall() - 28 )
	ResetButton:SetText( "Reset" )
	ResetButton.DoClick = function()
		ChoosePlayer:SetText( ChoosePlayer:GetOptionText( 1 ) )
		ChoosePlayer.selected = 1
		Search:SetText( SearchDefaultText )
		Mode = 1
		ULogs.Pages = 1
		Page = 1
		ULogs.Request( Mode, SelectedButton, Page )
	end
	
	local SetPage = vgui.Create( "ULogs_DButton", Main )
	SetPage:SetSize( 20, 25 )
	SetPage:SetPos( Main:GetWide() - 298, Main:GetTall() - 28 )
	SetPage:SetText( "?" )
	SetPage.DoClick = function()
		ULogs_Derma_StringRequest( ULogs.config.Title, "Set page to", "", function( NewPage )
			NewPage = tonumber( NewPage )
			if type( NewPage ) != "number" then NewPage = 1 end
			if NewPage < 1 or NewPage > ULogs.Pages then NewPage = 1 end
			Page = math.floor( NewPage )
			ChangePage()
		end, nil, "Set" )
	end
	
	local PageLastLeft = vgui.Create( "ULogs_DButton", Main )
	PageLastLeft:SetSize( 30, 25 )
	PageLastLeft:SetPos( Main:GetWide() - 275, Main:GetTall() - 28 )
	PageLastLeft:SetText( "<<" )
	PageLastLeft.DoClick = function()
		Page = 1
		ChangePage()
	end
	
	local PageLastRight = vgui.Create( "ULogs_DButton", Main )
	PageLastRight:SetSize( 30, 25 )
	PageLastRight:SetPos( Main:GetWide() - 33, Main:GetTall() - 28 )
	PageLastRight:SetText( ">>" )
	PageLastRight.DoClick = function()
		Page = ULogs.Pages
		ChangePage()
	end
	
	local PageLeft = vgui.Create( "ULogs_DButton", Main )
	PageLeft:SetSize( 30, 25 )
	PageLeft:SetPos( Main:GetWide() - 242, Main:GetTall() - 28 )
	PageLeft:SetText( "<" )
	PageLeft.DoClick = function()
		Page = Page - 1
		ChangePage()
	end
	PageLeft.OldThink = PageLeft.Think
	PageLeft.Think = function()
		if Page <= 1 and ( !PageLeft:GetDisabled() or !PageLastLeft:GetDisabled() ) then
			PageLeft:SetDisabled( true )
			PageLastLeft:SetDisabled( true )
		elseif Page > 1 and ( PageLeft:GetDisabled() or PageLastLeft:GetDisabled() ) then
			PageLeft:SetDisabled( false )
			PageLastLeft:SetDisabled( false )
		end
		PageLeft:OldThink()
	end
	
	local PageRight = vgui.Create( "ULogs_DButton", Main )
	PageRight:SetSize( 30, 25 )
	PageRight:SetPos( Main:GetWide() - 66, Main:GetTall() - 28 )
	PageRight:SetText( ">" )
	PageRight.DoClick = function()
		Page = Page + 1
		ChangePage()
	end
	PageRight.OldThink = PageRight.Think
	PageRight.Think = function()
		if Page >= ULogs.Pages and ( !PageRight:GetDisabled() or !PageLastRight:GetDisabled() ) then
			PageRight:SetDisabled( true )
			PageLastRight:SetDisabled( true )
		elseif Page < ULogs.Pages and ( PageRight:GetDisabled() or PageLastRight:GetDisabled() ) then
			PageRight:SetDisabled( false )
			PageLastRight:SetDisabled( false )
		end
		PageRight:OldThink()
	end
	
	local PageTitle = vgui.Create( "DLabel", Main )
	PageTitle:SetColor( Color( 255, 255, 255, 255 ) )
	PageTitle:SetFont( "ULogs_Page" )
	PageTitle.Think = function()
		PageTitle:SetText( Page .. " / " .. ULogs.Pages )
		PageTitle:SizeToContents()
		PageTitle:SetPos( Main:GetWide() - 140 - PageTitle:GetWide() / 2, Main:GetTall() - 15 - PageTitle:GetTall() / 2 )
		if Page > ULogs.Pages or Page < 1 then
			Page = 1
			local Option = nil
			if Mode == 2 then Option = Search:GetValue() end
			if Mode == 3 then Option = ChoosePlayer:GetValue() end
			ULogs.Request( Mode, SelectedButton, Page, Option )
		end
	end
	
	local LogTypes = {}
	for k, v in pairs( ULogs.LogTypes ) do
		
		if !LogTypes[ v.GM ] then LogTypes[ v.GM ] = {} end
		if ULogs.Block[ v.ID ] then continue end
		
		table.insert( LogTypes[ v.GM ], v )
		
	end
	
	for x, p in pairs( LogTypes ) do
		
		if x > 0 then
			
			if ULogs.GMTypes[ x ] then
				
				if table.Count( p ) <= 0 then continue end
				
				local Button = vgui.Create( "ULogs_DButton" )
				Button.Category = true
				Button:SetDisabled( true )
				Button:SetText( ULogs.GMTypes[ x ].Name )
				List:AddItem( Button )
				
			end
			
		end
		
		table.sort( p, function( a, b )
			
			a = a.Name
			b = b.Name
			
			a = string.Replace( a, "(Un)", "" ) -- Let's temporary do that ;-(
			a = string.Replace( a, "(Dis)", "" )
			a = string.Replace( a, "(", "" )
			a = string.Replace( a, ")", "" )
			a = string.Replace( a, " ", "" )
			
			b = string.Replace( b, "(Un)", "" )
			b = string.Replace( b, "(Dis)", "" )
			b = string.Replace( b, "(", "" )
			b = string.Replace( b, ")", "" )
			b = string.Replace( b, " ", "" )
			
			return a < b
			
		end )
		
		for k, v in pairs( p ) do
			
			local Button = vgui.Create( "ULogs_DButton" )
			Button.Selected = false
			Button.ID = v.ID
			Button:SetText( v.Name )
			Button.DoClick = function( self )
				SelectedButton = self.ID
				SelectedButtonText = self:GetText()
				self.Selected = true
				RefreshButtons()
				local Option = nil
				if Mode == 2 then Option = Search:GetValue() end
				if Mode == 3 then Option = ChoosePlayer:GetValue() end
				ULogs.Pages = 1
				Page = 1
				ULogs.Request( Mode, SelectedButton, Page, Option )
			end
			table.insert( Buttons, { v.ID, Button } )
			List:AddItem( Button )
			
		end
		
	end
	
	local Button = vgui.Create( "ULogs_DButton" )
	Button.Category = true
	Button:SetDisabled( true )
	Button:SetText( "Tools" )
	List:AddItem( Button )
	
	if Delete then
		
		local Button = vgui.Create( "ULogs_RDButton" )
		Button:SetText( "Remove Logs" )
		Button.DoClick = function()
			if Delete then
				Main:Close()
				ULogs.OpenDeleteMenu()
			end
		end
		List:AddItem( Button )
		
	end
	
	local Button = vgui.Create( "ULogs_DButton" )
	Button:SetText( "Options" )
	Button.DoClick = function()
			Main:Close()
			ULogs.OpenOptionsMenu()
	end
	List:AddItem( Button )
	
	local Button = vgui.Create( "ULogs_DButton" )
	Button:SetText( "Forum" )
	Button.DoClick = function()
		gui.OpenURL( "https://facepunch.com/showthread.php?t=1498803" )
	end
	List:AddItem( Button )
	
	if Buttons[ 1 ] then
		
		Buttons[ 1 ][ 2 ].DoClick( Buttons[ 1 ][ 2 ] )
		
	end	
	
	Main.FrameThink = Main.Think
	Main.Think = function()
		
		if ULogs.IsLoading and ULogs.LoadingTime < CurTime() then
			ULogs.IsLoading = false
			chat.AddText( Color( 255, 100, 0 ), "[" .. ULogs.config.Title .. "] ", Color( 255, 0, 0 ), "Can't receive logs data : Timed out" )
		end
		
		if ULogs.NeedLogUpdate then
			ULogs.NeedLogUpdate = false
			LogList:Clear()
			for k, v in pairs( ULogs.Logs ) do
				LogList:AddLine( v[ 1 ], v[ 2 ] )
			end
		end
		
		if ULogs.NeedLogClear then
			ULogs.NeedLogClear = false
			LogList:Clear()
		end
		
		Main:FrameThink()
		
	end
	
end

ULogs.OpenDeleteMenu = function()
	
	local Main = vgui.Create( "ULogs_DFrame" )
	Main:SetSize( 300, 500 )
	Main:Center()
	Main:SetTitle( "" )
	Main:MakePopup()
	Main:ShowCloseButton( false )
	Main:SetSizable( false )
	Main:SetDraggable( true )
	
	local CloseButton = vgui.Create( "ULogs_DButton", Main )
	CloseButton:SetSize( 30, 20 )
	CloseButton:SetPos( Main:GetWide() - 33, 3 )
	CloseButton:SetText( "X" )
	CloseButton.DoClick = function()
		Main:Close()
	end
	
	local Title = vgui.Create( "DLabel", Main )
	Title:SetColor( Color( 255, 255, 255, 255 ) )
	Title:SetFont( "ULogs_Title" )
	Title:SetText( ULogs.config.Title )
	Title:SizeToContents()
	Title:SetPos( Main:GetWide() / 2 - Title:GetWide() / 2, 3 )
	
	local List = vgui.Create( "DPanelList", Main )
	List:SetPos( 5, 26 )
	List:SetSize( 291, Main:GetTall() - 29 )
	List:SetSpacing( 1 )
	List:EnableHorizontal( false )
	List:EnableVerticalScrollbar( true )
	
	for k, v in pairs( ULogs.LogTypes ) do
		
		local Button = vgui.Create( "ULogs_RDButton" )
		Button.ID = v.ID
		Button.Category = v.Name
		local Info = ""
		if ULogs.GMTypes[ v.GM ] and ULogs.GMTypes[ v.GM ].Name then
			Info = ULogs.GMTypes[ v.GM ].Name .. " "
		end
		Button:SetText( "Delete " .. Info .. v.Name .. " logs" )
		Button.DoClick = function( self )
			
			ULogs_Delete_Derma_Query( "Do you want to delete " .. self.Category .. " logs ?", ULogs.config.Title, "Yes",function()
				
				net.Start( "ULogs_Delete" )
					net.WriteString( tostring( self.ID ) )
				net.SendToServer()
				
				Main:Close()
			end, "No", function() end)
			
		end
		List:AddItem( Button )
		
	end
	
	local Button = vgui.Create( "ULogs_DButton" )
	Button.Category = true
	Button:SetDisabled( true )
	Button:SetText( "" )
	List:AddItem( Button )
	
	local Button = vgui.Create( "ULogs_RDButton" )
	Button:SetText( "Delete the x oldest logs" )
	Button.DoClick = function( self )
		
		ULogs_Derma_StringRequest( ULogs.config.Title, "How many logs do you want to delete ?", "", function( Number )
			Number = tonumber( Number )
			if type( Number ) != "number" then return end
			if Number <= 0 then return end
			Number = math.floor( Number )
			
			net.Start( "ULogs_DeleteOldest" )
				net.WriteString( tostring( Number ) )
			net.SendToServer()
			
		end, nil, "Delete" )
		
	end
	List:AddItem( Button )
	
end

ULogs.OpenOptionsMenu = function()
	
	ULogs.GetOptions()
	
	local Main = vgui.Create( "ULogs_DFrame" )
	Main:SetSize( 300, 500 )
	Main:Center()
	Main:SetTitle( "" )
	Main:MakePopup()
	Main:ShowCloseButton( false )
	Main:SetSizable( false )
	Main:SetDraggable( true )
	
	local CloseButton = vgui.Create( "ULogs_DButton", Main )
	CloseButton:SetSize( 30, 20 )
	CloseButton:SetPos( Main:GetWide() - 33, 3 )
	CloseButton:SetText( "X" )
	CloseButton.DoClick = function()
		Main:Close()
	end
	
	local Title = vgui.Create( "DLabel", Main )
	Title:SetColor( Color( 255, 255, 255, 255 ) )
	Title:SetFont( "ULogs_Title" )
	Title:SetText( ULogs.config.Title )
	Title:SizeToContents()
	Title:SetPos( Main:GetWide() / 2 - Title:GetWide() / 2, 3 )
	
	local List = vgui.Create( "DPanelList", Main )
	List:SetPos( 5, 26 )
	List:SetSize( 291, Main:GetTall() - 29 )
	List:SetSpacing( 1 )
	List:EnableHorizontal( false )
	List:EnableVerticalScrollbar( true )
	
	local BlockOptions = {}
	for k, v in pairs( ULogs.LogTypes ) do
		
		if v.ID == 1 then continue end
		
		local Button = vgui.Create( "ULogs_DCheckBoxLabel" )
		local Info = ""
		if ULogs.GMTypes[ v.GM ] and ULogs.GMTypes[ v.GM ].Name then
			Info = ULogs.GMTypes[ v.GM ].Name .. " "
		end
		Button.ID = v.ID
		Button:SetText( "Show " .. Info .. v.Name .. " logs" )
		Button:SetValue( !ULogs.Block[ v.ID ] )
		Button.OnChange = function( self, Value )
			
			Value = !Value
			ULogs.Block[ self.ID ] = tobool( Value )
			local Data = util.TableToJSON( ULogs.Block )
			LocalPlayer():SetPData( "ulogs_block", Data )
			
			ULogs.GetOptions()
			
		end
		List:AddItem( Button )
		table.insert( BlockOptions, Button )
		
	end
	
	local Button = vgui.Create( "ULogs_DButton" )
	Button:SetText( "Reset" )
	Button.DoClick = function( self )
		
		for k, v in pairs( BlockOptions ) do
			
			v:SetValue( 1 )
			
		end
		
	end
	List:AddItem( Button )
	
end




