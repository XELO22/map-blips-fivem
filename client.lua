Config                            = {}

Config.Blipy = {
	{
		Pos     = vector3(-537.4, -176.97, 38.22),
		Sprite  = 498,
		Display = 2,
		Scale   = 1.0,
		Colour  = 43,
		Label 	= "Urząd Miasta",
		isHex = false
	},
	{
		Pos     = vector3(-3131.27, 799.5, 17.08),
		Sprite  = 492,
		Display = 2,
		Scale   = 1.0,
		Colour  = 3,
		Label 	= "7709 Malibu Masion",
		isHex = true,
		Hexs = {'steam:', 'steam:', 'steam:', 'steam:'}
	},
}

Config.Strefy = {
}

local PlayerData = {}
local hex = nil

ESX	= nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	
	while ESX.GetPlayerData().job2 == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
	
	ESX.TriggerServerCallback('esx_door:get', function(doors)
		Doors = doors	
	end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2)
		if hex == nil then
			ESX.TriggerServerCallback('garages:getPlayerHex', function(h)
				hex = h
			end)
		end
	end
end)

CreateThread(function()
    Citizen.Wait(1000)
	for i=1, #Config.Blipy, 1 do
		if Config.Blipy[i].isHex == true then
			if Config.Blipy[i].Hexs ~= nil then
				for k, v in pairs(Config.Blipy[i].Hexs) do
					if Config.Blipy[i].Hexs[k] == hex then
						local blip = AddBlipForCoord(Config.Blipy[i].Pos)

						SetBlipSprite (blip, Config.Blipy[i].Sprite)
						SetBlipDisplay(blip, Config.Blipy[i].Display)
						SetBlipScale  (blip, Config.Blipy[i].Scale)
						SetBlipColour (blip, Config.Blipy[i].Colour)
						SetBlipAsShortRange(blip, true)
			
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(Config.Blipy[i].Label)
						EndTextCommandSetBlipName(blip)
					end
				end
			end

		else
			local blip = AddBlipForCoord(Config.Blipy[i].Pos)

			SetBlipSprite (blip, Config.Blipy[i].Sprite)
			SetBlipDisplay(blip, Config.Blipy[i].Display)
			SetBlipScale  (blip, Config.Blipy[i].Scale)
			SetBlipColour (blip, Config.Blipy[i].Colour)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.Blipy[i].Label)
			EndTextCommandSetBlipName(blip)
		end
	end
	
	for i=1, #Config.Strefy, 1 do
		local blip = AddBlipForRadius(Config.Strefy[i].Pos, Config.Strefy[i].Radius)
		
		SetBlipHighDetail(blip, true)
		SetBlipColour(blip, Config.Strefy[i].Colour)
		SetBlipAlpha(blip, 150)
		SetBlipAsShortRange(blip, true)
	end
end)