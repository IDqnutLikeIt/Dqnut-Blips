RegisterNetEvent('Dqnut-Blips:server:GetPlayersForBlips', function()
    local src = source
    local Player = ESX.GetPlayerFromId(source)
    if Player.getGroup() == 'admin' or Player.getGroup() == 'owner' then
        TriggerClientEvent('Dqnut-Blips:client:Show', src, players)
    else
        print(src, 'Tried to enable blips with a trigger!')
    end
end)


RegisterCommand("toggleblips", function(source, args, rawCommand)
    local src = source
    local Player = ESX.GetPlayerFromId(source)
    if Player.getGroup() == 'admin' or Player.getGroup() == 'owner' then
        TriggerClientEvent('Dqnut-Blips:client:toggleBlips', src)
    else
        print(src, 'Tried to enable blips with a command!')
    end
end)

CreateThread(function()
    while true do
        local xPlayers = ESX.GetExtendedPlayers() -- Returns all xPlayers
        local tempPlayers = {}
        for _, xPlayer in pairs(xPlayers) do
            local targetped = GetPlayerPed(xPlayer.source)
            tempPlayers[#tempPlayers + 1] = {
                name = (xPlayer.getName() or '') .. ' | (' .. (GetPlayerName(xPlayer.source) or '') .. ')',
                id = xPlayer.source,
                coords = GetEntityCoords(targetped),
                job = xPlayer.job.name,
                sources = GetPlayerPed(xPlayer.source),
                sourceplayer = xPlayer.source

            }
        end
        table.sort(tempPlayers, function(a, b)
            return a.id < b.id
        end)
        players = tempPlayers
        Wait(1500)
    end
end)