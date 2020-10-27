function EventAlert_CreateAlertIcons(table)
    for index,value in pairs(table) do
        if (type(value) == "number") then
            value = tostring(index)
        elseif (type(value) == "boolean") then
            if (value) then
                value = "true"
            else
                value = "false"
            end
        end

        local eaf = CreateFrame("FRAME", "EAFrame_"..index, EA_Main_Frame);

        if (EA_Config.AllowESC == true) then
            tinsert(UISpecialFrames,"EAFrame_"..index);
        end

        eaf.spellName = eaf:CreateFontString("EAFrame_"..index.."_Name","OVERLAY");
        eaf.spellName:SetFontObject(ChatFontNormal);
        eaf.spellName:SetPoint("BOTTOM", 0, -15);

        eaf.spellTimer = eaf:CreateFontString("EAFrame_"..index.."_Timer","OVERLAY");
        eaf.spellTimer:SetFontObject(ChatFontNormal);
        eaf.spellTimer:SetPoint("TOP", 0, 15);

        eaf.spellCount = eaf:CreateFontString("EAFrame_"..index.."_Count","OVERLAY");
        eaf.spellCount:SetFontObject(ChatFontNormal);
        eaf.spellCount:SetPoint("CENTER", 0, 0);

        eaf:SetScript("OnEvent", EventAlert_OnEvent);
    end
end


function EventAlert_CreateAnchorIcons()

-- Create anchor frames used for mod customization.
        local anchorFrameName = "EA_Anchor_Frame";

        local i = 1;

        while i < 4 do

            if (i == 1) then
                local f = CreateFrame("FRAME", anchorFrameName, UIParent);

                f:ClearAllPoints();

                   f.spellName = f:CreateFontString(anchorFrameName.."_Name","OVERLAY");
                   f.spellName:SetFontObject(ChatFontNormal);
                   f.spellName:SetPoint("BOTTOM", 0, -15);

                   f.spellTimer = f:CreateFontString(anchorFrameName.."_Timer","OVERLAY");
                   f.spellTimer:SetFontObject(ChatFontNormal);
                   f.spellTimer:SetPoint("TOP", 0, 15);

                f:SetBackdrop({bgFile = "Interface/Icons/Spell_Nature_Polymorph_Cow"});

                f:SetPoint(EA_Position.Anchor, UIParent, EA_Position.xLoc, EA_Position.yLoc);

                f:SetMovable(true);
                   f:EnableMouse(true);

                f:SetScript("OnMouseDown",function()
                    if (EA_Position.LockFrame == true) then
                        DEFAULT_CHAT_FRAME:AddMessage("EventAlert: You must unlock the alert frame in order to move it or reset it's position.")
                    else
                        f:StartMoving();
                    end
                end)

                f:SetScript("OnMouseUp",function()
                    f:StopMovingOrSizing();

                    local EA_Anchor, _, EA_relativePoint, EA_xOfs, EA_yOfs = EA_Anchor_Frame:GetPoint();

                    EA_Position.Anchor = EA_Anchor;
                    EA_Position.relativePoint = EA_relativePoint;
                    EA_Position.xLoc = EA_xOfs;
                    EA_Position.yLoc = EA_yOfs;
                end)

                if (EA_Config.AllowESC == true) then
                    tinsert(UISpecialFrames,anchorFrameName..i);
                end

            else
                local f = CreateFrame("FRAME", anchorFrameName..i, UIParent);

                f:ClearAllPoints();

                   f.spellName = f:CreateFontString(anchorFrameName..i.."_Name","OVERLAY");
                   f.spellName:SetFontObject(ChatFontNormal);
                   f.spellName:SetPoint("BOTTOM", 0, -15);

                   f.spellTimer = f:CreateFontString(anchorFrameName..i.."_Timer","OVERLAY");
                   f.spellTimer:SetFontObject(ChatFontNormal);
                   f.spellTimer:SetPoint("TOP", 0, 15);

                f:SetBackdrop({bgFile = "Interface/Icons/Spell_Nature_Polymorph_Cow"});


                if (i == 2) then
                    f:SetPoint("CENTER", anchorFrameName, "CENTER", 100+EA_Position.xOffset, 0+EA_Position.yOffset)
                elseif (i > 2) then
                    f:SetPoint("CENTER", anchorFrameName..i-1, "CENTER", 100+EA_Position.xOffset, 0+EA_Position.yOffset);
                end
            end

        i = i + 1;
        end
end
