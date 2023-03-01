local QBCore = exports['qb-core']:GetCoreObject()

lib.callback.register('skillsystem:fetchStatus', function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        local status = MySQL.scalar.await('SELECT skills FROM players WHERE citizenid = ?', {Player.PlayerData.citizenid})
        if status ~= nil then
            return json.decode(status)
        end
    end
end)

RegisterServerEvent('skillsystem:update', function (data)
    local Player = QBCore.Functions.GetPlayer(source)
    MySQL.query('UPDATE players SET skills = @skills WHERE citizenid = @citizenid', {
        ['@skills'] = data,
        ['@citizenid'] = Player.PlayerData.citizenid
    })
end)
