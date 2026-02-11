-- ShadowCC Custom Menu - Rayfield-compatible API, red/black theme
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local RED = Color3.fromRGB(220, 55, 55)
local RED_DARK = Color3.fromRGB(160, 40, 40)
local BLACK = Color3.fromRGB(18, 18, 18)
local DARK = Color3.fromRGB(28, 10, 10)
local TEXT = Color3.fromRGB(255, 220, 220)
local TEXT_DIM = Color3.fromRGB(180, 150, 150)
local WHITE = Color3.fromRGB(255, 255, 255)

local function corner(parent, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 6)
    c.Parent = parent
    return c
end

local ShadowCCMenu = {}

function ShadowCCMenu:CreateWindow(config)
    config = config or {}
    local windowName = config.Name or "Shadow.CC"
    local gui = Instance.new("ScreenGui")
    gui.Name = "ShadowCCMenu"
    gui.Parent = CoreGui
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.ResetOnSpawn = false

    local main = Instance.new("Frame")
    main.Name = "Main"
    main.Size = UDim2.new(0, 560, 0, 400)
    main.Position = UDim2.new(0.5, -280, 0.5, -200)
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = DARK
    main.BorderSizePixel = 0
    main.Parent = gui
    corner(main, 8)

    local uig = Instance.new("UIGradient")
    uig.Color = ColorSequence.new({
        {0, Color3.fromRGB(50, 15, 15)},
        {1, Color3.fromRGB(15, 15, 15)}
    })
    uig.Rotation = 90
    uig.Parent = main

    -- Title bar (drag)
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 36)
    titleBar.BackgroundColor3 = BLACK
    titleBar.BorderSizePixel = 0
    titleBar.Parent = main
    corner(titleBar, 8)
    local titleCornerFix = Instance.new("Frame")
    titleCornerFix.Size = UDim2.new(1, 0, 0, 20)
    titleCornerFix.Position = UDim2.new(0, 0, 0, 16)
    titleCornerFix.BackgroundColor3 = BLACK
    titleCornerFix.BorderSizePixel = 0
    titleCornerFix.Parent = titleBar

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -80, 0, 36)
    titleLbl.Position = UDim2.new(0, 12, 0, 0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = windowName
    titleLbl.TextColor3 = RED
    titleLbl.TextSize = 16
    titleLbl.Font = Enum.Font.GothamSemibold
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent = titleBar

    -- Tab list (left)
    local tabList = Instance.new("ScrollingFrame")
    tabList.Name = "TabList"
    tabList.Size = UDim2.new(0, 140, 0, 358)
    tabList.Position = UDim2.new(0, 0, 0, 36)
    tabList.BackgroundColor3 = Color3.fromRGB(22, 8, 8)
    tabList.BorderSizePixel = 0
    tabList.ScrollBarThickness = 4
    tabList.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabList.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tabList.Parent = main
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 4)
    tabLayout.Parent = tabList

    -- Content (right)
    local content = Instance.new("ScrollingFrame")
    content.Name = "Content"
    content.Size = UDim2.new(0, 404, 0, 358)
    content.Position = UDim2.new(0, 140, 0, 36)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.ScrollBarThickness = 6
    content.CanvasSize = UDim2.new(0, 0, 0, 0)
    content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    content.Parent = main
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 6)
    contentLayout.Parent = content

    -- Drag
    local dragging, dragStart, mainStart = false, nil, nil
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = Vector2.new(input.Position.X, input.Position.Y)
            mainStart = main.AbsolutePosition
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging then
            local pos = Vector2.new(input.Position.X, input.Position.Y)
            local delta = pos - dragStart
            main.Position = UDim2.new(0, mainStart.X + delta.X, 0, mainStart.Y + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    local tabs = {}
    local tabOrder = 0

    local Window = {}

    function Window:CreateTab(name, _iconId)
        tabOrder = tabOrder + 1
        local tabName = name or "Tab"
        local tabBtn = Instance.new("TextButton")
        tabBtn.Name = "Tab_" .. tabName
        tabBtn.Size = UDim2.new(0, 132, 0, 32)
        tabBtn.BackgroundColor3 = BLACK
        tabBtn.Text = ""
        tabBtn.LayoutOrder = tabOrder
        tabBtn.Parent = tabList
        corner(tabBtn, 4)
        local tabBtnLbl = Instance.new("TextLabel")
        tabBtnLbl.Size = UDim2.new(1, -12, 1, 0)
        tabBtnLbl.Position = UDim2.new(0, 8, 0, 0)
        tabBtnLbl.BackgroundTransparency = 1
        tabBtnLbl.Text = tabName
        tabBtnLbl.TextColor3 = TEXT_DIM
        tabBtnLbl.TextSize = 14
        tabBtnLbl.Font = Enum.Font.Gotham
        tabBtnLbl.TextXAlignment = Enum.TextXAlignment.Left
        tabBtnLbl.TextTruncate = Enum.TextTruncate.AtEnd
        tabBtnLbl.Parent = tabBtn

        local container = Instance.new("Frame")
        container.Name = "TabContent"
        container.Size = UDim2.new(1, 0, 0, 0)
        container.BackgroundTransparency = 1
        container.Visible = (tabOrder == 1)
        container.Parent = content
        local conLayout = Instance.new("UIListLayout")
        conLayout.SortOrder = Enum.SortOrder.LayoutOrder
        conLayout.Padding = UDim.new(0, 4)
        conLayout.Parent = container
        container.AutomaticSize = Enum.AutomaticSize.Y

        local itemOrder = 0
        local Tab = {}

        local function nextOrder()
            itemOrder = itemOrder + 1
            return itemOrder
        end

        function Tab:CreateSection(name)
            local s = Instance.new("TextLabel")
            s.Size = UDim2.new(1, 0, 0, 24)
            s.BackgroundColor3 = BLACK
            s.BackgroundTransparency = 0.3
            s.Text = " " .. (name or "Section")
            s.TextColor3 = RED
            s.TextSize = 14
            s.Font = Enum.Font.GothamSemibold
            s.TextXAlignment = Enum.TextXAlignment.Left
            s.LayoutOrder = nextOrder()
            s.Parent = container
            corner(s, 4)
        end

        function Tab:CreateLabel(text)
            local l = Instance.new("TextLabel")
            l.Size = UDim2.new(1, 0, 0, 28)
            l.BackgroundColor3 = BLACK
            l.Text = " " .. (text or "")
            l.TextColor3 = TEXT
            l.TextSize = 13
            l.Font = Enum.Font.Gotham
            l.TextXAlignment = Enum.TextXAlignment.Left
            l.TextWrapped = true
            l.LayoutOrder = nextOrder()
            l.Parent = container
            corner(l, 4)
        end

        function Tab:CreateButton(data)
            data = data or {}
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 34)
            btn.BackgroundColor3 = BLACK
            btn.Text = " " .. (data.Name or "Button")
            btn.TextColor3 = TEXT
            btn.TextSize = 14
            btn.Font = Enum.Font.GothamSemibold
            btn.TextXAlignment = Enum.TextXAlignment.Left
            btn.AutoButtonColor = false
            btn.LayoutOrder = nextOrder()
            btn.Parent = container
            corner(btn, 4)
            if data.Callback then
                btn.MouseButton1Click:Connect(function() data.Callback() end)
            end
            btn.MouseEnter:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.12), { BackgroundColor3 = DARK, TextColor3 = WHITE }):Play()
            end)
            btn.MouseLeave:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.12), { BackgroundColor3 = BLACK, TextColor3 = TEXT }):Play()
            end)
        end

        function Tab:CreateToggle(data)
            data = data or {}
            local on = data.CurrentValue == true
            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, 34)
            row.BackgroundColor3 = BLACK
            row.LayoutOrder = nextOrder()
            row.Parent = container
            corner(row, 4)
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, -50, 0, 34)
            lbl.Position = UDim2.new(0, 10, 0, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = " " .. (data.Name or "Toggle")
            lbl.TextColor3 = on and RED or TEXT_DIM
            lbl.TextSize = 14
            lbl.Font = Enum.Font.GothamSemibold
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Parent = row
            local box = Instance.new("TextButton")
            box.Size = UDim2.new(0, 36, 0, 20)
            box.Position = UDim2.new(1, -42, 0, 7)
            box.BackgroundColor3 = on and RED_DARK or DARK
            box.Text = ""
            box.Parent = row
            corner(box, 10)
            local fill = Instance.new("Frame")
            fill.Size = UDim2.new(0, 16, 0, 16)
            fill.Position = UDim2.new(0, on and 18 or 2, 0, 2)
            fill.BackgroundColor3 = on and RED or TEXT_DIM
            fill.Parent = box
            corner(fill, 8)
            box.MouseButton1Click:Connect(function()
                on = not on
                lbl.TextColor3 = on and RED or TEXT_DIM
                fill.Position = UDim2.new(0, on and 18 or 2, 0, 2)
                box.BackgroundColor3 = on and RED_DARK or DARK
                fill.BackgroundColor3 = on and RED or TEXT_DIM
                if data.Callback then data.Callback(on) end
            end)
        end

        function Tab:CreateSlider(data)
            data = data or {}
            local range = data.Range or {0, 100}
            local minV, maxV = range[1], range[2]
            local cur = math.clamp(data.CurrentValue or minV, minV, maxV)
            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, 44)
            row.BackgroundColor3 = BLACK
            row.LayoutOrder = nextOrder()
            row.Parent = container
            corner(row, 4)
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, -60, 0, 22)
            lbl.Position = UDim2.new(0, 10, 0, 2)
            lbl.BackgroundTransparency = 1
            lbl.Text = " " .. (data.Name or "Slider")
            lbl.TextColor3 = TEXT
            lbl.TextSize = 13
            lbl.Font = Enum.Font.GothamSemibold
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Parent = row
            local valueLbl = Instance.new("TextLabel")
            valueLbl.Size = UDim2.new(0, 50, 0, 22)
            valueLbl.Position = UDim2.new(1, -55, 0, 2)
            valueLbl.BackgroundTransparency = 1
            valueLbl.Text = tostring(cur)
            valueLbl.TextColor3 = RED
            valueLbl.TextSize = 13
            valueLbl.Font = Enum.Font.GothamSemibold
            valueLbl.TextXAlignment = Enum.TextXAlignment.Right
            valueLbl.Parent = row
            local track = Instance.new("TextButton")
            track.Size = UDim2.new(1, -20, 0, 12)
            track.Position = UDim2.new(0, 10, 0, 30)
            track.BackgroundColor3 = DARK
            track.Text = ""
            track.AutoButtonColor = false
            track.Parent = row
            corner(track, 6)
            local trackW = 384
            local fillW = math.clamp((cur - minV) / (maxV - minV), 0, 1) * (trackW - 4)
            local fill = Instance.new("Frame")
            fill.Size = UDim2.new(0, math.max(0, fillW), 0, 8)
            fill.Position = UDim2.new(0, 2, 0, 2)
            fill.BackgroundColor3 = RED
            fill.Parent = track
            corner(fill, 4)
            local mouse = game:GetService("Players").LocalPlayer:GetMouse()
            local function update(val)
                cur = math.clamp(math.floor(val), minV, maxV)
                valueLbl.Text = tostring(cur)
                local pct = (cur - minV) / (maxV - minV)
                fill.Size = UDim2.new(0, math.max(0, pct * (track.AbsoluteSize.X - 4)), 0, 8)
                if data.Callback then data.Callback(cur) end
            end
            track.MouseButton1Down:Connect(function()
                local tw = track.AbsoluteSize.X
                local move, release
                move = mouse.Move:Connect(function()
                    tw = track.AbsoluteSize.X
                    local x = math.clamp(mouse.X - track.AbsolutePosition.X, 0, tw)
                    local pct = tw > 0 and (x / tw) or 0
                    update(minV + (maxV - minV) * pct)
                end)
                release = UserInputService.InputEnded:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                        move:Disconnect()
                        release:Disconnect()
                    end
                end)
            end)
            if data.Callback then data.Callback(cur) end
        end

        function Tab:CreateDropdown(data)
            data = data or {}
            local options = data.Options or {}
            local selected = data.CurrentOption or (options[1])
            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, 34)
            row.BackgroundColor3 = BLACK
            row.ClipsDescendants = true
            row.LayoutOrder = nextOrder()
            row.Parent = container
            corner(row, 4)
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, -40, 0, 34)
            lbl.Position = UDim2.new(0, 10, 0, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = " " .. (data.Name or "Dropdown")
            lbl.TextColor3 = TEXT
            lbl.TextSize = 14
            lbl.Font = Enum.Font.GothamSemibold
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Parent = row
            local valueLbl = Instance.new("TextLabel")
            valueLbl.Size = UDim2.new(0, 120, 0, 34)
            valueLbl.Position = UDim2.new(1, -125, 0, 0)
            valueLbl.BackgroundTransparency = 1
            valueLbl.Text = tostring(selected)
            valueLbl.TextColor3 = RED
            valueLbl.TextSize = 13
            valueLbl.Font = Enum.Font.Gotham
            valueLbl.TextXAlignment = Enum.TextXAlignment.Right
            valueLbl.TextTruncate = Enum.TextTruncate.AtEnd
            valueLbl.Parent = row
            local open = false
            local dropBtn = Instance.new("TextButton")
            dropBtn.Size = UDim2.new(1, 0, 0, 34)
            dropBtn.BackgroundTransparency = 1
            dropBtn.Text = ""
            dropBtn.Parent = row
            dropBtn.MouseButton1Click:Connect(function()
                if #options == 0 then return end
                for _, c in row:GetChildren() do
                    if c:IsA("TextButton") and c ~= dropBtn then c:Destroy() end
                end
                open = not open
                if open then
                    local h = 34
                    for i, opt in ipairs(options) do
                        local o = Instance.new("TextButton")
                        o.Size = UDim2.new(1, -10, 0, 28)
                        o.Position = UDim2.new(0, 5, 0, h)
                        o.BackgroundColor3 = DARK
                        o.Text = " " .. tostring(opt)
                        o.TextColor3 = TEXT
                        o.TextSize = 13
                        o.Font = Enum.Font.Gotham
                        o.TextXAlignment = Enum.TextXAlignment.Left
                        o.Parent = row
                        corner(o, 4)
                        o.MouseButton1Click:Connect(function()
                            selected = opt
                            valueLbl.Text = tostring(selected)
                            if data.Callback then data.Callback(selected) end
                            open = false
                            row.Size = UDim2.new(1, 0, 0, 34)
                            for _, c in row:GetChildren() do
                                if c:IsA("TextButton") and c ~= dropBtn then c:Destroy() end
                            end
                        end)
                        h = h + 32
                    end
                    row.Size = UDim2.new(1, 0, 0, h + 4)
                else
                    row.Size = UDim2.new(1, 0, 0, 34)
                    for _, c in row:GetChildren() do
                        if c:IsA("TextButton") and c ~= dropBtn then c:Destroy() end
                    end
                end
            end)
        end

        tabBtn.MouseButton1Click:Connect(function()
            for _, t in tabs do
                if t.container then t.container.Visible = false end
                if t.btnLbl then t.btnLbl.TextColor3 = TEXT_DIM end
            end
            container.Visible = true
            tabBtnLbl.TextColor3 = RED
        end)

        table.insert(tabs, { container = container, btnLbl = tabBtnLbl })
        return Tab
    end

    return Window
end

return ShadowCCMenu
