-- The API

function item_clone.add(itemstring, amount, time)
    if not item_clone.is(itemstring) then
        table.insert(item_clone_items, {itemstring, amount, time})
        if item_clone_settings["log_api"] then
            minetest.log("action", "[item_clone] API Add (Insert) {'"..itemstring.."', "..amount..", "..time.."}")
        end
    else
        local index = 0
        for ind, val in pairs(item_clone_items) do
            if val[1] == itemstring then
                break
            end
            index = index + 1
        end
        item_clone_items[index] = {itemstring, amount, time}
        if item_clone_settings["log_api"] then
            minetest.log("action", "[item_clone] API Add (Update) {'"..itemstring.."', "..amount..", "..time.."}")
        end
    end
end

function item_clone.is(itemstring)
    local result = false
    for ind, val in pairs(item_clone_items) do
        if val[1] == itemstring then
            result = true
            break
        end
    end
    if result then
        if item_clone_settings["log_api"] then
            minetest.log("action", "[item_clone] API Is '"..itemstring.."' == true")
        end
        return true
    end
    if item_clone_settings["log_api"] then
        minetest.log("action", "[item_clone] API Is '"..itemstring.."' == false")
    end
    return false
end

function item_clone.get_amount(itemstring)
    if item_clone.is(itemstring) then
        for ind, val in pairs(item_clone_items) do
            if val[1] == itemstring then
                if item_clone_settings["log_api"] then
                    minetest.log("action", "[item_clone] API get_amount '"..itemstring.."' x "..val[2])
                end
                return val[2]
            end
        end
    end
    if item_clone_settings["log_api"] then
        minetest.log("action", "[item_clone] API get_amount '"..itemstring.."' was not found, return 1")
    end
    return 1
end

function item_clone.get_time(itemstring)
    if item_clone.is(itemstring) then
        for ind, val in pairs(item_clone_items) do
            if val[1] == itemstring then
                if item_clone_settings["log_api"] then
                    minetest.log("action", "[item_clone] API get_time '"..itemstring.."' @ "..val[3].." second(s)")
                end
                return val[3]
            end
        end
    end
    if item_clone_settings["log_api"] then
        minetest.log("action", "[item_clone] API get_time '"..itemstring.."' was not found, returning "..item_clone_settings["unknown_item_time"].." second(s)")
    end
    return item_clone_settings["unknown_item_time"]
end

function item_clone.remove(itemstring)
    if item_clone.is(itemstring) then
        local index = 0
        for ind, val in pairs(item_clone_items) do
            if val[1] == itemstring then
                break
            end
            index = index + 1
        end
        table.remove(item_clone_items, index)
        if item_clone_settings["log_api"] then
            minetest.log("action", "[item_clone] API remove '"..itemstring.."' was removed")
        end
    end
    if item_clone_settings["log_api"] then
        minetest.log("action", "[item_clone] API remove '"..itemstring.."' was not found, ignoring")
    end
end
