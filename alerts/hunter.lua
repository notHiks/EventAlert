function EventAlert_LoadAlerts_Hunter()

	-- Init if not exists
	if EA_CustomItems[EA_CLASS_HUNTER] == nil then EA_CustomItems[EA_CLASS_HUNTER] = {} end;

	if EA_Items[EA_CLASS_HUNTER] == nil then EA_Items[EA_CLASS_HUNTER] = {} end;

	if EA_AltItems[EA_CLASS_HUNTER] == nil then EA_AltItems[EA_CLASS_HUNTER] = {} end;

	if EA_StackingItems[EA_CLASS_HUNTER] == nil then EA_StackingItems[EA_CLASS_HUNTER] = {} end;
	if EA_StackingItemsCounts[EA_CLASS_HUNTER] == nil then EA_StackingItemsCounts[EA_CLASS_HUNTER] = {} end;

	-- Normal
	-- Lethal Shots
	if EA_Items[EA_CLASS_HUNTER][260395] == nil then EA_Items[EA_CLASS_HUNTER][260395] = true end;

	-- Master Marksman
	if EA_Items[EA_CLASS_HUNTER][269576] == nil then EA_Items[EA_CLASS_HUNTER][269576] = true end;

	-- Mongoose fury
	if EA_Items[EA_CLASS_HUNTER][190931] == nil then EA_Items[EA_CLASS_HUNTER][190931] = true end;

	-- Wild Call
	if EA_Items[EA_CLASS_HUNTER][185791] == nil then EA_Items[EA_CLASS_HUNTER][185791] = true end;

	-- Lock and Load
	if EA_Items[EA_CLASS_HUNTER][194594] == nil then EA_Items[EA_CLASS_HUNTER][194594] = true end;

	-- Viper's Venom
	if EA_Items[EA_CLASS_HUNTER][268552] == nil then EA_Items[EA_CLASS_HUNTER][268552] = true end;

	-- Flanker's Advantage (Kill Command refresh)
	if EA_Items[EA_CLASS_HUNTER][259285] == nil then EA_Items[EA_CLASS_HUNTER][259285] = true end;

	-- Alternate
	-- Kill Command (Do not track the spell since refreshing itself makes it behave weirdly)
	-- if EA_AltItems[EA_CLASS_HUNTER][259489] == nil then EA_AltItems[EA_CLASS_HUNTER][259489] = true end;

	-- Stacking
	-- Precise Shots
	if EA_StackingItems[EA_CLASS_HUNTER][260242] == nil then EA_StackingItems[EA_CLASS_HUNTER][260242] = true end;
	if EA_StackingItemsCounts[EA_CLASS_HUNTER][260242] == nil then EA_StackingItemsCounts[EA_CLASS_HUNTER][260242] = 1 end;

	-- Steady Focus
	if EA_StackingItems[EA_CLASS_HUNTER][193534] == nil then EA_StackingItems[EA_CLASS_HUNTER][193534] = true end;
	if EA_StackingItemsCounts[EA_CLASS_HUNTER][193534] == nil then EA_StackingItemsCounts[EA_CLASS_HUNTER][193534] = 1 end;

	-- Tip of the Spear
	if EA_StackingItems[EA_CLASS_HUNTER][260286] == nil then EA_StackingItems[EA_CLASS_HUNTER][260286] = true end;
	if EA_StackingItemsCounts[EA_CLASS_HUNTER][260286] == nil then EA_StackingItemsCounts[EA_CLASS_HUNTER][260286] = 1 end;

	-- Mongoose Fury
	if EA_StackingItems[EA_CLASS_HUNTER][259388] == nil then EA_StackingItems[EA_CLASS_HUNTER][259388] = true end;
	if EA_StackingItemsCounts[EA_CLASS_HUNTER][259388] == nil then EA_StackingItemsCounts[EA_CLASS_HUNTER][259388] = 1 end;

	-- Mok'Nathal Tactics
	if EA_StackingItems[EA_CLASS_HUNTER][201081] == nil then EA_StackingItems[EA_CLASS_HUNTER][201081] = true end;
	if EA_StackingItemsCounts[EA_CLASS_HUNTER][201081] == nil then EA_StackingItemsCounts[EA_CLASS_HUNTER][201081] = 1 end;

--All credit goes to the original author, CurtisTheGreat
end
