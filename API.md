# Item Clone > API

This mod comes with an Application Programming Interface.

## Add

A rather simple thing, inserts or updates based on if itemstring exists already.

> Does not return anything.

I.E.

```lua
-- Adds 2 default:dirt_with_grass every 15 seconds
item_clone.add("default:dirt_with_grass", 2, 15)
```

## Is

Does the itemstring exist?

> Returns true if the itemstring does, else false.

I.E.

```lua
-- Tests if default:dirt exists
if item_clone.is("default:dirt") then
    -- Do something
end

-- Tests if default:tree does not exist
if not item_clone.is("default:tree") then
    -- Do something
end
```

## Get Amount

If the itemstring exists it will return the amount per process.

> Returns settings "unknown_item_amount" if the itemstring does not exist

I.E.

```lua
-- Tests if defualt:dirt_with_grass produces 2 per process
if item_clone.get_amount("default:dirt_with_grass") == 2 then
    -- Do something
end

-- Tests if default:dirt produces 1 per process
if item_clone.get_ammount("defualt:dirt") == 1 then
    -- Do something
end
```

## Get Time

If the itemstring exists it will return the number of seconds per process.

> Returns settings "unknown_item_time" if the itemstring does not exist

I.E.

```lua
-- Tests if default:dirt_with_grass processes at 15 seconds
if item_clone.get_time("default:dirt_with_grass") == 15 then
    -- Do something
end

-- Tests if default:dirt processes at 60 seconds (Default settings set unknown items to 60 seconds, adjust if wanted)
if item_clone.get_time("default:dirt") == 60 then
    -- Do something
end
```

## Remove

If the itemstring exists it will remove the item.

> Returns nothing

I.E.

```lua
-- Removes the item
item_clone.remove("defualt:dirt_with_grass")

-- Then checks to ensure it's gone
if item_clone.is("default:dirt_with_grass") then
    -- error("In this case it failed to remove")
    -- Because errors are frequently used in my mod in the testing (test.lua) I built my own error function
    item_clone_internal.throw_error("In this case it failed to remove")
    -- It simply adds the error message and follows it with my mod version, attempts to identify what game you used,
    -- And promotes making an issue on my repo so I know something is broken.
end
```
