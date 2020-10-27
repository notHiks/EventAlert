function EventAlert_LoadAlerts_Mage()

-- Custom
	if EA_CustomItems[EA_CLASS_MAGE] == nil then EA_CustomItems[EA_CLASS_MAGE] = {} end;

--Normal
	if EA_Items[EA_CLASS_MAGE] == nil then EA_Items[EA_CLASS_MAGE] = {} end;

		-- Hot Streak
			if EA_Items[EA_CLASS_MAGE][48108] == nil then EA_Items[EA_CLASS_MAGE][48108] = true end;

		-- Inferno Blast (Heating Up)
			if EA_Items[EA_CLASS_MAGE][48107] == nil then EA_Items[EA_CLASS_MAGE][48107] = true end;

		-- Brain Freeze
			if EA_Items[EA_CLASS_MAGE][190446] == nil then EA_Items[EA_CLASS_MAGE][190446] = true end;

-- Alternate
	if EA_AltItems[EA_CLASS_MAGE] == nil then EA_AltItems[EA_CLASS_MAGE] = {} end;

-- Stacking
	if EA_StackingItems[EA_CLASS_MAGE] == nil then EA_StackingItems[EA_CLASS_MAGE] = {} end;
	if EA_StackingItemsCounts[EA_CLASS_MAGE] == nil then EA_StackingItemsCounts[EA_CLASS_MAGE] = {} end;

		-- Arcane Charge
			if EA_StackingItems[EA_CLASS_MAGE][EA_CLASS_MAGE_POWER_SPELLID] == nil then EA_StackingItems[EA_CLASS_MAGE][EA_CLASS_MAGE_POWER_SPELLID] = true end;
			if EA_StackingItemsCounts[EA_CLASS_MAGE][EA_CLASS_MAGE_POWER_SPELLID] == nil then EA_StackingItemsCounts[EA_CLASS_MAGE][EA_CLASS_MAGE_POWER_SPELLID] = 4 end;

		-- Arcane Missiles!
			if EA_StackingItems[EA_CLASS_MAGE][79683] == nil then EA_StackingItems[EA_CLASS_MAGE][79683] = true end;
			if EA_StackingItemsCounts[EA_CLASS_MAGE][79683] == nil then EA_StackingItemsCounts[EA_CLASS_MAGE][79683] = 1 end;

    -- Fingers of Frost
			if EA_StackingItems[EA_CLASS_MAGE][44544] == nil then EA_StackingItems[EA_CLASS_MAGE][44544] = true end;
			if EA_StackingItemsCounts[EA_CLASS_MAGE][44544] == nil then EA_StackingItemsCounts[EA_CLASS_MAGE][44544] = 1 end;

-- All credits go to the Original Author CurtisTheGreat
end
