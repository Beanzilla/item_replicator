
item_clone_internal.update = function (pos, elapsed)
	local meta=minetest.get_meta(pos)
	local inv=meta:get_inventory()
	local gen=inv:get_stack("gen",1):get_name() -- The item to be produced
	local process=meta:get_int("proc")

	if inv:is_empty("gen") or inv:room_for_item("done",gen)==false then
		minetest.get_node_timer(pos):stop()
		meta:set_int("proc", 0)
		if inv:room_for_item("done",gen)==false then
			meta:set_string("infotext", "Item Clone [Full] (" .. meta:get_string("owner") .. ")")
		end
		if inv:is_empty("gen") then
			meta:set_string("infotext", "Item Clone [No Product] (" .. meta:get_string("owner") .. ")")
		end

		minetest.swap_node(pos, {name ="item_clone:clone"})
		return false
	end
	process=process+1
	if process>=item_clone.get_time(gen) then
		process=0
        for i=1,item_clone.get_amount(gen),1 do
            if inv:room_for_item("done",gen)==true then -- Only works if there is room
        		inv:add_item("done",gen)
            end
        end
        if item_clone_settings["log_production"] then
    		minetest.log("action", "[item_clone] item_clone:clone_active at ("..pos.x..", "..pos.y..", "..pos.z..") by '"..meta:get_string("owner").."' has produced '"..gen.."' x "..item_clone.get_amount(gen))
        end
	end
	meta:set_int("proc",process)
	-- Let's really use a percent rather than some made up stuff.
	meta:set_string("infotext", "Item Clone " .. ((process/item_clone.get_time(gen)) * 100)  .."% (" .. meta:get_string("owner") .. ")")
	return true
end

item_clone_internal.inv = function (placer, pos)
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
		"list[context;gen;0,0;1,1;]" ..
		"button[0,1; 1.5,1;save;Save]" ..
		"button[0,2; 1.5,1;open;" .. open .."]" ..
		"textarea[2.2,1.3;6,1.8;names;Members list (allow members to take and add);" .. names  .."]"..
		"list[context;done;0,2.9;8,4;]" ..
		"list[current_player;main;0,7;8,4;]" ..
		"listring[current_player;main]"  ..
		"listring[current_name;done]"
	)
	meta:set_string("infotext", "Item Clone (" .. placer:get_player_name() .. ")")
end

-- Now we use all this to make our clone machine
minetest.register_node("item_clone:clone", {
    description = "Item Clone",
    tiles = {},
    groups = {dig_immediate = 3},
    paramtype2 = "facedir",
    light_source = 1,
    after_place_node = function(pos, placer, itemstack)
        local meta = minetest.get_meta(pos)
        meta:set_string("owner", placer:get_player_name())
        meta:set_int("open", 0)
        meta:set_string("names", "")
        meta:set_int("proc", 0)
        meta:set_int("state", 0)
        local inv = meta:get_inventory()
        inv:set_size("done", 32)
        inv:set_size("gen", 1)
        item_clone_internal.inv(placer,pos)
    end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
        local meta=minetest.get_meta(pos)
        local open=meta:get_int("open")
        local name=player:get_player_name()
        local owner=meta:get_string("owner")
        local count=0
        if name==owner and listname~="done" then count=stack:get_count() end
        if open>0 and listname=="done" then count=stack:get_count() end
        if count>0 and meta:get_int("type")==0 then
	        minetest.get_node_timer(pos):start(1)
	        minetest.swap_node(pos, {name ="item_clone:clone_active"})
        end
        return count
    end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
        local meta=minetest.get_meta(pos)
        local open=meta:get_int("open")
        local name=player:get_player_name()
        local owner=meta:get_string("owner")
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
        -- 
        return (player:get_player_name()==owner and
                owner~="")
    end,
})
