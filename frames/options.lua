-- General Options Frames
    function EventAlert_CreateGeneralOptionsFrames()
        local tempParent = EA_GeneralOptions_Panel;

        local t = {"AllowESC", "ShowFrame", "ShowName", "ShowTimer", "ChangeTimer", "ShowStacks", "ShowFlash", "ShowSpellInfo"};
        local t2 = {"ESC key closes alerts. (Note: Requires UI reload)", "Show the alert frame.", "Show the alert name.", "Show time remaining (if any).", "Place timer on top of alert icon.", "Show number of charges on alerts (if any).", "Show fullscreen flash alert.", "Show spell IDs in chat when alert occurs." };

        local buttonPositionY = -60;
        local buttonPositionX = 20;

        for i,v in ipairs (t) do

            if (i == 5) then
                buttonPositionX = 35
            else
                buttonPositionX = 20;
            end

            local EA_GeneralOptions_CheckButton = CreateFrame("CheckButton", "EA_Button_"..v, tempParent, "OptionsCheckButtonTemplate");
            EA_GeneralOptions_CheckButton:SetPoint("TOPLEFT",buttonPositionX,buttonPositionY);

            getglobal(EA_GeneralOptions_CheckButton:GetName().."Text"):SetText(t2[i]);

            local function EA_GeneralOptions_CheckButton_OnClick()
                if (EA_GeneralOptions_CheckButton:GetChecked()) then
                       EA_Config[v] = true;
                else
                       EA_Config[v]= false;
                end
            end

            local function EA_GeneralOptions_CheckButton_OnShow()
                EA_GeneralOptions_CheckButton:SetChecked(EA_Config[v]);
            end

            EA_GeneralOptions_CheckButton:RegisterForClicks("AnyUp");
            EA_GeneralOptions_CheckButton:SetScript("OnClick", EA_GeneralOptions_CheckButton_OnClick);
            EA_GeneralOptions_CheckButton:SetScript("OnShow", EA_GeneralOptions_CheckButton_OnShow);

            buttonPositionY = buttonPositionY - 30;
        end
    end


-- Icon Options Frames
    function EventAlert_CreateIconOptionsFrames()
        local tempParent = EA_IconOptions_Panel;
        local buttonPositionY = -60;
        local buttonPositionX = 20;


    -- Lock Frame Button
        local t = {"LockFrame"};
        local t2 = {"Lock the alert frame so it cannot be clicked on or moved."};
        for i,v in ipairs (t) do
            local EA_IconOptions_CheckButton = CreateFrame("CheckButton", "EA_Button_"..v, tempParent, "OptionsCheckButtonTemplate");
            EA_IconOptions_CheckButton:SetPoint("TOPLEFT",buttonPositionX,buttonPositionY);

            getglobal(EA_IconOptions_CheckButton:GetName().."Text"):SetText(t2[i]);

            local function EA_IconOptions_CheckButton_OnClick()
                if (EA_IconOptions_CheckButton:GetChecked()) then
                    EA_Position[v] = true;
                else
                    EA_Position[v]= false;
                end
            end

            local function EA_IconOptions_CheckButton_OnShow()
                EA_IconOptions_CheckButton:SetChecked(EA_Position[v]);
            end

            EA_IconOptions_CheckButton:RegisterForClicks("AnyUp");
            EA_IconOptions_CheckButton:SetScript("OnClick", EA_IconOptions_CheckButton_OnClick);
            EA_IconOptions_CheckButton:SetScript("OnShow", EA_IconOptions_CheckButton_OnShow);

        buttonPositionY = buttonPositionY - 30;
        end


    -- Sliders
        buttonPositionY = buttonPositionY - 30;
        local t = {"IconSize", "xOffset", "yOffset"};
        local t2 = {"Alert Size", "Horizontal Spacing", "Vertical Spacing"};
        for i,v in ipairs (t) do

            local EA_IconOptions_Slider = CreateFrame("Slider", "EA_Slider_"..v, tempParent, "OptionsSliderTemplate");
            EA_IconOptions_Slider:SetPoint("TOPLEFT",buttonPositionX,buttonPositionY);

            getglobal(EA_IconOptions_Slider:GetName() .. 'Low'):SetText('-');
            getglobal(EA_IconOptions_Slider:GetName() .. 'High'):SetText('+');
            getglobal(EA_IconOptions_Slider:GetName() .. 'Text'):SetText(t2[i].."\nValue: "..EA_Position[v]);


            if (v == t[1]) then
                EA_IconOptions_Slider:SetMinMaxValues(0,200.0);
            else
                EA_IconOptions_Slider:SetMinMaxValues(-200.00,200.0);
            end

            EA_IconOptions_Slider:SetValueStep(1.0);


            local function EA_IconOptions_Slider_OnShow()
                EA_IconOptions_Slider:SetValue(EA_Position[v]);

                EA_Anchor_Frame:Hide();
                EA_Anchor_Frame2:Hide();
                EA_Anchor_Frame3:Hide();
            end

            local function EA_IconOptions_Slider_OnValueChanged()
                EA_Position[v] = EA_IconOptions_Slider:GetValue();
                getglobal(EA_IconOptions_Slider:GetName() .. 'Text'):SetText(t2[i].."\nValue: "..EA_Position[v]);

                EA_Anchor_Frame:ClearAllPoints();
                EA_Anchor_Frame:SetPoint(EA_Position.Anchor, EA_Position.xLoc, EA_Position.yLoc);
                EA_Anchor_Frame2:ClearAllPoints();
                EA_Anchor_Frame2:SetPoint("CENTER", EA_Anchor_Frame, 100+EA_Position.xOffset, 0+EA_Position.yOffset);
                EA_Anchor_Frame3:ClearAllPoints();
                EA_Anchor_Frame3:SetPoint("CENTER", EA_Anchor_Frame2, 100+EA_Position.xOffset, 0+EA_Position.yOffset);
                EA_Anchor_Frame:SetWidth(EA_Position.IconSize);
                EA_Anchor_Frame:SetHeight(EA_Position.IconSize);
                EA_Anchor_Frame2:SetWidth(EA_Position.IconSize);
                EA_Anchor_Frame2:SetHeight(EA_Position.IconSize);
                EA_Anchor_Frame3:SetWidth(EA_Position.IconSize);
                EA_Anchor_Frame3:SetHeight(EA_Position.IconSize);
            end

            EA_IconOptions_Slider:SetScript("OnValueChanged", EA_IconOptions_Slider_OnValueChanged);
            EA_IconOptions_Slider:SetScript("OnShow", EA_IconOptions_Slider_OnShow);

            buttonPositionY = buttonPositionY - 60;
        end

    -- Reset Button
        buttonPositionY = buttonPositionY - 30;
        local EA_IconOptions_ResetButton = CreateFrame("Button", "EAIOReset", tempParent, "OptionsButtonTemplate");
        EA_IconOptions_ResetButton:SetPoint("TOPLEFT",buttonPositionX,buttonPositionY);
        EA_IconOptions_ResetButton:SetWidth(150);
        EA_IconOptions_ResetButton:SetHeight(21);
        EA_IconOptions_ResetButton:SetText("Reset Icon Settings");
        local function EA_IconOptions_ResetButton_OnClick()
            if (EA_Position.LockFrame == true) then
                DEFAULT_CHAT_FRAME:AddMessage("EventAlert: You must unlock the alert frame in order to move it or reset it's position.")
            else
                EA_Position.IconSize = 60;
                EA_Position.xLoc = 0;
                EA_Position.yLoc = 0;
                EA_Position.xOffset = 0;
                EA_Position.yOffset = 0;
            end

            EventAlert_Options_ToggleAlertFrame();
            EventAlert_Options_ToggleAlertFrame();

            InterfaceOptionsFrame_OpenToCategory(EA_IconOptions_Panel);
        end

        EA_IconOptions_ResetButton:SetScript("OnClick", EA_IconOptions_ResetButton_OnClick);

    -- Alert Anchor Button
        buttonPositionY = buttonPositionY - 30;
        local EA_IconOptions_ShowAnchorButton = CreateFrame("Button", "EAIOShowAnchor", tempParent, "OptionsButtonTemplate");
        EA_IconOptions_ShowAnchorButton:SetPoint("TOPLEFT",buttonPositionX,buttonPositionY);
        EA_IconOptions_ShowAnchorButton:SetWidth(200);
        EA_IconOptions_ShowAnchorButton:SetHeight(21);
        EA_IconOptions_ShowAnchorButton:SetText("Show / Hide Test Alert Icon");

        EA_IconOptions_ShowAnchorButton:SetScript("OnClick", EventAlert_Options_ToggleAlertFrame)
    end



-- Sound Options Frames
    function EventAlert_CreateSoundOptionsFrames()
        local tempParent = EA_SoundOptions_Panel;
        local buttonPositionY = -80;
        local buttonPositionX = 20;

        -- Play Sound Button
        local t = {"DoAlertSound"};
        local t2 = {"Play a sound on alert."};
        for i,v in ipairs (t) do
            local EA_SoundOptions_CheckButton = CreateFrame("CheckButton", "EA_Button_"..v, tempParent, "OptionsCheckButtonTemplate");
            EA_SoundOptions_CheckButton:SetPoint("TOPLEFT",buttonPositionX,buttonPositionY);

            getglobal(EA_SoundOptions_CheckButton:GetName().."Text"):SetText(t2[i]);

            local function EA_SoundOptions_CheckButton_OnClick()
                if (EA_SoundOptions_CheckButton:GetChecked()) then
                    EA_Config[v] = true;
                else
                    EA_Config[v] = false;
                end
            end

            local function EA_SoundOptions_CheckButton_OnShow()
                EA_SoundOptions_CheckButton:SetChecked(EA_Config[v]);
            end

            EA_SoundOptions_CheckButton:RegisterForClicks("AnyUp");
            EA_SoundOptions_CheckButton:SetScript("OnClick", EA_SoundOptions_CheckButton_OnClick);
            EA_SoundOptions_CheckButton:SetScript("OnShow", EA_SoundOptions_CheckButton_OnShow);

            buttonPositionY = buttonPositionY - 30;
        end

        -- Sound Select Drop Down
        EA_SoundSelect_Menu = {
            { text = "Shay's Bell", fileDataID = EA_ALERT_SOUNDS["ShaysBell"] },
            { text = "Flute", fileDataID = EA_ALERT_SOUNDS["FluteRun"] },
            { text = "Netherwind", fileDataID = EA_ALERT_SOUNDS["NetherwindFocusImpact"] },
            { text = "Polymorph Cow", fileDataID = EA_ALERT_SOUNDS["PolymorphCow"] },
            { text = "Rockbiter", fileDataID = EA_ALERT_SOUNDS["RockBiterImpact"] },
            { text = "Yarrrr!", fileDataID = EA_ALERT_SOUNDS["YarrrrImpact"] },
            { text = "Broken Heart", fileDataID = EA_ALERT_SOUNDS["ValentinesBrokenHeart"] },
            { text = "Millhouse 1", fileDataID = EA_ALERT_SOUNDS["Millhouse1"] },
            { text = "Millhouse 2", fileDataID = EA_ALERT_SOUNDS["Millhouse2"] },
            { text = "Pissed Satyre", fileDataID = EA_ALERT_SOUNDS["PissedSatyre"] },
            { text = "Pissed Dwarf", fileDataID = EA_ALERT_SOUNDS["PissedDwarf"] },
        }

        EA_SoundSelect_MenuFrame = CreateFrame("Frame", "EA_SoundSelect_DropDown", EA_SoundOptions_Panel, "UIDropDownMenuTemplate");
        EA_SoundSelect_MenuFrame:SetPoint("TOPLEFT", EA_SoundOptions_Panel, "TOPLEFT", buttonPositionX,-120);
        EA_SoundSelect_MenuFrame_Text = EA_SoundSelect_MenuFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall');
        EA_SoundSelect_MenuFrame_Text:SetPoint("LEFT", EA_SoundSelect_DropDown, "CENTER", 150, 3);
        EA_SoundSelect_MenuFrame_Text:SetText("Sound Selected:   "..EA_Config.AlertSoundText);

        UIDropDownMenu_Initialize(EA_SoundSelect_MenuFrame, EA_SoundSelect_DropDown_MenuInit);
        UIDropDownMenu_SetText(EA_SoundSelect_MenuFrame, "Select a Sound");

    end

    function EA_SoundSelect_DropDown_MenuInit()
       local info = UIDropDownMenu_CreateInfo();

        for _, infoTab in pairs(EA_SoundSelect_Menu) do
            info.text = infoTab.text;
            info.func = function(self, arg1, arg2)
                EA_Config.AlertSound = infoTab.fileDataID
                EA_Config.AlertSoundText = infoTab.text
                EA_SoundSelect_MenuFrame_Text:SetText("Sound Selected:   " .. EA_Config.AlertSoundText)
                PlaySoundFile(EA_Config.AlertSound)
            end

            info.checked = false

            if EA_Config.AlertSound == infoTab.fileDataID then
                info.checked = true
            end

            UIDropDownMenu_AddButton(info);
        end
    end


-- Alerts Options Frames
    function EventAlert_CreateAlertsOptionsFrames()

        -- A BIG thanks to Xchg on the WoW Forums for the scroll frame code.  :)

        --parent frame
            local frame = CreateFrame("Frame", "EAParentScroll", EA_AlertOptions_Panel)
            frame:SetSize(350, 350)
            frame:SetPoint("TOPLEFT", 20, -70)
            local texture = frame:CreateTexture()
            texture:SetAllPoints()
            texture:SetTexture(0,0,0,0)
            frame.background = texture

        --scrollframe
            scrollframe = CreateFrame("ScrollFrame", "EA_scrollFrame", frame)
            scrollframe:SetPoint("TOPLEFT", 10, -10)
            scrollframe:SetPoint("BOTTOMRIGHT", -10, 10)
            local texture = scrollframe:CreateTexture()
            texture:SetAllPoints()
            texture:SetTexture(0,0,0,0)
            frame.scrollframe = scrollframe

        --scrollbar
            scrollbar = CreateFrame("Slider", "EA_scrollBar", scrollframe, "UIPanelScrollBarTemplate")
            scrollbar:SetPoint("TOPLEFT", frame, "TOPRIGHT", 4, -16)
            scrollbar:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 4, 16)
            scrollbar:SetMinMaxValues(1, 300)
            scrollbar:SetValueStep(1)
            scrollbar.scrollStep = 20
            scrollbar:SetValue(0)
            scrollbar:SetWidth(16)
            scrollbar:SetScript("OnValueChanged",
                function (self, value)
                self:GetParent():SetVerticalScroll(value)
            end)

            local scrollbg = scrollbar:CreateTexture(nil, "BACKGROUND")
            scrollbg:SetAllPoints(scrollbar)
            scrollbg:SetTexture(0, 0, 0, 0.4)
            frame.scrollbar = scrollbar

        --content frame
            local content = CreateFrame("Frame", "EAScrollContentFrame", scrollframe)
            content:SetSize(128, 128)
            local texture = content:CreateTexture()
            texture:SetAllPoints()
            content.texture = texture
            scrollframe.content = content

            scrollframe:SetScrollChild(content)


    -- Normal Alerts Checkbuttons
        local buttonPositionX = 10;
        local buttonPositionY = -15;
        local tempTextCounter = 0;

        for index,value in pairsByKeys(EA_Items[EventAlert_GetPlayerClass()]) do
            if (type(value) == "number") then
                value = tostring(index)
            elseif (type(value) == "boolean") then
                if (value) then
                    value = "true"
                else
                    value = "false"
                end
            end

            local EA_name, EA_rank = GetSpellInfo(index);

            if (EA_name ~= nil) then
                if (index == 16870) then
                    -- Special handling for feral druid clearcasting
                    local EA_name2 = GetSpellInfo(16864);
                    if (EA_name2 ~= nil) then
                      EA_name = EA_name2;
                    end
                end


                local EA_AlertOptions_CheckButton = CreateFrame("CheckButton", "EA_Button_"..index, EAScrollContentFrame, "OptionsCheckButtonTemplate");

                if (tempTextCounter == 0) then
                    EA_AlertOptions_CheckButton:SetPoint("TOPLEFT", buttonPositionX,buttonPositionY);
                    EA_SoundOptions_Panel_Text = EA_AlertOptions_CheckButton:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall');
                      EA_SoundOptions_Panel_Text:SetPoint("LEFT", -10, 20);
                    EA_SoundOptions_Panel_Text:SetText("Normal Alerts (Sorted by Spell ID)");
                    tempTextCounter = 1;
                else
                    EA_AlertOptions_CheckButton:SetPoint("TOPLEFT",buttonPositionX,buttonPositionY);
                end

                   buttonPositionY = buttonPositionY - 30;


                if (EA_Config.Debug == true) then
                    if EA_name == nil then EA_name = "REMOVED" end;
                end

                if (EA_rank == "" or EA_rank == nil) then
                    _G[EA_AlertOptions_CheckButton:GetName().."Text"]:SetText(EA_name.."   ["..index.."]");
                else
                    _G[EA_AlertOptions_CheckButton:GetName().."Text"]:SetText(EA_name.." ("..EA_rank..")   ["..index.."]");
                end

                local function EA_AlertOptions_CheckButton_OnClick()
                    if (EA_AlertOptions_CheckButton:GetChecked()) then
                        EA_Items[EventAlert_GetPlayerClass()][index] = true;
                    else
                        EA_Items[EventAlert_GetPlayerClass()][index] = false;
                    end
                end

                local function EA_AlertOptions_CheckButton_OnShow()
                    EA_AlertOptions_CheckButton:SetChecked(EA_Items[EventAlert_GetPlayerClass()][index]);
                end

                EA_AlertOptions_CheckButton:RegisterForClicks("AnyUp");
                EA_AlertOptions_CheckButton:SetScript("OnClick", EA_AlertOptions_CheckButton_OnClick)
                EA_AlertOptions_CheckButton:SetScript("OnShow", EA_AlertOptions_CheckButton_OnShow);
            end
        end

    -- Alternate Alerts Checkbuttons
        tempTextCounter = 0;
        buttonPositionY = buttonPositionY - 30;

        for index,value in pairsByKeys(EA_AltItems[EventAlert_GetPlayerClass()]) do
            if (type(value) == "number") then
                value = tostring(index)
            elseif (type(value) == "boolean") then
                if (value) then
                    value = "true"
                else
                    value = "false"
                end
            end

            EA_name, EA_rank = GetSpellInfo(index);

            if (EA_name ~= nil) then
                local EA_AlertOptions_CheckButton = CreateFrame("CheckButton", "EA_Button_"..index, EAScrollContentFrame, "OptionsCheckButtonTemplate");
                if (tempTextCounter == 0) then
                    EA_AlertOptions_CheckButton:SetPoint("TOPLEFT", buttonPositionX,buttonPositionY);
                    EA_SoundOptions_Panel_Text = EA_AlertOptions_CheckButton:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall');
                      EA_SoundOptions_Panel_Text:SetPoint("LEFT", -10, 20);
                    EA_SoundOptions_Panel_Text:SetText("Alternate Alerts (Sorted by Spell ID)");
                    tempTextCounter = 1;
                else
                    EA_AlertOptions_CheckButton:SetPoint("TOPLEFT",buttonPositionX,buttonPositionY);
                end

                   buttonPositionY = buttonPositionY - 30;


                if (EA_Config.Debug == true) then
                    -- How is this reachable if the surrounding if is EA_name ~= nil?
                    if EA_name == nil then EA_name = "REMOVED" end;
                end

                if (EA_rank == "" or EA_rank == nil) then
                    _G[EA_AlertOptions_CheckButton:GetName().."Text"]:SetText(EA_name.."   ["..index.."]");
                else
                    _G[EA_AlertOptions_CheckButton:GetName().."Text"]:SetText(EA_name.." ("..EA_rank..")   ["..index.."]");
                end

                local function EA_AlertOptions_CheckButton_OnClick()
                    if (EA_AlertOptions_CheckButton:GetChecked()) then
                        EA_AltItems[EventAlert_GetPlayerClass()][index] = true;
                    else
                        EA_AltItems[EventAlert_GetPlayerClass()][index] = false;
                    end
                end

                local function EA_AlertOptions_CheckButton_OnShow()
                    EA_AlertOptions_CheckButton:SetChecked(EA_AltItems[EventAlert_GetPlayerClass()][index]);
                end

                EA_AlertOptions_CheckButton:RegisterForClicks("AnyUp");
                EA_AlertOptions_CheckButton:SetScript("OnClick", EA_AlertOptions_CheckButton_OnClick)
                EA_AlertOptions_CheckButton:SetScript("OnShow", EA_AlertOptions_CheckButton_OnShow);
            end
        end


    -- Stacking Alerts Checkboxes
        tempTextCounter = 0;
        buttonPositionY = buttonPositionY - 60;

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
            index = tonumber(index);

            if (index == 64385) then
                EA_name = "Combo Points";
            elseif (index == EA_CLASS_DRUID_POWER_SPELLID) then
                EA_name = "Astral Power";
            elseif (index == EA_CLASS_SHAMAN_POWER_SPELLID) then
                EA_name = "Maelstrom";
            else
                EA_name, EA_rank = GetSpellInfo(index);
            end

            if (EA_name ~= nil) then
                local EA_AlertOptions_CheckButton = CreateFrame("CheckButton", "EA_Button_"..index, EAScrollContentFrame, "OptionsCheckButtonTemplate");
                local EA_StackingAlertChargeBox = CreateFrame("EditBox", index.."ChargeBox", EAScrollContentFrame, "InputBoxTemplate");

                if (tempTextCounter == 0) then
                    EA_AlertOptions_CheckButton:SetPoint("TOPLEFT", buttonPositionX+38,buttonPositionY);
                    EA_SoundOptions_Panel_Text = EA_AlertOptions_CheckButton:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall');
                      EA_SoundOptions_Panel_Text:SetPoint("LEFT", -45, 40);
                    EA_SoundOptions_Panel_Text:SetText("Stacking Alerts (Sorted by Spell ID)");

                       EA_SACB = EA_StackingAlertChargeBox:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall');
                    EA_SACB:SetPoint("LEFT", -5, 20);
                    EA_SACB:SetText("Charges")

                    tempTextCounter = 1;
                else
                    EA_AlertOptions_CheckButton:SetPoint("TOPLEFT",buttonPositionX+38,buttonPositionY);
                end

                EA_StackingAlertChargeBox:SetPoint("TOPLEFT", buttonPositionX+8,buttonPositionY);
                EA_StackingAlertChargeBox:SetWidth(25);
                EA_StackingAlertChargeBox:SetHeight(21);
                EA_StackingAlertChargeBox:EnableMouse(true);
                EA_StackingAlertChargeBox:SetAutoFocus(false);

                buttonPositionY = buttonPositionY - 30;


                -- This used to be for debug mode only but this may save a lot of confusion...
                if EA_name == nil then EA_name = "REMOVED" end;

                if (EA_rank == "" or EA_rank == nil) then
                    _G[EA_AlertOptions_CheckButton:GetName().."Text"]:SetText(EA_name.."   ["..index.."]");
                else
                    _G[EA_AlertOptions_CheckButton:GetName().."Text"]:SetText(EA_name.." ("..EA_rank..")   ["..index.."]");
                end

                local function EA_AlertOptions_CheckButton_OnClick()
                    if (EA_AlertOptions_CheckButton:GetChecked()) then
                        EA_StackingItems[EventAlert_GetPlayerClass()][index] = true;
                    else
                        EA_StackingItems[EventAlert_GetPlayerClass()][index] = false;
                    end
                end

                local function EA_AlertOptions_CheckButton_OnShow()
                    EA_AlertOptions_CheckButton:SetChecked(EA_StackingItems[EventAlert_GetPlayerClass()][index]);
                end

                local function EA_AlertOptions_StackingCharges_OnShow()
                    for index,value in pairs(EA_StackingItemsCounts[EventAlert_GetPlayerClass()]) do
                        if (_G[index.."ChargeBox"] ~= nil) then
                            local tempStackingName = _G[index.."ChargeBox"];
                            tempStackingName:SetFontObject(ChatFontNormal);
                            tempStackingName:SetText(value);
                        end
                    end
                end

                local function EA_AlertOptions_StackingCharges_OnTextChanged(self, userInput)
                  -- EditBox:GetNumber() returns 0 when NaN, we cannot use it here
                  local value = self:GetText()
                  local numValue = tonumber(value)

                  if (numValue ~= nil) then
                    EA_StackingItemsCounts[EventAlert_GetPlayerClass()][index] = numValue
                  end
                end

                EA_AlertOptions_CheckButton:RegisterForClicks("AnyUp");
                EA_AlertOptions_CheckButton:SetScript("OnClick", EA_AlertOptions_CheckButton_OnClick)
                EA_AlertOptions_CheckButton:SetScript("OnShow", EA_AlertOptions_CheckButton_OnShow);
                EA_StackingAlertChargeBox:SetScript("OnShow", EA_AlertOptions_StackingCharges_OnShow);
                EA_StackingAlertChargeBox:SetScript("OnTextChanged", EA_AlertOptions_StackingCharges_OnTextChanged);
            end
        end
    end


-- Custom Alerts Options Frames
    function EventAlert_CreateCustomAlertsOptionsFrames()
        local tempParent = EA_CustomAlertOptions_Panel;
        local buttonPositionY = -80;
        local buttonPositionX = 20;

        -- New Spell ID Box
        local EA_CustomAlerts_NewIDFrame = CreateFrame("EditBox", "EA_CustomAlerts_NewID", tempParent, "InputBoxTemplate");
        EA_CustomAlerts_NewIDFrame:SetPoint("TOPLEFT", buttonPositionX+23,buttonPositionY);
        EA_CustomAlerts_NewIDFrame:SetWidth(125);
        EA_CustomAlerts_NewIDFrame:SetHeight(21);
        EA_CustomAlerts_NewIDFrame:EnableMouse(true);
        EA_CustomAlerts_NewIDFrame:SetAutoFocus(false);
        EA_CustomAlerts_NewIDFrame_Text = EA_CustomAlerts_NewIDFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall');
        EA_CustomAlerts_NewIDFrame_Text:SetPoint("TOPLEFT", -3, 10);
        EA_CustomAlerts_NewIDFrame_Text:SetText("New Spell ID:");

        -- New Spell ID Save Button
        local EA_CustomAlerts_SaveButton = CreateFrame("Button", "EACAOSave", EA_CustomAlerts_NewID, "OptionsButtonTemplate");
        EA_CustomAlerts_SaveButton:SetPoint("RIGHT",55,0);
        EA_CustomAlerts_SaveButton:SetWidth(50);
        EA_CustomAlerts_SaveButton:SetHeight(21);
        EA_CustomAlerts_SaveButton:SetText("Save");
        EA_CustomAlerts_SaveButton:SetScript("OnClick", EventAlert_Options_SaveCustomAlerts)



        -- Drop Down Box
        EA_CustomAlerts_MenuFrame = CreateFrame("Frame", "EA_CustomAlerts_DropDown", tempParent, "UIDropDownMenuTemplate");
        EA_CustomAlerts_MenuFrame:SetPoint("TOPLEFT", buttonPositionX,buttonPositionY-50);
        UIDropDownMenu_Initialize(EA_CustomAlerts_MenuFrame, EA_CustomAlerts_DropDown_MenuInit);
        UIDropDownMenu_SetText(EA_CustomAlerts_MenuFrame, "Custom Alerts");

        -- Drop Down Delete Button
        local EA_CustomAlerts_DeleteButton = CreateFrame("Button", "EACAODelete", EA_CustomAlerts_DropDown, "OptionsButtonTemplate");
        EA_CustomAlerts_DeleteButton:SetPoint("RIGHT",165,0);
        EA_CustomAlerts_DeleteButton:SetWidth(50);
        EA_CustomAlerts_DeleteButton:SetHeight(21);
        EA_CustomAlerts_DeleteButton:SetText("Delete");
        EA_CustomAlerts_DeleteButton:SetScript("OnClick", EventAlert_Options_DeleteCustomAlerts)
    end

    function EA_CustomAlerts_DropDown_MenuInit()
           local info = UIDropDownMenu_CreateInfo();

        for index,value in pairsByKeys(EA_CustomItems[EventAlert_GetPlayerClass()]) do
            if (type(value) == "number") then
                value = tostring(index)
            elseif (type(value) == "boolean") then
                if (value) then
                    value = "true"
                else
                    value = "false"
                end
              end

             EA_name, EA_rank = GetSpellInfo(index);

               local selectedValue = UIDropDownMenu_GetSelectedValue(EA_CustomAlerts_DropDown) ;
            local info;

            info = {};
            info.text = EA_name.." ["..index.."]";
            info.func = EA_CustomAlerts_DropDown_OnClick;
            info.value = index;
            if ( info.value == selectedValue ) then
                info.checked = index;
            end
            UIDropDownMenu_AddButton(info);
        end
    end

    function EA_CustomAlerts_DropDown_OnClick(self)
        UIDropDownMenu_SetSelectedValue(EA_CustomAlerts_DropDown, self.value);
    end

    function EventAlert_Options_SaveCustomAlerts()
           local tempcustom = EA_CustomAlerts_NewID:GetText()

        if (tempcustom == nil or tempcustom == "") then return;end

           local EA_name, EA_rank = GetSpellInfo(tempcustom);

        if (EA_name == nil) then
            DEFAULT_CHAT_FRAME:AddMessage("Invalid spell ID.");
        else
            tempcustom = tonumber(tempcustom);

            if (EA_CustomItems[EventAlert_GetPlayerClass()][tempcustom] == nil) then
                EA_CustomItems[EventAlert_GetPlayerClass()][tempcustom] = true;
            end;

            EventAlert_CreateAlertIcons(EA_CustomItems[EventAlert_GetPlayerClass()]);
            DEFAULT_CHAT_FRAME:AddMessage("Added "..EA_name.." ["..tempcustom.."] to EventAlert.");
            EA_CustomAlerts_NewID:SetText("")
        end
    end

    function EventAlert_Options_DeleteCustomAlerts()
        local selectedValue = UIDropDownMenu_GetSelectedValue(EA_CustomAlerts_DropDown);

        for index,value in pairsByKeys(EA_CustomItems[EventAlert_GetPlayerClass()]) do
            if (type(value) == "number") then
                value = tostring(index)
            elseif (type(value) == "boolean") then
                if (value) then
                    value = "true"
                else
                    value = "false"
                end
            end

             local EA_name, EA_rank = GetSpellInfo(index);

             if (index == selectedValue) then
                 EA_CustomItems[EventAlert_GetPlayerClass()][selectedValue] = nil;
                  DEFAULT_CHAT_FRAME:AddMessage("Removed "..EA_name.." ["..index.."] from EventAlert.");
                UIDropDownMenu_SetSelectedValue(EA_CustomAlerts_DropDown, EA_CustomAlerts_DropDown);
             end
        end
    end



-- About Frames
    function EventAlert_CreateAboutFrames()
        -- A BIG thanks to Xchg on the WoW Forums for the scroll frame code.  :)

        --parent frame
            local frame = CreateFrame("Frame", "EA_About_ParentScroll", EA_About_Panel)
            frame:SetSize(350, 350)
            frame:SetPoint("TOPLEFT", 20, -70)
            local texture = frame:CreateTexture()
            texture:SetAllPoints()
            texture:SetTexture(0,0,0,0)
            frame.background = texture

        --scrollframe
            scrollframe = CreateFrame("ScrollFrame", nil, frame)
            scrollframe:SetPoint("TOPLEFT", 10, -10)
            scrollframe:SetPoint("BOTTOMRIGHT", -10, 10)
            local texture = scrollframe:CreateTexture()
            texture:SetAllPoints()
            texture:SetTexture(0,0,0,0)
            frame.scrollframe = scrollframe

        --scrollbar
            scrollbar = CreateFrame("Slider", nil, scrollframe, "UIPanelScrollBarTemplate")
            scrollbar:SetPoint("TOPLEFT", frame, "TOPRIGHT", 4, -16)
            scrollbar:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 4, 16)
            scrollbar:SetMinMaxValues(1, 200)
            scrollbar:SetValueStep(1)
            scrollbar.scrollStep = 20
            scrollbar:SetValue(0)
            scrollbar:SetWidth(16)
            scrollbar:SetScript("OnValueChanged",
                function (self, value)
                self:GetParent():SetVerticalScroll(value)
            end)

            local scrollbg = scrollbar:CreateTexture(nil, "BACKGROUND")
            scrollbg:SetAllPoints(scrollbar)
            scrollbg:SetTexture(0, 0, 0, 0.4)
            frame.scrollbar = scrollbar

        --content frame
            local content = CreateFrame("Frame", "EA_About_ScrollContentFrame", scrollframe)
            content:SetSize(128, 128)
            local texture = content:CreateTexture()
            texture:SetAllPoints()
            content.texture = texture
            scrollframe.content = content

            scrollframe:SetScrollChild(content)

        local EA_About_Text1 = CreateFrame("Frame", "EA_About_Text_Frame1", EA_About_ScrollContentFrame)
        EA_About_Text1 = EA_About_Text_Frame1:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall');
          EA_About_Text1:SetPoint("TOPLEFT", EA_About_ScrollContentFrame, "TOPLEFT", 0, 0);

        if (EA_Config.VersionText == nil) then
            EA_About_Text1:SetText("");
            EA_About_Text1:SetText("Event Alert Version:  "..EA_tempVerText);
        else
            EA_About_Text1:SetText("");
            EA_About_Text1:SetText("Event Alert Version:  "..EA_tempVerText);
        end

        local EA_About_ChangeLogFrame = CreateFrame("EditBox", "EA_About_ChangeLog", EA_About_ScrollContentFrame);
        EA_About_ChangeLogFrame:SetPoint("TOPLEFT", 0,-30);
        EA_About_ChangeLogFrame:SetWidth(300);
        EA_About_ChangeLogFrame:SetHeight(300);
        EA_About_ChangeLogFrame:SetMultiLine(true);
        EA_About_ChangeLogFrame:EnableMouse(false);
        EA_About_ChangeLogFrame:SetAutoFocus(false);
        EA_About_ChangeLogFrame:SetFontObject(GameFontHighlightSmall);
        EA_About_ChangeLogFrame:SetText("");
        EA_About_ChangeLogFrame:SetText("Changes:\n\n"..EA_tempChanges);


    end

--All credit goes to the original author, CurtisTheGreat
