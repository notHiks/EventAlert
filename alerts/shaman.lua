function EventAlert_LoadAlerts_Shaman()

	-- Init if not exists
	if EA_CustomItems[EA_CLASS_SHAMAN] == nil then EA_CustomItems[EA_CLASS_SHAMAN] = {} end;

	if EA_Items[EA_CLASS_SHAMAN] == nil then EA_Items[EA_CLASS_SHAMAN] = {} end;

	if EA_AltItems[EA_CLASS_SHAMAN] == nil then EA_AltItems[EA_CLASS_SHAMAN] = {} end;

	if EA_StackingItems[EA_CLASS_SHAMAN] == nil then EA_StackingItems[EA_CLASS_SHAMAN] = {} end;
	if EA_StackingItemsCounts[EA_CLASS_SHAMAN] == nil then EA_StackingItemsCounts[EA_CLASS_SHAMAN] = {} end;

	-- Normal

	-- Elemental
	-- Hot hand
	if EA_Items[EA_CLASS_SHAMAN][215785] == nil then EA_Items[EA_CLASS_SHAMAN][215785] = true end;

	-- Lava Surge
	if EA_Items[EA_CLASS_SHAMAN][77762] == nil then EA_Items[EA_CLASS_SHAMAN][77762] = true end;

	-- Stormbringer
	if EA_Items[EA_CLASS_SHAMAN][201846] == nil then EA_Items[EA_CLASS_SHAMAN][201846] = true end;

	-- Alternate
		
	-- Earth Shock
	if EA_AltItems[EA_CLASS_SHAMAN][8042] == nil then EA_AltItems[EA_CLASS_SHAMAN][8042] = true end;

	-- Stacking

	-- Tidal Waves
	if EA_StackingItems[EA_CLASS_SHAMAN][53390] == nil then EA_StackingItems[EA_CLASS_SHAMAN][53390] = true end;
	if EA_StackingItemsCounts[EA_CLASS_SHAMAN][53390] == nil then EA_StackingItemsCounts[EA_CLASS_SHAMAN][53390] = 1 end;

	-- Maelstrom
	if EA_StackingItems[EA_CLASS_SHAMAN][EA_CLASS_SHAMAN_POWER_SPELLID] == nil then EA_StackingItems[EA_CLASS_SHAMAN][EA_CLASS_SHAMAN_POWER_SPELLID] = true end;
	if EA_StackingItemsCounts[EA_CLASS_SHAMAN][EA_CLASS_SHAMAN_POWER_SPELLID] == nil then EA_StackingItemsCounts[EA_CLASS_SHAMAN][EA_CLASS_SHAMAN_POWER_SPELLID] = 90 end;

--All credit goes to the original author, CurtisTheGreat
end
