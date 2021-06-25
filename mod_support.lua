
local mods_folder = minetest.get_modpath("item_replicator").."/mods/"

if minetest.get_modpath("default") or false then
    dofile(mods_folder.."default.lua")
end