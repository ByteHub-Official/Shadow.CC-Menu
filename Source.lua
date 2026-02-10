-- Shadow.CC UI Library - Full Red Themed Version
-- Complete code with all functions (Button, Toggle, KeyBind, TextBox, Slider, Label, Credit, DropDown)

local ShadowCC = {}

function ShadowCC.CreateWindow(libName, logoId)
    libName = libName or "Shadow.CC"
    logoId = logoId or ""

    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local Players = game:GetService("Players")
    local lp = Players.LocalPlayer

    -- RED THEME
    local ACCENT = Color3.fromRGB(220, 50, 60)
    local ACCENT_DARK = Color3.fromRGB(160, 30, 40)
    local ACCENT_HOVER = Color3.fromRGB(240, 80, 90)
    local BG_MAIN = Color3.fromRGB(22, 18, 18)
    local BG_SIDEBAR = Color3.fromRGB(18, 12, 12)
    local BG_ELEMENT = Color3.fromRGB(28, 20, 20)
    local TEXT_MAIN = Color3.fromRGB(255, 230, 230)
    local TEXT_DIM = Color3.fromRGB(190, 140, 140)

    local Gui = Instance.new("ScreenGui")
    Gui.Name = "ShadowCC"
    Gui.ResetOnSpawn = false
    Gui.Parent = game.CoreGui

    local shadow = Instance.new("ImageLabel")
    shadow.Name = "shadow"
    shadow.Parent = Gui
    shadow.BackgroundTransparency = 1
    shadow.Position = UDim2.new(0.319562584, 0, 0.168689325, 0)
    shadow.Size = UDim2.new(0, 609, 0, 530)
    shadow.ZIndex = 0
    shadow.Image = "http://www.roblox.com/asset/?id=6105530152"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.2

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = shadow
    MainFrame.BackgroundColor3 = BG_MAIN
    MainFrame.Position = UDim2.new(0.048, 0, 0.075, 0)
    MainFrame.Size = UDim2.new(0, 553, 0, 452)
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

    local sideHeading = Instance.new("Frame")
    sideHeading.Name = "sideHeading"
    sideHeading.Parent = MainFrame
    sideHeading.BackgroundColor3 = BG_SIDEBAR
    sideHeading.Size = UDim2.new(0, 155, 0, 452)
    sideHeading.ZIndex = 2
    Instance.new("UICorner", sideHeading).CornerRadius = UDim.new(0, 8)

    local sideCover = Instance.new("Frame")
    sideCover.Name = "sideCover"
    sideCover.Parent = sideHeading
    sideCover.BackgroundColor3 = BG_SIDEBAR
    sideCover.BorderSizePixel = 0
    sideCover.Position = UDim2.new(0.909677446, 0, 0, 0)
    sideCover.Size = UDim2.new(0, 14, 0, 452)

    local hubLogo = Instance.new("ImageLabel")
    hubLogo.Name = "hubLogo"
    hubLogo.Parent = sideHeading
    hubLogo.BackgroundColor3 = ACCENT
    hubLogo.Position = UDim2.new(0.0567928664, 0, 0.0243411884, 0)
    hubLogo.Size = UDim2.new(0, 30, 0, 30)
    hubLogo.ZIndex = 2
    hubLogo.Image = "rbxassetid://" .. logoId
    Instance.new("UICorner", hubLogo).CornerRadius = UDim.new(0, 999)

    local hubName = Instance.new("TextLabel")
    hubName.Name = "hubName"
    hubName.Parent = sideHeading
    hubName.BackgroundTransparency = 1
    hubName.Position = UDim2.new(0.29, 0, 0.03, 0)
    hubName.Size = UDim2.new(0, 110, 0, 16)
    hubName.ZIndex = 2
    hubName.Font = Enum.Font.GothamSemibold
    hubName.Text = libName
    hubName.TextColor3 = ACCENT
    hubName.TextSize = 15
    hubName.TextXAlignment = Enum.TextXAlignment.Left

    local usename = Instance.new("TextLabel")
    usename.Name = "usename"
    usename.Parent = sideHeading
    usename.BackgroundTransparency = 1
    usename.Position = UDim2.new(0.29, 0, 0.07, 0)
    usename.Size = UDim2.new(0, 110, 0, 16)
    usename.ZIndex = 2
    usename.Font = Enum.Font.GothamSemibold
    usename.Text = lp.Name
    usename.TextColor3 = TEXT_DIM
    usename.TextSize = 13
    usename.TextXAlignment = Enum.TextXAlignment.Left

    -- Keybind toggle
    local key1 = Instance.new("TextButton")
    key1.Name = "key1"
    key1.Parent = sideHeading
    key1.BackgroundColor3 = Color3.fromRGB(40, 15, 15)
    key1.Position = UDim2.new(0.0508064516, 0, 0.935261786, 0)
    key1.Size = UDim2.new(0, 76, 0, 22)
    key1.ZIndex = 2
    key1.Font = Enum.Font.GothamSemibold
    key1.Text = "LeftAlt"
    key1.TextColor3 = ACCENT
    key1.TextSize = 14
    Instance.new("UICorner", key1).CornerRadius = UDim.new(0, 5)

    local oldKey = Enum.KeyCode.LeftAlt.Name

    key1.MouseButton1Click:Connect(function()
        key1.Text = "..."
        local a, b = UserInputService.InputBegan:Wait()
        if a.KeyCode.Name ~= "Unknown" then
            key1.Text = a.KeyCode.Name
            oldKey = a.KeyCode.Name
        end
    end)

    UserInputService.InputBegan:Connect(function(current, ok)
        if not ok and current.KeyCode.Name == oldKey then
            Gui.Enabled = not Gui.Enabled
        end
    end)

    local keybindInfo1 = Instance.new("TextLabel")
    keybindInfo1.Name = "keybindInfo"
    keybindInfo1.Parent = sideHeading
    keybindInfo1.BackgroundTransparency = 1
    keybindInfo1.Position = UDim2.new(0.585064113, 0, 0.935261846, 0)
    keybindInfo1.Size = UDim2.new(0, 60, 0, 22)
    keybindInfo1.ZIndex = 2
    keybindInfo1.Font = Enum.Font.GothamSemibold
    keybindInfo1.Text = "Toggle GUI"
    keybindInfo1.TextColor3 = TEXT_MAIN
    keybindInfo1.TextSize = 13
    keybindInfo1.TextXAlignment = Enum.TextXAlignment.Left

    -- Draggable
    local TopBar = sideHeading
    local DragMousePosition, FramePosition, Draggable = nil, nil, false
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Draggable = true
            DragMousePosition = Vector2.new(input.Position.X, input.Position.Y)
            FramePosition = Vector2.new(shadow.Position.X.Scale, shadow.Position.Y.Scale)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if Draggable then
            local NewPosition = FramePosition + ((Vector2.new(input.Position.X, input.Position.Y) - DragMousePosition) / workspace.CurrentCamera.ViewportSize)
            shadow.Position = UDim2.new(NewPosition.X, 0, NewPosition.Y, 0)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Draggable = false
        end
    end)

    local framesAll = Instance.new("Frame")
    framesAll.Name = "framesAll"
    framesAll.Parent = MainFrame
    framesAll.BackgroundTransparency = 1
    framesAll.Position = UDim2.new(0.296564192, 0, 0.0242873337, 0)
    framesAll.Size = UDim2.new(0, 381, 0, 431)
    framesAll.ZIndex = 2

    local pageFolder = Instance.new("Folder")
    pageFolder.Name = "pageFolder"
    pageFolder.Parent = framesAll

    local wave = Instance.new("ImageLabel")
    wave.Name = "wave"
    wave.Parent = MainFrame
    wave.BackgroundTransparency = 1
    wave.Position = UDim2.new(0.0213434305, 0, 0, 0)
    wave.Size = UDim2.new(0.97865659, 0, 0.557522118, 0)
    wave.Image = "http://www.roblox.com/asset/?id=6087537285"
    wave.ImageColor3 = ACCENT_DARK
    wave.ImageTransparency = 0.65
    wave.ScaleType = Enum.ScaleType.Slice
    Instance.new("UICorner", wave).CornerRadius = UDim.new(0, 3)

    local tabFrame = Instance.new("ScrollingFrame")
    tabFrame.Name = "tabFrame"
    tabFrame.Parent = sideHeading
    tabFrame.Active = true
    tabFrame.BackgroundTransparency = 1
    tabFrame.BorderSizePixel = 0
    tabFrame.Position = UDim2.new(0.0761478543, 0, 0.126385808, 0)
    tabFrame.Size = UDim2.new(0, 135, 0, 347)
    tabFrame.ZIndex = 2
    tabFrame.ScrollBarThickness = 0

    local UIListLayout = Instance.new("UIListLayout", tabFrame)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)

    local TabHandling = {}

    function TabHandling:Tab(tabText, tabId)
        tabText = tabText or "Tab"
        tabId = tabId or ""

        local tabBtnFrame = Instance.new("Frame")
        tabBtnFrame.Name = "tabBtnFrame"
        tabBtnFrame.Parent = tabFrame
        tabBtnFrame.BackgroundTransparency = 1
        tabBtnFrame.Size = UDim2.new(0, 135, 0, 30)
        tabBtnFrame.ZIndex = 2

        local tabBtn = Instance.new("TextButton")
        tabBtn.Name = "tabBtn"
        tabBtn.Parent = tabBtnFrame
        tabBtn.BackgroundTransparency = 1
        tabBtn.Position = UDim2.new(0.245534033, 0, 0, 0)
        tabBtn.Size = UDim2.new(0, 101, 0, 30)
        tabBtn.ZIndex = 2
        tabBtn.Font = Enum.Font.Gotham
        tabBtn.Text = tabText
        tabBtn.TextColor3 = TEXT_DIM
        tabBtn.TextSize = 14
        tabBtn.TextXAlignment = Enum.TextXAlignment.Left

        local tabLogo = Instance.new("ImageLabel")
        tabLogo.Name = "tabLogo"
        tabLogo.Parent = tabBtnFrame
        tabLogo.BackgroundTransparency = 1
        tabLogo.Position = UDim2.new(-0.007, 0, 0.067, 0)
        tabLogo.Size = UDim2.new(0, 25, 0, 25)
        tabLogo.ZIndex = 2
        tabLogo.Image = "rbxassetid://" .. tabId
        tabLogo.ImageColor3 = TEXT_DIM

        local newPage = Instance.new("ScrollingFrame")
        newPage.Name = "newPage" .. tabText
        newPage.Parent = pageFolder
        newPage.Active = true
        newPage.BackgroundTransparency = 1
        newPage.BorderSizePixel = 0
        newPage.Size = UDim2.new(1, 0, 1, 0)
        newPage.ZIndex = 2
        newPage.ScrollBarThickness = 0
        newPage.Visible = false

        local sectionList = Instance.new("UIListLayout", newPage)
        sectionList.SortOrder = Enum.SortOrder.LayoutOrder
        sectionList.Padding = UDim.new(0, 3)

        local function UpdateSize()
            newPage.CanvasSize = UDim2.new(0, 0, 0, sectionList.AbsoluteContentSize.Y + 20)
        end
        UpdateSize()
        newPage.ChildAdded:Connect(UpdateSize)
        newPage.ChildRemoved:Connect(UpdateSize)

        tabBtn.MouseButton1Click:Connect(function()
            UpdateSize()
            for _, v in ipairs(pageFolder:GetChildren()) do
                v.Visible = false
            end
            newPage.Visible = true

            for _, frame in ipairs(tabFrame:GetChildren()) do
                if frame:IsA("Frame") then
                    for _, child in ipairs(frame:GetChildren()) do
                        if child:IsA("TextButton") then
                            TweenService:Create(child, TweenInfo.new(0.18), {TextColor3 = TEXT_DIM}):Play()
                        elseif child:IsA("ImageLabel") then
                            TweenService:Create(child, TweenInfo.new(0.18), {ImageColor3 = TEXT_DIM}):Play()
                        end
                    end
                end
            end
            TweenService:Create(tabLogo, TweenInfo.new(0.18), {ImageColor3 = ACCENT}):Play()
            TweenService:Create(tabBtn, TweenInfo.new(0.18), {TextColor3 = ACCENT}):Play()
        end)

        local SectionHandling = {}

        function SectionHandling:Section(sectionText)
            sectionText = sectionText or "Section"
            local isDropped = false

            local sectionFrame = Instance.new("Frame")
            sectionFrame.Name = "sectionFrame"
            sectionFrame.Parent = newPage
            sectionFrame.BackgroundColor3 = BG_ELEMENT
            sectionFrame.Size = UDim2.new(1, 0, 0, 36)
            sectionFrame.ZIndex = 2
            sectionFrame.ClipsDescendants = true
            Instance.new("UICorner", sectionFrame).CornerRadius = UDim.new(0, 6)

            local mainSectionHead = Instance.new("Frame")
            mainSectionHead.Name = "mainSectionHead"
            mainSectionHead.Parent = sectionFrame
            mainSectionHead.BackgroundTransparency = 1
            mainSectionHead.Size = UDim2.new(1, 0, 0, 36)

            local sectionName = Instance.new("TextLabel")
            sectionName.Name = "sectionName"
            sectionName.Parent = mainSectionHead
            sectionName.BackgroundTransparency = 1
            sectionName.Position = UDim2.new(0.0236220472, 0, 0, 0)
            sectionName.Size = UDim2.new(0, 302, 0, 36)
            sectionName.Font = Enum.Font.GothamSemibold
            sectionName.Text = sectionText
            sectionName.TextColor3 = ACCENT
            sectionName.TextSize = 14
            sectionName.TextXAlignment = Enum.TextXAlignment.Left

            local sectionExpand = Instance.new("ImageButton")
            sectionExpand.Name = "sectionExpand"
            sectionExpand.Parent = mainSectionHead
            sectionExpand.BackgroundTransparency = 1
            sectionExpand.Position = UDim2.new(0.91863519, 0, 0.138888896, 0)
            sectionExpand.Size = UDim2.new(0, 25, 0, 25)
            sectionExpand.ZIndex = 2
            sectionExpand.Image = "rbxassetid://3926305904"
            sectionExpand.ImageColor3 = ACCENT
            sectionExpand.ImageRectOffset = Vector2.new(564, 284)
            sectionExpand.ImageRectSize = Vector2.new(36, 36)

            local sectionInnerList = Instance.new("UIListLayout", sectionFrame)
            sectionInnerList.SortOrder = Enum.SortOrder.LayoutOrder
            sectionInnerList.Padding = UDim.new(0, 3)

            sectionExpand.MouseButton1Click:Connect(function()
                if isDropped then
                    isDropped = false
                    sectionFrame:TweenSize(UDim2.new(1,0,0,36), "In", "Quint", 0.1)
                    TweenService:Create(sectionExpand, TweenInfo.new(0.1), {Rotation = 0}):Play()
                else
                    isDropped = true
                    sectionFrame:TweenSize(UDim2.new(1,0,0, sectionInnerList.AbsoluteContentSize.Y + 10), "In", "Quint", 0.1)
                    TweenService:Create(sectionExpand, TweenInfo.new(0.1), {Rotation = 180}):Play()
                end
                UpdateSize()
            end)

            local ItemHandling = {}

            function ItemHandling:Button(btnText, callback)
                btnText = btnText or "Button"
                callback = callback or function() end

                local ButtonFrame = Instance.new("Frame")
                ButtonFrame.Name = "ButtonFrame"
                ButtonFrame.Parent = sectionFrame
                ButtonFrame.BackgroundTransparency = 1
                ButtonFrame.Size = UDim2.new(0, 365, 0, 36)

                local TextButton = Instance.new("TextButton")
                TextButton.Parent = ButtonFrame
                TextButton.BackgroundColor3 = BG_ELEMENT
                TextButton.Size = UDim2.new(1, 0, 1, 0)
                TextButton.ZIndex = 2
                TextButton.AutoButtonColor = false
                TextButton.Text = btnText
                TextButton.Font = Enum.Font.GothamSemibold
                TextButton.TextColor3 = TEXT_MAIN
                TextButton.TextSize = 14
                Instance.new("UICorner", TextButton).CornerRadius = UDim.new(0, 6)

                TextButton.MouseEnter:Connect(function()
                    TweenService:Create(TextButton, TweenInfo.new(0.18), {BackgroundColor3 = ACCENT_DARK, TextColor3 = ACCENT_HOVER}):Play()
                end)
                TextButton.MouseLeave:Connect(function()
                    TweenService:Create(TextButton, TweenInfo.new(0.18), {BackgroundColor3 = BG_ELEMENT, TextColor3 = TEXT_MAIN}):Play()
                end)
                TextButton.MouseButton1Click:Connect(callback)
            end

            function ItemHandling:Toggle(toggInfo, callback)
                toggInfo = toggInfo or "Toggle"
                callback = callback or function() end

                local ToggleFrame = Instance.new("Frame")
                ToggleFrame.Name = "ToggleFrame"
                ToggleFrame.Parent = sectionFrame
                ToggleFrame.BackgroundTransparency = 1
                ToggleFrame.Size = UDim2.new(0, 365, 0, 36)

                local toggleFrame = Instance.new("Frame")
                toggleFrame.Name = "toggleFrame"
                toggleFrame.Parent = ToggleFrame
                toggleFrame.BackgroundColor3 = BG_ELEMENT
                toggleFrame.Size = UDim2.new(1, 0, 1, 0)
                Instance.new("UICorner", toggleFrame).CornerRadius = UDim.new(0, 6)

                local checkBtn = Instance.new("ImageButton")
                checkBtn.Name = "checkBtn"
                checkBtn.Parent = toggleFrame
                checkBtn.BackgroundTransparency = 1
                checkBtn.Position = UDim2.new(0.019, 0, 0.139, 0)
                checkBtn.Size = UDim2.new(0, 25, 0, 25)
                checkBtn.Image = "rbxassetid://3926311105"
                checkBtn.ImageColor3 = TEXT_DIM
                checkBtn.ImageRectOffset = Vector2.new(940, 784)
                checkBtn.ImageRectSize = Vector2.new(48, 48)

                local toggleInfo = Instance.new("TextLabel")
                toggleInfo.Name = "toggleInfo"
                toggleInfo.Parent = toggleFrame
                toggleInfo.BackgroundTransparency = 1
                toggleInfo.Position = UDim2.new(0.104, 0, 0, 0)
                toggleInfo.Size = UDim2.new(0.7, 0, 1, 0)
                toggleInfo.Font = Enum.Font.GothamSemibold
                toggleInfo.Text = toggInfo
                toggleInfo.TextColor3 = TEXT_DIM
                toggleInfo.TextSize = 14
                toggleInfo.TextXAlignment = Enum.TextXAlignment.Left

                local on = false
                checkBtn.MouseButton1Click:Connect(function()
                    on = not on
                    callback(on)
                    if on then
                        toggleInfo.TextColor3 = ACCENT
                        checkBtn.ImageColor3 = ACCENT
                        checkBtn.ImageRectOffset = Vector2.new(4, 836)
                    else
                        toggleInfo.TextColor3 = TEXT_DIM
                        checkBtn.ImageColor3 = TEXT_DIM
                        checkBtn.ImageRectOffset = Vector2.new(940, 784)
                    end
                end)
            end

            function ItemHandling:KeyBind(keyInfo, first, callback)
                keyInfo = keyInfo or "KeyBind"
                local oldKey = first.Name
                callback = callback or function() end

                local KeyBindFrame = Instance.new("Frame")
                KeyBindFrame.Name = "KeyBindFrame"
                KeyBindFrame.Parent = sectionFrame
                KeyBindFrame.BackgroundTransparency = 1
                KeyBindFrame.Size = UDim2.new(0, 365, 0, 36)

                local keybindFrame = Instance.new("Frame")
                keybindFrame.Name = "keybindFrame"
                keybindFrame.Parent = KeyBindFrame
                keybindFrame.BackgroundColor3 = BG_ELEMENT
                keybindFrame.Size = UDim2.new(1, 0, 1, 0)
                Instance.new("UICorner", keybindFrame).CornerRadius = UDim.new(0, 6)

                local key = Instance.new("TextButton")
                key.Name = "key"
                key.Parent = keybindFrame
                key.BackgroundColor3 = Color3.fromRGB(40, 15, 15)
                key.Position = UDim2.new(0.025, 0, 0.194, 0)
                key.Size = UDim2.new(0, 100, 0, 22)
                key.Font = Enum.Font.GothamSemibold
                key.Text = oldKey
                key.TextColor3 = ACCENT
                key.TextSize = 14
                Instance.new("UICorner", key).CornerRadius = UDim.new(0, 5)

                local keybindInfo = Instance.new("TextLabel")
                keybindInfo.Name = "keybindInfo"
                keybindInfo.Parent = keybindFrame
                keybindInfo.BackgroundTransparency = 1
                keybindInfo.Position = UDim2.new(0.32, 0, 0.167, 0)
                keybindInfo.Size = UDim2.new(0, 239, 0, 22)
                keybindInfo.Font = Enum.Font.GothamSemibold
                keybindInfo.Text = keyInfo
                keybindInfo.TextColor3 = TEXT_MAIN
                keybindInfo.TextSize = 13
                keybindInfo.TextXAlignment = Enum.TextXAlignment.Left

                key.MouseButton1Click:Connect(function()
                    key.Text = "..."
                    local a = UserInputService.InputBegan:Wait()
                    if a.KeyCode.Name ~= "Unknown" then
                        key.Text = a.KeyCode.Name
                        oldKey = a.KeyCode.Name
                    end
                end)

                UserInputService.InputBegan:Connect(function(current, ok)
                    if not ok and current.KeyCode.Name == oldKey then
                        callback()
                    end
                end)
            end

            function ItemHandling:TextBox(infbix, textPlace, callback)
                infbix = infbix or "TextBox"
                textPlace = textPlace or "Placeholder"
                callback = callback or function() end

                local TextBoxFrame = Instance.new("Frame")
                TextBoxFrame.Name = "TextBoxFrame"
                TextBoxFrame.Parent = sectionFrame
                TextBoxFrame.BackgroundTransparency = 1
                TextBoxFrame.Size = UDim2.new(0, 365, 0, 36)

                local textboxFrame = Instance.new("Frame")
                textboxFrame.Name = "textboxFrame"
                textboxFrame.Parent = TextBoxFrame
                textboxFrame.BackgroundColor3 = BG_ELEMENT
                textboxFrame.Size = UDim2.new(1, 0, 1, 0)
                Instance.new("UICorner", textboxFrame).CornerRadius = UDim.new(0, 6)

                local textboxInfo = Instance.new("TextLabel")
                textboxInfo.Name = "textboxInfo"
                textboxInfo.Parent = textboxFrame
                textboxInfo.BackgroundTransparency = 1
                textboxInfo.Position = UDim2.new(0.32, 0, 0.167, 0)
                textboxInfo.Size = UDim2.new(0, 239, 0, 22)
                textboxInfo.Font = Enum.Font.GothamSemibold
                textboxInfo.Text = infbix
                textboxInfo.TextColor3 = TEXT_MAIN
                textboxInfo.TextSize = 13
                textboxInfo.TextXAlignment = Enum.TextXAlignment.Left

                local TextBox = Instance.new("TextBox")
                TextBox.Parent = textboxFrame
                TextBox.BackgroundColor3 = ACCENT
                TextBox.Position = UDim2.new(0.025, 0, 0.194, 0)
                TextBox.Size = UDim2.new(0, 100, 0, 22)
                TextBox.Font = Enum.Font.GothamSemibold
                TextBox.PlaceholderText = textPlace
                TextBox.PlaceholderColor3 = Color3.fromRGB(80, 80, 80)
                TextBox.Text = ""
                TextBox.TextColor3 = Color3.new(0,0,0)
                TextBox.TextSize = 13
                Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 5)

                TextBox.FocusLost:Connect(function(enter)
                    if enter then
                        callback(TextBox.Text)
                        TextBox.Text = ""
                    end
                end)
            end

            function ItemHandling:Slider(slidInfo, minvalue, maxvalue, callback)
                slidInfo = slidInfo or "Slider"
                minvalue = minvalue or 0
                maxvalue = maxvalue or 500
                callback = callback or function() end

                local SliderFrame = Instance.new("Frame")
                SliderFrame.Name = "SliderFrame"
                SliderFrame.Parent = sectionFrame
                SliderFrame.BackgroundTransparency = 1
                SliderFrame.Size = UDim2.new(0, 365, 0, 36)

                local sliderFrame = Instance.new("Frame")
                sliderFrame.Name = "sliderFrame"
                sliderFrame.Parent = SliderFrame
                sliderFrame.BackgroundColor3 = BG_ELEMENT
                sliderFrame.Size = UDim2.new(1, 0, 1, 0)
                Instance.new("UICorner", sliderFrame).CornerRadius = UDim.new(0, 6)

                local sliderbtn = Instance.new("TextButton")
                sliderbtn.Name = "sliderbtn"
                sliderbtn.Parent = sliderFrame
                sliderbtn.BackgroundColor3 = Color3.fromRGB(40, 15, 15)
                sliderbtn.Position = UDim2.new(0.017, 0, 0.416, 0)
                sliderbtn.Size = UDim2.new(0, 150, 0, 6)
                sliderbtn.AutoButtonColor = false
                sliderbtn.Text = ""
                Instance.new("UICorner", sliderbtn).CornerRadius = UDim.new(0, 5)

                local dragSlider = Instance.new("Frame")
                dragSlider.Name = "dragSlider"
                dragSlider.Parent = sliderbtn
                dragSlider.BackgroundColor3 = ACCENT
                dragSlider.Size = UDim2.new(0, 0, 0, 6)
                Instance.new("UICorner", dragSlider).CornerRadius = UDim.new(0, 5)

                local sliderInfo = Instance.new("TextLabel")
                sliderInfo.Name = "sliderInfo"
                sliderInfo.Parent = sliderFrame
                sliderInfo.BackgroundTransparency = 1
                sliderInfo.Position = UDim2.new(0.466, 0, 0, 0)
                sliderInfo.Size = UDim2.new(0, 193, 0, 36)
                sliderInfo.Font = Enum.Font.GothamSemibold
                sliderInfo.Text = slidInfo
                sliderInfo.TextColor3 = TEXT_MAIN
                sliderInfo.TextSize = 14
                sliderInfo.TextXAlignment = Enum.TextXAlignment.Left

                local mouse = lp:GetMouse()
                local Value = 0

                sliderbtn.MouseButton1Down:Connect(function()
                    Value = math.floor((((maxvalue - minvalue) / 150) * dragSlider.AbsoluteSize.X) + minvalue)
                    callback(Value)
                    dragSlider.Size = UDim2.new(0, math.clamp(mouse.X - dragSlider.AbsolutePosition.X, 0, 150), 0, 6)

                    local moveConn = mouse.Move:Connect(function()
                        Value = math.floor((((maxvalue - minvalue) / 150) * dragSlider.AbsoluteSize.X) + minvalue)
                        callback(Value)
                        dragSlider.Size = UDim2.new(0, math.clamp(mouse.X - dragSlider.AbsolutePosition.X, 0, 150), 0, 6)
                    end)

                    local releaseConn
                    releaseConn = UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            moveConn:Disconnect()
                            releaseConn:Disconnect()
                        end
                    end)
                end)
            end

            function ItemHandling:Label(labelInfo)
                labelInfo = labelInfo or "Label"

                local TextLabelFrame = Instance.new("Frame")
                TextLabelFrame.Name = "TextLabelFrame"
                TextLabelFrame.Parent = sectionFrame
                TextLabelFrame.BackgroundTransparency = 1
                TextLabelFrame.Size = UDim2.new(0, 365, 0, 36)

                local TextLabel = Instance.new("TextLabel")
                TextLabel.Parent = TextLabelFrame
                TextLabel.BackgroundColor3 = BG_ELEMENT
                TextLabel.Size = UDim2.new(1, 0, 1, 0)
                TextLabel.Font = Enum.Font.GothamSemibold
                TextLabel.Text = labelInfo
                TextLabel.TextColor3 = TEXT_MAIN
                TextLabel.TextSize = 14
                Instance.new("UICorner", TextLabel).CornerRadius = UDim.new(0, 6)
            end

            function ItemHandling:Credit(creditWho)
                creditWho = creditWho or "Credit"

                local TextLabelFrame = Instance.new("Frame")
                TextLabelFrame.Name = "TextLabelFrame"
                TextLabelFrame.Parent = sectionFrame
                TextLabelFrame.BackgroundTransparency = 1
                TextLabelFrame.Size = UDim2.new(0, 365, 0, 36)

                local TextLabel = Instance.new("TextLabel")
                TextLabel.Parent = TextLabelFrame
                TextLabel.BackgroundColor3 = BG_ELEMENT
                TextLabel.Size = UDim2.new(1, 0, 1, 0)
                TextLabel.Font = Enum.Font.Gotham
                TextLabel.Text = "  " .. creditWho
                TextLabel.TextColor3 = TEXT_MAIN
                TextLabel.TextSize = 14
                TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                Instance.new("UICorner", TextLabel).CornerRadius = UDim.new(0, 6)
            end

            function ItemHandling:DropDown(dropInfo, list, callback)
                dropInfo = dropInfo or "Dropdown"
                list = list or {}
                callback = callback or function() end

                local isDropped1 = false
                local DropYSize = 36

                local DropDownFrame = Instance.new("Frame")
                DropDownFrame.Name = "DropDownFrame"
                DropDownFrame.Parent = sectionFrame
                DropDownFrame.BackgroundTransparency = 1
                DropDownFrame.Size = UDim2.new(0, 365, 0, 36)
                DropDownFrame.ClipsDescendants = true

                local dropdownFrame = Instance.new("Frame")
                dropdownFrame.Name = "dropdownFrame"
                dropdownFrame.Parent = DropDownFrame
                dropdownFrame.BackgroundColor3 = BG_ELEMENT
                dropdownFrame.Size = UDim2.new(1, 0, 1, 0)
                Instance.new("UICorner", dropdownFrame).CornerRadius = UDim.new(0, 6)

                local dropdownFrameMain = Instance.new("Frame")
                dropdownFrameMain.Name = "dropdownFrameMain"
                dropdownFrameMain.Parent = dropdownFrame
                dropdownFrameMain.BackgroundColor3 = BG_ELEMENT
                dropdownFrameMain.Size = UDim2.new(1, 0, 0, 36)
                Instance.new("UICorner", dropdownFrameMain).CornerRadius = UDim.new(0, 6)

                local expand_more = Instance.new("ImageButton")
                expand_more.Name = "expand_more"
                expand_more.Parent = dropdownFrameMain
                expand_more.BackgroundTransparency = 1
                expand_more.Position = UDim2.new(0.919, 0, 0.139, 0)
                expand_more.Size = UDim2.new(0, 25, 0, 25)
                expand_more.Image = "rbxassetid://3926305904"
                expand_more.ImageColor3 = ACCENT
                expand_more.ImageRectOffset = Vector2.new(564, 284)
                expand_more.ImageRectSize = Vector2.new(36, 36)

                local dropdownItem1 = Instance.new("TextLabel")
                dropdownItem1.Name = "dropdownItem1"
                dropdownItem1.Parent = dropdownFrameMain
                dropdownItem1.BackgroundTransparency = 1
                dropdownItem1.Position = UDim2.new(0.025, 0, 0.083, 0)
                dropdownItem1.Size = UDim2.new(0, 293, 0, 30)
                dropdownItem1.Font = Enum.Font.GothamSemibold
                dropdownItem1.Text = dropInfo
                dropdownItem1.TextColor3 = ACCENT
                dropdownItem1.TextSize = 14
                dropdownItem1.TextXAlignment = Enum.TextXAlignment.Left

                expand_more.MouseButton1Click:Connect(function()
                    isDropped1 = not isDropped1
                    if isDropped1 then
                        DropDownFrame:TweenSize(UDim2.new(0, 365, 0, DropYSize), "In", "Quint", 0.1)
                        TweenService:Create(expand_more, TweenInfo.new(0.1), {Rotation = 180}):Play()
                    else
                        DropDownFrame:TweenSize(UDim2.new(0, 365, 0, 36), "In", "Quint", 0.1)
                        TweenService:Create(expand_more, TweenInfo.new(0.1), {Rotation = 0}):Play()
                    end
                    UpdateSize()
                end)

                for _, v in ipairs(list) do
                    local optionBtnFrame = Instance.new("Frame")
                    optionBtnFrame.Name = "optionBtnFrame"
                    optionBtnFrame.Parent = dropdownFrame
                    optionBtnFrame.BackgroundTransparency = 1
                    optionBtnFrame.Size = UDim2.new(0, 339, 0, 34)

                    local optionBtn1 = Instance.new("TextButton")
                    optionBtn1.Name = "optionBtn1"
                    optionBtn1.Parent = optionBtnFrame
                    optionBtn1.BackgroundColor3 = BG_ELEMENT
                    optionBtn1.Size = UDim2.new(1, 0, 1, 0)
                    optionBtn1.Text = "  " .. v
                    optionBtn1.Font = Enum.Font.GothamSemibold
                    optionBtn1.TextColor3 = TEXT_DIM
                    optionBtn1.TextSize = 14
                    optionBtn1.TextXAlignment = Enum.TextXAlignment.Left
                    Instance.new("UICorner", optionBtn1).CornerRadius = UDim.new(0, 6)

                    DropYSize = DropYSize + 40

                    optionBtn1.MouseButton1Click:Connect(function()
                        callback(v)
                        dropdownItem1.Text = v
                        DropDownFrame:TweenSize(UDim2.new(0, 365, 0, 36), "In", "Quint", 0.1)
                        isDropped1 = false
                        TweenService:Create(expand_more, TweenInfo.new(0.1), {Rotation = 0}):Play()
                        UpdateSize()
                    end)
                end

                return ItemHandling
            end

            return ItemHandling
        end

        return SectionHandling
    end

    return TabHandling
end

return ShadowCC
