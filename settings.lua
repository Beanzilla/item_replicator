
-- Settings
item_replicator_settings = {}

-- Do we log the api calls? (Great for debugging issues but not so good on a long running production server)
item_replicator_settings.log_api = false

-- Do we log that items were produced? (Great for debugging issues but not so good on a long running production server)
item_replicator_settings.log_production = true

-- Do we log deep into the bowels of the replicator?
item_replicator_settings.log_deep = false

-- Does the blacklist remove items from the allowed list if someone or mod added the item to the blacklist?
item_replicator_settings.blacklist_removes_allowed = true

-- Does the mod not allow the Replicator to be replicated by a Replicator?
item_replicator_settings.allow_self_replication = false

-- Testing the API (Turn these false when not testing)
item_replicator_settings.run_test = true
item_replicator_settings.exit_after_test = false

-- If an item is not in the known items list it will equal this value
item_replicator_settings.allow_unknown = true
item_replicator_settings.unknown_item_time = 30
item_replicator_settings.unknown_item_amount = 1

-- Is the Replicator craftable?
item_replicator_settings.craft = true