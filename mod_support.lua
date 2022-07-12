
local mods_folder = minetest.get_modpath("item_replicator").."/mods/"

--[[
How to add your mod:
1. Update the mod.conf to include your mod as an optional dependency
2. Make a copy of one of the if statements including the dofile below.
3. Change that new if to verify your mod is present, then update the dofile to execute your mod_name.lua in the mods folder.
4. Make your mod_name.lua file in the mods folder.
5. Make item_replicator.add("your_mod_name:your_items_in_your_mod", amount_per_process, time_for_each_process) for each item in
   your mod.
6. Reload your server/game and enjoy the update.

Please feel free to change any of the item_replicator.add() calls in any of the dofiles below.

Please, please help me out and push a Pull Request (PR) to my repo so my mod can get your mods content included inside the box.

To send me a PR:
1. In a web browser goto https://github.com/Beanzilla/item_replicator
2. Fork the repo (in a seperate location not in the same directory this mod is in)
3. Copy over your changes to the fork.
4. Then with your web browser goto https://github.com/Beanzilla/item_replicator/pulls
5. And click 'New Pull Request'
6. Set it up to point to my repo to yours
   Mine <- Yours
   (You should see your changed files, if not try the other way)
7. Then fill out what you've changed/added to my mod so I can review it to know what you've changed/added.
8. I will **TRY** to respond as quickly as I can, please just wait. (I may deny your PR for particular reasons, please look at
   my comments to know why)
]]--

if minetest.get_modpath("default") or false then
    dofile(mods_folder.."default.lua")
end

if minetest.get_modpath("mcl_core") or false then
    dofile(mods_folder.."mcl_core.lua")
end

if minetest.get_modpath("area_containers") or false then
   dofile(mods_folder.."area_containers.lua")
end

if minetest.get_modpath("currency") or false then
   dofile(mods_folder.."currency.lua")
end

if minetest.get_modpath("tardis_new") or false then
   dofile(mods_folder.."tardis_new.lua")
end
