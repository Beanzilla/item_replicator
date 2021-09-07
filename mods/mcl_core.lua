
-- Using version 0.71.0 of MineClone2

item_replicator.add("mcl_core:stone", 2, 15)
item_replicator.add("mcl_core:cobble", 2, 20)

item_replicator.add("mcl_core:coal_lump", 1, 20)

-- If mcl_raw_ore then we need the raw versions too
if minetest.registered_items["mcl_raw_ores:raw_iron"] then
    item_replicator.add("mcl_raw_ores:raw_iron", 1, 35)
    item_replicator.add("mcl_raw_ores:raw_gold", 1, 35)
end

item_replicator.add("mcl_core:iron_ingot", 1, 40)
item_replicator.add("mcl_core:gold_ingot", 1, 40)
item_replicator.add("mesecons:redstone", 2, 45)
item_replicator.add("mcl_dye:blue", 2, 45)
item_replicator.add("mcl_core:emerald", 1, 128)
item_replicator.add("mcl_core:diamond", 1, 120)

item_replicator.add("mcl_core:dirt", 1, 10)
item_replicator.add("mcl_core:dirt_with_grass", 1, 20)
item_replicator.add("mcl_core:mycelium", 1, 25)
item_replicator.add("mcl_core:podzol", 1, 25)
item_replicator.add("mcl_core:gravel", 1, 30)
item_replicator.add("mcl_core:sand", 1, 17)
item_replicator.add("mcl_core:redsand", 1, 17)
item_replicator.add("mcl_core:clay_lump", 2, 20)

item_replicator.add("mcl_core:coalblock", 1, 64)
item_replicator.add("mcl_core:ironblock", 1, 64)
item_replicator.add("mcl_core:goldblock", 1, 64)
item_replicator.add("mcl_core:diamondblcok", 1, 250)
item_replicator.add("mcl_core:emeraldblock", 1, 256)
item_replicator.add("mesecons_torch:redstoneblock", 1, 64)
item_replicator.add("mcl_core:lapisblock", 1, 64)
item_replicator.add("mcl_core:obsidian", 1, 128)

item_replicator.add("mcl_core:cactus", 1, 20)
item_replicator.add("mcl_core:reeds", 1, 20)

item_replicator.add("mcl_dye:red", 1, 16)
item_replicator.add("mcl_dye:dark_green", 1, 16)
item_replicator.add("mcl_dye:blue", 1, 16)
item_replicator.add("mcl_dye:lightblue", 1, 16)
item_replicator.add("mcl_dye:black", 1, 16)
item_replicator.add("mcl_dye:white", 1, 16)
item_replicator.add("mcl_dye:yellow", 1, 16)
item_replicator.add("mcl_dye:brown", 1, 16)
item_replicator.add("mcl_dye:orange", 1, 16)
item_replicator.add("mcl_dye:pink", 1, 16)
item_replicator.add("mcl_dye:dark_grey", 1, 16)
item_replicator.add("mcl_dye:green", 1, 16)
item_replicator.add("mcl_dye:grey", 1, 16)
item_replicator.add("mcl_dye:magenta", 1, 16)
item_replicator.add("mcl_dye:violet", 1, 16)
item_replicator.add("mcl_dye:cyan", 1, 16)

item_replicator.add("mcl_mobitems:string", 1, 16)
item_replicator.add("mcl_mobitems:shulker_shell", 1, 192)
item_replicator.add("mcl_mobitems:rotten_flesh", 1, 19)
item_replicator.add("mcl_mobitems:spider_eye", 1, 22)
item_replicator.add("mcl_mobitems:bone", 1, 20)
item_replicator.add("mcl_mobitems:blaze_rod", 1, 64)
item_replicator.add("mcl_mobitems:magma_cream", 1, 40)
item_replicator.add("mcl_mobitems:ghast_tear", 1, 41)
item_replicator.add("mcl_mobitems:nether_star", 1, 512) -- Even though this item doesn't do anything right now (This will be re-adjusted)
item_replicator.add("mcl_mobitems:slimeball", 2, 19)
item_replicator.add("mcl_mobitems:gunpowder", 1, 19)
item_replicator.add("mcl_fire:fire_charge", 1, 60)

item_replicator.add("mcl_mobitems:mutton", 1, 24)
item_replicator.add("mcl_mobitems:beef", 1, 31)
item_replicator.add("mcl_mobitems:chicken", 1, 29)
item_replicator.add("mcl_mobitems:porkchop", 1, 22)
item_replicator.add("mcl_mobitems:rabbit", 1, 19)

item_replicator.add("mcl_mobitems:cooked_mutton", 1, 19)
item_replicator.add("mcl_mobitems:cooked_beef", 1, 19)
item_replicator.add("mcl_mobitems:cooked_chicken", 1, 19)
item_replicator.add("mcl_mobitems:cooked_porkchop", 1, 19)
item_replicator.add("mcl_mobitems:cooked_rabbit", 1, 19)

item_replicator.add("mcl_mobitems:leather", 1, 25)
item_replicator.add("mcl_mobitems:feather", 1, 24)
item_replicator.add("mcl_mobitems:rabbit_hide", 1, 26)
item_replicator.add("mcl_mobitems:rabbit_foot", 1, 60)

item_replicator.add("mcl_mobitems:saddle", 1, 256)

item_replicator.add("mcl_core:stick", 1, 24)
item_replicator.add("mcl_core:apple", 2, 32)

item_replicator.add("mcl_core:tree", 1, 24)
item_replicator.add("mcl_core:darktree", 1, 24)
item_replicator.add("mcl_core:acaciatree", 1, 24)
item_replicator.add("mcl_core:sprucetree", 1, 24)
item_replicator.add("mcl_core:birchtree", 1, 24)
item_replicator.add("mcl_core:jungletree", 1, 24)
item_replicator.add("mcl_core:wood", 2, 24)
item_replicator.add("mcl_core:darkwood", 2, 24)
item_replicator.add("mcl_core:junglewood", 2, 24)
item_replicator.add("mcl_core:sprucewood", 2, 24)
item_replicator.add("mcl_core:acaciawood", 2, 24)
item_replicator.add("mcl_core:birchwood", 2, 24)
item_replicator.add("mcl_core:sapling", 1, 14)
item_replicator.add("mcl_core:darksapling", 1, 14)
item_replicator.add("mcl_core:junglesapling", 1, 14)
item_replicator.add("mcl_core:acaciasapling", 1, 14)
item_replicator.add("mcl_core:sprucesapling", 1, 14)
item_replicator.add("mcl_core:birchsapling", 1, 14)
item_replicator.add("mcl_core:leaves", 1, 8)
item_replicator.add("mcl_core:darkleaves", 1, 8)
item_replicator.add("mcl_core:jungleleaves", 1, 8)
item_replicator.add("mcl_core:acacialeaves", 1, 8)
item_replicator.add("mcl_core:spruceleaves", 1, 8)
item_replicator.add("mcl_core:birchleaves", 1, 8)

item_replicator.add("mcl_core:charcoal_lump", 1, 20)

item_replicator.add("mcl_core:apple_gold", 1, 128)
item_replicator.add("mcl_core:apple_gold_enchanted", 1, 256)

item_replicator.add("mcl_buckets:bucket_water", 1, 128)
item_replicator.add("mcl_buckets:bucket_lava", 1, 192)
item_replicator.add("mcl_buckets:bucket_empty", 1, 64)
item_replicator.add("mcl_mobitems:milk_bucket", 1, 100)

item_replicator.add("mcl_bows:arrow", 1, 12)

item_replicator.add("mcl_chests:ender_chest", 1, 256)

item_replicator.add("mcl_farming:wheat_seeds", 1, 15)
item_replicator.add("mcl_farming:wheat_item", 1, 35)
item_replicator.add("mcl_farming:cookie", 1, 30)
item_replicator.add("mcl_farming:bread", 1, 55)
item_replicator.add("mcl_farming:pumpkin_seeds", 1, 15)
item_replicator.add("mcl_farming:pumpkin", 1, 45)
item_replicator.add("mcl_farming:pumpkin_face_light", 1, 31)
item_replicator.add("mcl_farming:pumpkin_pie", 1, 60)
item_replicator.add("mcl_farming:potato_item", 1, 21)
item_replicator.add("mcl_farming:potato_item_baked", 1, 40)
item_replicator.add("mcl_farming:melon_seeds", 1, 15)
item_replicator.add("mcl_farming:melon_item", 1, 10)
item_replicator.add("mcl_farming:carrot_item", 1, 20)
item_replicator.add("mcl_farming:carrot_item_gold", 1, 70)
item_replicator.add("mcl_farming:beetroot_seeds", 1, 20)
item_replicator.add("mcl_farming:beetroot_item", 1, 40)
item_replicator.add("mcl_mushrooms:mushroom_red", 1, 25)
item_replicator.add("mcl_mushrooms:mushroom_brown", 1, 25)

item_replicator.add("mcl_books:book", 1, 45)

item_replicator.add("mcl_nether:glowstone", 1, 26)
item_replicator.add("mcl_nether:quartz", 1, 55)
item_replicator.add("mcl_nether:netherrack", 1, 17)
item_replicator.add("mcl_nether:magma", 1, 16)
item_replicator.add("mcl_nether:soul_sand", 1, 24)
item_replicator.add("mcl_nether:nether_brick", 1, 40)
item_replicator.add("mcl_nether:red_nether_brick", 1, 41)
item_replicator.add("mcl_nether:nether_wart_item", 1, 75) -- Currently unobtainable via "natural" means

item_replicator.add("mcl_jukebox:record_1", 1, 128) -- 13
item_replicator.add("mcl_jukebox:record_2", 1, 128) -- Wait
item_replicator.add("mcl_jukebox:record_3", 1, 128) -- Blocks
item_replicator.add("mcl_jukebox:record_4", 1, 128) -- Far
item_replicator.add("mcl_jukebox:record_5", 1, 128) -- Chirp
item_replicator.add("mcl_jukebox:record_6", 1, 128) -- Strad
item_replicator.add("mcl_jukebox:record_7", 1, 128) -- Mellohi
item_replicator.add("mcl_jukebox:record_8", 1, 128) -- Mall
item_replicator.add("mcl_jukebox:jukebox", 1, 120)

item_replicator.add("mcl_ocean:kelp", 1, 40)
item_replicator.add("mcl_ocean:sea_pickle_1_dead_brain_coral_block", 1, 40)
item_replicator.add("mcl_ocean:seagrass", 1, 40)
item_replicator.add("mcl_ocean:sea_lanturn", 1, 32)
item_replicator.add("mcl_ocean:prismarine_crystals", 1, 40)
item_replicator.add("mcl_ocean:prismarine_shard", 1, 40)

-- Exclude Dead Coral (Because we want to replicate living matter not just dead stuff)
-- Despite the fact you are more likely to get dead rather than living.
item_replicator.add("mcl_ocean:tube_coral_block", 1, 50)
item_replicator.add("mcl_ocean:brain_coral_block", 1, 50)
item_replicator.add("mcl_ocean:bubble_coral_block", 1, 50)
item_replicator.add("mcl_ocean:fire_coral_block", 1, 50)
item_replicator.add("mcl_ocean:horn_coral_block", 1, 50)
item_replicator.add("mcl_ocean:tube_coral", 1, 30)
item_replicator.add("mcl_ocean:brain_coral", 1, 30)
item_replicator.add("mcl_ocean:bubble_coral", 1, 30)
item_replicator.add("mcl_ocean:fire_coral", 1, 30)
item_replicator.add("mcl_ocean:horn_coral", 1, 30)
item_replicator.add("mcl_ocean:tube_coral_fan", 1, 30)
item_replicator.add("mcl_ocean:brain_coral_fan", 1, 30)
item_replicator.add("mcl_ocean:bubble_coral_fan", 1, 30)
item_replicator.add("mcl_ocean:fire_coral_fan", 1, 30)
item_replicator.add("mcl_ocean:horn_coral_fan", 1, 30)

item_replicator.add("mcl_sponges:sponge", 1, 30)

item_replicator.add("mcl_throwing:egg", 1, 30)
item_replicator.add("mcl_throwing:snowball", 1, 10)
item_replicator.add("mcl_throwing:ender_pearl", 1, 110)

-- Even though it's yet to be implemented
item_replicator.add("mcl_mc:totem", 1, 512)

item_replicator.add("mcl_wool:white", 1, 30)

item_replicator.add("mcl_torches:torch", 1, 20)

item_replicator.add("mcl_end:end_stone", 1, 22)
item_replicator.add("mcl_end:chorus_flower", 1, 40)
item_replicator.add("mcl_end:chorus_fruit", 1, 30)
item_replicator.add("mcl_end:chorus_fruit_popped", 1, 45)
item_replicator.add("mcl_end:end_bricks", 1, 30)
item_replicator.add("mcl_end:end_rod", 1, 31)
item_replicator.add("mcl_end:dragon_egg", 1, 256) -- Yes this will allow players give deggs to anyone and everyone.

item_replicator.add("mesecons_torch:mesecon_torch_on", 1, 32)
item_replicator.add("mcl_comparators:comparator_off_comp", 1, 40)
item_replicator.add("mcl_dispensers:dispenser", 1, 40)
item_replicator.add("mcl_droppers:dropper", 1, 40)
item_replicator.add("mcl_observers:observer_off", 1, 40)
item_replicator.add("mesecons_delayer:delayer_off_1", 1, 40)
item_replicator.add("mesecons:switch", 1, 40)
item_replicator.add("mesecons:button", 1, 40)
item_replicator.add("mesecons_noteblock:noteblock", 1, 40)
item_replicator.add("mesecons_solarpanel:solar_panel_off", 1, 40)
item_replicator.add("mesecons_pressureplates:pressureplate_stone_off", 1, 38)
item_replicator.add("mesecons_pressureplates:pressureplate_wood_off", 1, 38)
item_replicator.add("mesecons_pressureplates:pressureplate_birchwood_off", 1, 38)
item_replicator.add("mesecons_pressureplates:pressureplate_acaciawood_off", 1, 38)
item_replicator.add("mesecons_pressureplates:pressureplate_darkwood_off", 1, 38)
item_replicator.add("mesecons_pressureplates:pressureplate_sprucewood_off", 1, 38)
item_replicator.add("mesecons_pressureplates:pressureplate_junglewood_off", 1, 38)
item_replicator.add("mesecons_pistons:piston_normal_off", 1, 40)
item_replicator.add("mesecons_pistons:pistion_sticky_off", 1, 40)

-- If you have something that isn't in this feel free to add it... (Please also let me know what it was I missed so everyone benifits)
-- Leave an issue in this repo https://github.com/Beanzilla/item_replicator/issues
