
local mod_path = minetest.get_modpath("item_replicator")

-- The API
item_replicator = {}

-- The Internal stuff
item_replicator_internal = {}

-- Items known to this mod
item_replicator_items = {}

-- Items known to not be allowed
item_replicator_blacklist = {}

-- My version
function item_replicator.version()
    -- DO NOT TOUCH THIS, This lets me know what version of the code your really running
    return "2.0 Serious Replication"
end

-- Attempt to detect what gamemode/game these folks are running on
function item_replicator.game_mode()
    local reported = false -- Have we send a report
    local game_mode = "???" -- let's even return that
    if (minetest.get_modpath("default") or false) and not reported then
        reported = true
        game_mode = "MTG"
    end
    if (minetest.get_modpath("mcl_core") or false) and not reported then
        reported = true
        game_mode = "MCL"
    end
    return game_mode
end

-- Just a helper to report issues in the test suite
function item_replicator_internal.throw_error(msg)
    minetest.log("action", "[item_replicator] Error: "..msg)
    minetest.log("action", "[item_replicator] Version: "..item_replicator.version())
    minetest.log("action", "[item_replicator] GameMode: "..item_replicator.game_mode())
    error("[item_replicator] Please make an issue on my repo with the logs from your debug.txt")
end

-- Initalize Settings
dofile(mod_path.."/settings.lua")

-- Initalize API
dofile(mod_path.."/api.lua")

-- Execute an API check
if item_replicator_settings.run_test == true then
    dofile(mod_path.."/test.lua")
end

-- Register the machine
dofile(mod_path.."/register.lua")

-- If to blacklist our machine or to add it as a valid item
if item_replicator_settings.allow_self_replication ~= true then
    item_replicator.bl_add("item_replicator:replicator")
    item_replicator.bl_add("item_replicator:replicator_active")
else -- Make it take a long time to make 1 more replicator (But you'd need 2 to get to this point)
    item_replicator.add("item_replicator:replicator", 1, 350)
    item_replicator.add("item_replicator:replicator_active", 1, 350)
end

-- Don't allow V2 or V3 to be replicated
item_replicator.bl_add("item_replicator:replicator1")
item_replicator.bl_add("item_replicator:replicator1_active")
item_replicator.bl_add("item_replicator:replicator2")
item_replicator.bl_add("item_replicator:replicator2_active")

-- Mod Support
dofile(mod_path.."/mod_support.lua")
