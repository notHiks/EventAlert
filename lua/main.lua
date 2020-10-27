local EventAlert = {};

function EventAlert_OnLoad(self)
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
    self:RegisterEvent("COMBAT_TEXT_UPDATE");
    self:RegisterEvent("UNIT_POWER_UPDATE");
    self:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW");
    self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");

    self:RegisterEvent("PLAYER_LOGIN");
    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    self:RegisterEvent("PLAYER_DEAD");
    self:RegisterEvent("ADDON_LOADED");

    SlashCmdList["EVENTALERT"] = EventAlert_SlashHandler;
    SLASH_EVENTALERT1 = "/eventalert";
    SLASH_EVENTALERT2 = "/ea";

    self:SetScript("OnEvent", function(self, event, ...)
        -- Cleanup the buff table on every event
        BuffTableCleanup()

        if EventAlert[event] then
            EventAlert[event](self, ...);
        end
    end);
end

function EventAlert:PLAYER_ENTERING_WORLD()
    -- Handle first load
    if (EA_PreLoadComplete == 0) then
        for i, spellID in pairs(EA_AltItems[EventAlert_GetPlayerClass()]) do
            local name = GetSpellInfo(spellID);
            local EA_link = GetSpellLink(spellID);

            if (EA_link ~= nil) then
                local _, _, spellString = string.find(EA_link, "^|c%x+|Hspell:(.+)|h%[.*%]")

                if (spellString ~= nil) then
                    if (EA_PreLoadAlts[name] == nil) then
                        EA_PreLoadAlts[name] = spellString;
                    elseif (EA_PreLoadAlts[name] < spellString) then
                        EA_PreLoadAlts[name] = spellString;
                    elseif (EA_PreLoadAlts[name] >= spellString) then
                        -- Do Nothing
                    end
                end
            end
        end

        EA_PreLoadComplete = 1;
    end
end

function EventAlert:ADDON_LOADED(addon_name)
    if (addon_name == "EventAlert") then
        EventAlert_LoadSpellArrays();
        EventAlert_LoadVariables();
        EventAlert_CheckAlerts();
        EventAlert_CreateOptionsPanels();

        -- Create Actual Alert Frames
        EventAlert_CreateAnchorIcons();
        EventAlert_CreateAlertIcons(EA_Items[EventAlert_GetPlayerClass()]);
        EventAlert_CreateAlertIcons(EA_AltItems[EventAlert_GetPlayerClass()]);
        EventAlert_CreateAlertIcons(EA_StackingItems[EventAlert_GetPlayerClass()]);
        EventAlert_CreateAlertIcons(EA_CustomItems[EventAlert_GetPlayerClass()]);
    end
end

-- Monitor Holy Power, Shadow Orbs, Warlock Powers, Monk Chi and Combo Points
function EventAlert:UNIT_POWER_UPDATE(unitID, powerType)
    if unitID == "player" and EventAlert_PlayerClassHasPower() then
        local _, EA_powerValue, EA_powerAlert = EventAlert_GetPlayerClassPowerInfo();

        -- Set power value in buff table
        if (EA_StackingItems[EventAlert_GetPlayerClass()][EA_powerAlert]) then
            if (EA_powerValue >= EA_StackingItemsCounts[EventAlert_GetPlayerClass()][EA_powerAlert] and EA_powerValue >= 0) then
                local v2 = table.foreach(EA_TempBuffsTable, function(i2, v2) if v2==EA_powerAlert then return v2 end end)
                if (not v2) then
                    EA_addBuffValue(EA_powerAlert);
                end
            end
            if (EA_powerValue < EA_StackingItemsCounts[EventAlert_GetPlayerClass()][EA_powerAlert]) then
                local v2 = table.foreach(EA_TempBuffsTable, function(i2, v2) if v2==EA_powerAlert then return v2 end end)
                if (v2) then
                    EA_removeBuffValue(EA_powerAlert);
                end
            end
        end
    end
end

-- Clear alert table on spec change
function EventAlert:ACTIVE_TALENT_GROUP_CHANGED(self, ...)
    EventAlert_ClearTables();
end

-- Handle combat log events
function EventAlert:COMBAT_LOG_EVENT_UNFILTERED(self, ...)
    -- Indexes of relevant fields as constants
    local EA_EVENT_TYPE_INDEX = 2
    local EA_SPELL_UNIT_CASTER_INDEX = 5
    local EA_SPELL_UNIT_TARGET_INDEX = 9
    local EA_SPELL_ID_INDEX = 12
    local EA_SPELL_NAME_INDEX = 13

    -- The fun starts here!
    local EA_combatLogEvent = {CombatLogGetCurrentEventInfo()}

    -- Retrieve relevant event data
    local EA_eventType = EA_combatLogEvent[EA_EVENT_TYPE_INDEX]
    local EA_spellUnitCaster = EA_combatLogEvent[EA_SPELL_UNIT_CASTER_INDEX]
    local EA_spellUnitTarget = EA_combatLogEvent[EA_SPELL_UNIT_TARGET_INDEX]
    local EA_spellID = EA_combatLogEvent[EA_SPELL_ID_INDEX]
    local EA_spellName = EA_combatLogEvent[EA_SPELL_NAME_INDEX]

    -- No longer need the base event
    table.wipe(EA_combatLogEvent)

    if (EA_Config.Debug == true) then
        if (EA_spellUnitTarget == UnitName("player")) then
            if (EA_spellName ~= nil and type(EA_spellName) == "string") then
                DEFAULT_CHAT_FRAME:AddMessage(""..EA_eventType.."  Name: "..EA_spellName.."  ID: "..EA_spellID);
            end
        end
    end

    -- Handle AltItems removal
    EventAlert_HandleSpellUnusable();

    -- Handle new spell aura (buff/debuff)
    if (EA_eventType == "SPELL_AURA_APPLIED" or EA_eventType == "SPELL_AURA_APPLIED_DOSE" or EA_eventType == "SPELL_AURA_REFRESH") then
        EventAlert_HandleAuraApplied(EA_eventType, EA_spellUnitTarget, EA_spellID, EA_spellName)
    end

    -- Handle removed spell aura (buff/debuff)
    if (EA_eventType == "SPELL_AURA_REMOVED" or EA_eventType == "SPELL_AURA_REMOVED_DOSE") then
        EventAlert_HandleAuraRemoved(EA_eventType, EA_spellUnitTarget, EA_spellID, EA_spellName)
    end
end

function EventAlert:COMBAT_TEXT_UPDATE(self, eventType, spellID)
    -- Handles spells that become active when the scrolling combat text fires a warning for it.
    if (eventType == "SPELL_ACTIVE") then
        EventAlert_HandleSpellActive(eventType, spellID)
    end
end

function EventAlert:SPELL_ACTIVATION_OVERLAY_GLOW_SHOW(spellID)
    -- Handles spells that start "glowing" when they become active.
    if (EA_AltItems[EventAlert_GetPlayerClass()][spellID]) then
        local EA_usable = IsUsableSpell(spellID);

        if (EA_usable ~= nil) then
            local v2 = table.foreach(EA_TempBuffsTable, function(i2, v2) if v2==spellID then return v2 end end)
            if (not v2) then
                EA_addBuffValue(spellID);
            end
        end
    end
end

function EventAlert_PlayerClassHasPower()
    for index = 1, #EA_CLASSES_WITH_POWER do
        if EA_CLASSES_WITH_POWER[index] == EventAlert_GetPlayerClass() then
            return true
        end
    end

    return false
end

-- Utility function to get power type, power alert icon spell ID and power value
function EventAlert_GetPlayerClassPowerInfo()
    -- Short circuit for classes with no unit power
    if (not EventAlert_PlayerClassHasPower()) then
        return nil, nil, nil
    end

    local EA_powerType = UnitPowerType("player");
    local EA_powerValue = 0
    local EA_powerAlert = EA_COMBO_POINTS_POWER_SPELLID;

    -- Customize the power alert icon and and value depending on class/spec
    if (EventAlert_GetPlayerClass() == EA_CLASS_PALADIN) then
        -- The spellID for power alert is ONLY used for the icon, pick a spell that exists.
        EA_powerAlert = EA_CLASS_PALADIN_POWER_SPELLID;
        EA_powerType = Enum.PowerType.HolyPower
    elseif (EventAlert_GetPlayerClass() == EA_CLASS_PRIEST) then
        EA_powerAlert = EA_CLASS_PRIEST_POWER_SPELLID;
        EA_powerType = Enum.PowerType.HolyPower;
    -- Somes druids have special powers
    elseif (EventAlert_GetPlayerClass() == EA_CLASS_DRUID and GetSpecialization() == 1) then
        -- Boomkins get Astral Power
        EA_powerAlert = EA_CLASS_DRUID_POWER_SPELLID;
        EA_powerType = Enum.PowerType.LunarPower;
    elseif (EventAlert_GetPlayerClass() == EA_CLASS_MONK) then
        EA_powerAlert = EA_CLASS_MONK_POWER_SPELLID;
        EA_powerType = Enum.PowerType.Chi;
    elseif (EventAlert_GetPlayerClass() == EA_CLASS_WARLOCK) then
        EA_powerAlert = EA_CLASS_WARLOCK_POWER_SPELLID;
        EA_powerType = Enum.PowerType.SoulShards;
    -- All shamans except resto get Maelstrom as power
    elseif (EventAlert_GetPlayerClass() == EA_CLASS_SHAMAN and GetSpecialization() ~= 3) then
        EA_powerAlert = EA_CLASS_SHAMAN_POWER_SPELLID;
        -- Going into Ghost Wolf changes the Shaman power type to Mana, locking to 11 (Maelstrom)
        EA_powerType = Enum.PowerType.Maelstrom;
    -- Arcane mages have arcane charges
    elseif (EventAlert_GetPlayerClass() == EA_CLASS_MAGE and GetSpecialization() == 1) then
        EA_powerAlert = EA_CLASS_MAGE_POWER_SPELLID;
        EA_powerType = Enum.PowerType.ArcaneCharges;
    -- Rogues and feral druids get combo points (CAT DURID IS 4 FITE)
    elseif (EventAlert_GetPlayerClass() == EA_CLASS_ROGUE or EventAlert_GetPlayerClass() == EA_CLASS_DRUID) then
        EA_powerAlert = EA_COMBO_POINTS_POWER_SPELLID;
        EA_powerType = Enum.PowerType.ComboPoints;
    end

    EA_powerValue = UnitPower("player", EA_powerType);

    return EA_powerType, EA_powerValue, EA_powerAlert
end

function EventAlert_HandleAuraApplied(eventType, targetName, spellID, spellName)
    if (targetName == UnitName("player")) then
        if (EA_Config.ShowSpellInfo) then
            DEFAULT_CHAT_FRAME:AddMessage("Spell Name: "..spellName.."  --  Spell ID: "..spellID);
        end

        if (EA_Items[EventAlert_GetPlayerClass()][spellID] or EA_CustomItems[EventAlert_GetPlayerClass()][spellID]) then
            if #EA_TempBuffsTable ~= 0 then
                local v = table.foreach(EA_TempBuffsTable, function(i2, v2) if v2==spellID then return v2 end end)
                if (not v) then
                    EA_addBuffValue(spellID);
                end
            else
                EA_addBuffValue(spellID);
            end
        end

        -- Handle stacking buffs that go above treshold
        if (EA_StackingItems[EventAlert_GetPlayerClass()][spellID] and spellID ~= EA_COMBO_POINTS_POWER_SPELLID) then
            local name = GetSpellInfo(spellID);

            local EA_stackCount = select(3, AuraUtil.FindAuraByName(name, "player"));

            if (EA_stackCount == nil) then
                EA_stackCount = select(3, AuraUtil.FindAuraByName(name, "player", "HARMFUL"));
            end

            if (EA_stackCount ~= nil) then
                if (EA_stackCount >= EA_StackingItemsCounts[EventAlert_GetPlayerClass()][spellID]) then
                    if #EA_TempBuffsTable ~= 0 then
                        local v = table.foreach(EA_TempBuffsTable, function(i2, v2) if v2==spellID then return v2 end end)
                        if (not v) then
                            EA_addBuffValue(spellID);
                        end
                    else
                        EA_addBuffValue(spellID);
                    end
                end
            end
        end
    end
end

function EventAlert_HandleAuraRemoved(eventType, targetName, spellID, spellName)
    if (targetName == UnitName("player")) then
        -- Handle stacking buffs that fall under treshold
        -- The order is important here in case a buff ends up in both custom and stacking alerts.
        local EA_powerAlert = select(3, EventAlert_GetPlayerClassPowerInfo())

        if (EA_StackingItems[EventAlert_GetPlayerClass()][spellID] and spellID ~= EA_powerAlert) then
            local EA_stackCount = select(3, AuraUtil.FindAuraByName(spellName, "player"));

            if (EA_stackCount == nil) then
                EA_stackCount = select(3, AuraUtil.FindAuraByName(spellName, "player", "HARMFUL"))
            end

            local EA_minStackCount = EA_StackingItemsCounts[EventAlert_GetPlayerClass()][spellID];

            local v = table.foreach(EA_TempBuffsTable, function(i, v) if v==spellID then return v end end)
            if v then
                if (EA_stackCount == nil or EA_minStackCount ~= nil and EA_stackCount < EA_minStackCount) then
                    EA_removeBuffValue(v);
                end
            end
        elseif (EA_Items[EventAlert_GetPlayerClass()][spellID] or EA_CustomItems[EventAlert_GetPlayerClass()][spellID]) then
            local v = table.foreach(EA_TempBuffsTable, function(i, v) if v==spellID then return v end end)
            if v then
                EA_removeBuffValue(v);
            end
        end
    end
end

-- Check usability of AltItems
function EventAlert_HandleSpellUnusable()
    if #EA_TempBuffsTable ~= 0 then
        for _, spellID in ipairs (EA_TempBuffsTable) do
            if (EA_AltItems[EventAlert_GetPlayerClass()][spellID]) then
                -- Lava Surge = 77762
                -- Lava Burst = 51505
                local EA_globalCooldownDuration = select(2, GetSpellCooldown(61304));

                if (spellID == 77762) then
                    local EA_start, EA_duration, EA_enabled = GetSpellCooldown(51505);

                    if (EA_start > 0 and EA_duration > EA_globalCooldownDuration) then
                        EA_removeBuffValue(spellID);
                    end

                    local EA_affectingCombat = UnitAffectingCombat("player");
                    if (not EA_affectingCombat) then
                        EA_removeBuffValue(spellID);
                    end
                else
                    -- Handle cooldown, usability and charces
                    local EA_isUsable = IsUsableSpell(spellID);
                    -- Will be nil if spell has no charges
                    local EA_numCharges = GetSpellCharges(spellID)
                    local EA_start, EA_duration, EA_enabled = GetSpellCooldown(spellID);

                    if ((not EA_isUsable or EA_numCharges == 0) or EA_start > 0 and EA_duration > EA_globalCooldownDuration) then
                        EA_removeBuffValue(spellID);
                    end
                end
            end
        end
    end
end

function EventAlert_HandleSpellActive(eventType, spellID)
    local v = table.foreach(EA_PreLoadAlts, function(i, v) if i==spellID then return v end end)
    if v then
        v = tonumber(v);

        if (EA_AltItems[EventAlert_GetPlayerClass()][v]) then
            local v2 = table.foreach(EA_TempBuffsTable, function(i2, v2) if v2==v then return v2 end end)
            if (not v2) then
                EA_addBuffValue(v);
            end
        end
    end
end

function EventAlert_OnUpdate()
    if #EA_TempBuffsTable ~= 0 then
        local timerFontSize = 0;
        for i,v in ipairs (EA_TempBuffsTable) do
            local eaf = _G["EAFrame_"..v];

            local name = GetSpellInfo(v);

            if (EA_Config.ShowStacks) then
                if (EA_StackingItems[EventAlert_GetPlayerClass()][v]) then
                    local EA_stackCount = nil;
                    local _, EA_powerValue, EA_powerAlert = EventAlert_GetPlayerClassPowerInfo();

                    if (v == EA_powerAlert) then
                        EA_stackCount = EA_powerValue;
                    else
                        EA_stackCount = select(3, AuraUtil.FindAuraByName(name, "player"));

                        if (EA_stackCount == nil) then
                            EA_stackCount = select(3, AuraUtil.FindAuraByName(name, "player", "HARMFUL"));
                        end
                    end

                    if (EA_stackCount ~= nil) then
                        eaf.spellCount:ClearAllPoints();
                        eaf.spellCount:SetPoint("BOTTOMRIGHT", 0, 0);

                        eaf.spellCount:SetFont("Fonts\\\FRIZQT__.TTF", 22, "OUTLINE");
                        eaf.spellCount:SetFormattedText("%s", EA_stackCount);
                    end
                end
            else
                eaf.spellCount:ClearAllPoints();
                eaf.spellCount:SetPoint("BOTTOMRIGHT", 0, 0);

                eaf.spellCount:SetFont("Fonts\\\FRIZQT__.TTF", 22, "OUTLINE");
                eaf.spellCount:SetFormattedText("%s", "");
            end

            if (EA_Config.ShowTimer == true) then
                local EA_expirationTime = select(6, AuraUtil.FindAuraByName(name, "player"));

                if (EA_expirationTime == nil) then
                    EA_expirationTime = select(6, AuraUtil.FindAuraByName(name, "player"), "HARMFUL");
                end

                if (EA_expirationTime ~= nil) then
                    EA_currentTime = GetTime();
                    EA_timeLeft = EA_expirationTime - EA_currentTime;

                    if (EA_timeLeft > 0) then
                        if (EA_Config.ChangeTimer == true) then
                            timerFontSize = 28;
                            eaf.spellTimer:ClearAllPoints();
                            eaf.spellTimer:SetPoint("CENTER", 0, 0);
                        else
                            timerFontSize = 18;
                            eaf.spellTimer:ClearAllPoints();
                            eaf.spellTimer:SetPoint("TOP", 0, 20);
                        end

                        eaf.spellTimer:SetFont("Fonts\\\FRIZQT__.TTF", timerFontSize, "OUTLINE");
                        eaf.spellTimer:SetFormattedText("%d", EA_timeLeft);
                    end
                end
            else
                eaf.spellTimer:SetText("");
            end
        end
    end
end

function EA_addBuffValue(EA_spellID)
    table.insert(EA_TempBuffsTable, EA_spellID);
    EventAlert_PositionFrames();
    EventAlert_DoAlert();
end

function EA_removeBuffValue(EA_spellID)
    local f = _G["EAFrame_"..EA_spellID];
    if (f ~= nil) then
        f:Hide();
    end

    for i,v in ipairs(EA_TempBuffsTable) do
        if (v == EA_spellID) then
            table.remove(EA_TempBuffsTable, i);
        end
    end

    EventAlert_PositionFrames();
    f:SetScript("OnUpdate", nil);

end

function EventAlert_DoAlert()
    if (EA_Config.ShowFlash == true) then
       UIFrameFadeIn(LowHealthFrame, 1, 0, 1);
       UIFrameFadeOut(LowHealthFrame, 2, 1, 0);
    end

    if (EA_Config.DoAlertSound == true) then
       PlaySoundFile(EA_Config.AlertSound);
    end
end

function EventAlert_PositionFrames(event)
    if (EA_Config.ShowFrame == true) then
        EA_Main_Frame:ClearAllPoints();
        EA_Main_Frame:SetPoint(EA_Position.Anchor, UIParent, EA_Position.relativePoint, EA_Position.xLoc, EA_Position.yLoc);

        local prevFrame = "EA_Main_Frame";

        for k, spellID in ipairs(EA_TempBuffsTable) do
            local eaf = _G["EAFrame_"..spellID];
            if (eaf ~= nil) then
                local EA_powerAlert = select(3, EventAlert_GetPlayerClassPowerInfo());

                -- TODO: Good candidate for encapsulation (function that return name, icon for spell ID)
                local gsiName = GetSpellInfo(spellID);
                local gsiIcon = select(3, GetSpellInfo(spellID));

                -- Special handling for holy power
                if (spellID == EA_CLASS_PALADIN_POWER_SPELLID) then
                    gsiIcon = select(3, GetSpellInfo(EA_CLASS_PALADIN_POWER_SPELLID));
                -- Special handling for combo points
                elseif (spellID == EA_COMBO_POINTS_POWER_SPELLID) then
                    gsiName = "Combo Points";
                -- Special handling for Chi
                elseif (spellID == EA_CLASS_MONK_POWER_SPELLID) then
                    gsiName = "Chi";
                -- Special handling for Astral Power
                elseif (spellID == EA_CLASS_DRUID_POWER_SPELLID) then
                    gsiName = "Astral Power";
                -- Special handling for Maelstrom
                elseif (spellID == EA_CLASS_SHAMAN_POWER_SPELLID) then
                    gsiName = "Maelstrom";
                -- Special handling for Arcane Charges
                elseif (spellID == EA_CLASS_MAGE_POWER_SPELLID) then
                    gsiName = "Arcane Charges";
                -- Since Vengeance has the same icon for both spells, change icon for Ignore Pain
                -- TODO: See about customizable icons
                elseif (spellID == EA_WARRIOR_VENGEANCE_IGNORE_PAIN_SPELLID) then
                    gsiIcon = select(3, GetSpellInfo(EA_WARRIOR_VENGEANCE_IGNORE_PAIN_ICON_SPELLID));
                elseif (spellID == EA_WARRIOR_VENGEANCE_FOCUSED_RAGE_SPELLID) then
                    gsiIcon = select(3, GetSpellInfo(EA_WARRIOR_VENGEANCE_FOCUSED_RAGE_ICON_SPELLID));
                -- Kill Command resets itself, causing weird behaviours with AltItems, so we use the hidden aura
                elseif (spellID == EA_HUNTER_KILL_COMMAND_RESET_SPELLID) then
                    gsiName, _, gsiIcon = GetSpellInfo(EA_HUNTER_KILL_COMMAND_SPELLID)
                elseif (spellID == EA_powerAlert) then
                    gsiName = select(2, UnitPowerType("player"));
                else
                    -- Heating Up has the same icon as Hot Streak.
                    if(spellID == 48107) then
                       gsiIcon= select(3, GetSpellInfo(108853));
                    end
                end

                eaf:ClearAllPoints();

                if (prevFrame == "EA_Main_Frame") then
                    eaf:SetPoint("CENTER", prevFrame, "CENTER", 0, 0);
                elseif (prevFrame == eaf) then
                    prevFrame = "EA_Main_Frame";
                    eaf:SetPoint("CENTER", prevFrame, "CENTER", 0, 0);
                else
                    eaf:SetPoint("CENTER", prevFrame, "CENTER", 100+EA_Position.xOffset, 0+EA_Position.yOffset);
                end

                eaf:SetWidth(EA_Position.IconSize);
                eaf:SetHeight(EA_Position.IconSize);

                -- SetBackdrop was broken in Legion, use texture instead.
                eaf.texture = eaf:CreateTexture();
                eaf.texture:SetAllPoints(eaf);
                eaf.texture:SetTexture(gsiIcon);

                if (EA_Config.ShowName == true) then
                    eaf.spellName:SetText(gsiName);
                else
                    eaf.spellName:SetText("");
                end


                eaf:SetScript("OnUpdate", EventAlert_OnUpdate);
                prevFrame = eaf;
                eaf:Show();
            end
        end
    end
end

function EventAlert_SlashHandler(msg)
    local msg = string.lower(msg);

    if (msg == "options" or msg == "opt") then
        InterfaceOptionsFrame_OpenToCategory(EA_GeneralOptions_Panel);
    elseif (msg == "showframe" or msg == "showtest") then
        EventAlert_Options_ToggleAlertFrame();
    elseif (msg == "togglelock" or msg == "toggleframelock") then
        EA_Position.LockFrame = not(EA_Position.LockFrame);
        local EA_FrameLockMessage = EA_Position.LockFrame;
        DEFAULT_CHAT_FRAME:AddMessage("Frame locked: " .. tostring(EA_FrameLockMessage));
    elseif (msg == "version" or msg == "ver") then
        InterfaceOptionsFrame_OpenToCategory(EA_About_Panel);
    elseif (msg == "print") then
        EventAlert_PrintTable();
    elseif (msg == "printalts") then
        EventAlert_PrintAltsTable();
    elseif (msg == "debug") then
        if (EA_Config.Debug == true) then
            DEFAULT_CHAT_FRAME:AddMessage("Debugging off");
            EA_Config.Debug = false;
        elseif (EA_Config.Debug == false) then
            DEFAULT_CHAT_FRAME:AddMessage("Debugging on");
            EA_Config.Debug = true;
        end
    elseif (msg == "clear") then
        EventAlert_ClearTables();
    else
        DEFAULT_CHAT_FRAME:AddMessage("EventAlert commands (/eventalert or /ea):");
        DEFAULT_CHAT_FRAME:AddMessage("/ea options (/ea opt) - Toggle the options window on or off");
        DEFAULT_CHAT_FRAME:AddMessage("/ea version (/ea ver) - Shows the current version of EventAlert.");
        DEFAULT_CHAT_FRAME:AddMessage("/ea showframe (/ea showtest) - Shows/Hides the anchor frames.");
        DEFAULT_CHAT_FRAME:AddMessage("/ea toggleframelock (/ea togglelock) - Locs/Unlocks the anchor frames.");
    end
end


-- Just used for debugging.
function EventAlert_PrintTable()
    table.foreach(EA_TempBuffsTable, print)
end

-- Just used for debugging.
function EventAlert_PrintAltsTable()
    table.foreach(EA_PreLoadAlts, print)
end

function EventAlert_ClearTables()
    for _, EA_spellID in ipairs(EA_TempBuffsTable) do
        local f = _G["EAFrame_"..EA_spellID];
        f:Hide()
    end
    EA_TempBuffsTable = table.wipe(EA_TempBuffsTable);
end

-- Cleanup leftover buffs from table, handle custom spells
function BuffTableCleanup()
    if (EA_TempBuffsTable ~= nil and #EA_TempBuffsTable ~= 0) then
        for i, spellID in ipairs (EA_TempBuffsTable) do
            if (spellID ~= nil) then
                local name = GetSpellInfo(spellID);

                if (name ~= nil) then
                    local auraInfo = {AuraUtil.FindAuraByName(name, "player")};

                    if (auraInfo[10] == nil) then
                        auraInfo = {AuraUtil.FindAuraByName(name, "player", "HARMFUL")};
                    end

                    local stack = auraInfo[3]
                    local auraID = auraInfo[10]

                    -- No longer need auraInfo
                    table.wipe(auraInfo)

                    if (stack ~= nil) then
                        -- If a custom spell has stacks, converts it to a StackingItem.
                        if (stack > 0 and EA_StackingItems[EventAlert_GetPlayerClass()][spellID] == nil and EA_CustomItems[EventAlert_GetPlayerClass()][spellID] == true) then
                            EA_CustomItems[EventAlert_GetPlayerClass()][spellID] = nil;
                            EA_StackingItems[EventAlert_GetPlayerClass()][spellID] = true;
                            EA_StackingItemsCounts[EventAlert_GetPlayerClass()][spellID] = 1;
                            DEFAULT_CHAT_FRAME:AddMessage("The custom spell, "..name..", has been added to the list of stacking buffs. Reload UI to adjust stack size from the interface menu.");
                        end
                    end

                    -- Spell from buff table was not found on player, remove.
                    if (auraID == nil) then
                        local EA_powerAlert = select(3, EventAlert_GetPlayerClassPowerInfo());
                        if (auraID ~= EA_powerAlert and not (EA_AltItems[EventAlert_GetPlayerClass()][auraID])) then
                            local v2 = table.foreach(EA_TempBuffsTable, function(i2, v2) if v2==auraID then return v2 end end)
                            if v2 then
                                EA_removeBuffValue(auraID);
                            end
                        end
                    end

                    -- Cleanup lingering alt items (activated spells)
                    if (EA_AltItems[EventAlert_GetPlayerClass()][spellID] ~= nil) then
                        -- Prevents lingering usable spells outside of combat
                        local EA_playerIsInCombat = InCombatLockdown();

                        if (not EA_playerIsInCombat) then
                            EA_removeBuffValue(spellID);
                        end
                    end
                end
            else
                EA_removeBuffValue(spellID);
            end
        end
    end
end

function pairsByKeys (t, f)
    local a = {}
        for n in pairs(t) do table.insert(a, n) end
        table.sort(a, f)
        local i = 0      -- iterator variable
        local iter = function ()   -- iterator function
            i = i + 1
            if a[i] == nil then return nil
            else return a[i], t[a[i]]
            end
        end
    return iter
end

function EventAlert_CreateOptionsPanels()
    -- Create Options Panels inside the addons section of the Blizzard UI.
    EventAlert.panel = CreateFrame( "Frame", "EventAlertPanel", UIParent );
    EventAlert.panel.name = "EventAlert";
    EventAlert.panel.okay = EAOptionsPanelOK;
    InterfaceOptions_AddCategory(EventAlert.panel);

    EAOptionsPanel('EA_GeneralOptions_Panel', 'EventAlert', EA_TITLE_MAINOPTIONS, EA_SUBTEXT_MAINOPTIONS)
    EAOptionsPanel('EA_IconOptions_Panel', 'EventAlert', EA_TITLE_ICONOPTIONS, EA_SUBTEXT_ICONOPTIONS)
    EAOptionsPanel('EA_SoundOptions_Panel', 'EventAlert', EA_TITLE_SOUNDOPTIONS, EA_SUBTEXT_SOUNDOPTIONS)
    EAOptionsPanel('EA_AlertOptions_Panel', 'EventAlert', EA_TITLE_ALERTOPTIONS, EA_SUBTEXT_ALERTOPTIONS)
    EAOptionsPanel('EA_CustomAlertOptions_Panel', 'EventAlert', EA_TITLE_CUSTOMALERTOPTIONS, EA_SUBTEXT_CUSTOMALERTOPTIONS)
    EAOptionsPanel('EA_About_Panel', 'EventAlert', EA_TITLE_ABOUT, EA_SUBTEXT_ABOUT)

    EventAlert_CreateGeneralOptionsFrames();
    EventAlert_CreateIconOptionsFrames();
    EventAlert_CreateSoundOptionsFrames();
    EventAlert_CreateAlertsOptionsFrames();
    EventAlert_CreateCustomAlertsOptionsFrames();
    EventAlert_CreateAboutFrames();
    -- End Options Panels Creation
end

function EventAlert_LoadSpellArrays()
    if EA_CustomItems == nil then EA_CustomItems = {} end;
    if EA_Items == nil then EA_Items = {} end;
    if EA_AltItems == nil then EA_AltItems = {}    end;
    if EA_StackingItems == nil then EA_StackingItems = {} end;
    if EA_StackingItemsCounts == nil then EA_StackingItemsCounts = {} end;

    EventAlert_LoadAlerts_Deathknight();
    EventAlert_LoadAlerts_DemonHunter();
    EventAlert_LoadAlerts_Druid();
    EventAlert_LoadAlerts_Hunter();
    EventAlert_LoadAlerts_Mage();
    EventAlert_LoadAlerts_Monk();
    EventAlert_LoadAlerts_Paladin();
    EventAlert_LoadAlerts_Priest();
    EventAlert_LoadAlerts_Rogue();
    EventAlert_LoadAlerts_Shaman();
    EventAlert_LoadAlerts_Warlock();
    EventAlert_LoadAlerts_Warrior();
end

function EventAlert_CheckAlerts()
    for _, spellID in ipairs(EA_Items[EventAlert_GetPlayerClass()]) do
        local EA_CheckName = GetSpellInfo(spellID);
        if (EA_CheckName == nil) then
          if (EA_Config.Debug == true) then
            DEFAULT_CHAT_FRAME:AddMessage("Removed deprecated spell with ID: "..spellID);
          end
          table.remove(EA_Items[EventAlert_GetPlayerClass()], spellID);
        end
    end

    for _, spellID in ipairs(EA_AltItems[EventAlert_GetPlayerClass()]) do
        local EA_CheckName = GetSpellInfo(spellID);
        if (EA_CheckName == nil) then
            if (EA_Config.Debug == true) then
              DEFAULT_CHAT_FRAME:AddMessage("Removed deprecated alt spell with ID: "..spellID);
            end
            table.remove(EA_AltItems[EventAlert_GetPlayerClass()], spellID);
        end
    end

    for _, spellID in ipairs(EA_StackingItems[EventAlert_GetPlayerClass()]) do
        local EA_CheckName = GetSpellInfo(spellID);
        if (EA_CheckName == nil) then
            if (EA_Config.Debug == true) then
              DEFAULT_CHAT_FRAME:AddMessage("Removed deprecated stacking spell with ID: "..spellID);
            end
            table.remove(EA_StackingItems[EventAlert_GetPlayerClass()], spellID);
            table.remove(EA_StackingItemsCounts[EventAlert_GetPlayerClass()], spellID);
        end
    end
end
--All credit goes to the original author, CurtisTheGreat
