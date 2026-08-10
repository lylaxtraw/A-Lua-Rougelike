local Status = {}

Status.List = {
    burn = {
        id = "burn", name = "Burn", description = "Takes damage over time from fire.",
        apply = function(enemy, player, power)
            enemy.status = { type = "burn", duration = 3, power = power }
            player.status = { type = "burn", duration = 3, power = power }
        end,
        tick = function(enemy, player)
            local burnDamageEnemy = math.floor((enemy.maxHp or 100) * (enemy.status.power or 0.10))
            local burnDamagePlayer = math.floor((player.maxHp or 100) * (player.status.power or 0.10))
            enemy.hp = math.max(0, enemy.hp - burnDamageEnemy)
            player.hp = math.max(0, player.hp - burnDamagePlayer)
            local enemyDuration = enemy.status.duration - 1
            local playerDuration = player.status.duration - 1
            if playerDuration <= 0 then
                player.status = nil
            else
                player.status.duration = playerDuration
            end
            if enemyDuration <= 0 then
                enemy.status = nil
            else
                enemy.status.duration = enemyDuration
            end
            return burnDamageEnemy, burnDamagePlayer
        end
    },
    scorch = {
        id = "scorch", name = "Scorch", description = "Takes heavy damage over a short time.",
        apply = function(enemy, power)
            enemy.status = { type = "scorch", duration = 5, power = power }
        end,
        tick = function(enemy)
            local scorchDamage = math.floor((enemy.maxHp or 100) * (enemy.status.power or 0.25))
            enemy.hp = math.max(0, enemy.hp - scorchDamage)
            local duration = enemy.status.duration - 1
            if duration <= 0 then
                enemy.status = nil
            else
                enemy.status.duration = duration
            end
            return scorchDamage
        end
    },
    paralysis = {
        id = "paralysis", name = "Paralysis", description = "Cannot act for a turn.",
        apply = function(enemy)
            enemy.paralyzed = true
        end,
        tick = function(enemy)
            -- Paralysis effect is handled in the combat system; no damage over time.
            return 0
        end
    },
    rooted = {
        id = "rooted", name = "Rooted", description = "Takes damage over time. Chance to avoid movement.",
        apply = function(enemy, power)
            enemy.status = { type = "rooted", duration = 5, power = power, atkchance = 1 }
        end,
        tick = function(enemy)
            local rootDamage = math.floor((enemy.maxHp or 100) * (enemy.status.power or 0.15))
            enemy.hp = math.max(0, enemy.hp - rootDamage)

            local duration = enemy.status.duration - 1
            if duration <= 0 then
                enemy.status = nil
            else
                enemy.status.duration = duration
            end
            return 0
        end
    },
    hail = {
        id = "hail", name = "Hail", description = "Ice shards rain down, dealing damage over time.",
        apply = function(enemy, player, power)
            enemy.status = { type = "hail", duration = 8, power = power }
            player.status = { type = "hail", duration = 8, power = power }
        end,
        tick = function(enemy, player)
            local hailDamageEnemy = math.floor((enemy.maxHp or 100) * (enemy.status.power or 0.20))
            enemy.hp = math.max(0, enemy.hp - hailDamageEnemy)
            local hailDamagePlayer = math.floor((player.maxHp or 100) * (player.status.power or 0.10))
            player.hp = math.max(0, player.hp - hailDamagePlayer)
            local enemyDuration = enemy.status.duration - 1
            local playerDuration = player.status.duration - 1
            if enemyDuration <= 0 then
                enemy.status = nil
            else
                enemy.status.duration = enemyDuration
            end
            if playerDuration <= 0 then
                player.status = nil
            else
                player.status.duration = playerDuration
            end
            return hailDamageEnemy, hailDamagePlayer
        end
    },
    flower = {
        id = "flower", name = "Flower", description = "A parasitic blossom drains life over time.",
        apply = function(enemy, player, power)
            enemy.status = { type = "flower", duration = -1, power = power }
            player.status = { type = "flower", duration = -1, power = power }
        end,
        tick = function(enemy, player)
            local flowerDamageEnemy = math.floor((enemy.maxHp or 100) * (enemy.status.power or 0.05))
            enemy.hp = math.max(0, enemy.hp - flowerDamageEnemy)
            local flowerHealPlayer = math.floor((player.maxHp or 100) * (player.status.power or 0.05))
            player.hp = math.max(0, player.hp + flowerHealPlayer)
            return flowerDamageEnemy, flowerHealPlayer
        end
    },
    frostbite = {
        id = "frostbite", name = "Frostbite", description = "Takes damage over time and has a chance to stop movement.",
        apply = function(enemy, player, power)
            player.status = { type = "frostbite", duration = 5, power = power }
        end,
        tick = function(player)
            local frostbiteDamagePlayer = math.floor((player.maxHp or 100) * (player.status.power or 0.10))
            player.hp = math.max(0, player.hp - frostbiteDamagePlayer)

            if math.random(1, 100) <= 10 then 
                player.status.id.frostbite = true
            end

            local playerDuration = player.status.duration - 1
            if playerDuration <= 0 then
                player.status = nil
            else
                player.status.duration = playerDuration
            end

            return frostbiteDamagePlayer
        end
    }
}

function Status.Get(id) return Status.List[id] end