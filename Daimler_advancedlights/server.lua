------------------------
-- DAIMLER | SERVER
------------------------

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local areLightsOn = false

RegisterNetEvent('daimler_advancedlights:toggleLights')
AddEventHandler('daimler_advancedlights:toggleLights', function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if DoesEntityExist(vehicle) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
        if not areLightsOn then
            SetVehicleLights(vehicle, 2)
            areLightsOn = true
            print('Dálková světla byla zapnuta.')
        else
            SetVehicleLights(vehicle, 0)
            areLightsOn = false
            print('Dálková světla byla vypnuta.')
        end
    end
end)

RegisterNetEvent('daimler_advancedlights:startHornLights')
AddEventHandler('daimler_advancedlights:startHornLights', function()
    if not areLightsOn then
        TriggerEvent('daimler_advancedlights:toggleLights')
    end
end)

RegisterNetEvent('daimler_advancedlights:stopHornLights')
AddEventHandler('daimler_advancedlights:stopHornLights', function()
    if areLightsOn then
        TriggerEvent('daimler_advancedlights:toggleLights')
    end
end)

RegisterCommand('svit', function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if DoesEntityExist(vehicle) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
        if IsControlPressed(0, 86) then -- Klakson (HORN)
            TriggerEvent('daimler_advancedlights:startHornLights')
        else
            TriggerEvent('daimler_advancedlights:stopHornLights')
        end
    end
end, false)

RegisterKeyMapping('svit', 'Zapnout/vypnout dálková světla', 'keyboard', 'L')

-- Přidáno: Obsluha tlačítka klaksonu (HORN) pro zapnutí a vypnutí dálkových světel
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if DoesEntityExist(vehicle) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
            if IsControlPressed(0, 86) then -- Klakson (HORN)
                TriggerEvent('daimler_advancedlights:startHornLights')
            else
                TriggerEvent('daimler_advancedlights:stopHornLights')
            end
        end
    end
end)


