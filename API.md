# Item Replicator > API

This mod comes with an Application Programming Interface.

## Add

A rather simple thing, inserts or updates based on if itemstring exists already.

> Does not return anything.

I.E.

```lua
-- Adds 2 default:dirt_with_grass every 15 seconds
item_replicator.add("default:dirt_with_grass", 2, 15)
```

# Bl(acklist) Add

Inserts the itemstring to the blacklist. (And if blacklist_removes_allowed is true also will remove it from allowed/known list)

The blacklist can be used to control/limit what can be replicated (by default the mod includes itself to prevent replicators replicating more replicators)

> Returns nothing

I.E.

```lua
-- Prevents default:dirt from being replicated
item_replicator.bl_add("default:dirt")

-- And lets assume default:sand was in the known/allowed list
-- Again with blacklist_removes_allowed == true (on) will not be in the allowed/known list
item_replicator.bl_add("default:sand") -- Now it's not allowed to be replicated and it's not in the known/allowed list.
```

## Is

Does the itemstring exist?

> Returns true if the itemstring does, else false.

I.E.

```lua
-- Tests if default:dirt exists
if item_replicator.is("default:dirt") then
    -- Do something
end

-- Tests if default:tree does not exist
if not item_replicator.is("default:tree") then
    -- Do something
end
```

## Bl(acklist) Is

Does the itemstring exist in the blacklist?

The blacklist is mainly used to prevent particular items from being replicated for a variety of reasons.

> Returns true if the itemstring does, else false.

I.E.

```lua
-- Tests if default:dirt exists in the blacklist
if item_replicator.bl_is("default:dirt") then
    -- Do something
end

-- Tests if default:tree does not exist in the blacklist
if not item_replicator.bl_is("default:tree") then
    -- Do something
end
```

## Get Amount

If the itemstring exists it will return the amount per process.

> If settings "allow_unknown" is true the returns settings "unknown_item_amount",
else returns -1 for not found

I.E.

```lua
-- Tests if defualt:dirt_with_grass produces 2 per process
if item_replicator.get_amount("default:dirt_with_grass") == 2 then
    -- Do something
end

-- Tests if default:dirt produces -1 per process (Assuming allow_unknown is false)
-- This is an alternate way to check if the item exists (-1 means not found)
if item_replicator.get_ammount("defualt:dirt") == -1 then
    -- Do something
end
```

## Get Time

If the itemstring exists it will return the number of seconds per process.

> If settings "allow_unknown" is true the returns settings "unknown_item_time",
else returns -1 for not found

I.E.

```lua
-- Tests if default:dirt_with_grass processes at 15 seconds
if item_replicator.get_time("default:dirt_with_grass") == 15 then
    -- Do something
end

-- Tests if default:dirt processes at -1 seconds (Assuming allow_unknown is false)
-- This is an alternate way to check if the item exists (-1 means not found)
if item_replicator.get_time("default:dirt") == -1 then
    -- Do something
end
```

## Remove

If the itemstring exists it will remove the item.

> Returns nothing

I.E.

```lua
-- Removes the item
item_replicator.remove("defualt:dirt_with_grass")

-- Then checks to ensure it's gone
if item_replicator.is("default:dirt_with_grass") then
    -- error("In this case it failed to remove")
    -- Because errors are frequently used in my mod in the testing (test.lua) I built my own error function
    item_replicator_internal.throw_error("In this case it failed to remove")
    -- It simply adds the error message and follows it with my mod version, attempts to identify what game you used,
    -- And promotes making an issue on my repo so I know something is broken.
end
```

## Bl(acklist) Remove

If the itemstring exists it will remove it from the blacklist.

The blacklist is mainly used to prevent particular items from being replicated for a variety of reasons.

> Returns nothing

I.E.

```lua
-- Removes the item from blacklist
item_replicator.bl_remove("default:dirt")

-- Then checks to ensure it's gone from the blacklist
if item_replicator.bl_is("default:dirt") then
    -- error("In this case it failed to remove")
end
```
