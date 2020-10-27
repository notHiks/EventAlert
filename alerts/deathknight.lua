function EventAlert_LoadAlerts_Deathknight()

-- Custom
	if EA_CustomItems[EA_CLASS_DK] == nil then EA_CustomItems[EA_CLASS_DK] = {} end;

-- Normal
	if EA_Items[EA_CLASS_DK] == nil then EA_Items[EA_CLASS_DK] = {} end;

		-- Killing Machine
			if EA_Items[EA_CLASS_DK][51124] == nil then EA_Items[EA_CLASS_DK][51124] = true end;

		-- Rime (Freezing Fog)
			if EA_Items[EA_CLASS_DK][59052] == nil then EA_Items[EA_CLASS_DK][59052] = true end;

		-- Sudden Doom
			if EA_Items[EA_CLASS_DK][81340] == nil then EA_Items[EA_CLASS_DK][81340] = true end;

		-- Crimson Scourge
			if EA_Items[EA_CLASS_DK][81141] == nil then EA_Items[EA_CLASS_DK][81141] = true end;

		-- Dark Succor
			if EA_Items[EA_CLASS_DK][101568] == nil then EA_Items[EA_CLASS_DK][101568] = false end;

-- Alternate
	if EA_AltItems[EA_CLASS_DK] == nil then EA_AltItems[EA_CLASS_DK] = {} end;

		  -- Dark Transformation
	    	if EA_AltItems[EA_CLASS_DK][63560] == nil then EA_AltItems[EA_CLASS_DK][63560] = true end;

-- Stacking
	if EA_StackingItems[EA_CLASS_DK] == nil then EA_StackingItems[EA_CLASS_DK] = {} end;
	if EA_StackingItemsCounts[EA_CLASS_DK] == nil then EA_StackingItemsCounts[EA_CLASS_DK] = {} end;

--All credits go to the original author, CurtisTheGreat
end
