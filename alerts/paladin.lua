function EventAlert_LoadAlerts_Paladin()

	-- Init if not exists
	if EA_CustomItems[EA_CLASS_PALADIN] == nil then EA_CustomItems[EA_CLASS_PALADIN] = {} end;

	if EA_Items[EA_CLASS_PALADIN] == nil then EA_Items[EA_CLASS_PALADIN] = {} end;

	if EA_StackingItems[EA_CLASS_PALADIN] == nil then EA_StackingItems[EA_CLASS_PALADIN] = {} end;
    if EA_StackingItemsCounts[EA_CLASS_PALADIN] == nil then EA_StackingItemsCounts[EA_CLASS_PALADIN] = {} end;

    if EA_AltItems[EA_CLASS_PALADIN] == nil then EA_AltItems[EA_CLASS_PALADIN] = {} end;

    -- Normal
    -- Righteous Verdict
    if EA_Items[EA_CLASS_PALADIN][267611] == nil then EA_Items[EA_CLASS_PALADIN][267611] = true end;

    -- Grand Crusader
    if EA_Items[EA_CLASS_PALADIN][85416] == nil then EA_Items[EA_CLASS_PALADIN][85416] = true end;

    -- Divine Purpose
    if EA_Items[EA_CLASS_PALADIN][223819] == nil then EA_Items[EA_CLASS_PALADIN][223819] = true end;

    -- Blade of Wrath (disabled by default, tracking Blade of Justice "glow" instead)
    if EA_Items[EA_CLASS_PALADIN][281178] == nil then EA_Items[EA_CLASS_PALADIN][281178] = false end;

    -- Infusion of Light
    if EA_Items[EA_CLASS_PALADIN][54149] == nil then EA_Items[EA_CLASS_PALADIN][54149] = true end;

    -- Avenger's Valor (100% proc, disabled by default)
    if EA_Items[EA_CLASS_PALADIN][197561] == nil then EA_Items[EA_CLASS_PALADIN][197561] = false end;

    -- Alternate
    -- Hammer of Wrath
	if EA_AltItems[EA_CLASS_PALADIN][24275] == nil then EA_AltItems[EA_CLASS_PALADIN][24275] = true end;

	-- Blade of Justice
    if EA_AltItems[EA_CLASS_PALADIN][184575] == nil then EA_AltItems[EA_CLASS_PALADIN][184575] = true end;

    -- Avenger's Shield
	if EA_AltItems[EA_CLASS_PALADIN][31935] == nil then EA_AltItems[EA_CLASS_PALADIN][31935] = true end;

	-- Stacking
	-- Zeal (100% proc, disabled by default)
	if EA_StackingItems[EA_CLASS_PALADIN][269571] == nil then EA_StackingItems[EA_CLASS_PALADIN][269571] = false end;
	if EA_StackingItemsCounts[EA_CLASS_PALADIN][269571] == nil then EA_StackingItemsCounts[EA_CLASS_PALADIN][269571] = 1 end;

	-- Divine Judgment (100% proc, disabled by default)
    if EA_StackingItems[EA_CLASS_PALADIN][271581] == nil then EA_StackingItems[EA_CLASS_PALADIN][271581] = true end;
    if EA_StackingItemsCounts[EA_CLASS_PALADIN][271581] == nil then EA_StackingItemsCounts[EA_CLASS_PALADIN][271581] = 4 end;

    -- Selfless Healer
    if EA_StackingItems[EA_CLASS_PALADIN][114250] == nil then EA_StackingItems[EA_CLASS_PALADIN][114250] = true end;
    if EA_StackingItemsCounts[EA_CLASS_PALADIN][114250] == nil then EA_StackingItemsCounts[EA_CLASS_PALADIN][114250] = 4 end;

    -- Holy Power
    if EA_StackingItems[EA_CLASS_PALADIN][EA_CLASS_PALADIN_POWER_SPELLID] == nil then EA_StackingItems[EA_CLASS_PALADIN][EA_CLASS_PALADIN_POWER_SPELLID] = true end;
    if EA_StackingItemsCounts[EA_CLASS_PALADIN][EA_CLASS_PALADIN_POWER_SPELLID] == nil then EA_StackingItemsCounts[EA_CLASS_PALADIN][EA_CLASS_PALADIN_POWER_SPELLID] = 3 end;

--All credit goes to the original author, CurtisTheGreat
end
