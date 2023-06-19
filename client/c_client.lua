local QBCore = exports[Config.Core]:GetCoreObject()

local peds = Config.Peds 

-- Peds
CreateThread(function()
    for _, item in pairs(peds) do
        RequestModel(item.hash)
        while not HasModelLoaded(item.hash) do Wait(1) end
        peds =  CreatePed(item.type, item.hash, item.x, item.y, item.z, item.a, false, true)
        SetBlockingOfNonTemporaryEvents(peds, true)
        SetPedDiesWhenInjured(peds, false)
        SetEntityHeading(peds, item.h)
        SetPedCanPlayAmbientAnims(peds, true)
        SetPedCanRagdollFromPlayerImpact(peds, false)
        SetEntityInvincible(peds, true)
        FreezeEntityPosition(peds, true)
    end
end)

CreateThread(function()
    for k, v in pairs(Config.Blips) do
        if v.Enable then
            local blip = AddBlipForCoord(v.Location) 
            SetBlipSprite(blip, v.Sprite) 
            SetBlipDisplay(blip, v.Display)
            SetBlipScale(blip, v.Scale)
            SetBlipAsShortRange(blip, true)
            SetBlipColour(blip, v.Colour)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(v.Name) 
            EndTextCommandSetBlipName(blip)
        end
    end
end)

RegisterNetEvent('m-Vineyard:Client:Notify')
AddEventHandler("m-Vineyard:Client:Notify", function(msg,type)
    Notify(msg,type)
end)

RegisterNetEvent("m-Vineyard:Client:StartingJob", function()
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar('ReceiveToolBox', Config.Language["TakeJob"], Config.Times.TakeJob, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        Notify(Config.Language["Duty"], 'success', 5000)
        TriggerServerEvent("m-Vineyard:Server:AddItem", "basket", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["basket"], "add", 1)
        ClearPedTasks(ped)
    end, function() -- Cancel
        ClearPedTasks(ped)
        Notify(Config.Language["Canceled"], 'error', 5000)
    end)
end)


local Zones = {}
local inCollectZone = false

CreateThread(function() 
    for k=1, #Config.Zones do
        Zones[k] = PolyZone:Create(Config.Zones[k].zones, {
            debugPoly = false,
        })
        Zones[k]:onPlayerInOut(function(isPointInside)
            if isPointInside then
                inCollectZone = true
                if Config.Debug then print("[DEBUG] | inCollectZone = true") end
                Notify(Config.Language["EnterZone"], 'success', 5000)
            else
                inCollectZone = false
                if Config.Debug then print("[DEBUG] | inCollectZone = false") end
            end
        end)
    end
end)


RegisterNetEvent("m-Vineyard:Client:ColherUvas", function()
    local ped = PlayerPedId()
    if inCollectZone then
        exports['ps-ui']:Circle(function(success)
            if success then
                TriggerEvent('animations:client:EmoteCommandStart', {"beast"})
                QBCore.Functions.Progressbar('ReceiveToolBox', Config.Language["PickUp"], Config.Times.Pickup, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function()
                    Notify(Config.Language["PickUpSuccess"], 'success', 5000)
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    local drop = math.random(Config.Drops.pickup.min,Config.Drops.pickup.max)
                    TriggerServerEvent("m-Vineyard:Server:AddItem", "grape", drop)
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["grape"], "add", drop)
                    if Config.Debug then print("[DEBUG] | Player pickup: x"..drop.." Grape") end
                end, function() -- Cancel
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    Notify(Config.Language["Canceled"], 'error', 5000)
                end)
            else
                Notify(Config.Language["Failed"], 'error', 5000)
            end
        end, Config.Minigame.NumberOfCircles, Config.Minigame.MS) -- NumberOfCircles, MS
    end
end)

RegisterNetEvent("m-Vineyard:Client:TreadGrapes", function()
    local ped = PlayerPedId()
    QBCore.Functions.TriggerCallback('m-Vineyard:Server:HaveGrape', function(cb)
        if cb then
            exports['ps-ui']:Circle(function(success)
                if success then
                    TriggerEvent('animations:client:EmoteCommandStart', {"jog"})
                    TriggerServerEvent("m-Vineyard:Server:RemoveItem", "grape", 1)
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["grape"], "remove", 1)
                    QBCore.Functions.Progressbar('ReceiveToolBox', Config.Language["Crushing"], Config.Times.Crushing, false, false, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {}, {}, {}, function()
                        Notify(Config.Language["CrushingSuccess"], 'success', 5000)
                        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                        local drop = math.random(Config.Drops.tread.min,Config.Drops.tread.max)
                        TriggerServerEvent("m-Vineyard:Server:AddItem", "grapehull", drop)
                        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["grapehull"], "add", drop)
                        if Config.Debug then print("[DEBUG] | Player Tread Grapes: x"..drop.." Grape Hull") end
                    end, function() -- Cancel
                        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                        Notify(Config.Language["Canceled"], 'error', 5000)
                    end)
                else
                    Notify(Config.Language["Failed"], 'error', 5000)
                end
            end, Config.Minigame.NumberOfCircles, Config.Minigame.MS) -- NumberOfCircles, MS
        else
            Notify(Config.Language["NoGrape"], 'error', 5000)
        end
    end)
end)

RegisterNetEvent("m-Vineyard:Client:TradeGrapes", function()
    local ped = PlayerPedId()
    QBCore.Functions.TriggerCallback('m-Vineyard:Server:HaveGrapeHull', function(cb, montante)
        if cb then
            TriggerEvent('animations:client:EmoteCommandStart', {"box"})
            QBCore.Functions.Progressbar('ReceiveToolBox', Config.Language["Trading"], Config.Times.Trading, false, false, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function()
                Notify(Config.Language["TradingSuccess"], 'success', 5000)
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                local drop = math.random(Config.Drops.trade.min,Config.Drops.trade.max) * montante
                local prob = math.random(1,10)
                if prob >= 5 then
                    TriggerServerEvent("m-Vineyard:Server:AddItem", "redwine", drop)
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["redwine"], "add", drop)
                    if Config.Debug then print("[DEBUG] | Player Trade Grapes and receive: x"..drop.." Red Wine") end
                else
                    TriggerServerEvent("m-Vineyard:Server:AddItem", "rosewine", drop)
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["rosewine"], "add", drop)
                    if Config.Debug then print("[DEBUG] | Player Trade Grapesand receive: x"..drop.." Green Wine") end
                end
                Citizen.Wait(2500)
                Notify(Config.Language["TradingInfo"], 'primary', 5000)
                Email()
                Citizen.Wait(2500)
                SetNewWaypoint(Config.Selling)
            end, function() -- Cancel
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                Notify(Config.Language["Canceled"], 'error', 5000)
            end)
        else
            Notify(Config.Language["NoGrapehull"], 'error', 5000)
        end
    end)
end)

RegisterNetEvent("m-Vineyard:Client:SellWine", function()
    local ped = PlayerPedId()
    QBCore.Functions.TriggerCallback('m-Vineyard:Server:HaveWine', function(cb)
        if cb then
            TriggerEvent('animations:client:EmoteCommandStart', {"box"})
            QBCore.Functions.Progressbar('ReceiveToolBox', Config.Language["Selling"], Config.Times.Selling, false, false, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function()
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                TriggerServerEvent("m-Vineyard:Server:SellWine")
            end, function() -- Cancel
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                Notify(Config.Language["Canceled"], 'error', 5000)
            end)
        else
            Notify(Config.Language["NoWine"], 'error', 5000)
        end
    end)
end)

RegisterNetEvent("m-Vineyard:Client:DrinkRedWine", function()
    local playerPed = PlayerPedId()
    local maxHealth = GetEntityMaxHealth(playerPed)
    TriggerEvent('animations:client:EmoteCommandStart', {"wine"})  
    TriggerServerEvent("m-Vineyard:Server:RemoveItem", "redwine", 1)
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["redwine"], "remove", 1)
    QBCore.Functions.Progressbar('ReceiveToolBox', Config.Language["Drinking"], Config.Times.Drinking, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})  
        SetTimecycleModifier(Config.Drinks.Timecycle)

        if Config.Drinks.MotionBlur then
            SetPedMotionBlur(playerPed, true)
        end

        SetPedMovementClipset(playerPed, "move_m@hurry_butch@a", true)

        if Config.Drinks.Amour then
            AddArmourToPed(playerPed, Config.Drinks.ArmourAmount)
        end

        if Config.Drinks.Thirst.Enable then
            TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + Config.Drinks.Thirst.Amount)
        end

        if Config.Drinks.Health then
            local health = GetEntityHealth(playerPed)
            local newHealth = math.min(maxHealth , math.floor(health + maxHealth/6))
            SetEntityHealth(playerPed, newHealth)
            Citizen.Wait(Config.Drinks.Time)
        end

        if Config.Drinks.Stress then
             TriggerServerEvent(Config.Drinks.Stress.Event, math.random(Config.Drinks.Stress.Amount.Min, Config.Drinks.Stress.Amount.Max))
        end

        Normal()
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        Notify(Config.Language["Canceled"], 'error', 5000)
    end)
end)

RegisterNetEvent("m-Vineyard:Client:DrinkRoseWine", function()
    local playerPed = PlayerPedId()
    local maxHealth = GetEntityMaxHealth(playerPed)
    TriggerEvent('animations:client:EmoteCommandStart', {"wine"})  
    TriggerServerEvent("m-Vineyard:Server:RemoveItem", "rosewine", 1)
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["rosewine"], "remove", 1)
    QBCore.Functions.Progressbar('ReceiveToolBox', Config.Language["Drinking"], Config.Times.Drinking, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})  
        SetTimecycleModifier(Config.Drinks.Timecycle)

        if Config.Drinks.MotionBlur then
            SetPedMotionBlur(playerPed, true)
        end

        SetPedMovementClipset(playerPed, "move_m@hurry_butch@a", true)

        if Config.Drinks.Amour then
            AddArmourToPed(playerPed, Config.Drinks.ArmourAmount)
        end

        if Config.Drinks.Thirst.Enable then
            TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + Config.Drinks.Thirst.Amount)
        end

        if Config.Drinks.Health then
            local health = GetEntityHealth(playerPed)
            local newHealth = math.min(maxHealth , math.floor(health + maxHealth/6))
            SetEntityHealth(playerPed, newHealth)
            Citizen.Wait(Config.Drinks.Time)
        end

        if Config.Drinks.Stress then
             TriggerServerEvent(Config.Drinks.Stress.Event, math.random(Config.Drinks.Stress.Amount.Min, Config.Drinks.Stress.Amount.Max))
        end

        Normal()
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        Notify(Config.Language["Canceled"], 'error', 5000)
    end)
end)

function Normal()
    Citizen.CreateThread(function()
        local playerPed = PlayerId()
        ClearTimecycleModifier()
        ResetScenarioTypesEnabled()
        SetPedMotionBlur(playerPed, false)
    end)
end