# Item Clone > Internal Assitant Functions

Inside my mod I use a variety of little or big functions which help me perform some test or task with ease.

Some are used only for testing, others are used directly by the mod's main functions. (Like it's API or even else where)

## Version

This will simply be used to obtain a string of the version you are using.

It's also used by me to make automatic update reminders for the older versions. (Just to encourage folks to use the latest)

## Game Mode

This simply attempts to identify what game you are running.

E.G. MTG, MCL2.

## Throw Error

This is a function typically seen in the testing (test.lua) file.

Simply put it logs to minetest logs an error message, the current version of my mod, attemt's to get what game your running,
and encourages you to make an issue with your logs.