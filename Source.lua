-- ShadowCC UI - Red & Black gradient, Luxt-style layout
local ShadowCC = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Theme: red & black
local BLACK = Color3.fromRGB(12, 12, 12)
local DARK = Color3.fromRGB(22, 8, 8)
local DARK2 = Color3.fromRGB(35, 10, 10)
local RED = Color3.fromRGB(220, 55, 55)
local RED_DIM = Color3.fromRGB(180, 45, 45)
local RED_BRIGHT = Color3.fromRGB(255, 90, 90)
local TEXT = Color3.fromRGB(255, 210, 210)
local TEXT_DIM = Color3.fromRGB(200, 150, 150)
local WHITE = Color3.fromRGB(255, 255, 255)

local function addCorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 5)
    c.Parent = parent
    return c
end

local function addGradient(parent, c0, c1)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new({ {0, c0 or DARK}, {1, c1 or BLACK} })
    g.Rotation = 90
    g.Parent = parent
    return g
end

function ShadowCC.CreateWindow(libName, logoId)
    libName = libName or "ShadowCC"
    logoId = logoId or ""

    local gui = Instance.new("ScreenGui")
    gui.Name = "ShadowCCLib" .. libName
    gui.Parent = game:GetService("CoreGui")
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local shadow = Instance.new("ImageLabel")
    shadow.Name = "shadow"
    shadow.Size = UDim2.new(0, 609, 0, 530)
    shadow.Position = UDim2.new(0.32, 0, 0.17, 0)
    shadow.BackgroundTransparency = 1
    shadow.Image = "http://www.roblox.com/asset/?id=6105530152"
    shadow.ImageColor3 = BLACK
    shadow.ImageTransparency = 0.25
    shadow.ZIndex = 0
    shadow.Parent = gui

    local main = Instance.new("Frame")
    main.Name = "MainFrame"
    main.Size = UDim2.new(0, 553, 0, 452)
    main.Position = UDim2.new(0.048, 0, 0.075, 0)
    main.BackgroundColor3 = DARK2
    main.Parent = shadow
    addCorner(main, 6)
    addGradient(main, Color3.fromRGB(45, 12, 12), Color3.fromRGB(18, 18, 18))

    -- Sidebar
    local sidebar = Instance.new("Frame")
    sidebar.Name = "sideHeading"
    sidebar.Size = UDim2.new(0, 155, 0, 452)
    sidebar.Position = UDim2.new(0, 0, 0, 0)
    sidebar.BackgroundColor3 = DARK
    sidebar.ZIndex = 3
    sidebar.Parent = main
    addCorner(sidebar, 6)
    addGradient(sidebar, Color3.fromRGB(55, 15, 15), Color3.fromRGB(15, 15, 15))

    local cover = Instance.new("Frame")
    cover.Size = UDim2.new(0, 14, 0, 452)
    cover.Position = UDim2.new(0.91, 0, 0, 0)
    cover.BackgroundColor3 = DARK
    cover.BorderSizePixel = 0
    cover.Parent = sidebar

    -- Logo
    local logo = Instance.new("ImageLabel")
    logo.Name = "hubLogo"
    logo.Size = UDim2.new(0, 30, 0, 30)
    logo.Position = UDim2.new(0.057, 0, 0.024, 0)
    logo.BackgroundColor3 = RED
    logo.Image = "rbxassetid://" .. logoId
    logo.ZIndex = 4
    logo.Parent = sidebar
    addCorner(logo, 999)

    local hubName = Instance.new("TextLabel")
    hubName.Size = UDim2.new(0, 110, 0, 16)
    hubName.Position = UDim2.new(0.29, 0, 0.03, 0)
    hubName.BackgroundTransparency = 1
    hubName.Text = libName
    hubName.TextColor3 = RED
    hubName.TextSize = 14
    hubName.Font = Enum.Font.GothamSemibold
    hubName.TextXAlignment = Enum.TextXAlignment.Left
    hubName.ZIndex = 4
    hubName.Parent = sidebar

    local usename = Instance.new("TextLabel")
    usename.Size = UDim2.new(0, 110, 0, 16)
    usename.Position = UDim2.new(0.29, 0, 0.07, 0)
    usename.BackgroundTransparency = 1
    usename.Text = game.Players.LocalPlayer and game.Players.LocalPlayer.Name or "Player"
    usename.TextColor3 = TEXT_DIM
    usename.TextSize = 12
    usename.Font = Enum.Font.GothamSemibold
    usename.TextXAlignment = Enum.TextXAlignment.Left
    usename.ZIndex = 4
    usename.Parent = sidebar

    -- Tab list: ScrollingFrame -> inner Frame -> UIListLayout (tabs added here)
    local tabScroll = Instance.new("ScrollingFrame")
    tabScroll.Name = "tabFrame"
    tabScroll.Size = UDim2.new(0, 135, 0, 320)
    tabScroll.Position = UDim2.new(0.076, 0, 0.128, 0)
    tabScroll.BackgroundTransparency = 1
    tabScroll.BorderSizePixel = 0
    tabScroll.ScrollBarThickness = 0
    tabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tabScroll.ScrollingDirection = Enum.ScrollingDirection.Y
    tabScroll.ZIndex = 4
    tabScroll.Parent = sidebar

    local tabListInner = Instance.new("Frame")
    tabListInner.Name = "TabListInner"
    tabListInner.Size = UDim2.new(1, 0, 0, 0)
    tabListInner.BackgroundTransparency = 1
    tabListInner.Parent = tabScroll

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 5)
    tabLayout.Parent = tabListInner

    local function updateTabListSize()
        local h = tabLayout.AbsoluteContentSize.Y
        tabListInner.Size = UDim2.new(1, 0, 0, math.max(h, 10))
        tabScroll.CanvasSize = UDim2.new(0, 0, 0, h + 5)
    end
    tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateTabListSize)

    -- Keybind toggle (close menu)
    local toggleKey = Enum.KeyCode.LeftAlt
    local keyBtn = Instance.new("TextButton")
    keyBtn.Name = "key1"
    keyBtn.Size = UDim2.new(0, 76, 0, 22)
    keyBtn.Position = UDim2.new(0.05, 0, 0.935, 0)
    keyBtn.BackgroundColor3 = BLACK
    keyBtn.Text = toggleKey.Name
    keyBtn.TextColor3 = RED
    keyBtn.TextSize = 14
    keyBtn.Font = Enum.Font.GothamSemibold
    keyBtn.ZIndex = 4
    keyBtn.Parent = sidebar
    addCorner(keyBtn, 5)

    keyBtn.MouseButton1Click:Connect(function()
        keyBtn.Text = "..."
        local _, input = UserInputService.InputBegan:Wait()
        if input and input.KeyCode.Name ~= "Unknown" then
            keyBtn.Text = input.KeyCode.Name
            toggleKey = input.KeyCode
        end
    end)
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == toggleKey then
            gui.Enabled = not gui.Enabled
        end
    end)

    local keyLabel = Instance.new("TextLabel")
    keyLabel.Size = UDim2.new(0, 50, 0, 22)
    keyLabel.Position = UDim2.new(0.585, 0, 0.935, 0)
    keyLabel.BackgroundTransparency = 1
    keyLabel.Text = "Close"
    keyLabel.TextColor3 = WHITE
    keyLabel.TextSize = 13
    keyLabel.Font = Enum.Font.GothamSemibold
    keyLabel.TextXAlignment = Enum.TextXAlignment.Left
    keyLabel.ZIndex = 4
    keyLabel.Parent = sidebar

    -- Drag
    local Camera = workspace:WaitForChild("Camera")
    local dragging, dragStart, frameStart = false, nil, nil
    sidebar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = Vector2.new(input.Position.X, input.Position.Y)
            frameStart = Vector2.new(shadow.Position.X.Scale, shadow.Position.Y.Scale)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging then
            local pos = Vector2.new(input.Position.X, input.Position.Y)
            local delta = (pos - dragStart) / Vector2.new(Camera.ViewportSize.X, Camera.ViewportSize.Y)
            shadow.Position = UDim2.new(frameStart.X + delta.X, 0, frameStart.Y + delta.Y, 0)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    -- Content area
    local content = Instance.new("Frame")
    content.Name = "framesAll"
    content.Size = UDim2.new(0, 381, 0, 431)
    content.Position = UDim2.new(0.297, 0, 0.024, 0)
    content.BackgroundTransparency = 1
    content.ZIndex = 2
    content.Parent = main

    local pageFolder = Instance.new("Folder")
    pageFolder.Name = "pageFolder"
    pageFolder.Parent = content

    local tabCount = 0
    local TabHandling = {}

    function TabHandling:Tab(tabText, tabId)
        tabText = tabText or "Tab"
        tabId = tabId or ""
        tabCount = tabCount + 1

        -- Tab button
        local btnFrame = Instance.new("Frame")
        btnFrame.Name = "tabBtnFrame"
        btnFrame.Size = UDim2.new(0, 135, 0, 30)
        btnFrame.BackgroundTransparency = 1
        btnFrame.LayoutOrder = tabCount
        btnFrame.ZIndex = 4
        btnFrame.Parent = tabListInner

        local tabBtn = Instance.new("TextButton")
        tabBtn.Name = "tabBtn"
        tabBtn.Size = UDim2.new(0, 101, 0, 30)
        tabBtn.Position = UDim2.new(0.245, 0, 0, 0)
        tabBtn.BackgroundTransparency = 1
        tabBtn.Text = tabText
        tabBtn.TextColor3 = RED
        tabBtn.TextSize = 14
        tabBtn.Font = Enum.Font.Gotham
        tabBtn.TextXAlignment = Enum.TextXAlignment.Left
        tabBtn.ZIndex = 4
        tabBtn.Parent = btnFrame

        local tabIcon = Instance.new("ImageLabel")
        tabIcon.Size = UDim2.new(0, 25, 0, 25)
        tabIcon.Position = UDim2.new(-0.007, 0, 0.067, 0)
        tabIcon.BackgroundTransparency = 1
        tabIcon.Image = "rbxassetid://" .. tabId
        tabIcon.ImageColor3 = RED
        tabIcon.ZIndex = 4
        tabIcon.Parent = btnFrame

        -- Page
        local page = Instance.new("ScrollingFrame")
        page.Name = "newPage" .. tabText
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.BorderSizePixel = 0
        page.ScrollBarThickness = 0
        page.Visible = false
        page.ZIndex = 2
        page.Parent = pageFolder

        local sectionList = Instance.new("UIListLayout")
        sectionList.SortOrder = Enum.SortOrder.LayoutOrder
        sectionList.Padding = UDim.new(0, 3)
        sectionList.Parent = page

        local function updatePageSize()
            local cs = sectionList.AbsoluteContentSize
            TweenService:Create(page, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {
                CanvasSize = UDim2.new(0, cs.X, 0, cs.Y)
            }):Play()
        end
        page.ChildAdded:Connect(updatePageSize)
        page.ChildRemoved:Connect(updatePageSize)
        task.defer(updateTabListSize)

        tabBtn.MouseButton1Click:Connect(function()
            updatePageSize()
            for _, p in pageFolder:GetChildren() do
                p.Visible = false
            end
            page.Visible = true
            -- Deselect other tabs
            for _, f in tabListInner:GetChildren() do
                if f:IsA("Frame") then
                    for _, c in f:GetChildren() do
                        if c:IsA("TextButton") then
                            TweenService:Create(c, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {
                                TextColor3 = TEXT_DIM
                            }):Play()
                        elseif c:IsA("ImageLabel") then
                            TweenService:Create(c, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {
                                ImageColor3 = TEXT_DIM
                            }):Play()
                        end
                    end
                end
            end
            TweenService:Create(tabBtn, TweenInfo.new(0.18, Enum.EasingStyle.Quint), { TextColor3 = RED }):Play()
            TweenService:Create(tabIcon, TweenInfo.new(0.18, Enum.EasingStyle.Quint), { ImageColor3 = RED }):Play()
        end)

        -- First tab: show by default
        if tabCount == 1 then
            page.Visible = true
        end

        local sectionHandling = {}

        function sectionHandling:Section(sectionText)
            sectionText = sectionText or "Section"
            local sectionFrame = Instance.new("Frame")
            sectionFrame.Name = "sectionFrame"
            sectionFrame.Size = UDim2.new(1, 0, 0, 36)
            sectionFrame.BackgroundColor3 = DARK
            sectionFrame.ClipsDescendants = true
            sectionFrame.ZIndex = 2
            sectionFrame.Parent = page
            addCorner(sectionFrame, 5)
            addGradient(sectionFrame, Color3.fromRGB(40, 12, 12), Color3.fromRGB(20, 20, 20))

            local sectionInnerList = Instance.new("UIListLayout")
            sectionInnerList.SortOrder = Enum.SortOrder.LayoutOrder
            sectionInnerList.Padding = UDim.new(0, 3)
            sectionInnerList.HorizontalAlignment = Enum.HorizontalAlignment.Center
            sectionInnerList.Parent = sectionFrame

            local header = Instance.new("Frame")
            header.Size = UDim2.new(0, 381, 0, 36)
            header.BackgroundTransparency = 1
            header.Parent = sectionFrame

            local sectionName = Instance.new("TextLabel")
            sectionName.Size = UDim2.new(0, 302, 0, 36)
            sectionName.Position = UDim2.new(0.024, 0, 0, 0)
            sectionName.BackgroundTransparency = 1
            sectionName.Text = sectionText
            sectionName.TextColor3 = RED
            sectionName.TextSize = 14
            sectionName.Font = Enum.Font.GothamSemibold
            sectionName.TextXAlignment = Enum.TextXAlignment.Left
            sectionName.ZIndex = 2
            sectionName.Parent = header

            local expandBtn = Instance.new("ImageButton")
            expandBtn.Size = UDim2.new(0, 25, 0, 25)
            expandBtn.Position = UDim2.new(0.919, 0, 0.14, 0)
            expandBtn.BackgroundTransparency = 1
            expandBtn.Image = "rbxassetid://3926305904"
            expandBtn.ImageColor3 = RED
            expandBtn.ImageRectOffset = Vector2.new(564, 284)
            expandBtn.ImageRectSize = Vector2.new(36, 36)
            expandBtn.ZIndex = 2
            expandBtn.Parent = header

            local isDropped = false
            expandBtn.MouseButton1Click:Connect(function()
                if isDropped then
                    isDropped = false
                    sectionFrame:TweenSize(UDim2.new(1, 0, 0, 36), "In", "Quint", 0.1)
                    TweenService:Create(expandBtn, TweenInfo.new(0.1, Enum.EasingStyle.Quad), { Rotation = 0 }):Play()
                else
                    isDropped = true
                    sectionFrame:TweenSize(UDim2.new(1, 0, 0, sectionInnerList.AbsoluteContentSize.Y + 8), "In", "Quint", 0.1)
                    TweenService:Create(expandBtn, TweenInfo.new(0.1, Enum.EasingStyle.Quad), { Rotation = 180 }):Play()
                end
                task.defer(updatePageSize)
            end)

            local ItemHandling = {}

            function ItemHandling:Button(btnText, callback)
                btnText = btnText or "Button"
                callback = callback or function() end
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(0, 365, 0, 36)
                btn.BackgroundColor3 = BLACK
                btn.Text = btnText
                btn.TextColor3 = TEXT
                btn.TextSize = 14
                btn.Font = Enum.Font.GothamSemibold
                btn.AutoButtonColor = false
                btn.ZIndex = 2
                btn.Parent = sectionFrame
                addCorner(btn, 3)
                btn.MouseButton1Click:Connect(function()
                    callback()
                end)
                btn.MouseEnter:Connect(function()
                    TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = DARK2, TextColor3 = WHITE }):Play()
                end)
                btn.MouseLeave:Connect(function()
                    TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = BLACK, TextColor3 = TEXT }):Play()
                end)
                btn.MouseButton1Down:Connect(function()
                    TweenService:Create(btn, TweenInfo.new(0.1), { BackgroundColor3 = RED_DIM, TextColor3 = BLACK }):Play()
                end)
                btn.MouseButton1Up:Connect(function()
                    TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = BLACK, TextColor3 = TEXT }):Play()
                end)
            end

            function ItemHandling:Toggle(toggInfo, callback)
                toggInfo = toggInfo or "Toggle"
                callback = callback or function() end
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(0, 365, 0, 36)
                frame.BackgroundColor3 = BLACK
                frame.ZIndex = 2
                frame.Parent = sectionFrame
                addCorner(frame, 3)
                local check = Instance.new("ImageButton")
                check.Size = UDim2.new(0, 25, 0, 25)
                check.Position = UDim2.new(0.019, 0, 0.14, 0)
                check.BackgroundTransparency = 1
                check.Image = "rbxassetid://3926311105"
                check.ImageColor3 = TEXT_DIM
                check.ImageRectOffset = Vector2.new(940, 784)
                check.ImageRectSize = Vector2.new(48, 48)
                check.ZIndex = 2
                check.Parent = frame
                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.new(0.7, 0, 1, 0)
                lbl.Position = UDim2.new(0.104, 0, 0, 0)
                lbl.BackgroundTransparency = 1
                lbl.Text = toggInfo
                lbl.TextColor3 = TEXT_DIM
                lbl.TextSize = 14
                lbl.Font = Enum.Font.GothamSemibold
                lbl.TextXAlignment = Enum.TextXAlignment.Left
                lbl.ZIndex = 2
                lbl.Parent = frame
                local on = false
                check.MouseButton1Click:Connect(function()
                    on = not on
                    callback(on)
                    if on then
                        lbl.TextColor3 = RED
                        check.ImageColor3 = RED
                        check.ImageRectOffset = Vector2.new(4, 836)
                    else
                        lbl.TextColor3 = TEXT_DIM
                        check.ImageColor3 = TEXT_DIM
                        check.ImageRectOffset = Vector2.new(940, 784)
                    end
                end)
            end

            function ItemHandling:KeyBind(keyInfo, firstKey, callback)
                keyInfo = keyInfo or "KeyBind"
                callback = callback or function() end
                local currentKey = (firstKey and firstKey.Name) or "None"
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(0, 365, 0, 36)
                frame.BackgroundColor3 = BLACK
                frame.ZIndex = 2
                frame.Parent = sectionFrame
                addCorner(frame, 3)
                local keyBtn = Instance.new("TextButton")
                keyBtn.Size = UDim2.new(0, 100, 0, 22)
                keyBtn.Position = UDim2.new(0.025, 0, 0.19, 0)
                keyBtn.BackgroundColor3 = DARK2
                keyBtn.Text = currentKey
                keyBtn.TextColor3 = RED
                keyBtn.TextSize = 14
                keyBtn.Font = Enum.Font.GothamSemibold
                keyBtn.ZIndex = 2
                keyBtn.Parent = frame
                addCorner(keyBtn, 5)
                local keyLbl = Instance.new("TextLabel")
                keyLbl.Size = UDim2.new(0, 239, 0, 22)
                keyLbl.Position = UDim2.new(0.32, 0, 0.17, 0)
                keyLbl.BackgroundTransparency = 1
                keyLbl.Text = keyInfo
                keyLbl.TextColor3 = WHITE
                keyLbl.TextSize = 13
                keyLbl.Font = Enum.Font.GothamSemibold
                keyLbl.TextXAlignment = Enum.TextXAlignment.Left
                keyLbl.ZIndex = 2
                keyLbl.Parent = frame
                keyBtn.MouseButton1Click:Connect(function()
                    keyBtn.Text = "..."
                    local _, input = UserInputService.InputBegan:Wait()
                    if input and input.KeyCode.Name ~= "Unknown" then
                        currentKey = input.KeyCode.Name
                        keyBtn.Text = currentKey
                    end
                end)
                UserInputService.InputBegan:Connect(function(input, gp)
                    if not gp and input.KeyCode.Name == currentKey then callback() end
                end)
            end

            function ItemHandling:TextBox(infbix, textPlace, callback)
                infbix = infbix or "TextBox"
                textPlace = textPlace or ""
                callback = callback or function() end
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(0, 365, 0, 36)
                frame.BackgroundColor3 = BLACK
                frame.ZIndex = 2
                frame.Parent = sectionFrame
                addCorner(frame, 3)
                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.new(0, 239, 0, 22)
                lbl.Position = UDim2.new(0.32, 0, 0.17, 0)
                lbl.BackgroundTransparency = 1
                lbl.Text = infbix
                lbl.TextColor3 = WHITE
                lbl.TextSize = 13
                lbl.Font = Enum.Font.GothamSemibold
                lbl.TextXAlignment = Enum.TextXAlignment.Left
                lbl.ZIndex = 2
                lbl.Parent = frame
                local box = Instance.new("TextBox")
                box.Size = UDim2.new(0, 100, 0, 22)
                box.Position = UDim2.new(0.025, 0, 0.19, 0)
                box.BackgroundColor3 = RED
                box.Text = ""
                box.PlaceholderText = textPlace
                box.PlaceholderColor3 = BLACK
                box.TextColor3 = BLACK
                box.TextSize = 13
                box.Font = Enum.Font.GothamSemibold
                box.ClearTextOnFocus = false
                box.ZIndex = 2
                box.Parent = frame
                addCorner(box, 5)
                box.FocusLost:Connect(function(enter)
                    if enter then callback(box.Text) end
                end)
            end

            function ItemHandling:Slider(slidInfo, minvalue, maxvalue, callback)
                slidInfo = slidInfo or "Slider"
                minvalue = minvalue or 0
                maxvalue = maxvalue or 100
                callback = callback or function() end
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(0, 365, 0, 36)
                frame.BackgroundColor3 = BLACK
                frame.ZIndex = 2
                frame.Parent = sectionFrame
                addCorner(frame, 3)
                local track = Instance.new("TextButton")
                track.Size = UDim2.new(0, 150, 0, 6)
                track.Position = UDim2.new(0.017, 0, 0.42, 0)
                track.BackgroundColor3 = DARK2
                track.Text = ""
                track.AutoButtonColor = false
                track.ZIndex = 2
                track.Parent = frame
                addCorner(track, 3)
                local fill = Instance.new("Frame")
                fill.Size = UDim2.new(0, 0, 0, 6)
                fill.BackgroundColor3 = RED
                fill.ZIndex = 2
                fill.Parent = track
                addCorner(fill, 3)
                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.new(0, 193, 0, 36)
                lbl.Position = UDim2.new(0.466, 0, 0, 0)
                lbl.BackgroundTransparency = 1
                lbl.Text = slidInfo
                lbl.TextColor3 = WHITE
                lbl.TextSize = 14
                lbl.Font = Enum.Font.GothamSemibold
                lbl.TextXAlignment = Enum.TextXAlignment.Left
                lbl.ZIndex = 2
                lbl.Parent = frame
                local mouse = game.Players.LocalPlayer:GetMouse()
                local uis = UserInputService
                local value = minvalue
                local moveConn, releaseConn
                track.MouseButton1Down:Connect(function()
                    value = math.clamp(math.floor((maxvalue - minvalue) / 150 * fill.AbsoluteSize.X + minvalue), minvalue, maxvalue)
                    callback(value)
                    fill.Size = UDim2.new(0, math.clamp(mouse.X - fill.AbsolutePosition.X, 0, 150), 0, 6)
                    moveConn = mouse.Move:Connect(function()
                        value = math.clamp(math.floor((maxvalue - minvalue) / 150 * fill.AbsoluteSize.X + minvalue), minvalue, maxvalue)
                        callback(value)
                        fill.Size = UDim2.new(0, math.clamp(mouse.X - fill.AbsolutePosition.X, 0, 150), 0, 6)
                    end)
                    releaseConn = uis.InputEnded:Connect(function(inp)
                        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                            if moveConn then moveConn:Disconnect() end
                            if releaseConn then releaseConn:Disconnect() end
                        end
                    end)
                end)
            end

            function ItemHandling:Label(labelInfo)
                labelInfo = labelInfo or "Label"
                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.new(0, 365, 0, 36)
                lbl.BackgroundColor3 = BLACK
                lbl.Text = labelInfo
                lbl.TextColor3 = WHITE
                lbl.TextSize = 14
                lbl.Font = Enum.Font.GothamSemibold
                lbl.ZIndex = 2
                lbl.Parent = sectionFrame
                addCorner(lbl, 5)
            end

            function ItemHandling:Credit(creditWho)
                ItemHandling:Label(" " .. (creditWho or "Credit"))
            end

            function ItemHandling:DropDown(dropInfo, list, callback)
                dropInfo = dropInfo or ""
                list = list or {}
                callback = callback or function() end
                local isDropped1 = false
                local dropFrame = Instance.new("Frame")
                dropFrame.Size = UDim2.new(0, 365, 0, 36)
                dropFrame.ClipsDescendants = true
                dropFrame.BackgroundTransparency = 1
                dropFrame.ZIndex = 2
                dropFrame.Parent = sectionFrame
                local dropLayout = Instance.new("UIListLayout")
                dropLayout.SortOrder = Enum.SortOrder.LayoutOrder
                dropLayout.Padding = UDim.new(0, 3)
                dropLayout.Parent = dropFrame
                local mainDrop = Instance.new("Frame")
                mainDrop.Size = UDim2.new(0, 365, 0, 36)
                mainDrop.BackgroundColor3 = BLACK
                mainDrop.ZIndex = 2
                mainDrop.Parent = dropFrame
                addCorner(mainDrop, 3)
                local dropLbl = Instance.new("TextLabel")
                dropLbl.Size = UDim2.new(0, 293, 0, 30)
                dropLbl.Position = UDim2.new(0.025, 0, 0.08, 0)
                dropLbl.BackgroundTransparency = 1
                dropLbl.Text = dropInfo
                dropLbl.TextColor3 = RED
                dropLbl.TextSize = 14
                dropLbl.Font = Enum.Font.GothamSemibold
                dropLbl.TextXAlignment = Enum.TextXAlignment.Left
                dropLbl.ZIndex = 2
                dropLbl.Parent = mainDrop
                local expand = Instance.new("ImageButton")
                expand.Size = UDim2.new(0, 25, 0, 25)
                expand.Position = UDim2.new(0.919, 0, 0.14, 0)
                expand.BackgroundTransparency = 1
                expand.Image = "rbxassetid://3926305904"
                expand.ImageColor3 = RED
                expand.ImageRectOffset = Vector2.new(564, 284)
                expand.ImageRectSize = Vector2.new(36, 36)
                expand.ZIndex = 2
                expand.Parent = mainDrop
                local dropYSize = 36
                expand.MouseButton1Click:Connect(function()
                    if isDropped1 then
                        isDropped1 = false
                        dropFrame:TweenSize(UDim2.new(0, 365, 0, 36), "In", "Quint", 0.1)
                        TweenService:Create(expand, TweenInfo.new(0.1, Enum.EasingStyle.Quad), { Rotation = 0 }):Play()
                    else
                        isDropped1 = true
                        dropFrame:TweenSize(UDim2.new(0, 365, 0, dropYSize), "In", "Quint", 0.1)
                        TweenService:Create(expand, TweenInfo.new(0.1, Enum.EasingStyle.Quad), { Rotation = 180 }):Play()
                    end
                    task.defer(updatePageSize)
                end)
                for i, v in ipairs(list) do
                    local optFrame = Instance.new("Frame")
                    optFrame.Size = UDim2.new(0, 339, 0, 34)
                    optFrame.BackgroundTransparency = 1
                    optFrame.LayoutOrder = i
                    optFrame.Parent = dropFrame
                    local optBtn = Instance.new("TextButton")
                    optBtn.Size = UDim2.new(0, 339, 0, 34)
                    optBtn.BackgroundColor3 = DARK
                    optBtn.Text = " " .. tostring(v)
                    optBtn.TextColor3 = RED
                    optBtn.TextSize = 14
                    optBtn.Font = Enum.Font.GothamSemibold
                    optBtn.TextXAlignment = Enum.TextXAlignment.Left
                    optBtn.AutoButtonColor = false
                    optBtn.ZIndex = 2
                    optBtn.Parent = optFrame
                    addCorner(optBtn, 3)
                    dropYSize = dropYSize + 37
                    optBtn.MouseButton1Click:Connect(function()
                        callback(v)
                        dropLbl.Text = tostring(v)
                        isDropped1 = false
                        dropFrame:TweenSize(UDim2.new(0, 365, 0, 36), "In", "Quint", 0.1)
                        TweenService:Create(expand, TweenInfo.new(0.1, Enum.EasingStyle.Quad), { Rotation = 0 }):Play()
                        task.defer(updatePageSize)
                    end)
                    optBtn.MouseEnter:Connect(function()
                        TweenService:Create(optBtn, TweenInfo.new(0.15), { BackgroundColor3 = DARK2, TextColor3 = WHITE }):Play()
                    end)
                    optBtn.MouseLeave:Connect(function()
                        TweenService:Create(optBtn, TweenInfo.new(0.15), { BackgroundColor3 = DARK, TextColor3 = RED }):Play()
                    end)
                end
            end

            return ItemHandling
        end
        return sectionHandling
    end
    return TabHandling
end
return ShadowCC
