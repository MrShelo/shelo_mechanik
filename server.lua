ESX = nil

local koszt1 = 200
local koszt2 = 150
local koszt3 = 75

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_society:registerSociety', 'mechanic', 'mechanic', 'society_mechanic', 'society_mechanic', 'society_mechanic', {type = 'private'})





RegisterNetEvent('shelo:buy_naprawa')
AddEventHandler('shelo:buy_naprawa', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if data == "visual" then
      xPlayer.removeAccountMoney("bank", koszt1)
      pNotify('Zapłacono kartą za naprawę: <span style="color: green">$' .. koszt1 .. '</span>', 'success', 2000)
    elseif data == "engine" then
      xPlayer.removeAccountMoney("bank", koszt2)
      pNotify('Zapłacono kartą za naprawę: <span style="color: green">$' .. koszt2 .. '</span>', 'success', 2000)
    elseif data == "wheels" then
      xPlayer.removeAccountMoney("bank", koszt2)
      pNotify('Zapłacono kartą za naprawę: <span style="color: green">$' .. koszt2 .. '</span>', 'success', 2000)
    end
end)






RegisterServerEvent('shelo_mechanik:item_check')
AddEventHandler('shelo_mechanik:item_check', function(itenName)
  local xPlayer = ESX.GetPlayerFromId(source)
  local itemCount = xPlayer.getInventoryItem(itenName).count

  if itemCount > 0 then
    TriggerClientEvent('shelo_mechanik:fixCar', source, itenName)
  else
    pNotify('<span style="color: red">Nie masz przedmiotu wymaganego do naprawy</span>', 'success', 2000)  
  end
end)

RegisterServerEvent('shelo_mechanik:item_buy')
AddEventHandler('shelo_mechanik:item_buy', function(itemName)
  local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(itemName, 1)
end)

RegisterServerEvent('shelo_mechanik:fixed')
AddEventHandler('shelo_mechanik:fixed', function(item)
  local xPlayer = ESX.GetPlayerFromId(source)
  xPlayer.removeInventoryItem(item, 1)
  TriggerClientEvent('shelo_mechanik:fixAnim', source)
end)

RegisterServerEvent('shelo_mechanik:mess')
AddEventHandler('shelo_mechanik:mess', function(mess)
  TriggerClientEvent('esx:showNotification', source, mess)
end)

RegisterServerEvent('shelo_mechanik:fixE')
AddEventHandler('shelo_mechanik:fixE', function(car, c)
  TriggerClientEvent('shelo_mechanik:fixEngine', -1, car, c)
end)

RegisterServerEvent('shelo_mechanik:fixT')
AddEventHandler('shelo_mechanik:fixT', function(car, c)
  TriggerClientEvent('shelo_mechanik:fixTire', -1, car, c)
end)

RegisterServerEvent('shelo_mechanik:fixV')
AddEventHandler('shelo_mechanik:fixV', function(car, c)
  TriggerClientEvent('shelo_mechanik:fixVisual', -1, car, c)
end)



pNotify = function(message, messageType, messageTimeout)
	TriggerClientEvent("pNotify:SendNotification", source, {
		text = message,
		type = messageType,
		queue = "shop_sv",
		timeout = messageTimeout,
		layout = "centerRight"
	})
end
