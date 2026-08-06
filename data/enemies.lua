local Enemies = {
    slime = {
        id = "slime",
        name = "Slime",
        maxHp = 25,
        atk = 2,
        def = 2,
        xp = math.random(30, 50),
        gold = math.random(30, 50),
        critChance = 3,
        ability = "anger_point"
    },
    red_slime = {
        id = "red_slime",
        name = "Red Slime",
        maxHp = 40,
        atk = 7,
        def = 1,
        xp = math.random(60, 70),
        gold = math.random(60, 70),
        critChance = 5,
        burnAttack = true
    },
    heavy_slime = {
        id = "heavy_slime",
        name = "Heavy Slime",
        maxHp = 70,
        atk = 1,
        def = 5,
        xp = math.random(100, 200),
        gold = math.random(100, 200),
        critChance = 2
    }
}

return Enemies