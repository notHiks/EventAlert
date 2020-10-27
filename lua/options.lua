EventAlert = {};

-- Options panel code shamelessly stolen from Bagnon.  Check out Bagnon here:
-- http://www.wowinterface.com/downloads/info4459-Bagnon.html

function EAOptionsPanel(name, parent, title, subtitle)
    local f = CreateFrame("Frame", name);
    f.name = title
    -- For the "OnShow" script to be called, the panel must first be hidden.
    f:Hide();
    f.parent = parent

    local text = f:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
    text:SetPoint('TOPLEFT', 16, -16)
    text:SetText(title)
    local subtext = f:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall')
    subtext:SetHeight(32)
    subtext:SetPoint('TOPLEFT', text, 'BOTTOMLEFT', 0, -8)
    subtext:SetPoint('RIGHT', f, -32, 0)
    subtext:SetNonSpaceWrap(true)
    subtext:SetJustifyH('LEFT')
    subtext:SetJustifyV('TOP')
    subtext:SetText(subtitle)

    InterfaceOptions_AddCategory(f, 'EventAlert')

    return f
end

function EAOptionsPanelOK()
    for index,value in pairsByKeys(EA_StackingItems[EventAlert_GetPlayerClass()]) do
        if (type(value) == "number") then
            value = tostring(index)
        elseif (type(value) == "boolean") then
            if (value) then
                value = "true"
            else
                value = "false"
            end
          end


        local tempStackingName = _G[index.."ChargeBox"];
        local tempStacking = tempStackingName:GetText();

        tempStacking = tonumber(tempStacking);

        if (tempStacking == nil) then
            tempStacking = EA_StackingItemsCounts[EventAlert_GetPlayerClass()][index];
        end

        EA_StackingItemsCounts[EventAlert_GetPlayerClass()][index] = tempStacking;

           -- local EA_name, EA_rank = GetSpellInfo(index);
        -- DEFAULT_CHAT_FRAME:AddMessage(EA_name.." ["..index.."] will now only alert on "..tempStacking.." charges or more.");

    end

    local EA_Anchor, _, EA_relativePoint, EA_xOfs, EA_yOfs = EA_Anchor_Frame:GetPoint();
    EA_Position.Anchor = EA_Anchor;
    EA_Position.relativePoint = EA_relativePoint;
    EA_Position.xLoc = EA_xOfs;
    EA_Position.yLoc = EA_yOfs;

    if EA_Anchor_Frame:IsVisible() then
       EA_Anchor_Frame:Hide();
       EA_Anchor_Frame2:Hide();
       EA_Anchor_Frame3:Hide();
    end
end


function EventAlert_Options_ToggleAlertFrame()
local timerFontSize = 0;

    if EA_Anchor_Frame:IsVisible() then
       EA_Anchor_Frame:Hide();
       EA_Anchor_Frame2:Hide();
       EA_Anchor_Frame3:Hide();
    else
        if (EA_Config.ShowFrame == true) then

            EA_Anchor_Frame:ClearAllPoints();
            EA_Anchor_Frame:SetPoint(EA_Position.Anchor, EA_Position.xLoc, EA_Position.yLoc);

            EA_Anchor_Frame2:ClearAllPoints();
            EA_Anchor_Frame2:SetPoint("CENTER", EA_Anchor_Frame, 100+EA_Position.xOffset, 0+EA_Position.yOffset);

            EA_Anchor_Frame3:ClearAllPoints();
            EA_Anchor_Frame3:SetPoint("CENTER", EA_Anchor_Frame2, 100+EA_Position.xOffset, 0+EA_Position.yOffset);


            if (EA_Config.ShowName == true) then
                EA_Anchor_Frame_Name:SetText("Moo-ve Me!");
                EA_Anchor_Frame2_Name:SetText("Event Alert Frame");
                EA_Anchor_Frame3_Name:SetText("Event Alert Frame");
            else
                EA_Anchor_Frame_Name:SetText("");
                EA_Anchor_Frame2_Name:SetText("");
                EA_Anchor_Frame3_Name:SetText("");
            end

               if (EA_Config.ShowTimer == true) then
                if (EA_Config.ChangeTimer == true) then
                   timerFontSize = 28;
                   EA_Anchor_Frame_Timer:ClearAllPoints();
                   EA_Anchor_Frame_Timer:SetPoint("CENTER", 0, 0);
                   EA_Anchor_Frame2_Timer:ClearAllPoints();
                   EA_Anchor_Frame2_Timer:SetPoint("CENTER", 0, 0);
                   EA_Anchor_Frame3_Timer:ClearAllPoints();
                   EA_Anchor_Frame3_Timer:SetPoint("CENTER", 0, 0);
                else
                    timerFontSize = 18;
                    EA_Anchor_Frame_Timer:ClearAllPoints();
                    EA_Anchor_Frame_Timer:SetPoint("TOP", 0, 20);
                    EA_Anchor_Frame2_Timer:ClearAllPoints();
                    EA_Anchor_Frame2_Timer:SetPoint("TOP", 0, 20);
                    EA_Anchor_Frame3_Timer:ClearAllPoints();
                    EA_Anchor_Frame3_Timer:SetPoint("TOP", 0, 20);
                end

                EA_Anchor_Frame_Timer:SetFont("Fonts\\\FRIZQT__.TTF", timerFontSize, "OUTLINE");
                EA_Anchor_Frame_Timer:SetText("TIME LEFT");
                EA_Anchor_Frame2_Timer:SetFont("Fonts\\\FRIZQT__.TTF", timerFontSize, "OUTLINE");
                EA_Anchor_Frame2_Timer:SetText("TIME LEFT");
                EA_Anchor_Frame3_Timer:SetFont("Fonts\\\FRIZQT__.TTF", timerFontSize, "OUTLINE");
                EA_Anchor_Frame3_Timer:SetText("TIME LEFT");
            else
                EA_Anchor_Frame_Timer:SetText("");
                EA_Anchor_Frame2_Timer:SetText("");
                EA_Anchor_Frame3_Timer:SetText("");
            end

            EA_Anchor_Frame:SetWidth(EA_Position.IconSize);
            EA_Anchor_Frame:SetHeight(EA_Position.IconSize);
            EA_Anchor_Frame2:SetWidth(EA_Position.IconSize);
            EA_Anchor_Frame2:SetHeight(EA_Position.IconSize);
            EA_Anchor_Frame3:SetWidth(EA_Position.IconSize);
            EA_Anchor_Frame3:SetHeight(EA_Position.IconSize);
            EA_Anchor_Frame:Show();
            EA_Anchor_Frame2:Show();
            EA_Anchor_Frame3:Show();

        end


        if (EA_Config.ShowFlash == true) then
            UIFrameFadeIn(LowHealthFrame, 1, 0, 1);
            UIFrameFadeOut(LowHealthFrame, 2, 1, 0);
        end

        if (EA_Config.DoAlertSound == true) then
            PlaySoundFile(EA_Config.AlertSound);
        end

    end
--All credit goes to the original author, CurtisTheGreat
end
