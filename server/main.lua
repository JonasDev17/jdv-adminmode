local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('jdv-adminmode:server:check', function()
    local src = source
    if not QBCore.Functions.HasPermission(src, Config.PermissionMinLevel) then
        exports['qb-core']:ExploitBan(src, "jdv-adminmode")
    end
end)

QBCore.Commands.Add('adminmode', 'Toggle adminmode', {}, false, function(source, args)
    local rank = nil
    for k, v in pairs(Config.PermissionHirarchy) do
        if QBCore.Functions.HasPermission(source, v) then
            rank = tonumber(k)
        end
    end
    TriggerClientEvent('jdv-adminmode:client:toggle', source, rank or 1)
end, Config.PermissionMinLevel)