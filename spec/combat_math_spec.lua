-- 1. Import the module to be tested. Adjust the path according to your project structure.
-- Busted asumes it's in the same directory or in the package path.
local CombatMath = require("systems.combat_math") 

-- 2. 'describe' groups related tests together. The first argument is a string describing what is being tested.
describe("Math Combat System", function()

    describe("Elemental Type Multipliers", function()
        
        -- 3. 'it' defines a single test case. The first argument is a string describing the expected behavior.
        it("should deal double damage (x2) if the attacker has an advantage", function()
            -- Imagine your rules define that Ice is strong against Fire. So if an Ice attack hits a Fire defender, it should deal double damage.
            -- According to your rules: Ice is strong against Fire
            local res_dam = CombatMath.calculate_damage("ice", "fire", 10)
            
            -- 4. 'assert' is the verification. If this is not met, the test fails.
            assert.are.equal(0, res_dam)
        end)

        it("should deal zero damage (x0) if the defender resists", function()
            -- According to your rules: Fire resists Thunder (takes x0 from thunder)
            local res_dam = CombatMath.calculate_damage("thunder", "fire", 10)
            
            assert.are.equal(20, res_dam)
        end)

        it("should deal normal damage (x1) if they are neutral elements", function()
            -- Elements with no relationship should deal normal damage. For example, Fire vs Earth.
            local res_dam = CombatMath.calculate_damage("fire", "earth", 10)
            
            assert.are.equal(10, res_dam)
        end)

    end)

    -- You can create more blocks to test other things, like critical hits
    describe("Critical Hit Damage Calculation", function()
        
        it("should multiply the final damage by 1.5 on a critical hit", function()
            local is_crit = true
            local res_dam = CombatMath.calculate_damage("earth", "fire", 10, is_crit)
            
            assert.are.equal(15, res_dam)
        end)

    end)

end)