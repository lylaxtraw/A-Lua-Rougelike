local Weapons = require("data.weapons")
local Shields = require("data.shields")

local Inventory = {}

function Inventory.Initialize(player)
    player.inventory = {
        weapons = { fists = true },
        shields = { none = true },
        potions = { full_restore = 1, mana_restore = 1 },
        spells = { itchy_pollen = true }
    }
    player.weapon = "fists"
    player.shield = "none"
end

function Inventory.GetWeapons(player)
    local list = {}
    for id, _ in pairs(player.inventory.weapons or {}) do
        local weapon = Weapons.Get(id)
        if weapon then
            local data = {
                id = weapon.id,
                name = weapon.name,
                description = weapon.description,
                damageMultiplier = weapon.damageMultiplier or 1,
                equipped = (player.weapon == id)
            }
            table.insert(list, data)
        end
    end
    table.sort(list, function(a, b) return a.name < b.name end)
    return list
end

function Inventory.GetShields(player)
    local list = {}
    for id, _ in pairs(player.inventory.shields or {}) do
        local shield = Shields.Get(id)
        if shield then
            local data = {
                id = shield.id,
                name = shield.name,
                description = shield.description,
                defenseMultiplier = shield.defenseMultiplier or 1,
                equipped = (player.shield == id)
            }
            table.insert(list, data)
        end
    end
    table.sort(list, function(a, b) return a.name < b.name end)
    return list
end

function Inventory.EquipWeapon(player, weaponId)
    if not player.inventory.weapons[weaponId] then return false end
    if not Weapons.Get(weaponId) then return false end
    player.weapon = weaponId
    return true
end

function Inventory.EquipShield(player, shieldId)
    if not player.inventory.shields[shieldId] then return false end
    if not Shields.Get(shieldId) then return false end
    player.shield = shieldId
    return true
end

-- Inventory.Show() was completely deleted. LÖVE will read GetWeapons/GetShields directly.

return Inventory