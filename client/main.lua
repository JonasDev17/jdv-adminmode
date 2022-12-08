local QBCore = exports['qb-core']:GetCoreObject()

IsInAdminMode = false

RegisterNetEvent('jdv-adminmode:client:toggle', function(rank)
    IsInAdminMode = not IsInAdminMode
    if IsInAdminMode then
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = true,
            args = {"Admin Mode", "You are now in admin mode"}
        })
        SetEntityInvincible(PlayerPedId(), true)
    else
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = true,
            args = {"Admin Mode", "You are no longer in admin mode"}
        })
    end
    ApplyOutfit(rank)
    TriggerServerEvent('jdv-adminmode:server:check')
end)

function ReloadSkin()
    local playerPed = PlayerPedId()
    local health = GetEntityHealth(playerPed)
    local model

    local gender = QBCore.Functions.GetPlayerData().charinfo.gender
    local maxhealth = GetEntityMaxHealth(PlayerPedId())

    if gender == 1 then -- Gender is ONE for FEMALE
        model = GetHashKey("mp_f_freemode_01") -- Female Model
    else
        model = GetHashKey("mp_m_freemode_01") -- Male Model
    end

    RequestModel(model)

    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)
    Citizen.Wait(1000) -- Safety Delay

    TriggerServerEvent("qb-clothes:loadPlayerSkin") -- LOADING PLAYER'S CLOTHES
    TriggerServerEvent("qb-clothing:loadPlayerSkin") -- LOADING PLAYER'S CLOTHES - Event 2

    SetPedMaxHealth(PlayerId(), maxhealth)
    Citizen.Wait(1000) -- Safety Delay
    SetEntityHealth(PlayerPedId(), health)
end

function ApplyOutfit(rank)
    if not IsInAdminMode then
        ReloadSkin()
        return
    end
    local PlayerData = QBCore.Functions.GetPlayerData()
    -- get gender
    local gender = "male"
    if PlayerData.charinfo.gender == 1 then
        gender = "female"
    end
    local outfitData = Config.Outfits[gender][Config.PermissionHirarchy[rank or 1]]
    -- get current outfit

    -- apply outfitData
    TriggerEvent('qb-clothing:client:loadOutfit', outfitData)
end