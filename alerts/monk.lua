function EventAlert_LoadAlerts_Monk()

-- Custom
	if EA_CustomItems[EA_CLASS_MONK] == nil then EA_CustomItems[EA_CLASS_MONK] = {} end;

-- Normal
	if EA_Items[EA_CLASS_MONK] == nil then EA_Items[EA_CLASS_MONK] = {} end;

		-- Combo Breaker
			if EA_Items[EA_CLASS_MONK][116768] == nil then EA_Items[EA_CLASS_MONK][116768] = true end;

-- Alternate
	if EA_AltItems[EA_CLASS_MONK] == nil then EA_AltItems[EA_CLASS_MONK] = {} end;


--Stacking
	if EA_StackingItems[EA_CLASS_MONK] == nil then EA_StackingItems[EA_CLASS_MONK] = {} end;
	if EA_StackingItemsCounts[EA_CLASS_MONK] == nil then EA_StackingItemsCounts[EA_CLASS_MONK] = {} end;

		-- Chi
			if EA_StackingItems[EA_CLASS_MONK][EA_CLASS_MONK_POWER_SPELLID] == nil then EA_StackingItems[EA_CLASS_MONK][EA_CLASS_MONK_POWER_SPELLID] = true end;
			if EA_StackingItemsCounts[EA_CLASS_MONK][EA_CLASS_MONK_POWER_SPELLID] == nil then EA_StackingItemsCounts[EA_CLASS_MONK][EA_CLASS_MONK_POWER_SPELLID] = 4 end;

		-- Elusive Brew
			if EA_StackingItems[EA_CLASS_MONK][128939] == nil then EA_StackingItems[EA_CLASS_MONK][128939] = true end;
			if EA_StackingItemsCounts[EA_CLASS_MONK][128939] == nil then EA_StackingItemsCounts[EA_CLASS_MONK][128939] = 15 end;

--All credit goes to the original author, CurtisTheGreat
end
