function EventAlert_LoadAlerts_Warrior()

-- Custom
	if EA_CustomItems[EA_CLASS_WARRIOR] == nil then EA_CustomItems[EA_CLASS_WARRIOR] = {} end;

-- Normal
	if EA_Items[EA_CLASS_WARRIOR] == nil then EA_Items[EA_CLASS_WARRIOR] = {} end;

		-- Victory Rush
			if EA_Items[EA_CLASS_WARRIOR][32216] == nil then EA_Items[EA_CLASS_WARRIOR][32216] = true end;

		-- Sudden Death
			if EA_Items[EA_CLASS_WARRIOR][52437] == nil then EA_Items[EA_CLASS_WARRIOR][52437] = true end;

		-- Ultimatum
			if EA_Items[EA_CLASS_WARRIOR][122510] == nil then EA_Items[EA_CLASS_WARRIOR][122510] = true end;

		-- Overpower!
			if EA_Items[EA_CLASS_WARRIOR][60503] == nil then EA_Items[EA_CLASS_WARRIOR][60503] = true end;

		-- Vengeance: Focused Rage
			if EA_Items[EA_CLASS_WARRIOR][202573] == nil then EA_Items[EA_CLASS_WARRIOR][202573] = true end;

		-- Vengeance: Ignore Pain
			if EA_Items[EA_CLASS_WARRIOR][202574] == nil then EA_Items[EA_CLASS_WARRIOR][202574] = true end;

		-- Wrecking Ball
			if EA_Items[EA_CLASS_WARRIOR][215570] == nil then EA_Items[EA_CLASS_WARRIOR][215570] = true end;

		-- Massacre
			if EA_Items[EA_CLASS_WARRIOR][206316] == nil then EA_Items[EA_CLASS_WARRIOR][206316] = true end;

		-- Enrage (defaults to false... for now)
			if EA_Items[EA_CLASS_WARRIOR][184362] == nil then EA_Items[EA_CLASS_WARRIOR][184362] = false end;

-- Alternate
	if EA_AltItems[EA_CLASS_WARRIOR] == nil then EA_AltItems[EA_CLASS_WARRIOR] = {} end;

		-- Colossus Smash; AltAlert detection needs work for this to work... Not reliable at the moment.
				if EA_AltItems[EA_CLASS_WARRIOR][167105] == nil then EA_AltItems[EA_CLASS_WARRIOR][167105] = true end;

		-- Shield Slam
				if EA_AltItems[EA_CLASS_WARRIOR][23922] == nil then EA_AltItems[EA_CLASS_WARRIOR][23922] = true end;

		-- Execute
	    	if EA_AltItems[EA_CLASS_WARRIOR][5308] == nil then EA_AltItems[EA_CLASS_WARRIOR][5308] = true end;

		-- Revenge
	    	if EA_AltItems[EA_CLASS_WARRIOR][6572] == nil then EA_AltItems[EA_CLASS_WARRIOR][6572] = true end;

		-- Raging Blow
				if EA_AltItems[EA_CLASS_WARRIOR][85288] == nil then EA_AltItems[EA_CLASS_WARRIOR][85288] = true end;

		-- Rampage
				if EA_AltItems[EA_CLASS_WARRIOR][184367] == nil then EA_AltItems[EA_CLASS_WARRIOR][184367] = true end;

--Stacking
	if EA_StackingItems[EA_CLASS_WARRIOR] == nil then EA_StackingItems[EA_CLASS_WARRIOR] = {} end;
	if EA_StackingItemsCounts[EA_CLASS_WARRIOR] == nil then EA_StackingItemsCounts[EA_CLASS_WARRIOR] = {} end;

		-- Taste for blood
			if EA_StackingItems[EA_CLASS_WARRIOR][206333] == nil then EA_StackingItems[EA_CLASS_WARRIOR][206333] = true end;
			if EA_StackingItemsCounts[EA_CLASS_WARRIOR][206333] == nil then EA_StackingItemsCounts[EA_CLASS_WARRIOR][206333] = 3 end;

		-- Raging Blow!
			if EA_StackingItems[EA_CLASS_WARRIOR][131116] == nil then EA_StackingItems[EA_CLASS_WARRIOR][131116] = true end;
			if EA_StackingItemsCounts[EA_CLASS_WARRIOR][131116] == nil then EA_StackingItemsCounts[EA_CLASS_WARRIOR][131116] = 1 end;

		-- Meat Cleaver
			if EA_StackingItems[EA_CLASS_WARRIOR][85739] == nil then EA_StackingItems[EA_CLASS_WARRIOR][85739] = true end;
			if EA_StackingItemsCounts[EA_CLASS_WARRIOR][85739] == nil then EA_StackingItemsCounts[EA_CLASS_WARRIOR][85739] = 3 end;

--All credit goes to the original author, CurtisTheGreat
end
