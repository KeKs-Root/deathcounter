ESX = nil
TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

RegisterServerEvent("playerDied")
AddEventHandler("playerDied", function(killer, reason)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT deathcounter FROM users WHERE identifier = @identifier", {
        ['@identifier'] = xPlayer.getIdentifier()
    }, function(result)
        if #result > 0 then
            local counter = result[1].deathcounter + 1

            MySQL.Async.execute("UPDATE users SET `deathcounter` = @deathcounter WHERE identifier = @identifier", {
                ['@deathcounter'] = counter,
                ['@identifier'] = xPlayer.getIdentifier()
            })
            if counter > Config.MaxDeaths then
                if Config.Kick then
                    xPlayer.kick(Config.KickMessage)
                end
                if Config.Notify then
                    sendToDiscord(Config.DiscordTitle, Config.DiscordDesc, 3752795,
                        xPlayer.getName(), xPlayer.getIdentifier())
                end
            end
        end
    end)
end)

function sendToDiscord(title, message, color, user, identifier)
    local embed = {{
        ["author"] = {
            ["name"] = user,
            ["icon_url"] = "https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg"
        },
        ["color"] = color,
        ["title"] = "**" .. title .. "**",
        ["description"] = message .. "\n\nIdentifier: " .. identifier,
        ["footer"] = {
            ["text"] = "Developed by Iso#4506 & 👑Marco#0001",
        }
    }}

    PerformHttpRequest(Config.Webhook, function(err, text, headers)
    end, 'POST', json.encode({
        embeds = embed
    }), {
        ['Content-Type'] = 'application/json'
    })
end

RegisterCommand("resetdeaths", function(source, args)
    
    local xsourcePlayer = ESX.GetPlayerFromId(source)
    if args[1] then
        local xtargetPlayer = ESX.GetPlayerFromId(tonumber(args[1]))
        MySQL.Async.execute("UPDATE users SET `deathcounter` = 0 WHERE identifier = @identifier", {
            ['@identifier'] = xtargetPlayer.getIdentifier()
        })
        print("Deaths of player "..xtargetPlayer.getName().." successfully resetted.")
        xsourcePlayer.showNotification(Config.DeathCounterOfOneUser)
    else
        MySQL.Async.execute("UPDATE users SET `deathcounter` = 0;")
        xsourcePlayer.showNotification(Config.DeathCounterAllUsers)
    end
end, true)