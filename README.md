# Item Replicator [![ContentDB](https://content.minetest.net/packages/ApolloX/item_replicator/shields/downloads/)](https://content.minetest.net/packages/ApolloX/item_replicator/)

Replicate items with ease.

## What's in the box

* [Unique API](API.md)
* [Internal Assitant Functions](INTERNALS.md)
* [Settings](SETTINGS.md)
* Multi-player support
* Security
* Multiple Games support (This mod supports MTG and MCL2)
* [Multiple Mods supported](mod_support.lua)

## Disclamers

This mod does "work" with MineClone2. (However there is a graphical issue in the formspec which adds some difficulty in navigation)

## Quick-Start

1. Get this repo!
2. Drop this directory/repo into your Minetest mods folder.
3. Edit settings.lua to your liking.
4. Add `load_mod_item_replicator = true` to your worlds world.mt file.
5. Enjoy the mod.

## A note about logging

This mod can dump a lot of information out to your log file (`debug.txt`).

Please turn off the following settings like so, below:

```lua
item_replicator_settings.log_api = false
item_replicator_settings.log_production = false -- Only turn this one off if really needed
item_replicator_settings.log_deep = false
```

## A note about items

This mod tracks a lot of information about items.

From it's itemstring to it's amount produced per process, or even the time between processes.

It may be easier for your server to simply run with allow_unknown to be true (on).

This will simply use the other settings below that (unknown_item_time, unknown_item_amount) when it encounters an unknown item.

Or for those who wish to better my mod and the community using it, please consider making a Pull Request with your additions/changes.
(See [mod_support.lua](mod_support.lua) for further details)

## Mods supported

* MTG default
* MTG beds
* MTG binoculars
* MTG boats
* MTG bones
* MTG bucket
* MTG butterflies
* MTG carts
* MTG doors
* MTG dye
* MTG farming (That is, built-in to MTG, not the extended one, just yet)
* MTG fire
* MTG fireflies
* MTG flowers
* MTG map
* MTG screwdriver
* MTG stairs (This may be incomplete, I tried to get everything)
* MTG tnt
* MTG vessels
* MTG walls
* MTG wool
* MTG xpanes (This may be incomplete, I tried to get everything)
