ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('zbBicrave:vente')
AddEventHandler('zbBicrave:vente', function()
    local nombre=0
    local argent=0

    local _src=source
    local xPlayer = ESX.GetPlayerFromId(_src)

    local weed = xPlayer.getInventoryItem(zbBicrave.nomVente.weed).count
    local meth = xPlayer.getInventoryItem(zbBicrave.nomVente.meth).count
    local cocaine = xPlayer.getInventoryItem(zbBicrave.nomVente.coke).count

    if weed~=0 then
        nombre=math.random(zbBicrave.nombreVente.minimum,zbBicrave.nombreVente.maximum)
        argent=zbBicrave.prixVente.weed*nombre

        xPlayer.removeInventoryItem(zbBicrave.nomVente.weed, nombre)
        xPlayer.addAccountMoney('black_money', argent)

        TriggerClientEvent('esx:showNotification', source, "Tiens prend les ~g~"..argent.."€")
    elseif meth~=0 then
        nombre=math.random(zbBicrave.nombreVente.minimum,zbBicrave.nombreVente.maximum)
        argent=zbBicrave.prixVente.meth*nombre

        xPlayer.removeInventoryItem(zbBicrave.nomVente.meth, nombre)
        xPlayer.addAccountMoney('black_money', argent)

        TriggerClientEvent('esx:showNotification', source, "Tiens prend les ~g~"..argent.."€")
    elseif cocaine~=0 then
        nombre=math.random(zbBicrave.nombreVente.minimum,zbBicrave.nombreVente.maximum)
        argent=zbBicrave.prixVente.cocaine*nombre

        xPlayer.removeInventoryItem(zbBicrave.nomVente.coke, nombre)
        xPlayer.addAccountMoney('black_money', argent)

        TriggerClientEvent('esx:showNotification', source, "Tiens prend les ~g~"..argent.."€")
    end

end)

RegisterServerEvent('zbBicrave:peutVendre')
AddEventHandler('zbBicrave:peutVendre', function(heading,closestPed,playerPed)
	local xPlayer = ESX.GetPlayerFromId(source)

    local weed = xPlayer.getInventoryItem(zbBicrave.nomVente.weed).count
    local meth = xPlayer.getInventoryItem(zbBicrave.nomVente.meth).count
    local cocaine = xPlayer.getInventoryItem(zbBicrave.nomVente.coke).count

    if weed~=0 or meth~=0 or cocaine~=0 then
        TriggerClientEvent("zbBicrave:clientVente",source,true,heading,closestPed,playerPed)
    else
        TriggerClientEvent('esx:showNotification', source, "T'as rien à me vendre")
    end
end)