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
        else
            SetVehicleLights(vehicle, 0)
            areLightsOn = false
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

RegisterCommand('lights', function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if DoesEntityExist(vehicle) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
        if IsControlPressed(0, 86) then -- Horn key
            TriggerEvent('daimler_advancedlights:startHornLights')
        else
            TriggerEvent('daimler_advancedlights:stopHornLights')
        end
    end
end, false)

RegisterKeyMapping('lights', 'Toggle headlights', 'keyboard', 'L')

-- Added: Handling of the horn key to toggle headlights
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if DoesEntityExist(vehicle) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
            if IsControlPressed(0, 86) then -- Horn key
                TriggerEvent('daimler_advancedlights:startHornLights')
            else
                TriggerEvent('daimler_advancedlights:stopHornLights')
            end
        end
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(500)
    print('Daimler_advancedlights - working')
end)