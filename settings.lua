
-- Settings
item_clone_settings = {}

-- Do we log the api calls? (Great for debugging issues but not so good on a long running production server)
item_clone_settings["log_api"] = true

-- Do we log that items were produced? (Great for debugging issues but not so good on a long running production server)
item_clone_settings["log_production"] = true

-- Testing the API (Turn these false when not testing)
item_clone_settings["run_test"] = true
item_clone_settings["exit_after_test"] = true

-- If an item is not in the known items list it will equal this value
item_clone_settings["unknown_item_time"] = 30
item_clone_settings["unknown_item_amount"] = 1
