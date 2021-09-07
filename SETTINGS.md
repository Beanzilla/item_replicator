# Item Replicator > Settings

Where you can control the mod.

## Log API

This indicates if you want **ALL** API calls to be logged.

## Log Production

This will dump what was made where into your logs, helps track how many people are using replicators and what they are replicating.

## Log Deep

This will provide very low level logs of some areas of the API. (Later on there will also be logs in deep for everything)

## Run Test

This mod comes with a test!

It's rather a basic test, mainly for the API calls but still is a good thing to have either way.

This can be used to verify the API is working correctly and returns the correct values.

## Exit After Test

Does the mod automatically exit the game when the test is done?

## Blacklist removes allowed

Does the blacklist API remove an item (Thus making it unknown) for the allowed items list?

This allows for code like:

```lua
 -- A full stack every 1 process (every second)
item_replicator.add("default:dirt", 99, 1)

 -- Would remove the above from the known/allowed items list with this setting true (on)
item_replicator.bl_add("default:dirt")
```

## Allow self replication

Does the mod allow the Replicator to be replicated in a replicator?

Default is to not allow (false).

## Allow Unknown

Does the replicator allow unknown items to be produced?

This means anything from any mod could be produced without neeeding to be configured (Typically this means it's less efficient but stil works)

## Unknown Item Time

The time it takes for **ANY** unknown item to be produced.

## Unknown Item Amount

The amount produced for unknown items.

## Craft

Can you make the replicator or, is it only avalible by Admin shops or, only by Admins?

## Can I add/change some mods configuration for an item?

I would be glade to have someone else help me add values to other mods via using the [API](API.md).

A good example of this is to look at the mods already included inside the mods folder of this repo.

I made this mod to support creativity, so please by all means add other mods you use to the mods folder (again you can look at how I do some of this by looking at the other mods I already support).