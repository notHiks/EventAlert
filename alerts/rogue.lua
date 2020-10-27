function EventAlert_LoadAlerts_Rogue()

-- Custom
	if EA_CustomItems[EA_CLASS_ROGUE] == nil then EA_CustomItems[EA_CLASS_ROGUE] = {} end;

-- Normal
	if EA_Items[EA_CLASS_ROGUE] == nil then EA_Items[EA_CLASS_ROGUE] = {} end;

		-- Opportunity
		  if EA_Items[EA_CLASS_ROGUE][195627] == nil then EA_Items[EA_CLASS_ROGUE][195627] = true end;

		-- Roll the bones (disabled by default to avoid spam)
		-- Jolly Roger
			if EA_Items[EA_CLASS_ROGUE][199603] == nil then EA_Items[EA_CLASS_ROGUE][199603] = false end;
		-- Grand Melee
			if EA_Items[EA_CLASS_ROGUE][193358] == nil then EA_Items[EA_CLASS_ROGUE][193358] = false end;
		-- Shark Infested Waters
			if EA_Items[EA_CLASS_ROGUE][193357] == nil then EA_Items[EA_CLASS_ROGUE][193357] = false end;
		-- True Bearing
			if EA_Items[EA_CLASS_ROGUE][193359] == nil then EA_Items[EA_CLASS_ROGUE][193359] = false end;
		-- Buried Treasure
			if EA_Items[EA_CLASS_ROGUE][199600] == nil then EA_Items[EA_CLASS_ROGUE][199600] = false end;

-- Alternate
	if EA_AltItems[EA_CLASS_ROGUE] == nil then EA_AltItems[EA_CLASS_ROGUE] = {} end;

-- Stacking
	if EA_StackingItems[EA_CLASS_ROGUE] == nil then EA_StackingItems[EA_CLASS_ROGUE] = {} end;
	if EA_StackingItemsCounts[EA_CLASS_ROGUE] == nil then EA_StackingItemsCounts[EA_CLASS_ROGUE] = {} end;

		-- Alacrity
			if EA_StackingItems[EA_CLASS_ROGUE][193538] == nil then EA_StackingItems[EA_CLASS_ROGUE][193538] = true end;
			if EA_StackingItemsCounts[EA_CLASS_ROGUE][193538] == nil then EA_StackingItemsCounts[EA_CLASS_ROGUE][193538] = 1 end;

		-- Combo Points
			if EA_StackingItems[EA_CLASS_ROGUE][EA_COMBO_POINTS_POWER_SPELLID] == nil then EA_StackingItems[EA_CLASS_ROGUE][EA_COMBO_POINTS_POWER_SPELLID] = true end;
			if EA_StackingItemsCounts[EA_CLASS_ROGUE][EA_COMBO_POINTS_POWER_SPELLID] == nil then EA_StackingItemsCounts[EA_CLASS_ROGUE][EA_COMBO_POINTS_POWER_SPELLID] = 5 end;

--All credit goes to the original author, CurtisTheGreat
end
