function EventAlert_LoadAlerts_Druid()

-- Custom
	if EA_CustomItems[EA_CLASS_DRUID] == nil then EA_CustomItems[EA_CLASS_DRUID] = {} end;

-- Normal
	if EA_Items[EA_CLASS_DRUID] == nil then EA_Items[EA_CLASS_DRUID] = {} end;

    -- Mangle!
      if EA_Items[EA_CLASS_DRUID][93622] == nil then EA_Items[EA_CLASS_DRUID][93622] = true end;

		-- Predatory Swiftness
			if EA_Items[EA_CLASS_DRUID][69369] == nil then EA_Items[EA_CLASS_DRUID][69369] = true end;

	 -- Clearcasting (Omen of Clarity)
			if EA_Items[EA_CLASS_DRUID][16870] == nil then EA_Items[EA_CLASS_DRUID][16870] = true end;

	 -- Shooting Stars
			if EA_Items[EA_CLASS_DRUID][93400] == nil then EA_Items[EA_CLASS_DRUID][93400] = true end;

		-- Guardian of Elune
		  if EA_Items[EA_CLASS_DRUID][213680] == nil then EA_Items[EA_CLASS_DRUID][213680] = true end;

		-- Galactic Guardian
		 	if EA_Items[EA_CLASS_DRUID][213708] == nil then EA_Items[EA_CLASS_DRUID][213708] = true end;

		-- Soul of the Forest
			if EA_Items[EA_CLASS_DRUID][114108] == nil then EA_Items[EA_CLASS_DRUID][114108] = true end;


-- Alternate
	if EA_AltItems[EA_CLASS_DRUID] == nil then EA_AltItems[EA_CLASS_DRUID] = {} end;

		-- Mangle
			if EA_AltItems[EA_CLASS_DRUID][93622] ~= nil then EA_AltItems[EA_CLASS_DRUID][93622] = nil end;

-- Stacking
	if EA_StackingItems[EA_CLASS_DRUID] == nil then EA_StackingItems[EA_CLASS_DRUID] = {} end;
	if EA_StackingItemsCounts[EA_CLASS_DRUID] == nil then EA_StackingItemsCounts[EA_CLASS_DRUID] = {} end;

		-- Astral Power
			if EA_StackingItems[EA_CLASS_DRUID][EA_CLASS_DRUID_POWER_SPELLID] == nil then EA_StackingItems[EA_CLASS_DRUID][EA_CLASS_DRUID_POWER_SPELLID] = true end;
			if EA_StackingItemsCounts[EA_CLASS_DRUID][EA_CLASS_DRUID_POWER_SPELLID] == nil then EA_StackingItemsCounts[EA_CLASS_DRUID][EA_CLASS_DRUID_POWER_SPELLID] = 85 end;

		-- Combo Points
			if EA_StackingItems[EA_CLASS_DRUID][EA_COMBO_POINTS_POWER_SPELLID] == nil then EA_StackingItems[EA_CLASS_DRUID][EA_COMBO_POINTS_POWER_SPELLID] = true end;
			if EA_StackingItemsCounts[EA_CLASS_DRUID][EA_COMBO_POINTS_POWER_SPELLID] == nil then EA_StackingItemsCounts[EA_CLASS_DRUID][EA_COMBO_POINTS_POWER_SPELLID] = 5 end;

--All credit goes to the original author, CurtisTheGreat
end
