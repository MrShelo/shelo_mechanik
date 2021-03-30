ESX = nil

local tyres = {0, 1, 2, 3, 4, 5, 45, 47}
local timer = 0.0
local menagmentBlip = vector3(-305.95, -120.82, 38.15)
local garageBlip = vector3(-370.91, -112.14, 37.88)
local szatniablip = vector3(-310.68, -136.68, 38.15)
local mechanicloc = vector3(733.9, -1089.04, 21.2)
local mechanicloc2 = vector3(543.21, -187.91, 53.6)
local heading = 0.0
local naprawaTrwa = false

local clothsMen = {shoes_1 = 27,shoes_2 = 0, pants_1 = 39, pants_2 = 0, tshirt_1 = 149, tshirt_2 = 0, helmet_1 = -1, helmet_2 = 0, torso_1 = 66, torso_2 = 0, arms_1 = 46, arms_2 = 0}
local clothsFem = {shoes_1 = 26,shoes_2 = 0, pants_1 = 39, pants_2 = 0, tshirt_1 = 185, tshirt_2 = 0, helmet_1 = -1, helmet_2 = 0, torso_1 = 60, torso_2 = 0,  arms_1 = 49, arms_2 = 0}


local cars = {  {label = ('Laweta'), value = 'flatbed'}, {label = ('Holownik'), value = 'towtruck'} }

local isJob = false
local jobsLoc = {vector3(-195.94, -1300.7, 30.7), vector3(-202.94, -1300.7, 30.7)}
local cel = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	local blip = AddBlipForCoord(menagmentBlip.x, menagmentBlip.y, menagmentBlip.z)
  SetBlipSprite(blip, 446)
  SetBlipDisplay(blip, 4)
  SetBlipScale(blip, 1.0)
  SetBlipColour(blip, 5)
  SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('LSC')
  EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(4)
		local playerPed = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)
		if GetDistanceBetweenCoords(coords, mechanicloc, true) < 20 then
    	timer = timer + 0.1
      DrawMarker(27, mechanicloc.x, mechanicloc.y, mechanicloc.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.5, 2.5, 1.0, 204, 50, 50, 100, false, true, 2, false, false, false, false)
      if GetDistanceBetweenCoords(coords,  mechanicloc,  true) < 2.5  then
        showText1('~INPUT_CONTEXT~ aby naprawić pojazd')
			end
      if GetDistanceBetweenCoords(coords,  mechanicloc,  true) < 2.5 and IsControlPressed(0, 38) and timer >= 5.0 then
				if not naprawaTrwa == true then
      	OpenLocalFixMenu()
      	timer = 0.0
				end
			end
		end
		if GetDistanceBetweenCoords(coords, mechanicloc2, true) < 20 then
    	timer = timer + 0.1
      DrawMarker(27, mechanicloc2.x, mechanicloc2.y, mechanicloc2.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.5, 2.5, 1.0, 204, 50, 50, 100, false, true, 2, false, false, false, false)
      if GetDistanceBetweenCoords(coords,  mechanicloc2,  true) < 2.5  then
        showText1('~INPUT_CONTEXT~ aby naprawić pojazd')
			end
      if GetDistanceBetweenCoords(coords,  mechanicloc2,  true) < 2.5 and IsControlPressed(0, 38) and timer >= 5.0 then
				if not naprawaTrwa == true then
      	OpenLocalFixMenu()
      	timer = 0.0
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(6)
		local playerPed = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)
		if IsControlJustReleased(0, 167) and ESX.GetPlayerData().job.name == 'mechanic' then
			OpenMechanicMenu()
		end
		if GetDistanceBetweenCoords(coords, menagmentBlip, true) < 20 and ESX.GetPlayerData().job.name == 'mechanic' then
    	timer = timer + 0.1
      PlayerData = ESX.GetPlayerData(GetPlayerPed(-1))
      DrawMarker(27, menagmentBlip.x, menagmentBlip.y, menagmentBlip.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 204, 50, 50, 100, false, true, 2, false, false, false, false)
      if GetDistanceBetweenCoords(coords,  menagmentBlip,  true) < 1.5 and ESX.GetPlayerData().job.name == 'mechanic' then
        showText1('~INPUT_CONTEXT~ aby zarządzać')
			end
      if GetDistanceBetweenCoords(coords,  menagmentBlip,  true) < 1.5 and ESX.GetPlayerData().job.name == 'mechanic' and IsControlPressed(0, 38) and timer >= 5.0 then
      	OpenMechanicMenagmentMenu()
      	timer = 0.0
			end
		end
		if GetDistanceBetweenCoords(coords, szatniablip, true) < 20 and ESX.GetPlayerData().job.name == 'mechanic' then
			timer = timer + 0.1
			PlayerData = ESX.GetPlayerData(GetPlayerPed(-1))
			DrawMarker(27, szatniablip.x, szatniablip.y, szatniablip.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 204, 50, 50, 100, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords,  szatniablip,  true) < 1.5 and ESX.GetPlayerData().job.name == 'mechanic' then
				showText1('~INPUT_CONTEXT~ aby przebrać się')
			end
			if GetDistanceBetweenCoords(coords,  szatniablip,  true) < 1.5 and ESX.GetPlayerData().job.name == 'mechanic' and IsControlPressed(0, 38) and timer >= 5.0 then
				OpenMechanicClothMenu()
				timer = 0.0
			end
		end
		if GetDistanceBetweenCoords(coords, garageBlip, true) < 20 and ESX.GetPlayerData().job.name == 'mechanic' then
    	timer = timer + 0.1
      PlayerData = ESX.GetPlayerData(GetPlayerPed(-1))
      DrawMarker(27, garageBlip.x, garageBlip.y, garageBlip.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 204, 50, 50, 100, false, true, 2, false, false, false, false)
      if GetDistanceBetweenCoords(coords,  garageBlip,  true) < 1.5 and ESX.GetPlayerData().job.name == 'mechanic' then
        showText1('~INPUT_CONTEXT~ aby otworzyć garaż')
			end
      if GetDistanceBetweenCoords(coords,  garageBlip,  true) < 1.5 and ESX.GetPlayerData().job.name == 'mechanic' and IsControlPressed(0, 38) and timer >= 5.0 then
      	OpenMechanicGarageMenu()
      	timer = 0.0
			end
		end
  end
end)



RegisterNetEvent('shelo_mechanik:fixCar')
AddEventHandler('shelo_mechanik:fixCar', function(type)
  local playerPed = GetPlayerPed(-1)
  local coords = GetEntityCoords(playerPed)
  local closestCar = ESX.Game.GetClosestVehicle(coords)
	local carCoords = GetEntityCoords(closestCar)
  if GetDistanceBetweenCoords(coords, carCoords) > 4.0 then
		TriggerEvent("pNotify:SendNotification", {text = "Nie ma pojazdu w pobliżu", type = "alert", timeout = 1400, layout = "centerLeft"})
  else
		if type == 'fix_engine' then
    	TriggerServerEvent('shelo_mechanik:fixed', type, closestCar)
			TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = 10000,
        label = "Naprawa Silnika",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }
    }, function(status)
        if not status then
            TriggerServerEvent('shelo_mechanik:fixE', closestCar, coords)
        end
    end)
		elseif type == 'fix_wheels' then
			TriggerServerEvent('shelo_mechanik:fixed', type, closestCar)

			TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = 10000,
        label = "Wymiana Opon",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }
    }, function(status)
        if not status then
            TriggerServerEvent('shelo_mechanik:fixT', closestCar, coords)
        end
    end)
		elseif type == 'fix_visual' then
			TriggerServerEvent('shelo_mechanik:fixed', type, closestCar)
			TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = 10000,
        label = "Naprawa Karoserii",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }
    }, function(status)
        if not status then
            TriggerServerEvent('shelo_mechanik:fixV', closestCar, coords)
        end
    end)
		end
  end
end)



RegisterNetEvent('shelo_mechanik:fixEngine')
AddEventHandler('shelo_mechanik:fixEngine', function(closestCar, c)
	local playerPed = GetPlayerPed(-1)
  local coords = GetEntityCoords(playerPed)
	if GetDistanceBetweenCoords(coords, c, true) > 3 then
		return
	end
	SetVehicleEngineHealth(closestCar, 1000.0)
	local playerPed = GetPlayerPed(-1)
	ClearPedTasksImmediately(playerPed)
end)

RegisterNetEvent('shelo_mechanik:fixTire')
AddEventHandler('shelo_mechanik:fixTire', function(closestCar, c)
	local playerPed = GetPlayerPed(-1)
  local coords = GetEntityCoords(playerPed)
	if GetDistanceBetweenCoords(coords, c, true) > 3 then
		return
	end
	for i, v in ipairs(tyres) do
		SetVehicleTyreFixed(closestCar, v)
	end
	local playerPed = GetPlayerPed(-1)
	ClearPedTasksImmediately(playerPed)
end)

RegisterNetEvent('shelo_mechanik:fixVisual')
AddEventHandler('shelo_mechanik:fixVisual', function(closestCar, c)
	local playerPed = GetPlayerPed(-1)
  local coords = GetEntityCoords(playerPed)
	if GetDistanceBetweenCoords(coords, c, true) > 3 then
		return
	end
	local tyresToBurst = {}
	local engineHealt = 0.0

	engineHealt = GetVehicleEngineHealth(closestCar)

	for i, v in ipairs(tyres) do
		if IsVehicleTyreBurst(closestCar, v) then
			table.insert(tyresToBurst, v)
		end
	end

	SetVehicleFixed(closestCar)

	for i, v in ipairs(tyresToBurst) do
		SetVehicleTyreBurst(closestCar, v, true, 1000.0)
	end

	SetVehicleEngineHealth(closestCar, engineHealt)
	local playerPed = GetPlayerPed(-1)
	ClearPedTasksImmediately(playerPed)
end)

RegisterNetEvent('shelo_mechanik:fixAnim')
AddEventHandler('shelo_mechanik:fixAnim', function()
	local playerPed = GetPlayerPed(-1)
	TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
end)

function OpenMechanicGarageMenu()
	local elements = {}

	for i, v in ipairs(cars) do
		table.insert(elements, v)
	end
	table.insert(elements, {label = ('Odstaw do garażu'),  value = 'delete'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_garage', {
		title    = ('Garaż'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'exit' then
			ESX.UI.Menu.CloseAll()
		elseif data.current.value == 'delete' then
				local closestVeh = ESX.Game.GetClosestVehicle(playerCoords)
				print(closestVeh)
				ESX.Game.DeleteVehicle(closestVeh)
		else
			ESX.Game.SpawnVehicle(data.current.value, garageBlip+2.5, heading, function(vehicle)
			end)
			ESX.UI.Menu.CloseAll()
		end
	end,function(data, menu)
		menu.close()
		end)
end


function OpenLocalFixMenu()
	local elements = {}

	table.insert(elements, {label = ('Naprawa Wizualna'),  value = 'visual'})
	table.insert(elements, {label = ('Naprawa Silnika'),  value = 'engine'})
	table.insert(elements, {label = ('Wymiana Opon'),  value = 'wheels'})
	table.insert(elements, {label = ('Wyjście'),  value = 'exit'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_garage', {
		title    = ('Naprawa Pojazdu'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'visual' then

			local playerPed = GetPlayerPed(-1)
			local coords = GetEntityCoords(playerPed)
			local closestCar = ESX.Game.GetClosestVehicle(coords)
			local carCoords = GetEntityCoords(closestCar)
			ESX.UI.Menu.CloseAll()
			if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
				naprawaTrwa = true
			ClearPedTasksImmediately(playerPed)

			TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = 10000,
        label = "Naprawa Karoserii",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }
    }, function(status)
        if not status then
            TriggerEvent('shelo_mechanik:fixVisual', closestCar, coords)
						TriggerServerEvent('shelo:buy_naprawa', data.current["value"])
						naprawaTrwa = false
        end
    end)
		else
			TriggerEvent("pNotify:SendNotification", {text = "Nie znajdujesz się w pojeździe", type = "alert", timeout = 1400, layout = "centerLeft"})
			naprawaTrwa = false
		end
	elseif data.current.value == 'engine' then

						local playerPed = GetPlayerPed(-1)
						local coords = GetEntityCoords(playerPed)
						local closestCar = ESX.Game.GetClosestVehicle(coords)
						local carCoords = GetEntityCoords(closestCar)
						ESX.UI.Menu.CloseAll()
						if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
						naprawaTrwa = true
						ClearPedTasksImmediately(playerPed)

						TriggerEvent("mythic_progbar:client:progress", {
			        name = "unique_action_name",
			        duration = 10000,
			        label = "Naprawa Engine",
			        useWhileDead = false,
			        canCancel = true,
			        controlDisables = {
			            disableMovement = true,
			            disableCarMovement = true,
			            disableMouse = false,
			            disableCombat = true,
			        }
			    }, function(status)
			        if not status then
			            TriggerEvent('shelo_mechanik:fixEngine', closestCar, coords)
									TriggerServerEvent('shelo:buy_naprawa', data.current["value"])
									naprawaTrwa = false
			        end
			    end)
					else
						TriggerEvent("pNotify:SendNotification", {text = "Nie znajdujesz się w pojeździe", type = "alert", timeout = 1400, layout = "centerLeft"})
						naprawaTrwa = false
					end
				elseif data.current.value == 'wheels' then

									local playerPed = GetPlayerPed(-1)
									local coords = GetEntityCoords(playerPed)
									local closestCar = ESX.Game.GetClosestVehicle(coords)
									local carCoords = GetEntityCoords(closestCar)
									ESX.UI.Menu.CloseAll()
									if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
										naprawaTrwa = true
									ClearPedTasksImmediately(playerPed)

									TriggerEvent("mythic_progbar:client:progress", {
						        name = "unique_action_name",
						        duration = 10000,
						        label = "Wymiana Opon",
						        useWhileDead = false,
						        canCancel = true,
						        controlDisables = {
						            disableMovement = true,
						            disableCarMovement = true,
						            disableMouse = false,
						            disableCombat = true,
						        }
						    }, function(status)
						        if not status then
						            TriggerEvent('shelo_mechanik:fixTire', closestCar, coords)
												TriggerServerEvent('shelo:buy_naprawa', data.current["value"])
												naprawaTrwa = false
						        end
						    end)
							else
								TriggerEvent("pNotify:SendNotification", {text = "Nie znajdujesz się w pojeździe", type = "alert", timeout = 1400, layout = "centerLeft"})
								naprawaTrwa = false
							end
		elseif data.current.value == 'exit' then
			ESX.UI.Menu.CloseAll()
		else
			Citizen.Wait(8000)
			ESX.UI.Menu.CloseAll()
		end
	end,function(data, menu)
		menu.close()
		end)
end

function OpenMechanicClothMenu()

	local elements = {
		{label = ('Ubranie robocze'),   value = 'wear_robocze'},
		{label = ('Ubranie cywilne'),      value = 'wear_cywilne'},
		{label = ('Ubrania zapisane'),       value = 'ubrania'},
		{label = ('Wyjdź'),  value = 'exit'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'mechanic_cloth',
		{
			title    = ('Menu Szatni'),
			align    = 'center',
			elements = elements
		},function(data, menu)

			local player, distance = ESX.Game.GetClosestPlayer()

			ESX.UI.Menu.CloseAll()
			if data.current.value == 'wear_robocze' then
				ESX.UI.Menu.CloseAll()
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skin, clothsMen)
					else
						TriggerEvent('skinchanger:loadClothes', skin, clothsFem)
					end
				end)
			elseif data.current.value == 'wear_cywilne' then
				ESX.UI.Menu.CloseAll()
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)

			elseif data.current.value == 'ubrania' then
				ESX.UI.Menu.CloseAll()
				OpenMechSzafka()
			elseif data.current.value == 'exit' then
				ESX.UI.Menu.CloseAll()
			end
	end,function(data, menu)
		menu.close()
		end)
end


function OpenMechanicMenagmentMenu()
	local elements = {
		{label = ('Wytwarzanie'),       value = 'craft'},
		{label = ('Boss menu'),  value = 'boss_menu'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_menagment', {
		title    = ('Zarządzanie'),
		align    = 'center-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'craft' then
			OpenCraftMenu()
		elseif data.current.value == 'boss_menu' then
			if ESX.GetPlayerData().job.grade_name ~= 'boss' then
				TriggerEvent("pNotify:SendNotification", {text = "Nie jesteś właścielem warsztatu", type = "alert", timeout = 1400, layout = "centerLeft"})
			end
			ESX.UI.Menu.CloseAll()
			TriggerEvent('esx_society:openBossMenu', 'mechanic', function(data, menu)
				menu.close()
			end)
		elseif data.current.value == 'exit' then
			ESX.UI.Menu.CloseAll()
		end
	end,function(data, menu)
		menu.close()
		end)
end


function OpenMechSzafka()
  local elements = {{label = ('Przebieralnia'), value = 'player_dressing'},
{label = ('Wyjdź'), value = 'exit'},}
  local playerPed = GetPlayerPed(-1)
ESX.UI.Menu.CloseAll()

ESX.UI.Menu.Open(
  'default', GetCurrentResourceName(), 'action_menu',
  {
    title    = ('Ubrania'),
    align    = 'center',
    elements = elements
  },function(data, menu)

    local player, distance = ESX.Game.GetClosestPlayer()

    ESX.UI.Menu.CloseAll()

    if data.current.value == 'player_dressing' then
			ESX.TriggerServerCallback('ambulance_szafka:getPlayerDressing', function(dressing)
			local elements = {}

		for i=1, #dressing, 1 do
			table.insert(elements, {
				label = dressing[i],
				value = i
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing', {
			title    = 'Ubrania gracza',
			align    = 'left',
			elements = elements
			}, function(data2, menu2)
				TriggerEvent('skinchanger:getSkin', function(skin)
					ESX.TriggerServerCallback('ambulance_szafka:getPlayerOutfit', function(clothes)
						TriggerEvent('skinchanger:loadClothes', skin, clothes)
						TriggerEvent('esx_skin:setLastSkin', skin)

						TriggerEvent('skinchanger:getSkin', function(skin)
						TriggerServerEvent('esx_skin:save', skin)
						end)
					end, data2.current.value)
				end)
			end, function(data2, menu2)
			menu2.close()
		end)
		end)
      ESX.UI.Menu.CloseAll()
    end

    if data.current.value == 'exit' then
      ESX.UI.Menu.CloseAll()
    end


end,function(data, menu)
  menu.close()
  end)
end

function OpenMechanicMenu(target)
  local elements = {}
		table.insert(elements, {label = ('Napraw silnik'), value = 'fix_engine'})
		table.insert(elements, {label = ('Wymień koła'), value = 'fix_wheels'})
		table.insert(elements, {label = ('Wyklep karoserię'), value = 'fix_visual'})
		table.insert(elements, {label = ('Odholuj'), value = 'holowanie'})
		table.insert(elements, {label = ('Laweta'), value = 'laweta'})
		table.insert(elements, {label = ('Umyj Pojazd'), value = 'clean_vehicle'})
		table.insert(elements, {label = ('Otwórz Pojazd'), value = 'hijack_vehicle'})
		table.insert(elements, {label = ('Remontuj Silnik'), value = "remont_engine"})
		ESX.UI.Menu.CloseAll()



	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'action_menu',
		{
			title    = ('Menu Zarządzania'),
			align    = 'center',
			elements = elements
		},function(data, menu)

		local player, distance = ESX.Game.GetClosestPlayer()


    if data.current.value == 'fix_engine' then
      TriggerServerEvent('shelo_mechanik:item_check', 'fix_engine')
			ESX.UI.Menu.CloseAll()
    elseif data.current.value == 'fix_wheels' then
      TriggerServerEvent('shelo_mechanik:item_check', 'fix_wheels')
			ESX.UI.Menu.CloseAll()
    elseif data.current.value == 'fix_visual' then
      TriggerServerEvent('shelo_mechanik:item_check', 'fix_visual')
			ESX.UI.Menu.CloseAll()
		elseif data.current.value == 'hijack_vehicle' then

		local playerPed = GetPlayerPed(-1)
		local vehicle   = ESX.Game.GetVehicleInDirection()
		local coords    = GetEntityCoords(playerPed)

		if IsPedSittingInAnyVehicle(playerPed) then
			return
		end

		if DoesEntityExist(vehicle) then
			IsBusy = true
			TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(10000)

				SetVehicleDoorsLocked(vehicle, 1)
				SetVehicleDoorsLockedForAllPlayers(vehicle, false)
				ClearPedTasksImmediately(playerPed)

				TriggerEvent("pNotify:SendNotification", {text = "Pojazd Odblokowany", type = "alert", timeout = 1400, layout = "centerLeft"})
				IsBusy = false
			end)
		else
			TriggerEvent("pNotify:SendNotification", {text = "Brak pojazdu w pobliżu", type = "alert", timeout = 1400, layout = "centerLeft"})
		end
 		elseif data.current.value == 'holowanie' then
			Holowanie()
			ESX.UI.Menu.CloseAll()

				elseif data.current.value == 'clean_vehicle' then

					local playerPed = GetPlayerPed(-1)
					local vehicle   = ESX.Game.GetVehicleInDirection()
					local coords    = GetEntityCoords(playerPed)

					if IsPedSittingInAnyVehicle(playerPed) then
						return
					end

					if DoesEntityExist(vehicle) then
						IsBusy = true
						TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_MAID_CLEAN", 0, true)
						Citizen.CreateThread(function()
							Citizen.Wait(10000)

							SetVehicleDirtLevel(vehicle, 0)
							ClearPedTasksImmediately(playerPed)

							TriggerEvent("pNotify:SendNotification", {text = "Pojazd Umyty", type = "alert", timeout = 1400, layout = "centerLeft"})
							IsBusy = false
						end)
					else
						TriggerEvent("pNotify:SendNotification", {text = "Brak pojazdu w pobliżu", type = "alert", timeout = 1400, layout = "centerLeft"})
					end
		elseif data.current.value == 'laweta' then
			ExecuteCommand('laweta')
		elseif data.current.value == 'remont_engine' then
			if IsPedInAnyVehicle(GetPlayerPed(-1), false)then
			TriggerEvent('remont:silnikoff')
			else
			TriggerEvent("pNotify:SendNotification", {text = "Musisz Znajdować się w pojeździe aby to zrobić", type = "alert", timeout = 1400, layout = "centerLeft"})
			end
		elseif data.current.value == 'exit' then
			ESX.UI.Menu.CloseAll()
		end
	end,function(data, menu)
		menu.close()
		end)
end

RegisterNetEvent('shelo:myjkaqb')
AddEventHandler('shelo:myjkaqb', function()

					local playerPed = GetPlayerPed(-1)
					local vehicle   = ESX.Game.GetVehicleInDirection()
					local coords    = GetEntityCoords(playerPed)

					if IsPedSittingInAnyVehicle(playerPed) then
						return
					end

					if DoesEntityExist(vehicle) then
						IsBusy = true
						TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_MAID_CLEAN", 0, true)
						Citizen.CreateThread(function()
							Citizen.Wait(10000)

							SetVehicleDirtLevel(vehicle, 0)
							ClearPedTasksImmediately(playerPed)

							TriggerEvent("pNotify:SendNotification", {text = "Pojazd Umyty", type = "alert", timeout = 1400, layout = "centerLeft"})
							IsBusy = false
						end)
					else
						TriggerEvent("pNotify:SendNotification", {text = "Brak pojazdu w pobliżu", type = "alert", timeout = 1400, layout = "centerLeft"})
					end
end)

RegisterNetEvent('shelo:fixengineqb')
AddEventHandler('shelo:fixengineqb', function()

		TriggerServerEvent('shelo_mechanik:item_check', 'fix_engine')


end)

RegisterNetEvent('shelo:fixvisqb')
AddEventHandler('shelo:fixvisqb', function()

		TriggerServerEvent('shelo_mechanik:item_check', 'fix_visual')


end)

RegisterNetEvent('shelo:fixwheelsqb')
AddEventHandler('shelo:fixwheelsqb', function()

		TriggerServerEvent('shelo_mechanik:item_check', 'fix_wheels')


end)

function OpenCraftMenu()
	local elements = {
		{label = ('Naprawka silnika'),   value = 'nap_engine'},
		{label = ('Zestaw opon'),      value = 'nap_wheels'},
		{label = ('Zestaw blacharski'),       value = 'nap_visual'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_crafting', {
		title    = ('Naprawki'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'nap_engine' then
			TriggerServerEvent('shelo_mechanik:item_buy', 'fix_engine')
		elseif data.current.value == 'nap_wheels' then
			TriggerServerEvent('shelo_mechanik:item_buy', 'fix_wheels')
		elseif data.current.value == 'nap_visual' then
			TriggerServerEvent('shelo_mechanik:item_buy', 'fix_visual')
		end
	end,function(data, menu)
		menu.close()
		end)
end

function Holowanie()
	local playerPed = GetPlayerPed(-1)
  local coords = GetEntityCoords(playerPed)
  local closestCar = ESX.Game.GetClosestVehicle(coords)
	local carCoords = GetEntityCoords(closestCar)
  if GetDistanceBetweenCoords(coords, carCoords) > 4.0 then
		TriggerEvent("pNotify:SendNotification", {text = "Nie ma pojazdu w pobliżu", type = "alert", timeout = 1400, layout = "centerLeft"})
  else
		TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
		--ExecuteCommand('e mechanic3')
		Citizen.Wait(10000)
		ESX.Game.DeleteVehicle(closestCar)
		ClearPedTasksImmediately(playerPed)
	end
end



function showText1(text)
    SetTextComponentFormat('STRING')
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
