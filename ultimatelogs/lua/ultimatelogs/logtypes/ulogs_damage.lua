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





local INDEX = 5
local GM = 0

ULogs.AddLogType( INDEX, GM, "Damage/Kill", function( Player, Attacker )
	
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	
	local Informations = {}
	local Base = ULogs.RegisterBase( Player )
	local Data = {}
	Data[ 1 ] = "Victim " .. Player:Name()
	Data[ 2 ] = {}
	table.Add( Data[ 2 ], Base )
	table.insert( Informations, Data )
	
	if Attacker and type( Attacker ) != "string" and Attacker:IsValid() and Attacker:IsPlayer() then
		local Base = ULogs.RegisterBase( Attacker )
		local Data = {}
		Data[ 1 ] = "Attacker " .. Attacker:Name()
		Data[ 2 ] = {}
		table.Add( Data[ 2 ], Base )
		table.insert( Informations, Data )
	end
	
	return Informations
	
end)

hook.Add( "EntityTakeDamage", "ULogs_EntityTakeDamage", function( Player, DmgInfo )
	
	if !Player or !Player:IsValid() or !Player:IsPlayer() or !Player:Alive() then return end
	local Attacker = ""
	local Weapon = ""
	local Damage = math.Round( DmgInfo:GetDamage() )
	local HealthDamage = Player:Health() - Damage
	
	if DmgInfo:GetAttacker():IsValid() then
		if DmgInfo:GetAttacker():IsPlayer() or DmgInfo:GetAttacker():GetClass() == "prop_physics" then
			Attacker = DmgInfo:GetAttacker()
			if Attacker:IsPlayer() then
				Weapon = Attacker:GetActiveWeapon()
			else
				Weapon = DmgInfo:GetAttacker()
				if type( Weapon.CPPIGetOwner ) == "function" and Weapon:CPPIGetOwner() and Weapon:CPPIGetOwner():IsValid() and Weapon:CPPIGetOwner():IsPlayer() then
					Attacker = Weapon:CPPIGetOwner()
				end
			end
		end		
	end
	
	if DmgInfo:GetInflictor():IsValid() then
		if DmgInfo:GetInflictor():IsPlayer() then
			Attacker = DmgInfo:GetInflictor()
			Weapon = Attacker:GetActiveWeapon()
		end
		if DmgInfo:GetInflictor():GetClass() == "prop_physics" then
			Attacker = DmgInfo:GetInflictor()
			Weapon = DmgInfo:GetInflictor()
			if type( Weapon.CPPIGetOwner ) == "function" and Weapon:CPPIGetOwner() and Weapon:CPPIGetOwner():IsValid() and Weapon:CPPIGetOwner():IsPlayer() then
				Attacker = Weapon:CPPIGetOwner()
			end
		end
		if DmgInfo:GetInflictor():IsVehicle() then
			Attacker = "A vehicle"
			Weapon = DmgInfo:GetInflictor()
			if Weapon:GetDriver() and Weapon:GetDriver():IsValid() then
				Attacker = Weapon:GetDriver()
			end
		end
	end
	
	if !Weapon or type( Weapon ) == "string" or Weapon:IsValid() then
		if DmgInfo:GetAttacker():IsWeapon() or DmgInfo:GetAttacker().Projectile then
			Weapon = DmgInfo:GetAttacker()
		end
		if DmgInfo:GetInflictor():IsWeapon() or DmgInfo:GetInflictor().Projectile then
			Weapon = DmgInfo:GetInflictor()
		end
	end
	
	if !Weapon or type( Weapon ) == "string" or !Weapon:IsValid() then
		Weapon = tostring( DmgInfo:GetInflictor() )
	end
	
	if !Attacker or type( Attacker ) == "string" or !Attacker:IsValid() then
		Attacker = "Something"
	end
	
	if DmgInfo:IsFallDamage() then
		Weapon = "fall damage"
		Attacker = "The world"
	end
	
	local AttackerInfo = Attacker
	if type( Attacker ) != "string" and Attacker:IsValid() then
		if Attacker:IsPlayer() then
			AttackerInfo = ULogs.PlayerInfo( Attacker )
		else
			AttackerInfo = Attacker:GetClass()
		end
	end
	local WeaponInfo = Weapon
	if type( Weapon ) != "string" and Weapon:IsValid() then
		WeaponInfo = Weapon:GetClass()
	end
	
	if !Player:Alive() or ( HealthDamage <= 0 and Player:Armor() <= 0 ) then
		ULogs.AddLog( INDEX, "[KILL] " .. AttackerInfo .. " killed " .. ULogs.PlayerInfo( Player ) .. " with " .. Damage .. " damage using " .. WeaponInfo,
			ULogs.Register( INDEX, Player, Attacker ) )
	else
		ULogs.AddLog( INDEX, "[HURT] " .. AttackerInfo .. " hurt " .. ULogs.PlayerInfo( Player ) .. " with " .. Damage .. " damage using " .. WeaponInfo,
			ULogs.Register( INDEX, Player, Attacker ) )
	end
	
end)

hook.Add( "PlayerDeath", "ULogs_PlayerDeath", function( Player, _, Killer )
	
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !Killer or !Killer:IsValid() or !Killer:IsPlayer() then return end
	
	if Killer == Player then
		ULogs.AddLog( INDEX, "[KILL] " .. ULogs.PlayerInfo( Player ) .. " killed himself",
			ULogs.Register( INDEX, Player ) )
	end
	
end)




