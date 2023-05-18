ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
    while true do
        local attente=0
        local heading=0

        local playerPed=PlayerPedId()
        local playerCoords=GetEntityCoords(playerPed)

        local state,closestPed=GetClosestPed(playerCoords['x'], playerCoords['y'], playerCoords['z'],zbBicrave.zoneVente.radius,1,0,-1,0,0)
        local enVoiture=GetVehiclePedIsIn(playerPed, false)

        if enVoiture==0 then
            if closestPed==0 then
                attente=500
            else
                attente=0
    
                local closestPedCoords=GetEntityCoords(closestPed)
                local distance=GetDistanceBetweenCoords(playerCoords['x'], playerCoords['y'], playerCoords['z'],closestPedCoords["x"], closestPedCoords["y"], closestPedCoords["z"],false)
                if distance>zbBicrave.zoneVente.distanceVente then
                    DrawMarker(6, closestPedCoords["x"], closestPedCoords["y"], closestPedCoords["z"] + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.2, 0.2, 0.2, 255, 128, 0, 100, false, true, 2, nil, nil, false)
                else
                    DrawMarker(2, closestPedCoords["x"], closestPedCoords["y"], closestPedCoords["z"] + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.2, 0.2, 0.2, 255, 128, 0, 100, false, true, 2, nil, nil, false)
                    ESX.ShowHelpNotification("~g~[E]~w~ Vendre de la drogue")
                    if IsControlJustPressed(1, 86) then
                        heading=GetEntityHeading(GetPlayerPed(-1))+180
                        TriggerServerEvent("zbBicrave:peutVendre",heading,closestPed,playerPed)
                        Citizen.Wait(zbBicrave.tempsAnimation*1000+zbBicrave.zoneVente.cooldown*1000)
                    end
                end
            end
        else
            Citizen.Wait(1000)
        end
        Citizen.Wait(attente)
    end

end)

RegisterNetEvent('zbBicrave:clientVente')
AddEventHandler('zbBicrave:clientVente', function(peutVendre,heading,closestPed,playerPed)
    Citizen.CreateThread(function()
        if peutVendre then
            heading=GetEntityHeading(GetPlayerPed(-1))+180
            SetEntityHeading(closestPed,heading)
            FreezeEntityPosition(closestPed, true)
            TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_DRUG_DEALER_HARD", 0,true)
            TaskStartScenarioInPlace(closestPed, "WORLD_HUMAN_BUM_STANDING", 0,true)
            Citizen.Wait(zbBicrave.tempsAnimation*1000)
            TriggerServerEvent("zbBicrave:vente",closestPed)
            FreezeEntityPosition(closestPed, false)
            ClearPedTasksImmediately(playerPed)
            ClearPedTasksImmediately(closestPed)
            SetEntityAsMissionEntity(closestPed)
            RemovePedElegantly(closestPed)
        end
    end)
end)