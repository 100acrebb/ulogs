--[[   _                                
    ( )                               
   _| |   __   _ __   ___ ___     _ _ 
 /'_` | /'__`\( '__)/' _ ` _ `\ /'_` )
( (_| |(  ___/| |   | ( ) ( ) |( (_| |
`\__,_)`\____)(_)   (_) (_) (_)`\__,_) 
	DScrollBarGrip
--]]

local PANEL = {}

--[[---------------------------------------------------------
   Name: Init
-----------------------------------------------------------]]
function PANEL:Init()
end

--[[---------------------------------------------------------
   Name: OnMousePressed
-----------------------------------------------------------]]
function PANEL:OnMousePressed()

	self:GetParent():Grip( 1 )

end

--[[---------------------------------------------------------
   Name: Paint
-----------------------------------------------------------]]
function PANEL:Paint( w, h )
	
	if ( self:GetDisabled() ) then
		return draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 75, 75, 75, 255 ) )
	end
	
	if ( self.Depressed ) then
		return draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 0, 140, 255, 255 ) )
	end
	
	if ( self.Hovered ) then
		return draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 0, 160, 255, 255 ) )
	end
	
	return draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 0, 180, 255, 255 ) )
	
end

derma.DefineControl( "ULogs_DScrollBarGrip", "A Scrollbar Grip", PANEL, "DPanel" )