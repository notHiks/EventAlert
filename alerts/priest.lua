function EventAlert_LoadAlerts_Priest()

-- Custom
    if EA_CustomItems[EA_CLASS_PRIEST] == nil then EA_CustomItems[EA_CLASS_PRIEST] = {} end;

-- Normal
    if EA_Items[EA_CLASS_PRIEST] == nil then EA_Items[EA_CLASS_PRIEST] = {} end;

        -- Divine Insight
            if EA_Items[EA_CLASS_PRIEST][124430] == nil then EA_Items[EA_CLASS_PRIEST][124430] = true end;

-- Alternate
    if EA_AltItems[EA_CLASS_PRIEST] == nil then EA_AltItems[EA_CLASS_PRIEST] = {} end;

        -- Shadow Word: Death
            if EA_AltItems[EA_CLASS_PRIEST][32379] == nil then EA_AltItems[EA_CLASS_PRIEST][32379] = true end;

-- Stacking
    if EA_StackingItems[EA_CLASS_PRIEST] == nil then EA_StackingItems[EA_CLASS_PRIEST] = {} end;
    if EA_StackingItemsCounts[EA_CLASS_PRIEST] == nil then EA_StackingItemsCounts[EA_CLASS_PRIEST] = {} end;

         -- Surge of Light
            if EA_StackingItems[EA_CLASS_PRIEST][114255] == nil then EA_StackingItems[EA_CLASS_PRIEST][114255] = true end;
            if EA_StackingItemsCounts[EA_CLASS_PRIEST][114255] == nil then EA_StackingItemsCounts[EA_CLASS_PRIEST][114255] = 1 end;

        -- Surge of Darkness
            if EA_StackingItems[EA_CLASS_PRIEST][87160] == nil then EA_StackingItems[EA_CLASS_PRIEST][87160] = true end;
            if EA_StackingItemsCounts[EA_CLASS_PRIEST][87160] == nil then EA_StackingItemsCounts[EA_CLASS_PRIEST][87160] = 1 end;

        -- Insanity
            if EA_StackingItems[EA_CLASS_PRIEST][EA_CLASS_PRIEST_POWER_SPELLID] == nil then EA_StackingItems[EA_CLASS_PRIEST][EA_CLASS_PRIEST_POWER_SPELLID] = true end;
            if EA_StackingItemsCounts[EA_CLASS_PRIEST][EA_CLASS_PRIEST_POWER_SPELLID] == nil then EA_StackingItemsCounts[EA_CLASS_PRIEST][EA_CLASS_PRIEST_POWER_SPELLID] = 90 end;

--All credit goes to the Original Author, CurtisTheGreat
end
