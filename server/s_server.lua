local QBCore = exports[Config.Core]:GetCoreObject()


CreateThread(function()

    QBCore.Functions.CreateUseableItem('basket', function(source, item) TriggerClientEvent("m-Vineyard:Client:ColherUvas", source ) end)

    QBCore.Functions.CreateUseableItem('redwine', function(source, item) TriggerClientEvent("m-Vineyard:Client:DrinkRedWine", source ) end)

    QBCore.Functions.CreateUseableItem('rosewine', function(source, item) TriggerClientEvent("m-Vineyard:Client:DrinkRoseWine", source ) end)

end)

RegisterNetEvent('m-Vineyard:Server:RemoveItem', function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        Player.Functions.RemoveItem(item, amount)
    end
end)

RegisterNetEvent('m-Vineyard:Server:AddItem', function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        Player.Functions.AddItem(item, amount)
    end
end)

QBCore.Functions.CreateCallback('m-Vineyard:Server:HaveGrape', function(source, cb)
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName("grape") and Player.Functions.GetItemByName("grape").amount >= 1 then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('m-Vineyard:Server:HaveGrapeHull', function(source, cb, montante)
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName("grapehull") then
        local montante = Player.Functions.GetItemByName("grapehull").amount
        if montante >= 1 then
            cb(true, montante)
            Player.Functions.RemoveItem("grapehull", montante)
        end
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('m-Vineyard:Server:HaveWine', function(source, cb)
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName("redwine") then
        local montante = Player.Functions.GetItemByName("redwine").amount
        if montante >= 1 then
            cb(true)
        end
    elseif Player.Functions.GetItemByName("rosewine") then
        local montante = Player.Functions.GetItemByName("rosewine").amount
        if montante >= 1 then
            cb(true)
        end
    else
        cb(false)
    end
end)

local items = {"redwine", "rosewine"}

RegisterNetEvent('m-Vineyard:Server:SellWine')
AddEventHandler('m-Vineyard:Server:SellWine', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local payment = math.random(Config.Payment.Amount.min, Config.Payment.Amount.max)

    if Player then
        if Player.Functions.GetItemByName("redwine") then
            amount = Player.Functions.GetItemByName("redwine").amount
            Player.Functions.AddMoney(Config.Payment.Type, amount * payment)
            Player.Functions.RemoveItem("redwine", amount)
            TriggerClientEvent('m-Vineyard:Client:Notify', src, "+" .. amount * payment ..Config.Language["Currency"], 'success', 5000)
        elseif Player.Functions.GetItemByName("rosewine") then
            amount = Player.Functions.GetItemByName("rosewine").amount
            Player.Functions.AddMoney(Config.Payment.Type, amount * payment)
            Player.Functions.RemoveItem("rosewine", amount)
            TriggerClientEvent('m-Vineyard:Client:Notify', src, "+" .. amount * payment ..Config.Language["Currency"], 'success', 5000)
        end
    end
end)
