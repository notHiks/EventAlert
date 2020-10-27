function EventAlert_LoadVariables()

    EA_tempVer = 825;
    EA_tempVerText = "8.2.5";
    EA_tempChanges = [[
        Bugfix: Fixed issue displaying aura timer
    ]];
    EA_TempBuffsTable = { };
    EA_PreLoadAlts = { };
    EA_PreLoadComplete = 0;

    EventAlert_GetPlayerClass = function() return  select(2, UnitClass("player")); end

    if (EA_Config == nil) then
        EA_Config = { DoAlertSound, AlertSound, AlertSoundText, ShowFrame, ShowName, ShowFlash, ShowTimer, ChangeTimer, ShowStacks, AllowESC, ShowSpellInfo, DoDoom, Debug, Version, VersionText};
    end
    if (EA_Position == nil) then
        EA_Position = { Anchor, LockFrame, IconSize, relativePoint, xLoc, yLoc, xOffset, yOffset };
    end

    if EA_Config.DoAlertSound == nil then EA_Config.DoAlertSound = true end;
    if EA_Config.AlertSound == nil or tonumber(EA_Config.AlertSound) == nil then EA_Config.AlertSound = EA_ALERT_SOUNDS["ShaysBell"] end;
    if EA_Config.AlertSoundText == nil then EA_Config.AlertSoundText = "Shay's Bell" end;
    if EA_Config.ShowFrame == nil then EA_Config.ShowFrame = true end;
    if EA_Config.ShowName == nil then EA_Config.ShowName = true end;
    if EA_Config.ShowFlash == nil then EA_Config.ShowFlash = false end;
    if EA_Config.ShowTimer == nil then EA_Config.ShowTimer = true end;
    if EA_Config.ChangeTimer == nil then EA_Config.ChangeTimer = false end;
    if EA_Config.ShowStacks == nil then EA_Config.ShowStacks = true end;
    if EA_Config.AllowESC == nil then EA_Config.AllowESC = false end;
    if EA_Config.ShowSpellInfo == nil then EA_Config.ShowSpellInfo = false end;
    if EA_Config.DoDoom == nil then EA_Config.DoDoom = true end;
    if EA_Config.Debug == nil then EA_Config.Debug = false end;
    if EA_Config.Version == nil then EA_Config.Version = EA_tempVer end;
    if EA_Config.VersionText == nil then EA_Config.VersionText = EA_tempVerText end;

    if EA_Position.Anchor == nil then EA_Position.Anchor = "CENTER" end;
    if EA_Position.LockFrame == nil then EA_Position.LockFrame = true end;
    if EA_Position.IconSize == nil then EA_Position.IconSize = 60 end;
    if EA_Position.relativePoint == nil then EA_Position.relativePoint = "CENTER" end;
    if EA_Position.xLoc == nil then EA_Position.xLoc = 0 end;
    if EA_Position.yLoc == nil then EA_Position.yLoc = 0 end;
    if EA_Position.xOffset == nil then EA_Position.xOffset = 0 end;
    if EA_Position.yOffset == nil then EA_Position.yOffset = 0 end;
end
