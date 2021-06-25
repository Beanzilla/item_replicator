
item_replicator_internal.update = function (pos, elapsed)
    local meta=minetest.get_meta(pos)
    local inv=meta:get_inventory()
    local gen=inv:get_stack("gen",1):get_name() -- The item to be produced
    local process=meta:get_int("proc")

    if inv:is_empty("gen") or inv:room_for_item("done",gen) == false or gen == "" or gen == "item_replicator:replicator" or gen == "item_replicator:replicator_active" then
        minetest.get_node_timer(pos):stop()
        meta:set_int("proc", 0)
        meta:set_int("state", 0)
        if item_replicator_settings.log_deep then
            minetest.log("action", "[item_replicator] item_replicator:replicator_active at ("..pos.x..", "..pos.y..", "..pos.z..") by '"..meta:get_string("owner").."' will produce '"..gen.."' x "..item_replicator.get_amount(gen).." every "..item_replicator.get_time(gen).." second(s)") 
            minetest.log("action", "[item_replicator] stopped")
        end
        local reported = false
        if inv:room_for_item("done",gen) == false and not reported then
            meta:set_string("infotext", "Item Replicator [Full] (" .. meta:get_string("owner") .. ")")
            reported = true
        end
        if (inv:is_empty("gen") or gen == "") and not reported then
            meta:set_string("infotext", "Item Replicator [No Product] (" .. meta:get_string("owner") .. ")")
            reported = true
        end
        if ((item_replicator.is(gen) == false and not item_replicator_settings.allow_unknown) and not reported) or (gen == "item_replicator:replicator" or gen == "item_replicator:replicator_active") then
            meta:set_string("infotext", "Item Replicator [Invalid Product] (" .. meta:get_string("owner") .. ")")
            reported = true
        end

        minetest.log("action", "[item_replicator] 30")
        minetest.swap_node(pos, {name ="item_replicator:replicator"})
        return false
    end
    process=process+1
    if item_replicator.is(gen) then
        if process>=item_replicator.get_time(gen) then
            process=0
            for i=1,item_replicator.get_amount(gen),1 do
                if inv:room_for_item("done",gen)==true then -- Only works if there is room
                    inv:add_item("done",gen)
                end
            end
            if item_replicator_settings.log_production then
                minetest.log("action", "[item_replicator] item_replicator:replicator_active at ("..pos.x..", "..pos.y..", "..pos.z..") by '"..meta:get_string("owner").."' has produced '"..gen.."' x "..item_replicator.get_amount(gen))
            end
        end
    elseif item_replicator_settings.allow_unknown then
        if process>=item_replicator_settings.unknown_item_time then
            process=0
            for i=1,item_replicator_settings.unknown_item_amount,1 do
                if inv:room_for_item("done",gen)==true then -- Only works if there is room
                    inv:add_item("done",gen)
                end
            end
            if item_replicator_settings.log_production then
                minetest.log("action", "[item_replicator] item_replicator:replicator_active at ("..pos.x..", "..pos.y..", "..pos.z..") by '"..meta:get_string("owner").."' has produced '"..gen.."' x "..item_replicator_settings.unknown_item_amount)
            end
        end
    end
    meta:set_int("proc",process)
    -- Let's really use a percent rather than some made up stuff.
    local percent = ((process/item_replicator.get_time(gen)) * 100)
    local percent_format = string.format("%.2f", percent)
    meta:set_string("infotext", "Item Replicator " .. percent_format  .."% (" .. meta:get_string("owner") .. ")")
    if item_replicator_settings.log_deep then
        minetest.log("action", "[item_replicator] item_replicator:replicator_active at ("..pos.x..", "..pos.y..", "..pos.z..") by '"..meta:get_string("owner").."' will produce '"..gen.."' x "..item_replicator.get_amount(gen).." every "..item_replicator.get_time(gen).." second(s)") 
        minetest.log("action", "[item_replicator] currently it's at "..percent_format.."%")
    end
    return true
end

item_replicator_internal.inv = function (placer, pos)
    local meta=minetest.get_meta(pos)
    local names=meta:get_string("names")
    local op=meta:get_int("open")
    local open=""
    if op==0 then
        open="Locked"
    elseif op==1 then
        open="Members"  
    else
        open="Public"
    end
    meta:set_string("formspec",
        "size[8,11]" ..
        "list[context;gen;2,0;1,1;]" ..
        "button[0,1; 1.5,1;save;Save]" ..
        "button[0,2; 1.5,1;open;" .. open .."]" ..
        "textarea[2.2,1.3;6,1.8;names;Members list (Inventory access);" .. names  .."]"..
        "list[context;done;0,2.9;8,4;]" ..
        "list[current_player;main;0,7;8,4;]" ..
        "listring[current_player;main]"  ..
        "listring[current_name;done]"
    )
    meta:set_string("infotext", "Item Replicator (" .. placer:get_player_name() .. ")")
end

-- Now we use all this to make our machine
local mod_name = "item_replicator_"
local extent = ".png"
local grouping = nil
local sounding = nil
if item_replicator_internal.game_mode() == "MCL2" then
    local mcl_sounds = rawget(_G, "mcl_sounds") or item_replicator_internal.throw_error("Failed to obtain MCL2 Sounds")
    grouping = {handy=1}
    sounding = mcl_sounds.node_sound_metal_defaults()
elseif item_replicator_internal.game_mode() == "MTG" then
    local default = rawget(_G, "default") or item_replicator_internal.throw_error("Failed to obtain MTG Sounds")
    grouping = {crumbly = 3}
    sounding = default.node_sound_metal_defaults()
else
    grouping = {crumbly = 3, handy=1}
end
minetest.register_node("item_replicator:replicator", {
    description = "Item Replicator",
    tiles = {
        mod_name.."plate"..extent,
        mod_name.."plate"..extent,
        mod_name.."vent_off"..extent,
        mod_name.."vent_off"..extent,
        mod_name.."vent_off"..extent,
        mod_name.."controls_off"..extent,
    },
    groups = grouping,
    sounds = sounding,
    paramtype2 = "facedir",
    light_source = 0,
    drop = "item_replicator:replicator",
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("infotext", "Item Replicator")
        meta:set_string("owner", "")
        meta:set_int("open", 0)
        meta:set_int("state", 0)
        meta:set_string("names", "")
        meta:set_int("proc", 0)
        local inv = meta:get_inventory()
        inv:set_size("done", 32)
        inv:set_size("gen", 1)
    end,
    after_place_node = function(pos, placer, itemstack)
        local meta = minetest.get_meta(pos)
        meta:set_string("owner", (placer:get_player_name() or ""))
        local inv = meta:get_inventory()
        item_replicator_internal.inv(placer,pos)
    end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
        local meta=minetest.get_meta(pos)
        local open=meta:get_int("open")
        local name=player:get_player_name()
        local owner=meta:get_string("owner")
        if listname=="gen" and meta:get_int("state") ~= 1 then
            minetest.get_node_timer(pos):start(1)
            minetest.log("action", "[item_replicator] 140")
            minetest.swap_node(pos, {name ="item_replicator:replicator_active"})
            meta:set_int("state", 1)
        end
        if name==owner then return stack:get_count() end
        if open==2 and listname=="done" then return stack:get_count() end
        if open==1 and listname=="done" then
            local names=meta:get_string("names")
            local txt=names.split(names,"\n")
            for i in pairs(txt) do
                if name==txt[i] then
                    return stack:get_count()
                end
            end
        end
        return 0
    end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
        local meta=minetest.get_meta(pos)
        local open=meta:get_int("open")
        local name=player:get_player_name()
        local owner=meta:get_string("owner")
        if listname=="gen" and meta:get_int("state") ~= 1 then
            minetest.get_node_timer(pos):start(1)
            minetest.log("action", "[item_replicator] 164")
            minetest.swap_node(pos, {name ="item_replicator:replicator_active"})
            meta:set_int("state", 1)
        end
        if name==owner then return stack:get_count() end
        if open==2 and listname=="done" then return stack:get_count() end
        if open==1 and listname=="done" then
            local names=meta:get_string("names")
            local txt=names.split(names,"\n")
            for i in pairs(txt) do
                if name==txt[i] then
                    return stack:get_count()
                end
            end
        end
        return 0
    end,
    can_dig = function(pos, player)
        local meta=minetest.get_meta(pos)
        local owner=meta:get_string("owner")
        local inv=meta:get_inventory()
        if (player:get_player_name()==owner) and owner ~= "" then
            minetest.get_node_timer(pos):stop()
        end
        -- Only check it's the owner
        return (player:get_player_name()==owner and
                owner~="")
    end,
    allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
        local meta = minetest.get_meta(pos)
        if to_list=="gen" and meta:get_int("state") ~= 1 then
            minetest.get_node_timer(pos):start(1)
            minetest.log("action", "[item_replicator] 196")
            minetest.swap_node(pos, {name ="item_replicator:replicator_active"})
            meta:set_int("state", 1)
        end
        if meta:get_int("open")==0 and player:get_player_name()~=meta:get_string("owner") then
            return 0
        end
        return count
        --[[if (from_list=="gen" and to_list=="gen" and player:get_player_name()==meta:get_string("owner")) then
            return count
        end]]
        -- return 0
    end,
    on_receive_fields = function(pos, formname, fields, sender)
        local meta = minetest.get_meta(pos)
        if sender:get_player_name() ~= meta:get_string("owner") then
            return false
        end

        if fields.save then
            meta:set_string("names", fields.names)
            item_replicator_internal.inv(sender,pos)
        end

        if fields.open then
            local open=meta:get_int("open")
            open=open+1
            if open>2 then open=0 end
            meta:set_int("open",open)
            item_replicator_internal.inv(sender,pos)
        end
    end,
    on_timer = function(pos, elapsed)
        return item_replicator_internal.update(pos, elapsed)
    end
})

minetest.register_node("item_replicator:replicator_active", {
    description = "Item Replicator",
    tiles = {
        mod_name.."plate"..extent,
        mod_name.."plate"..extent,
        mod_name.."vent_on"..extent,
        mod_name.."vent_on"..extent,
        mod_name.."vent_on"..extent,
        mod_name.."controls_on"..extent,
    },
    groups = grouping,
    sounds = sounding,
    paramtype2 = "facedir",
    light_source = 4,
    drop = "item_replicator:replicator",
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("infotext", "Item Replicator")
        meta:set_string("owner", "")
        meta:set_int("open", 0)
        meta:set_int("state", 0)
        meta:set_string("names", "")
        meta:set_int("proc", 0)
        local inv = meta:get_inventory()
        inv:set_size("done", 32)
        inv:set_size("gen", 1)
    end,
    after_place_node = function(pos, placer, itemstack)
        local meta = minetest.get_meta(pos)
        if meta:get_string("owner") == "" then
            meta:set_string("owner", placer:get_player_name() or "")
        end
        local inv = meta:get_inventory()
        item_replicator_internal.inv(placer,pos)
    end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
        local meta=minetest.get_meta(pos)
        local open=meta:get_int("open")
        local name=player:get_player_name()
        local owner=meta:get_string("owner")
        if listname=="gen" and meta:get_int("state") ~= 1 then
            minetest.get_node_timer(pos):start(1)
            minetest.log("action", "[item_replicator] 274")
            minetest.swap_node(pos, {name ="item_replicator:replicator_active"})
            meta:set_int("state", 1)
        end
        if name==owner then return stack:get_count() end
        if open==2 and listname=="done" then return stack:get_count() end
        if open==1 and listname=="done" then
            local names=meta:get_string("names")
            local txt=names.split(names,"\n")
            for i in pairs(txt) do
                if name==txt[i] then
                    return stack:get_count()
                end
            end
        end
        return 0
    end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
        local meta=minetest.get_meta(pos)
        local open=meta:get_int("open")
        local name=player:get_player_name()
        local owner=meta:get_string("owner")
        if listname=="gen" and meta:get_int("state") ~= 1 then
            minetest.get_node_timer(pos):start(1)
            minetest.log("action", "[item_replicator] 298")
            minetest.swap_node(pos, {name ="item_replicator:replicator_active"})
            meta:set_int("state", 1)
        end
        if name==owner then return stack:get_count() end
        if open==2 and listname=="done" then return stack:get_count() end
        if open==1 and listname=="done" then
            local names=meta:get_string("names")
            local txt=names.split(names,"\n")
            for i in pairs(txt) do
                if name==txt[i] then
                    return stack:get_count()
                end
            end
        end
        return 0
    end,
    can_dig = function(pos, player)
        local meta=minetest.get_meta(pos)
        local owner=meta:get_string("owner")
        local inv=meta:get_inventory()
        if (player:get_player_name()==owner) and owner ~= "" then
            minetest.get_node_timer(pos):stop()
        end
        -- Only check it's the owner
        return (player:get_player_name()==owner and
                owner~="")
    end,
    allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
        local meta = minetest.get_meta(pos)
        if to_list=="gen" and meta:get_int("state") ~= 1 then
            minetest.get_node_timer(pos):start(1)
            minetest.log("action", "[item_replicator] 330")
            minetest.swap_node(pos, {name ="item_replicator:replicator_active"})
            meta:set_int("state", 1)
        end
        if meta:get_int("open")==0 and player:get_player_name()~=meta:get_string("owner") then
            return 0
        end
        return count
        --[[if (from_list=="gen" and to_list=="gen" and player:get_player_name()==meta:get_string("owner")) then
            return count
        end]]
        --return 0
    end,
    on_receive_fields = function(pos, formname, fields, sender)
        local meta = minetest.get_meta(pos)
        if sender:get_player_name() ~= meta:get_string("owner") then
            return false
        end

        if fields.save then
            meta:set_string("names", fields.names)
            item_replicator_internal.inv(sender,pos)
        end

        if fields.open then
            local open=meta:get_int("open")
            open=open+1
            if open>2 then open=0 end
            meta:set_int("open",open)
            item_replicator_internal.inv(sender,pos)
        end
    end,
    on_timer = function(pos, elapsed)
        return item_replicator_internal.update(pos, elapsed)
    end
})

if item_replicator_settings.craft then
    if minetest.get_modpath("default") or false then
        minetest.register_craft({
            output = "item_replicator:replicator",
            recipe = {
                {"", "default:mese", ""},
                {"default:mese", "default:diamondblock", "default:mese"},
                {"", "default:mese", ""},
            }
        })
    end
    if (minetest.get_modpath("mcl_core") or false) and (minetest.get_modpath("mesecons") or false) then
        minetest.register_craft({
            output = "item_replicator:replicator",
            recipe = {
                {"", "mesecons_torch:redstoneblock", ""},
                {"mesecons_torch:redstoneblock", "mcl_core:diamondblock", "mesecons_torch:redstoneblock"},
                {"", "mesecons_torch:redstoneblock", ""},
            }
        })
    end
    minetest.register_craft({
        type = "fuel",
        recipe = "item_replicator:replicator",
        burntime = 300
    })
    minetest.register_craft({
        type = "fuel",
        recipe = "item_replicator:replicator_active",
        burntime = 300
    })
end

-- For those who don't want an active replicator in their inventory. (Looks only)
minetest.register_craft({
    type = "shapeless",
    output = "item_replicator:replicator",
    recipe = {
        "item_replicator:replicator_active",
    }
}) -- Or perhaps you want it to look active.
minetest.register_craft({
    type = "shapeless",
    output = "item_replicator:replicator_active",
    recipe = {
        "item_replicator:replicator",
    }
})
