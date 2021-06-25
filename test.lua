-- Test file for the API
minetest.log("action", "[item_clone] Test: ....")

-- Test adding an item (Insert and Update check
item_clone.add("default:dirt", 2, 15)
item_clone.add("default:dirt", 4, 10)
item_clone.add("default:dirt", 2, 15)

-- Test validity
if item_clone.is("default:dirt_with_grass") then
    item_clone_internal.throw_error("item_clone.is('default:dirt_with_grass') ~= false")
end
if not item_clone.is("default:dirt") then
    item_clone_internal.throw_error("item_clone.is('default:dirt') ~= true")
end

-- Test amounts
if item_clone.get_amount("default:dirt_with_grass") ~= 1 then
    item_clone_internal.throw_error("item_clone.get_amount('default:dirt_with_grass') ~= 1")
end
if item_clone.get_amount("default:dirt") ~= 2 then
    item_clone_internal.throw_error("item_clone.get_amount('default:dirt') ~= 2")
end

-- Test times
if item_clone.get_time("default:dirt_with_grass") ~= item_clone_settings["unknown_item_time"] then
    item_clone_internal.throw_error("item_clone.get_time('default:dirt_with_grass') ~= "..item_clone_settings["unknown_item_time"])
end
if item_clone.get_time("default:dirt") ~= 15 then
    item_clone_internal.throw_error("item_clone.get_time('default:dirt') ~= 15")
end

-- Test Cleanup (Also a test against removals)
item_clone.remove("default:dirt")
if item_clone.is("default:dirt") then
    item_clone_internal.throw_error("item_clone.remove('defualt:dirt') did not remove!")
end

-- If the user wants to... just have them exit
if item_clone_settings["exit_after_test"] then
    minetest.log("action", "[item_clone] Test: OKAY")
    error("[item_clone] Test: OKAY  (Your seeing this because exit_after_test is true)")
end

-- The user chosen to keep running... so let's just let them know the tests passed
minetest.log("action", "[item_clone] Test: OKAY")