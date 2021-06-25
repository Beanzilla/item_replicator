
local mod_path = minetest.get_modpath("item_replicator")

-- The API
item_replicator = {}

-- The Internal stuff
item_replicator_internal = {}

-- Items known to this mod
item_replicator_items = {}

-- My version
function item_replicator.version()
    -- DO NOT TOUCH THIS, This lets me know what version of the code your really running
    return "0.1 Inital"
end

-- Attempt to detect what gamemode/game these folks are running on
function item_replicator.game_mode()
    local reported = false -- Have we send a report
    local game_mode = "???" -- let's even return that
    if (minetest.get_modpath("default") or false) and not reported then
        reported = true
        game_mode = "MTG"
    end
    if (minetest.get_modpath("mcl_clone") or false) and not reported then
        reported = true
        game_mode = "MCL2"
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
if item_replicator_settings["run_test"] then
    dofile(mod_path.."/test.lua")
end

-- Register the machine
dofile(mod_path.."/register.lua")

-- Mod Support
dofile(mod_path.."/mod_support.lua")