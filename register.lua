local S = minetest.get_translator("item_replicator")

item_replicator_internal.update = function (pos, elapsed)
    local meta=minetest.get_meta(pos)
    local inv=meta:get_inventory()
    local gen=inv:get_stack("gen",1):get_name() -- The item to be produced
    local process=meta:get_int("proc")

    if inv:is_empty("gen") or inv:room_for_item("done",gen) == false or gen == "" or item_replicator.bl_is(gen) then
        minetest.get_node_timer(pos):stop()
        meta:set_int("proc", 0)
        meta:set_int("state", 0)
        item_replicator_internal.inv_update(pos) -- Update the formspec for the new percent
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
        if ((item_replicator.is(gen) == false and not item_replicator_settings.allow_unknown) and not reported) or item_replicator.bl_is(gen) then
            meta:set_string("infotext", "Item Replicator [Invalid Product] (" .. meta:get_string("owner") .. ")")
            reported = true
        end

        if item_replicator_settings.log_deep then
            minetest.log("action", "[item_replicator] 32")
        end
        minetest.swap_node(pos, {name ="item_replicator:replicator"})
        return false
    end
    process=process+1
    if item_replicator.is(gen) and not item_replicator.bl_is(gen) then
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
    elseif item_replicator_settings.allow_unknown and not item_replicator.bl_is(gen) then
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
    local percent_format = string.format("%.0f", percent)
    item_replicator_internal.inv_update(pos) -- Update the formspec for the new percent
    meta:set_string("infotext", "Item Replicator " .. percent_format  .."% (" .. meta:get_string("owner") .. ")")
    if item_replicator_settings.log_deep then
        minetest.log("action", "[item_replicator] item_replicator:replicator_active at ("..pos.x..", "..pos.y..", "..pos.z..") by '"..meta:get_string("owner").."' will produce '"..gen.."' x "..item_replicator.get_amount(gen).." every "..item_replicator.get_time(gen).." second(s)")
        minetest.log("action", "[item_replicator] currently it's at "..percent_format.."%")
    end
    return true
end

item_replicator_internal.update1 = function (pos, elapsed)
    local meta=minetest.get_meta(pos)
    local inv=meta:get_inventory()
    local gen=inv:get_stack("gen",1):get_name() -- The item to be produced
    local process=meta:get_int("proc")

    if inv:is_empty("gen") or inv:room_for_item("done",gen) == false or gen == "" or item_replicator.bl_is(gen) then
        minetest.get_node_timer(pos):stop()
        meta:set_int("proc", 0)
        meta:set_int("state", 0)
        item_replicator_internal.inv_update(pos) -- Update the formspec for the new percent
        if item_replicator_settings.log_deep then
            minetest.log("action", "[item_replicator] item_replicator:replicator1_active at ("..pos.x..", "..pos.y..", "..pos.z..") by '"..meta:get_string("owner").."' will produce '"..gen.."' x "..item_replicator.get_amount(gen).." every "..item_replicator.get_time(gen).." second(s)")
            minetest.log("action", "[item_replicator] stopped")
        end
        local reported = false
        if inv:room_for_item("done",gen) == false and not reported then
            meta:set_string("infotext", "Item Replicator V2 [Full] (" .. meta:get_string("owner") .. ")")
            reported = true
        end
        if (inv:is_empty("gen") or gen == "") and not reported then
            meta:set_string("infotext", "Item Replicator V2 [No Product] (" .. meta:get_string("owner") .. ")")
            reported = true
        end
        if ((item_replicator.is(gen) == false and not item_replicator_settings.allow_unknown) and not reported) or item_replicator.bl_is(gen) then
            meta:set_string("infotext", "Item Replicator V2 [Invalid Product] (" .. meta:get_string("owner") .. ")")
            reported = true
        end

        if item_replicator_settings.log_deep then
            minetest.log("action", "[item_replicator] 107")
        end
        minetest.swap_node(pos, {name ="item_replicator:replicator1"})
        return false
    end
    process=process+2 -- Item Replicator V2 is 2 times faster than the Item Replicator!
    if item_replicator.is(gen) and not item_replicator.bl_is(gen) then
        if process>=item_replicator.get_time(gen) then
            process=0
            for i=1,item_replicator.get_amount(gen),1 do
                if inv:room_for_item("done",gen)==true then -- Only works if there is room
                    inv:add_item("done",gen)
                end
            end
            if item_replicator_settings.log_production then
                minetest.log("action", "[item_replicator] item_replicator:replicator1_active at ("..pos.x..", "..pos.y..", "..pos.z..") by '"..meta:get_string("owner").."' has produced '"..gen.."' x "..item_replicator.get_amount(gen))
            end
        end
    elseif item_replicator_settings.allow_unknown and not item_replicator.bl_is(gen) then
        if process>=item_replicator_settings.unknown_item_time then
            process=0
            for i=1,item_replicator_settings.unknown_item_amount,1 do
                if inv:room_for_item("done",gen)==true then -- Only works if there is room
                    inv:add_item("done",gen)
                end
            end
            if item_replicator_settings.log_production then
                minetest.log("action", "[item_replicator] item_replicator:replicator1_active at ("..pos.x..", "..pos.y..", "..pos.z..") by '"..meta:get_string("owner").."' has produced '"..gen.."' x "..item_replicator_settings.unknown_item_amount)
            end
        end
    end
    meta:set_int("proc",process)
    -- Let's really use a percent rather than some made up stuff.
    local percent = ((process/item_replicator.get_time(gen)) * 100)
    local percent_format = string.format("%.0f", percent)
    item_replicator_internal.inv_update(pos) -- Update the formspec for the new percent
    meta:set_string("infotext", "Item Replicator V2 " .. percent_format  .."% (" .. meta:get_string("owner") .. ")")
    if item_replicator_settings.log_deep then
        minetest.log("action", "[item_replicator] item_replicator:replicator1_active at ("..pos.x..", "..pos.y..", "..pos.z..") by '"..meta:get_string("owner").."' will produce '"..gen.."' x "..item_replicator.get_amount(gen).." every "..item_replicator.get_time(gen).." second(s)")
        minetest.log("action", "[item_replicator] currently it's at "..percent_format.."%")
    end
    return true
end

item_replicator_internal.update2 = function (pos, elapsed)
    local meta=minetest.get_meta(pos)
    local inv=meta:get_inventory()
    local gen=inv:get_stack("gen",1):get_name() -- The item to be produced
    local process=meta:get_int("proc")

    if inv:is_empty("gen") or inv:room_for_item("done",gen) == false or gen == "" or item_replicator.bl_is(gen) then
        minetest.get_node_timer(pos):stop()
        meta:set_int("proc", 0)
        meta:set_int("state", 0)
        item_replicator_internal.inv_update(pos) -- Update the formspec for the new percent
        if item_replicator_settings.log_deep then
            minetest.log("action", "[item_replicator] item_replicator:replicator2_active at ("..pos.x..", "..pos.y..", "..pos.z..") by '"..meta:get_string("owner").."' will produce '"..gen.."' x "..item_replicator.get_amount(gen).." every "..item_replicator.get_time(gen).." second(s)")
            minetest.log("action", "[item_replicator] stopped")
        end
        local reported = false
        if inv:room_for_item("done",gen) == false and not reported then
            meta:set_string("infotext", "Item Replicator V3 [Full] (" .. meta:get_string("owner") .. ")")
            reported = true
        end
        if (inv:is_empty("gen") or gen == "") and not reported then
            meta:set_string("infotext", "Item Replicator V3 [No Product] (" .. meta:get_string("owner") .. ")")
            reported = true
        end
        if ((item_replicator.is(gen) == false and not item_replicator_settings.allow_unknown) and not reported) or item_replicator.bl_is(gen) then
            meta:set_string("infotext", "Item Replicator V3 [Invalid Product] (" .. meta:get_string("owner") .. ")")
            reported = true
        end

        if item_replicator_settings.log_deep then
            minetest.log("action", "[item_replicator] 181")
        end
        minetest.swap_node(pos, {name ="item_replicator:replicator2"})
        return false
    end
    process=process+4 -- Item Replicator V3 is 4 times faster than Item Replicator (or 2 times faster than the Item Replicator V2)
    if item_replicator.is(gen) and not item_replicator.bl_is(gen) then
        if process>=item_replicator.get_time(gen) then
            process=0
            for i=1,item_replicator.get_amount(gen),1 do
                if inv:room_for_item("done",gen)==true then -- Only works if there is room
                    inv:add_item("done",gen)
                end
            end
            if item_replicator_settings.log_production then
                minetest.log("action", "[item_replicator] item_replicator:replicator2_active at ("..pos.x..", "..pos.y..", "..pos.z..") by '"..meta:get_string("owner").."' has produced '"..gen.."' x "..item_replicator.get_amount(gen))
            end
        end
    elseif item_replicator_settings.allow_unknown and not item_replicator.bl_is(gen) then
        if process>=item_replicator_settings.unknown_item_time then
            process=0
            for i=1,item_replicator_settings.unknown_item_amount,1 do
                if inv:room_for_item("done",gen)==true then -- Only works if there is room
                    inv:add_item("done",gen)
                end
            end
            if item_replicator_settings.log_production then
                minetest.log("action", "[item_replicator] item_replicator:replicator2_active at ("..pos.x..", "..pos.y..", "..pos.z..") by '"..meta:get_string("owner").."' has produced '"..gen.."' x "..item_replicator_settings.unknown_item_amount)
            end
        end
    end
    meta:set_int("proc",process)
    -- Let's really use a percent rather than some made up stuff.
    local percent = ((process/item_replicator.get_time(gen)) * 100)
    local percent_format = string.format("%.0f", percent)
    item_replicator_internal.inv_update(pos) -- Update the formspec for the new percent
    meta:set_string("infotext", "Item Replicator V3 " .. percent_format  .."% (" .. meta:get_string("owner") .. ")")
    if item_replicator_settings.log_deep then
        minetest.log("action", "[item_replicator] item_replicator:replicator2_active at ("..pos.x..", "..pos.y..", "..pos.z..") by '"..meta:get_string("owner").."' will produce '"..gen.."' x "..item_replicator.get_amount(gen).." every "..item_replicator.get_time(gen).." second(s)")
        minetest.log("action", "[item_replicator] currently it's at "..percent_format.."%")
    end
    return true
end

-- Attempt to get the MCL formspec to build a formspec able to be shown via their stuff
local mclform = rawget(_G, "mcl_formspec") or nil

-- This formspec will auto-change if MCL detected
item_replicator_internal.inv_update = function(pos)
    local meta=minetest.get_meta(pos)
    local inv=meta:get_inventory()
    local names=meta:get_string("names")
    local op=meta:get_int("open")
    local gen=inv:get_stack("gen",1):get_name() -- The item to be produced
    local open=""
    if op==0 then
        open="Only U"
    elseif op==1 then
        open="Members"
    else
        open="Public"
    end
    local state = meta:get_int("state")
    local proc = meta:get_int("proc")
    local percentage = ""
    if state~=0 then
        local percent = ((proc/item_replicator.get_time(gen)) * 100)
        local percent_format = string.format("%.0f", percent)
        percentage = ""..percent_format.."%"
    else
        percentage = "0%"
    end
    if item_replicator.game_mode() == "MTG" then
        meta:set_string("formspec",
            "size[8,11]" ..
            "label[0.3,0.3;"..minetest.formspec_escape(percentage).."]" ..
            "list[context;gen;2,0;1,1;]" ..
            "button[0,1; 1.5,1;save;Save]" ..
            "button[0,2; 1.5,1;open;" .. open .."]" ..
            "textarea[2.2,1.3;6,1.8;names;Members List (Inventory access);" .. names  .."]"..
            "list[context;done;0,2.9;8,4;]" ..
            "list[current_player;main;0,7;8,4;]" ..
            "listring[current_player;main]"  ..
            "listring[current_name;done]"
        )
    elseif item_replicator.game_mode() == "MCL" and mclform ~= nil then
        meta:set_string("formspec",
            "size[9, 10.5]"..
            "label[0.3,0.3;"..minetest.formspec_escape(percentage).."]"..
            "list[context;gen;2,0;1,1;]"..
            mclform.get_itemslot_bg(2, 0, 1, 1)..
            "button[0,1; 1.9,1;save;Save]"..
            "button[0,2; 1.9,1;open;" .. open .."]" ..
            "label[2.16, 0.9;Members List (Inventory Access)]"..
            "textarea[2.2,1.3;6,1.8;names;;" .. names  .."]"..
            "list[context;done;0,2.9;9,3;]" ..
            mclform.get_itemslot_bg(0, 2.9, 9, 3)..
            "label[0,5.85;"..minetest.formspec_escape("Inventory").."]"..
--            "list[current_player;main;0,6.5;9,4;]" ..
--            mclform.get_itemslot_bg(0, 6.5, 9, 4)..
		    "list[current_player;main;0,6.5;9,3;9]"..
		    mclform.get_itemslot_bg(0,6.5,9,3)..
		    "list[current_player;main;0,9.74;9,1;]"..
		    mclform.get_itemslot_bg(0,9.74,9,1)..
            "listring[current_player;main]"  ..
            "listring[current_name;done]"
        )
    end
end

item_replicator_internal.inv = function (placer, pos)
    local meta=minetest.get_meta(pos)
    item_replicator_internal.inv_update(pos)
    meta:set_string("infotext", "Item Replicator (" .. placer:get_player_name() .. ")")
end

item_replicator_internal.inv1 = function (placer, pos)
    local meta=minetest.get_meta(pos)
    item_replicator_internal.inv_update(pos)
    meta:set_string("infotext", "Item Replicator V2 (" .. placer:get_player_name() .. ")")
end

item_replicator_internal.inv2 = function (placer, pos)
    local meta=minetest.get_meta(pos)
    item_replicator_internal.inv_update(pos)
    meta:set_string("infotext", "Item Replicator V3 (" .. placer:get_player_name() .. ")")
end

-- Now we use all this to make our machine
local mod_name = "item_replicator_"
local extent = ".png"
local grouping = nil
local sounding = nil
if item_replicator.game_mode() == "MCL" then
    local mcl_sounds = rawget(_G, "mcl_sounds") or item_replicator_internal.throw_error("Failed to obtain MCL Sounds")
    grouping = {handy=1}
    sounding = mcl_sounds.node_sound_metal_defaults()
elseif item_replicator.game_mode() == "MTG" then
    local default = rawget(_G, "default") or item_replicator_internal.throw_error("Failed to obtain MTG Sounds")
    grouping = {crumbly = 3}
    sounding = default.node_sound_metal_defaults()
else
    grouping = {crumbly = 3, handy=1}
end
minetest.register_node("item_replicator:replicator", {
    short_description = "Item Replicator",
    description = "Item Replicator",
    _doc_items_long_desc = S("Replicators are technology from the future, they can replicate items so long as one has at least one of that item."),
    _dock_items_usagehelp = S("Place the item wished to be replicated on the very top slot, collect resources below, or add players (1 per line) to allow others and change to Members."),
    _dock_items_hidden=false,
    tiles = {
        mod_name.."plate_off"..extent,
        mod_name.."plate_off"..extent,
        mod_name.."plate_off"..extent,
        mod_name.."plate_off"..extent,
        mod_name.."plate_off"..extent,
        mod_name.."plate_off"..extent,
    },
    groups = grouping,
    sounds = sounding,
    paramtype2 = "facedir",
    light_source = 1,
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
        if item_replicator.game_mode() == "MTG" then
            inv:set_size("done", 32) -- 4*8
        elseif item_replicator.game_mode() == "MCL" then
            inv:set_size("done", 27) -- 3*9
        end
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
            if item_replicator_settings.log_deep then
                minetest.log("action", "[item_replicator] 208")
            end
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
            if item_replicator_settings.log_deep then
                minetest.log("action", "[item_replicator] 234")
            end
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
            if item_replicator_settings.log_deep then
                minetest.log("action", "[item_replicator] 268")
            end
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
    short_description = "Item Replicator",
    description = "Item Replicator",
    tiles = {
        mod_name.."plate_on"..extent,
        mod_name.."plate_on"..extent,
        mod_name.."plate_on"..extent,
        mod_name.."plate_on"..extent,
        mod_name.."plate_on"..extent,
        mod_name.."plate_on"..extent,
    },
    groups = grouping,
    sounds = sounding,
    paramtype2 = "facedir",
    light_source = 5,
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
            if item_replicator_settings.log_deep then
                minetest.log("action", "[item_replicator] 349")
            end
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
            if item_replicator_settings.log_deep then
                    minetest.log("action", "[item_replicator] 375")
            end
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
            if item_replicator_settings.log_deep then
                minetest.log("action", "[item_replicator] 409")
            end
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

minetest.register_node("item_replicator:replicator1", {
    short_description = "Item Replicator V2",
    description = "Item Replicator V2\nBonus: 2 times faster",
    _doc_items_long_desc = S("Replicators are technology from the future, they can replicate items so long as one has at least one of that item."),
    _dock_items_usagehelp = S("Place the item wished to be replicated on the very top slot, collect resources below, or add players (1 per line) to allow others and change to Members."),
    _dock_items_hidden=false,
    tiles = {
        mod_name.."plate2_off"..extent,
        mod_name.."plate2_off"..extent,
        mod_name.."plate2_off"..extent,
        mod_name.."plate2_off"..extent,
        mod_name.."plate2_off"..extent,
        mod_name.."plate2_off"..extent,
    },
    groups = grouping,
    sounds = sounding,
    paramtype2 = "facedir",
    light_source = 1,
    drop = "item_replicator:replicator1",
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("infotext", "Item Replicator V2")
        meta:set_string("owner", "")
        meta:set_int("open", 0)
        meta:set_int("state", 0)
        meta:set_string("names", "")
        meta:set_int("proc", 0)
        local inv = meta:get_inventory()
        if item_replicator.game_mode() == "MTG" then
            inv:set_size("done", 32) -- 4*8
        elseif item_replicator.game_mode() == "MCL" then
            inv:set_size("done", 27) -- 3*9
        end
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
            if item_replicator_settings.log_deep then
                minetest.log("action", "[item_replicator] 660")
            end
            minetest.swap_node(pos, {name ="item_replicator:replicator1_active"})
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
            if item_replicator_settings.log_deep then
                minetest.log("action", "[item_replicator] 686")
            end
            minetest.swap_node(pos, {name ="item_replicator:replicator1_active"})
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
            if item_replicator_settings.log_deep then
                minetest.log("action", "[item_replicator] 720")
            end
            minetest.swap_node(pos, {name ="item_replicator:replicator1_active"})
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
            item_replicator_internal.inv1(sender,pos)
        end

        if fields.open then
            local open=meta:get_int("open")
            open=open+1
            if open>2 then open=0 end
            meta:set_int("open",open)
            item_replicator_internal.inv1(sender,pos)
        end
    end,
    on_timer = function(pos, elapsed)
        return item_replicator_internal.update1(pos, elapsed)
    end
})

minetest.register_node("item_replicator:replicator1_active", {
    short_description = "Item Replicator V2",
    description = "Item Replicator V2\nBonus: 2 times faster",
    tiles = {
        mod_name.."plate2_on"..extent,
        mod_name.."plate2_on"..extent,
        mod_name.."plate2_on"..extent,
        mod_name.."plate2_on"..extent,
        mod_name.."plate2_on"..extent,
        mod_name.."plate2_on"..extent,
    },
    groups = grouping,
    sounds = sounding,
    paramtype2 = "facedir",
    light_source = 6,
    drop = "item_replicator:replicator1",
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("infotext", "Item Replicator V2")
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
            if item_replicator_settings.log_deep then
                minetest.log("action", "[item_replicator] 802")
            end
            minetest.swap_node(pos, {name ="item_replicator:replicator1_active"})
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
            if item_replicator_settings.log_deep then
                    minetest.log("action", "[item_replicator] 828")
            end
            minetest.swap_node(pos, {name ="item_replicator:replicator1_active"})
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
            if item_replicator_settings.log_deep then
                minetest.log("action", "[item_replicator] 862")
            end
            minetest.swap_node(pos, {name ="item_replicator:replicator1_active"})
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
            item_replicator_internal.inv1(sender,pos)
        end

        if fields.open then
            local open=meta:get_int("open")
            open=open+1
            if open>2 then open=0 end
            meta:set_int("open",open)
            item_replicator_internal.inv1(sender,pos)
        end
    end,
    on_timer = function(pos, elapsed)
        return item_replicator_internal.update1(pos, elapsed)
    end
})

minetest.register_node("item_replicator:replicator2", {
    short_description = "Item Replicator V3",
    description = "Item Replicator V3\nBonus: 4 times faster",
    _doc_items_long_desc = S("Replicators are technology from the future, they can replicate items so long as one has at least one of that item."),
    _dock_items_usagehelp = S("Place the item wished to be replicated on the very top slot, collect resources below, or add players (1 per line) to allow others and change to Members."),
    _dock_items_hidden=false,
    tiles = {
        mod_name.."plate3_off"..extent,
        mod_name.."plate3_off"..extent,
        mod_name.."plate3_off"..extent,
        mod_name.."plate3_off"..extent,
        mod_name.."plate3_off"..extent,
        mod_name.."plate3_off"..extent,
    },
    groups = grouping,
    sounds = sounding,
    paramtype2 = "facedir",
    light_source = 2,
    drop = "item_replicator:replicator2",
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("infotext", "Item Replicator V3")
        meta:set_string("owner", "")
        meta:set_int("open", 0)
        meta:set_int("state", 0)
        meta:set_string("names", "")
        meta:set_int("proc", 0)
        local inv = meta:get_inventory()
        if item_replicator.game_mode() == "MTG" then
            inv:set_size("done", 32) -- 4*8
        elseif item_replicator.game_mode() == "MCL" then
            inv:set_size("done", 27) -- 3*9
        end
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
            if item_replicator_settings.log_deep then
                minetest.log("action", "[item_replicator] 952")
            end
            minetest.swap_node(pos, {name ="item_replicator:replicator2_active"})
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
            if item_replicator_settings.log_deep then
                minetest.log("action", "[item_replicator] 978")
            end
            minetest.swap_node(pos, {name ="item_replicator:replicator2_active"})
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
            if item_replicator_settings.log_deep then
                minetest.log("action", "[item_replicator] 1012")
            end
            minetest.swap_node(pos, {name ="item_replicator:replicator2_active"})
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
            item_replicator_internal.inv2(sender,pos)
        end

        if fields.open then
            local open=meta:get_int("open")
            open=open+1
            if open>2 then open=0 end
            meta:set_int("open",open)
            item_replicator_internal.inv2(sender,pos)
        end
    end,
    on_timer = function(pos, elapsed)
        return item_replicator_internal.update2(pos, elapsed)
    end
})

minetest.register_node("item_replicator:replicator2_active", {
    short_description = "Item Replicator V3",
    description = "Item Replicator V3\nBonus: 4 times faster",
    tiles = {
        mod_name.."plate3_on"..extent,
        mod_name.."plate3_on"..extent,
        mod_name.."plate3_on"..extent,
        mod_name.."plate3_on"..extent,
        mod_name.."plate3_on"..extent,
        mod_name.."plate3_on"..extent,
    },
    groups = grouping,
    sounds = sounding,
    paramtype2 = "facedir",
    light_source = 7,
    drop = "item_replicator:replicator2",
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("infotext", "Item Replicator V3")
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
            if item_replicator_settings.log_deep then
                minetest.log("action", "[item_replicator] 1094")
            end
            minetest.swap_node(pos, {name ="item_replicator:replicator2_active"})
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
            if item_replicator_settings.log_deep then
                    minetest.log("action", "[item_replicator] 1120")
            end
            minetest.swap_node(pos, {name ="item_replicator:replicator2_active"})
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
            if item_replicator_settings.log_deep then
                minetest.log("action", "[item_replicator] 1154")
            end
            minetest.swap_node(pos, {name ="item_replicator:replicator2_active"})
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
            item_replicator_internal.inv2(sender,pos)
        end

        if fields.open then
            local open=meta:get_int("open")
            open=open+1
            if open>2 then open=0 end
            meta:set_int("open",open)
            item_replicator_internal.inv2(sender,pos)
        end
    end,
    on_timer = function(pos, elapsed)
        return item_replicator_internal.update2(pos, elapsed)
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
    -- Upgrades by fire
    -- IR to IRV2
    minetest.register_craft({
        type = "cooking",
        output = "item_replicator:replicator1",
        recipe = "item_replicator:replicator",
        cooktime = 375 -- You get 25 seconds off if it's not active
    })
    -- IR Active to IRV2
    minetest.register_craft({
        type = "cooking",
        output = "item_replicator:replicator1",
        recipe = "item_replicator:replicator_active",
        cooktime = 400
    })
    -- IRV2 to IRV3
    minetest.register_craft({
        type = "cooking",
        output = "item_replicator:replicator2",
        recipe = "item_replicator:replicator1",
        cooktime = 475 -- You get 25 seconds off if it's not active
    })
    -- IRV2 Active to IRV3
    minetest.register_craft({
        type = "cooking",
        output = "item_replicator:replicator2",
        recipe = "item_replicator:replicator1_active",
        cooktime = 500
    })
end

-- Allow a "recycle" feature
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
-- V2
minetest.register_craft({
    type = "fuel",
    recipe = "item_replicator:replicator1",
    burntime = 400
})
minetest.register_craft({
    type = "fuel",
    recipe = "item_replicator:replicator1_active",
    burntime = 400
})
-- V3
minetest.register_craft({
    type = "fuel",
    recipe = "item_replicator:replicator2",
    burntime = 500
})
minetest.register_craft({
    type = "fuel",
    recipe = "item_replicator:replicator2_active",
    burntime = 500
})

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
-- V2
minetest.register_craft({
    type = "shapeless",
    output = "item_replicator:replicator1",
    recipe = {
        "item_replicator:replicator1_active",
    }
})
minetest.register_craft({
    type = "shapeless",
    output = "item_replicator:replicator1_active",
    recipe = {
        "item_replicator:replicator1",
    }
})
-- V3
minetest.register_craft({
    type = "shapeless",
    output = "item_replicator:replicator2",
    recipe = {
        "item_replicator:replicator2_active",
    }
})
minetest.register_craft({
    type = "shapeless",
    output = "item_replicator:replicator2_active",
    recipe = {
        "item_replicator:replicator2",
    }
})
