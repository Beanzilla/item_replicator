-- The API

function item_replicator.add(itemstring, amount, time)
    if not item_replicator.is(itemstring) then
        table.insert(item_replicator_items, {itemstring, amount, time})
        if item_replicator_settings.log_api then
            minetest.log("action", "[item_replicator] API Add (Insert) {'"..itemstring.."', "..amount..", "..time.."}")
        end
    else
        local index = 1
        for ind, val in pairs(item_replicator_items) do
            --minetest.log("action", "[item_replicator] API Add (dump) "..ind.." {'"..val[1].."', "..val[2]..", "..val[3].."}")
            if val[1] == itemstring then
                break
            end
            index = index + 1
        end
        item_replicator_items[index] = {itemstring, amount, time}
        if item_replicator_settings.log_api then
            minetest.log("action", "[item_replicator] API Add (Update) {'"..itemstring.."', "..amount..", "..time.."}")
        end
    end
end

function item_replicator.is(itemstring)
    local result = false
    for ind, val in pairs(item_replicator_items) do
        if val[1] == itemstring then
            result = true
            break
        end
    end
    if result then
        if item_replicator_settings.log_api then
            minetest.log("action", "[item_replicator] API Is '"..itemstring.."' == true")
        end
        return true
    end
    if item_replicator_settings.log_api then
        minetest.log("action", "[item_replicator] API Is '"..itemstring.."' == false")
    end
    return false
end

function item_replicator.get_amount(itemstring)
    if item_replicator.is(itemstring) then
        for ind, val in pairs(item_replicator_items) do
            if val[1] == itemstring then
                if item_replicator_settings.log_api then
                    minetest.log("action", "[item_replicator] API Get Amount '"..itemstring.."' x "..val[2])
                end
                return val[2]
            end
        end
    end
    if not item_replicator_settings.allow_unknown then
        if item_replicator_settings.log_api then
            minetest.log("action", "[item_replicator] API Get Amount '"..itemstring.."' was not found, return -1")
        end
        return -1
    else
        if item_replicator_settings.log_api then
            minetest.log("action", "[item_replicator] API Get Amount '"..itemstring.."' was not found, return "..item_replicator_settings.unknown_item_amount)
        end
        return item_replicator_settings.unknown_item_amount
    end
end

function item_replicator.get_time(itemstring)
    if item_replicator.is(itemstring) then
        for ind, val in pairs(item_replicator_items) do
            if val[1] == itemstring then
                if item_replicator_settings.log_api then
                    minetest.log("action", "[item_replicator] API Get Time '"..itemstring.."' @ "..val[3].." second(s)")
                end
                return val[3]
            end
        end
    end
    if not item_replicator_settings.allow_unknown then
        if item_replicator_settings.log_api then
            minetest.log("action", "[item_replicator] API Get Time '"..itemstring.."' was not found, returning -1 second(s)")
        end
        return -1
    else
        if item_replicator_settings.log_api then
            minetest.log("action", "[item_replicator] API Get Time '"..itemstring.."' was not found, return "..item_replicator_settings.unknown_item_time)
        end
        return item_replicator_settings.unknown_item_time
    end
end

function item_replicator.remove(itemstring)
    if item_replicator.is(itemstring) then
        local index = 1
        for ind, val in pairs(item_replicator_items) do
            --minetest.log("action", "[item_replicator] API Remove (dump) "..ind.." {'"..val[1].."', "..val[2]..", "..val[3].."}")
            if val[1] == itemstring then
                break
            end
            index = index + 1
        end
        table.remove(item_replicator_items, index)
        if item_replicator_settings.log_api then
            minetest.log("action", "[item_replicator] API Remove '"..itemstring.."' was removed")
        end
    else
        if item_replicator_settings.log_api then
            minetest.log("action", "[item_replicator] API Remove '"..itemstring.."' was not found, ignoring")
        end
    end
end

-- API for blacklist
function item_replicator.bl_is(itemstring)
    local result = false
    for ind, val in pairs(item_replicator_blacklist) do
        if val[1] == itemstring then
            result = true
            break
        end
    end
    if result then
        if item_replicator_settings.log_api then
            minetest.log("action", "[item_replicator] API Black Is '"..itemstring.."' == true")
        end
        return true
    end
    if item_replicator_settings.log_api then
        minetest.log("action", "[item_replicator] API Black Is '"..itemstring.."' == false")
    end
    return false
end

function item_replicator.bl_add(itemstring)
    if not item_replicator.bl_is(itemstring) then
        table.insert(item_replicator_blacklist, {itemstring})
        if item_replicator_settings.log_api then
            minetest.log("action", "[item_replicator] API Blacklist Add '"..itemstring.."' was added")
        end
        if item_replicator_settings.blacklist_removes_allowed and item_replicator.is(itemstring) then
            if item_replicator_settings.log_api then
                minetest.log("action", "[item_replicator] API Blacklist Add '"..itemstring.."' was removed from the known/allowed list")
            end
            item_replicator.remove(itemstring)
        end
    else
        if item_replicator_settings.log_api then
            minetest.log("action", "[item_replicator] API Blacklist Add '"..itemstring.."' was already found, ignoring")
        end
        -- If this gets called again do another check just in case (Not really a big deal though)
        if item_replicator_settings.blacklist_removes_allowed and item_replicator.is(itemstring) then
            if item_replicator_settings.log_api then
                minetest.log("action", "[item_replicator] API Blacklist Add '"..itemstring.."' was removed from the known/allowed list")
            end
            item_replicator.remove(itemstring)
        end
    end
end

function item_replicator.bl_remove(itemstring)
    if item_replicator.bl_is(itemstring) then
        local index = 1
        for ind, val in pairs(item_replicator_items) do
            --minetest.log("action", "[item_replicator] API Remove (dump) "..ind.." {'"..val[1].."', "..val[2]..", "..val[3].."}")
            if val[1] == itemstring then
                break
            end
            index = index + 1
        end
        table.remove(item_replicator_blacklist, index)
        if item_replicator_settings.log_api then
            minetest.log("action", "[item_replicator] API Blacklist Remove '"..itemstring.."' was removed")
        end
    else
        if item_replicator_settings.log_api then
            minetest.log("action", "[item_replicator] API Blacklist Remove '"..itemstring.."' was not found, ignoring")
        end
    end
end
