local QBCore = exports['qb-core']:GetCoreObject({ 'Functions' })
local sharedItems = exports['qb-core']:GetShared('Items')
local grapePickupState = {}
local wineRewardState = {}
local grapeJuiceRewardState = {}
local grapePickupMaxDistance = 5.0

local grapeLocations = {
    vector3(-1875.41, 2100.37, 138.86),
    vector3(-1908.69, 2107.48, 131.31),
    vector3(-1866.04, 2112.64, 134.41),
    vector3(-1907.76, 2125.35, 124.03),
    vector3(-1850.31, 2142.95, 122.30),
    vector3(-1888.22, 2164.51, 114.81),
    vector3(-1835.52, 2180.59, 104.88),
    vector3(-1891.98, 2208.35, 94.56),
    vector3(-1720.37, 2182.03, 106.18),
    vector3(-1808.52, 2173.14, 107.63),
    vector3(-1784.22, 2222.80, 92.86),
    vector3(-1889.13, 2250.05, 79.63),
    vector3(-1861.16, 2254.32, 81.04),
    vector3(-1886.75, 2272.45, 70.81),
    vector3(-1845.49, 2274.63, 73.33),
    vector3(-1687.28, 2195.76, 97.87),
    vector3(-1741.18, 2173.22, 114.39),
    vector3(-1743.17, 2141.11, 121.18),
    vector3(-1813.84, 2089.57, 134.21),
    vector3(-1698.71, 2150.65, 110.41),
}

local function playerHasVineyardJob(Player)
    return Player and Player.PlayerData and Player.PlayerData.job and Player.PlayerData.job.name == 'vineyard'
end

local function playerIsNearGrapeLocation(src)
    local ped = GetPlayerPed(src)
    if ped == 0 then
        return false
    end

    local playerCoords = GetEntityCoords(ped)
    for i = 1, #grapeLocations do
        if #(playerCoords - grapeLocations[i]) <= grapePickupMaxDistance then
            return true
        end
    end
    return false
end

RegisterNetEvent('qb-vineyard:server:getGrapes', function()
    local src = source
    local Player = exports['qb-core']:GetPlayer(src)
    if not playerHasVineyardJob(Player) then
        return
    end
    if not playerIsNearGrapeLocation(src) then
        return
    end

    local now = GetGameTimer()
    local lastPickup = grapePickupState[src] or 0
    if now - lastPickup < 3000 then
        return
    end
    grapePickupState[src] = now

    local amount = math.random(Config.GrapeAmount.min, Config.GrapeAmount.max)
    exports['qb-inventory']:AddItem(src, 'grape', amount, false, false, 'qb-vineyard:server:getGrapes')
    TriggerClientEvent('qb-inventory:client:ItemBox', src, sharedItems['grape'], 'add')
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
                wineRewardState[src] = true
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
                grapeJuiceRewardState[src] = true
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
    local src = source
    local Player = exports['qb-core']:GetPlayer(src)
    if not playerHasVineyardJob(Player) then
        return
    end
    if not wineRewardState[src] then
        return
    end
    wineRewardState[src] = nil

    local amount = math.random(Config.WineAmount.min, Config.WineAmount.max)
    exports['qb-inventory']:AddItem(src, 'wine', amount, false, false, 'qb-vineyard:server:receiveWine')
    TriggerClientEvent('qb-inventory:client:ItemBox', src, sharedItems['wine'], 'add')
end)

RegisterNetEvent('qb-vineyard:server:receiveGrapeJuice', function()
    local src = source
    local Player = exports['qb-core']:GetPlayer(src)
    if not playerHasVineyardJob(Player) then
        return
    end
    if not grapeJuiceRewardState[src] then
        return
    end
    grapeJuiceRewardState[src] = nil

    local amount = math.random(Config.GrapeJuiceAmount.min, Config.GrapeJuiceAmount.max)
    exports['qb-inventory']:AddItem(src, 'grapejuice', amount, false, false, 'qb-vineyard:server:receiveGrapeJuice')
    TriggerClientEvent('qb-inventory:client:ItemBox', src, sharedItems['grapejuice'], 'add')
end)

AddEventHandler('playerDropped', function()
    local src = source
    grapePickupState[src] = nil
    wineRewardState[src] = nil
    grapeJuiceRewardState[src] = nil
end)

RegisterNetEvent('qb-vineyard:server:sellItems', function()
    local src = source
    local Player = exports['qb-core']:GetPlayer(src)
    if not Player then return end
    if not Config.Sell or not Config.Sell.enabled then return end

    local total = 0
    local soldAny = false
    for itemName, price in pairs(Config.Sell.prices or {}) do
        local item = Player.GetItemByName(itemName)
        if item and item.amount and item.amount > 0 then
            exports['qb-inventory']:RemoveItem(src, itemName, item.amount, false, 'qb-vineyard:server:sellItems')
            TriggerClientEvent('qb-inventory:client:ItemBox', src, sharedItems[itemName], 'remove')
            total = total + (item.amount * price)
            soldAny = true
        end
    end

    if not soldAny then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_items'), 'error')
        return
    end

    Player.Functions.AddMoney('cash', total, 'qb-vineyard:sellItems')
    TriggerClientEvent('QBCore:Notify', src, ('Sold goods for $%s'):format(total), 'success')
end)
