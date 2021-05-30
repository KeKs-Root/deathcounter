Config = {}

Config.MaxDeaths = 1 -- How many deaths should a player have until he gets kicked
Config.Kick = true -- Do you want the player to be kicked if he reaches the max amount of deaths
Config.KickMessage = "You've reached your max deaths. Please contact the support." -- Specify a message if the player gets kicked
Config.Notify = true -- Do you want to be notified if someone reaches maximum amount of deaths?

Config.Webhook = "" -- Enter your webhook link if you set "Config.Notify" to true
Config.WebhookImage = "" -- Enter a image url you want to use for your webhook

Config.DeathCounterOfOneUser = "The deathcounter was reset." -- If you ran the command resetdeaths with an argument this message will be triggered
Config.DeathCounterAllUsers = "You reset all death counters from all users." -- If you ran the command resetdeaths without an argument this message will be triggered

Config.DiscordTitle = "Death maximum reached" -- title of the discord webhook if you enabled Config.Notify
Config.DiscordDesc = "The player has reached the maximum deaths." -- description of discord webhook if you enabled Config.Notify