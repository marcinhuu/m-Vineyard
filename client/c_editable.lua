local QBCore = exports[Config.Core]:GetCoreObject()

CreateThread(function()
    
    exports[Config.Target]:AddBoxZone("StartingJob", Config.Peds[1], 1.0, 1.0, 
    { name="StartingJob", heading = 320, debugPoly = false, minZ = Config.Peds[1].z-2, maxZ = Config.Peds[1].z+2 }, 
    { options = { 
        { event = "m-Vineyard:Client:StartingJob", icon = "fa-solid fa-wine-bottle", label = Config.Language["StartJob"] },
        { event = "m-Vineyard:Client:TradeGrapes", icon = "fa-solid fa-hand-point-up", label = Config.Language["TradeGrapes"] },
    },  distance = 2.0 })

    exports[Config.Target]:AddBoxZone("MixingWine", vector3(-1859.41, 2069.61, 141.06), 3.1, 1.5, 
    { name="MixingWine", heading = 270, debugPoly = false, minZ = 139.26, maxZ = 141.26 }, 
    { options = { { event = "m-Vineyard:Client:TreadGrapes", icon = "fa-solid fa-wine-bottle", label = Config.Language["TreadGrapes"] }, },  distance = 2.0 })

    exports[Config.Target]:AddBoxZone("SellWine", Config.Peds[2], 1.0, 1.0, 
    { name="SellWine", heading = 320, debugPoly = false, minZ = Config.Peds[2].z-2, maxZ = Config.Peds[2].z+2 }, 
    { options = { { event = "m-Vineyard:Client:SellWine", icon = "fa-solid fa-wine-bottle", label = Config.Language["SellWine"] },  },  distance = 2.0 })

end)


function Notify(msg, type)
    if type == "primary" then 
        QBCore.Functions.Notify(msg, "primary")
    end
    if type == "success" then
        QBCore.Functions.Notify(msg, "success")
    end
    if type == "error" then
        QBCore.Functions.Notify(msg, "error")
    end
end

function Email()
    TriggerServerEvent("qs-smartphone:server:sendNewMail", {
        sender = Config.Language["Sender"],
        subject = Config.Language["Subject"],
        message = Config.Language["Message"],
    })
end

-- Email qb-phone:

--  TriggerServerEvent("qb-phone:server:sendNewMail", {
--        sender = Config.Language["Sender"],
--        subject = Config.Language["Subject"],
--        message = Config.Language["Message"],
--  })

-- Email gksphone:

--  TriggerServerEvent("gksphone:NewMail", {
--        sender = Config.Language["Sender"],
--        image = '/html/static/img/icons/mail.png',
--        subject = Config.Language["Subject"],
--        message = Config.Language["Message"],
--    })