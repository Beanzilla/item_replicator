-- Only allow 0.05 minegeld (5 Minegeld Cent Coin) to be replicated
item_replicator.add("currency:minegeld_cent_5", 1, 60)

-- Blacklist everything else
item_replicator.bl_add("currency:minegeld_cent_10")
item_replicator.bl_add("currency:minegeld_cent_25")
item_replicator.bl_add("currency:minegeld")
item_replicator.bl_add("currency:minegeld_5")
item_replicator.bl_add("currency:minegeld_10")
item_replicator.bl_add("currency:minegeld_50")
item_replicator.bl_add("currency:minegeld_100")
item_replicator.bl_add("currency:minegeld_bundle")
