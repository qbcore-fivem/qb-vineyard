local QBCore = exports['qb-core']:GetCoreObject({ 'Functions' })
local sharedItems = exports['qb-core']:GetShared('Items')

RegisterNetEvent('qb-vineyard:server:getGrapes', function()
    local Player = exports['qb-core']:GetPlayer(source)
    local amount = math.random(Config.GrapeAmount.min, Config.GrapeAmount.max)
    exports['qb-inventory']:AddItem(source, 'grape', amount, false, false, 'qb-vineyard:server:getGrapes')
    TriggerClientEvent('qb-inventory:client:ItemBox', source, sharedItems['grape'], 'add')
end)

QBCore.Functions.CreateCallback('qb-vineyard:server:loadIngredients', function(source, cb)
    local src = source
    local Player = exports['qb-core']:GetPlayer(src)
    local grape = Player.GetItemByName('grapejuice')
    if Player.PlayerData.items ~= nil then
        if grape ~= nil then
            if grape.amount >= 23 then
                exports['qb-inventory']:RemoveItem(src, 'grapejuice', 23, false, 'qb-vineyard:server:loadIngredients')
                TriggerClientEvent('qb-inventory:client:ItemBox', source, sharedItems['grapejuice'], 'remove')
                cb(true)
            else
                TriggerClientEvent('QBCore:Notify', source, Lang:t('error.invalid_items'), 'error')
                cb(false)
            end
        else
            TriggerClientEvent('QBCore:Notify', source, Lang:t('error.invalid_items'), 'error')
            cb(false)
        end
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.no_items'), 'error')
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-vineyard:server:grapeJuice', function(source, cb)
    local src = source
    local Player = exports['qb-core']:GetPlayer(src)
    local grape = Player.GetItemByName('grape')
    if Player.PlayerData.items ~= nil then
        if grape ~= nil then
            if grape.amount >= 16 then
                exports['qb-inventory']:RemoveItem(src, 'grape', 16, false, 'qb-vineyard:server:grapeJuice')
                TriggerClientEvent('qb-inventory:client:ItemBox', source, sharedItems['grape'], 'remove')
                cb(true)
            else
                TriggerClientEvent('QBCore:Notify', source, Lang:t('error.invalid_items'), 'error')
                cb(false)
            end
        else
            TriggerClientEvent('QBCore:Notify', source, Lang:t('error.invalid_items'), 'error')
            cb(false)
        end
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.no_items'), 'error')
        cb(false)
    end
end)

RegisterNetEvent('qb-vineyard:server:receiveWine', function()
    local Player = exports['qb-core']:GetPlayer(tonumber(source))
    local amount = math.random(Config.WineAmount.min, Config.WineAmount.max)
    exports['qb-inventory']:AddItem(source, 'wine', amount, false, false, 'qb-vineyard:server:receiveWine')
    TriggerClientEvent('qb-inventory:client:ItemBox', source, sharedItems['wine'], 'add')
end)

RegisterNetEvent('qb-vineyard:server:receiveGrapeJuice', function()
    local Player = exports['qb-core']:GetPlayer(tonumber(source))
    local amount = math.random(Config.GrapeJuiceAmount.min, Config.GrapeJuiceAmount.max)
    exports['qb-inventory']:AddItem(source, 'grapejuice', amount, false, false, 'qb-vineyard:server:receiveGrapeJuice')
    TriggerClientEvent('qb-inventory:client:ItemBox', source, sharedItems['grapejuice'], 'add')
end)
