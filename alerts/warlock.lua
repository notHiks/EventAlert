function EventAlert_LoadAlerts_Warlock()

-- Custom
	if EA_CustomItems[EA_CLASS_WARLOCK] == nil then EA_CustomItems[EA_CLASS_WARLOCK] = {} end;

-- Normal
	if EA_Items[EA_CLASS_WARLOCK] == nil then EA_Items[EA_CLASS_WARLOCK] = {} end;

		-- Agony
			if EA_Items[EA_CLASS_WARLOCK][17941] == nil then EA_Items[EA_CLASS_WARLOCK][17941] = true end;

		-- Demonic Rebirth
			if EA_Items[EA_CLASS_WARLOCK][88448] == nil then EA_Items[EA_CLASS_WARLOCK][88448] = true end;

		-- Backdraft
			if EA_Items[EA_CLASS_WARLOCK][117828] == nil then EA_Items[EA_CLASS_WARLOCK][117828] = true end;

-- Alternate
	if EA_AltItems[EA_CLASS_WARLOCK] == nil then EA_AltItems[EA_CLASS_WARLOCK] = {} end;

		-- Shadowburn
			if EA_AltItems[EA_CLASS_WARLOCK][17877] == nil then EA_AltItems[EA_CLASS_WARLOCK][17877] = true end;

-- Stacking
	if EA_StackingItems[EA_CLASS_WARLOCK] == nil then EA_StackingItems[EA_CLASS_WARLOCK] = {} end;
	if EA_StackingItemsCounts[EA_CLASS_WARLOCK] == nil then EA_StackingItemsCounts[EA_CLASS_WARLOCK] = {} end;

		-- Havoc
			if EA_StackingItems[EA_CLASS_WARLOCK][80240] == nil then EA_StackingItems[EA_CLASS_WARLOCK][80240] = true end;
			if EA_StackingItemsCounts[EA_CLASS_WARLOCK][80240] == nil then EA_StackingItemsCounts[EA_CLASS_WARLOCK][80240] = 1 end;

		-- Backdraft (Clean up existing spell from variables since changed in legion - no more stacks)
			if EA_StackingItems[EA_CLASS_WARLOCK][117828] ~= nil then EA_StackingItems[EA_CLASS_WARLOCK][117828] = nil end;
			if EA_StackingItemsCounts[EA_CLASS_WARLOCK][117828] ~= nil then EA_StackingItemsCounts[EA_CLASS_WARLOCK][117828] = nil end;

		-- Soul Shards
			if EA_StackingItems[EA_CLASS_WARLOCK][EA_CLASS_WARLOCK_POWER_SPELLID] == nil then EA_StackingItems[EA_CLASS_WARLOCK][EA_CLASS_WARLOCK_POWER_SPELLID] = true end;
			if EA_StackingItemsCounts[EA_CLASS_WARLOCK][EA_CLASS_WARLOCK_POWER_SPELLID] == nil then EA_StackingItemsCounts[EA_CLASS_WARLOCK][EA_CLASS_WARLOCK_POWER_SPELLID] = 4 end;

--All credit goes to the original author, CurtisTheGreat
end
