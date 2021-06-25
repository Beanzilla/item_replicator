
local mod_path = minetest.get_modpath("item_clone")

-- The API
item_clone = {}

-- The Internal stuff
item_clone_internal = {}

-- Items known to this mod
item_clone_items = {}

-- My version
function item_clone.version()
    -- DO NOT TOUCH THIS, This lets me know what version of the code your really running
    return "0.1 Inital"
end

-- Attempt to detect what gamemode/game these folks are running on
function item_clone.game_mode()
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
function item_clone_internal.throw_error(msg)
    minetest.log("action", "[item_clone] Error: "..msg)
    minetest.log("action", "[item_clone] Version: "..item_clone.version())
    minetest.log("action", "[item_clone] GameMode: "..item_clone.game_mode())
    error("[item_clone] Please make an issue on my repo with the logs from your debug.txt")
end

-- Initalize Settings
dofile(mod_path.."/settings.lua")

-- Initalize API
dofile(mod_path.."/api.lua")

-- Execute an API check
if item_clone_settings["run_test"] then
    dofile(mod_path.."/test.lua")
end