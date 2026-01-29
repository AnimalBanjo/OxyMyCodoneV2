-- Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local function sendNotification(title, text, duration)
	local bindableFunction = Instance.new("BindableFunction")

	game.StarterGui:SetCore("SendNotification", {
		Title = title,
		Text = text,
		Duration = duration,
		callback = bindableFunction,
	})
end

-- butterfly knife
local BUTTERFLY = false
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Resources = ReplicatedStorage:WaitForChild("Resources", 10)
local WeaponFolder = Resources:WaitForChild("Weapon", 10)

local shortknife = WeaponFolder:FindFirstChild("shortknife")
local goldenknife = WeaponFolder:FindFirstChild("gg_goldenknife")

if not shortknife or not goldenknife then
    return
end

    -- Store original shortknife
local originalShortknife = shortknife:Clone()

local function applyReplacement()
    local current = WeaponFolder:FindFirstChild("shortknife")
    if current then
        current:Destroy()
    end
    
    if BUTTERFLY then
        local replacement = goldenknife:Clone()
        replacement.Name = "shortknife"
        replacement.Parent = WeaponFolder
    else
        local original = originalShortknife:Clone()
        original.Parent = WeaponFolder
    end
end

applyReplacement()

local ESP_ENABLED = false
local ESP_COLOR = Color3.fromRGB(255, 180, 80) -- default esp color
local RGBESP = false

local ModelTransparency = 1  -- weapon transparency
local HandTransparency  = 1  -- hands transparency

local AIMBOT = false

local SPEEDOMETER = false

local SKINCHANGER = false
local SKIN = "gold" -- gold is default

-- Skin asset IDs
local skinAssets = {
    gold = "rbxassetid://9886468582", -- default goldenknife texture from the game
}

local SHOW_PING = false

-- unused/to do
local RAPIDFIRE = false

local MODELS_FOLDER = "Playermodels"
local HIGHLIGHT_NAME = "ESPHighlight"
local VIEWMODELS_FOLDER = "Viewmodels"

local Window = Rayfield:CreateWindow({
    Name = "OxyMyCodoneV2",
    LoadingTitle = "Loading OxyMyCodoneV2",
    LoadingSubtitle = "Banjo made this shit 🪕",
    ConfigurationSaving = {
        Enabled = false,
        FileName = "FemboySex_Config"
    },
    KeySystem = false
})
-- Rayfield custom theme
Window.ModifyTheme({
    TextColor = Color3.fromRGB(240, 240, 240),

    Background = Color3.fromRGB(25, 25, 25),
    Topbar = Color3.fromRGB(34, 34, 34),
    Shadow = Color3.fromRGB(20, 20, 20),

    NotificationBackground = Color3.fromRGB(20, 20, 20),
    NotificationActionsBackground = Color3.fromRGB(230, 230, 230),

    TabBackground = Color3.fromRGB(80, 80, 80),
    TabStroke = Color3.fromRGB(85, 85, 85),
    TabBackgroundSelected = Color3.fromRGB(255, 180, 80), -- selected tab
    TabTextColor = Color3.fromRGB(240, 240, 240),
    SelectedTabTextColor = Color3.fromRGB(25, 25, 25),

    ElementBackground = Color3.fromRGB(35, 35, 35),
    ElementBackgroundHover = Color3.fromRGB(40, 40, 40),
    SecondaryElementBackground = Color3.fromRGB(25, 25, 25),
    ElementStroke = Color3.fromRGB(50, 50, 50),
    SecondaryElementStroke = Color3.fromRGB(40, 40, 40),
            
    SliderBackground = Color3.fromRGB(255, 180, 80),
    SliderProgress = Color3.fromRGB(255, 180, 80),
    SliderStroke = Color3.fromRGB(25, 25, 25),

    ToggleBackground = Color3.fromRGB(30, 30, 30),
    ToggleEnabled = Color3.fromRGB(255, 180, 80), -- interior
    ToggleDisabled = Color3.fromRGB(100, 100, 100),
    ToggleEnabledStroke = Color3.fromRGB(25, 25, 25), -- outline
    ToggleDisabledStroke = Color3.fromRGB(125, 125, 125),
    ToggleEnabledOuterStroke = Color3.fromRGB(100, 100, 100),
    ToggleDisabledOuterStroke = Color3.fromRGB(65, 65, 65),

    DropdownSelected = Color3.fromRGB(40, 40, 40),
    DropdownUnselected = Color3.fromRGB(30, 30, 30),

    InputBackground = Color3.fromRGB(30, 30, 30),
    InputStroke = Color3.fromRGB(65, 65, 65),
    PlaceholderColor = Color3.fromRGB(178, 178, 178)
})

-- cheats tab
local CheatsTab = Window:CreateTab("Cheats", "settings")

CheatsTab:CreateButton({
    Name = "Aimbot doesn't work on Xeno. Use Bunni",
})

CheatsTab:CreateToggle({
    Name = "AimBot",
    CurrentValue = false,
    Flag = "AimEnabled",
    Callback = function(value)
        AIMBOT = value
    end
})

CheatsTab:CreateToggle({
    Name = "AutoBhop",
    CurrentValue = false,
    Flag = "BhopEnabled",
    Callback = function(value)
        BHOP = value
    end
})

CheatsTab:CreateButton({
    Name = "Bhop external script download if your executor doesnt support AutoBhop (click to copy link)",
    Callback = function()
        setclipboard("https://drive.google.com/file/d/1wrHMWE_8tuGN4E1HTX5n8G8OuMVss1QA/view?usp=sharing")
    end
})

CheatsTab:CreateButton({
    Name = "Rejoin",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        TeleportService:Teleport(game.PlaceId, player)
    end
})

-- visuals
local VisualTab = Window:CreateTab("Visuals", "eye")

VisualTab:CreateToggle({
    Name = "ESP Toggle",
    CurrentValue = false,
    Flag = "ESPEnabled",
    Callback = function(value)
        ESP_ENABLED = value
    end
})

VisualTab:CreateColorPicker({
    Name = "ESP Color",
    Color = ESP_COLOR,
    Callback = function(color)
        ESP_COLOR = color
        if ESP_ENABLED then
            local folder = workspace:FindFirstChild(MODELS_FOLDER)
            if folder then
                for _, model in ipairs(folder:GetChildren()) do
                    if model:IsA("Model") then
                        local highlight = model:FindFirstChild(HIGHLIGHT_NAME)
                        if highlight then
                            highlight.OutlineColor = ESP_COLOR
                        end
                    end
                end
            end
        end
    end
})
VisualTab:CreateToggle({
    Name = "RGB ESP",
    CurrentValue = false,
    Flag = "RGBEnabled",
    Callback = function(value)
        RGBESP = value
    end
})

VisualTab:CreateSlider({
    Name = "Arms Transparency",
    Range = {0, 1},
    Increment = 0.1,
    Suffix = "",
    CurrentValue = 0,
    Flag = "ArmsT",
    Callback = function(value)
        HandTransparency = value
        local viewmodels = workspace.CurrentCamera:FindFirstChild("Viewmodels")
        if viewmodels then
            local arms = viewmodels:FindFirstChild("c_arms")
            if arms and arms:IsA("Model") then
                for _, part in ipairs(arms:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "RootPart" then
                        part.Transparency = HandTransparency
                        part.LocalTransparencyModifier = HandTransparency
                    end
                end
            end
        end
    end
})
VisualTab:CreateSlider({
    Name = "Field of View",
    Range = {30, 120},
    Increment = 1,
    Suffix = "",
    CurrentValue = 85,
    Flag = "FOV",
    Callback = function(value)
        FOV = value
    end
})

VisualTab:CreateToggle({
    Name = "Ping",
    CurrentValue = false,
    Flag = "PingEnabled",
    Callback = function(value)
        SHOW_PING = value
    end
})
VisualTab:CreateToggle({
    Name = "Speedometer",
    CurrentValue = false, 
    Flag = "SpeedEnabled",
    Callback = function(value)
        SPEEDOMETER = value
    end
})

-- skin changer
local SkinTab = Window:CreateTab("Skinschanger", "palette")

SkinTab:CreateToggle({
    Name = "Butterfly Knife (applies after death)",
    CurrentValue = false,
    Flag = "ButterflyEnabled",
    Callback = function(value)
        BUTTERFLY = value
        applyReplacement()
    end
})
SkinTab:CreateSlider({
    Name = "Weapon Transparency",
    Range = {0, 1},
    Increment = 0.1,
    Suffix = "",
    CurrentValue = 0,
    Flag = "WeaponT",
    Callback = function(value)
        ModelTransparency = value
        local folder = workspace.CurrentCamera:FindFirstChild("Viewmodels")
        if folder then
            for _, model in ipairs(folder:GetChildren()) do
                if model:IsA("Model") and model.Name ~= "c_arms" then
                    for _, part in ipairs(model:GetDescendants()) do
                        if part:IsA("BasePart") and part.Name ~= "RootPart" then
                           part.Transparency = ModelTransparency
                           part.LocalTransparencyModifier = ModelTransparency
                        end
                    end
                end
            end
        end
    end
})

_G.SOLID_KNIFE_COLOR = Color3.fromRGB(255, 180, 80)
_G.SOLID_KNIFE_MATERIAL = Enum.Material.Neon 

local function applySolidKnife()
    local viewmodels = workspace.Camera:FindFirstChild("Viewmodels")
    if not viewmodels then
        warn("Viewmodels folder not found!")
        return
    end
    
    local goldenKnife = viewmodels:FindFirstChild("v_gg_goldenknife")
    if not goldenKnife then
        warn("v_gg_goldenknife not found!")
        return
    end
    
    for _, descendant in pairs(goldenKnife:GetDescendants()) do
        if descendant:IsA("MeshPart") then
            local surfaceAppearance = descendant:FindFirstChildOfClass("SurfaceAppearance")
            if surfaceAppearance then
                surfaceAppearance:Destroy()
            end
            if descendant.TextureID and descendant.TextureID ~= "" then
                descendant.TextureID = ""
            end
            descendant.Color = _G.SOLID_KNIFE_COLOR
            descendant.Material = _G.SOLID_KNIFE_MATERIAL
        end
    end
end

SkinTab:CreateColorPicker({
    Name = "Knife Color",
    Color = Color3.fromRGB(255, 180, 80),
    Flag = "SolidKnifeColor",
    Callback = function(color)
        _G.SOLID_KNIFE_COLOR = color
        applySolidKnife()
    end
})

SkinTab:CreateDropdown({
    Name = "Knife Material",
    Options = {"Plastic", "Neon", "Metal", "Foil", "Force Field", "Diamond Plate", "Marble", "Rust", "Glass"},
    CurrentOption = {"Neon"},
    Flag = "SolidKnifeMaterial",
    Callback = function(option)
        local selectedOption = type(option) == "table" and option[1] or option
        
        local materialMap = {
            ["Plastic"] = Enum.Material.Plastic,
            ["Neon"] = Enum.Material.Neon,
            ["Metal"] = Enum.Material.Metal,
            ["Foil"] = Enum.Material.Foil,
            ["Force Field"] = Enum.Material.ForceField,
            ["Diamond Plate"] = Enum.Material.DiamondPlate,
            ["Marble"] = Enum.Material.Marble,
            ["Rust"] = Enum.Material.CorrodedMetal,
            ["Glass"] = Enum.Material.Glass,
        }
        _G.SOLID_KNIFE_MATERIAL = materialMap[selectedOption] or Enum.Material.Neon
        applySolidKnife()
    end
})
task.spawn(function()
    task.wait(1)
    applySolidKnife()
end)

-- thanks tab
local ThanksTab = Window:CreateTab("Special Thanks", "heart")

ThanksTab:CreateButton({
    Name = "Special thanks to AndreyTheDev for creating the aimbot, join his telegram group (click to copy link)",
    Callback = function()
        setclipboard("https://t.me/SegmaNews")
    end
})

-- config tab
local ConfigTab = Window:CreateTab("Configs", "book-copy")

ConfigTab:CreateParagraph({Title = "Explination", Content = "These are purely visual changes to your FOV, crosshair and viewmodel. To apply these changes click the config you want to use then outside of the menu click ` and paste it in. Everything here is from the official website of the game."})


ConfigTab:CreateButton({
    Name = "Default",
    Callback = function()
        setclipboard("crosshair_alpha 0.15; crosshair_gap 6; crosshair_size 10; crosshair_thickness 2; crosshair_color 255 244 222; crosshair_t 0; crosshair_recoil_scale 1; crosshair_outline 1; crosshair_outline_thickness 1; crosshair_outline_color 0 0 0;  crosshair_outline_alpha 0.75; crosshair_dot 0; crosshair_dot_alpha 0; crosshair_dot_size 2; viewmodel_arms 1; viewmodel_offset 0 0 0; viewmodel_flip 0; default_fov 85; camera_aspect_ratio 1;")
    end
})
ConfigTab:CreateButton({
    Name = "The Bum",
    Callback = function()
        setclipboard("viewmodel_offset 0.08 -0.70 0.4; default_fov 90; camera_aspect_ratio 0.5; crosshair_t 1; crosshair_size 8; crosshair_dot 1; crosshair_color 255 227 36")
    end
})
ConfigTab:CreateButton({
    Name = "The Gay",
    Callback = function()
        setclipboard("crosshair_gap 3; crosshair_color 0 255 0; crosshair_alpha 0; crosshair_t 1; crosshair_size 8; crosshair_gap 3; viewmodel_offset 0 -0.25 0; default_fov 105")
    end
})

ConfigTab:CreateButton({
    Name = "The Flipped",
    Callback = function()
        setclipboard("viewmodel_flip 1; crosshair_t 1; crosshair_recoil_scale 0; crosshair_gap 1; crosshair_alpha 0.35; crosshair_color 90 255 180; viewmodel_offset 0.45 -0.4 0.1")
    end
})
ConfigTab:CreateButton({
    Name = "Small Crosshair",
    Callback = function()
        setclipboard("crosshair_gap 2; crosshair_recoil_scale 0; crosshair_outline_alpha 0; crosshair_thickness 2; crosshair_alpha 0.1; crosshair_size 7")
    end
})
ConfigTab:CreateButton({
    Name = "Dogged",
    Callback = function()
        setclipboard("default_fov 120; crosshair_gap 1; crosshair_size 1; viewmodel_arms 0; viewmodel_offset -.3 -.7 -1")
    end
})

ConfigTab:CreateButton({
    Name = "Intense Vision",
    Callback = function()
        setclipboard("default_fov 170; viewmodel_offset -.7 -.5 -.2; crosshair_size 0; crosshair_dot 1; crosshair_outline_alpha 1; camera_aspect_ratio .7")
    end
})
ConfigTab:CreateButton({
    Name = "bluehat",
    Callback = function()
        setclipboard("default_fov 105; viewmodel_arms 0; viewmodel_flip 1; viewmodel_offset -1.5 -0.1 -0.3; crosshair_gap 4; crosshair_size 5; crosshair_outline_alpha 0.9; crosshair_thickness 2; crosshair_color 0 255 255; net_graph 1; camera_aspect_ratio 0.85;")
    end
})
ConfigTab:CreateButton({
    Name = "Casual Dot",
    Callback = function()
        setclipboard("crosshair_outline_alpha 1; crosshair_gap -2; crosshair_size 2; crosshair_recoil_scale 0; default_fov 105; net_graph 0; viewmodel_arms 0; viewmodel_offset -1 -1 2")
    end
})

ConfigTab:CreateButton({
    Name = "Warfork",
    Callback = function()
        setclipboard("viewmodel_offset -0.05 -0.65 -0.95; crosshair_gap -1; crosshair_size 7; crosshair_recoil_scale 0")
    end
})
ConfigTab:CreateButton({
    Name = "schloinfig",
    Callback = function()
        setclipboard("crosshair_color 255 0 255; crosshair_gap 2; crosshair_recoil_scale 1; crosshair_size 2; crosshair_thickness 2; default_fov 120; viewmodel_arms 0; viewmodel_flip 1; viewmodel_offset -1.25 0 0")
    end
})
ConfigTab:CreateButton({
    Name = "naiscfg",
    Callback = function()
        setclipboard("crosshair_gap 0; crosshair_dot 1; crosshair_size 4; default_fov 120; crosshair_recoil_scale 0 ; viewmodel_offset; -0.3 -0.5 -0.1; camera_aspect_ratio 0.75")
    end
})

ConfigTab:CreateButton({
    Name = "Head Shooter",
    Callback = function()
        setclipboard("crosshair_gap 0; crosshair_size 2; crosshair_dot 0; viewmodel_offset -2 -1 -1; crosshair_recoil_scale 0")
    end
})
ConfigTab:CreateButton({
    Name = "Call of Duty",
    Callback = function()
        setclipboard("viewmodel_offset 0.395 0.2 -0.25; default_fov 60; crosshair_alpha 1; viewmodel_arms 1;")
    end
})
ConfigTab:CreateButton({
    Name = "Quake Pro",
    Callback = function()
        setclipboard("viewmodel_offset 0.35 -0.5 -0.5; viewmodel_arms 0; default_fov 85; crosshair_alpha 1;")
    end
})

ConfigTab:CreateButton({
    Name = "CS 1.6",
    Callback = function()
        setclipboard("viewmodel_offset -1 -0.5 0.05;  viewmodel_arms 1; default_fov 75;")
    end
})
ConfigTab:CreateButton({
    Name = "Vision Hater",
    Callback = function()
        setclipboard("viewmodel_offset -0.3 0.4 0.5; crosshair_alpha 1; crosshair_dot_size 5; viewmodel_arms 1; crosshair_dot 1;")
    end
})
ConfigTab:CreateButton({
    Name = "Sk1tlxs Centered",
    Callback = function()
        setclipboard("viewmodel_offset 0.2 -2 1; crosshair_gap -1; crosshair_size 2; crosshair_recoil_scale 0;")
    end
})

ConfigTab:CreateButton({
    Name = "invisible",
    Callback = function()
        setclipboard("viewmodel_arms 0; viewmodel_offset -2 0 10; default_fov 70")
    end
})

-- esp
local RGB_COLOR = Color3.fromRGB(255, 255, 255)
if RGBESP then RGB_COLOR = Color3.fromHSV((tick() * 0.2) % 1, 1, 1) end

spawn(function()
    while true do
        local folder = workspace:FindFirstChild(MODELS_FOLDER)
        if folder then
            if RGBESP then
                RGB_COLOR = Color3.fromHSV((tick() * 0.2) % 1, 1, 1)
            end

            for _, model in ipairs(folder:GetChildren()) do
                if model:IsA("Model") then
                    local oldHighlight = model:FindFirstChild(HIGHLIGHT_NAME)

                    if ESP_ENABLED then
                        if oldHighlight then
                            oldHighlight:Destroy()
                        end

                        local newHighlight = Instance.new("Highlight")
                        newHighlight.Name = HIGHLIGHT_NAME
                        newHighlight.Adornee = model
                        newHighlight.FillTransparency = 1
                        newHighlight.OutlineTransparency = 0
                        -- rgb
                        newHighlight.OutlineColor = RGBESP and RGB_COLOR or ESP_COLOR
                        newHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        newHighlight.Parent = model
                    else
                        if oldHighlight then
                            oldHighlight:Destroy()
                        end
                    end
                end
            end
        end

        task.wait(0.1)
    end
end)

-- aimbot
-- ====== ORIGINAL AIMBOT MADE BY ANDREYTHEDEV ====== tg: https://t.me/SegmaNews
local Camera = workspace.CurrentCamera
local UserInputService = game:GetService('UserInputService')
local Players = game:GetService('Players')
local TweenService = game:GetService('TweenService')
local RunService = game:GetService('RunService')
local currentTarget = nil

local Client = {}
local maxAttempts = 10
local attemptCount = 0
local successs = false

while attemptCount < maxAttempts and not successs do
    attemptCount = attemptCount + 1
    successs = true

    for _, v in next, getgc(true) do
        if type(v) == 'table' then
            if rawget(v, 'Fire') and type(rawget(v, 'Fire')) == 'function' and not Client.Bullet then
                Client.Bullet = v
            elseif rawget(v, 'HiddenUpdate') then
                local successUpvalue, players = pcall(function()
                    return debug.getupvalue(rawget(v, 'new'), 9)
                end)

                if successUpvalue and players then
                    Client.Players = players
                else
                    successs = false 
                end
            end
        end
    end

    if not Client.Bullet or not Client.Players then
        wait(0.5)
    end
end

if not successs then
    print("Failed to attach client after " .. maxAttempts .. " attempts.")
    sendNotification("Failed to attach client after " .. maxAttempts .. " attempts, try rejoin game and try again", 8)
else
    print("Client successfully attached")
    sendNotification("Client was successfully attached", 8)

end


function Client:GetPlayerHitbox(player, hitbox)
	for _, player_hitbox in next, player.Hitboxes do
		if (player_hitbox._name == hitbox) then
			return player_hitbox
		end
	end
end

function Client:GetClosestPlayerFromScreen()
    local nearest_player, min_combined_score = nil, math.huge
    local camera_position = Camera.CFrame.Position
    local cursor_position = UserInputService:GetMouseLocation()

    for _, player in next, Client.Players do
        local model = player.PlayerModel and player.PlayerModel.Model
        if model and model.Head.Transparency ~= 1 then
            local screen_pos, is_visible = Camera:WorldToViewportPoint(player.Position)
            if is_visible then
                local distance_to_camera = (player.Position - camera_position).Magnitude
                local distance_to_cursor = (cursor_position - Vector2.new(screen_pos.X, screen_pos.Y)).Magnitude

                local combined_score = distance_to_camera * 0.7 + distance_to_cursor * 0.3

                if combined_score < min_combined_score then
                    min_combined_score = combined_score
                    nearest_player = player
                end
            end
        end
    end

    return nearest_player
end

local last_hitbox = nil

function Client:GetTargetHitbox(target)
    if last_hitbox and last_hitbox.Parent == target.PlayerModel.Model then
        return last_hitbox
    end

    for _, hitbox in next, {"Head", "Torso", "LeftArm", "RightArm", "LeftLeg", "RightLeg"} do
        local player_hitbox = Client:GetPlayerHitbox(target, hitbox)
        if player_hitbox then
            last_hitbox = player_hitbox
            return player_hitbox
        end
    end

    last_hitbox = nil
    return nil
end

Fire = hookfunction(Client.Bullet.Fire, function(self, ...)
    local args = {...}

    if AIMBOT then
        local target = Client:GetClosestPlayerFromScreen()
        local targetHitbox = target and Client:GetTargetHitbox(target)

        if targetHitbox and target.Health > 0 then
            args[2] = (targetHitbox.CFrame.Position - Camera.CFrame.Position).Unit
            currentTarget = target
        else
            currentTarget = nil
            return Fire(self, ...)
        end
    else
        return Fire(self, ...)
    end

    return Fire(self, unpack(args))
end)

-- speedometer
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "CameraSpeedometerGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local label = Instance.new("TextLabel")
label.BackgroundTransparency = 1
label.TextColor3 = Color3.new(1, 1, 1)
label.TextStrokeTransparency = 0.5
label.Font = Enum.Font.Code
label.TextSize = 18
label.AnchorPoint = Vector2.new(0.5, 0.5)
label.Position = UDim2.fromScale(0.5, 0.52)
label.TextXAlignment = Enum.TextXAlignment.Center
label.TextYAlignment = Enum.TextYAlignment.Center
label.Parent = gui

local lastPos = nil
local lastTime = tick()

RunService.Heartbeat:Connect(function()
    if not SPEEDOMETER then
        label.Text = ""
        return
    end

    local cam = workspace.CurrentCamera
    if not cam then return end

    local now = tick()
    if now - lastTime >= 0.1 then
        local pos = cam.CFrame.Position
        local currentPos = Vector3.new(pos.X, 0, pos.Z)

        if lastPos then
            local speed = (currentPos - lastPos).Magnitude / (now - lastTime)
            label.Text = string.format("%.1f studs/s", speed)
        end

        lastPos = currentPos
        lastTime = now
    end
end)

-- loop transparency
task.spawn(function()
    while true do
        updateViewmodelTransparency()
        task.wait(1)
    end
end)

-- ping
local gui = Instance.new("ScreenGui")
gui.Name = "PingDisplayGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local label = Instance.new("TextLabel")
label.BackgroundTransparency = 1
label.TextColor3 = Color3.new(1, 1, 1)
label.TextStrokeTransparency = 0.5
label.Font = Enum.Font.Code
label.TextSize = 26
label.AnchorPoint = Vector2.new(1, 0.5)
label.Position = UDim2.fromScale(0.98, 0.36) 
label.TextXAlignment = Enum.TextXAlignment.Right
label.TextYAlignment = Enum.TextYAlignment.Center
label.Parent = gui

RunService.RenderStepped:Connect(function()
    if not SHOW_PING then
        label.Text = ""
        return
    end

    local pingMs = math.floor(player:GetNetworkPing() * 1000)
    label.Text = string.format("%d ms", pingMs)
end)

-- fov changer
local CameraService = nil
local maxAttempts = 10
local attemptCount = 0
local success = false

while attemptCount < maxAttempts and not success do
    attemptCount = attemptCount + 1
    success = true
    
    for _, v in next, getgc(true) do
        if type(v) == 'table' then
            if rawget(v, 'DefaultFov') and 
               rawget(v, 'FovMultiplier') and 
               rawget(v, 'newFovOffset') and
               type(rawget(v, 'newFovOffset')) == 'function' then
                CameraService = v
                break
            end
        end
    end
    
    if not CameraService then
        wait(0.5)
    else
        success = true
    end
end

if not success then
    print("Failed to find CameraService")
    return
end
FOV = 85
local previousFOV = FOV
function UpdateFOV()
    if CameraService then
        CameraService.DefaultFov = FOV
    end
end
UpdateFOV()
game:GetService("RunService").Heartbeat:Connect(function()
    if FOV ~= previousFOV then
        previousFOV = FOV
        UpdateFOV()
    end
end)

-- autobhop
local Client = {}
local success = false

while attemptCount < maxAttempts and not success do
    attemptCount = attemptCount + 1
    success = true
    
    for _, v in next, getgc(true) do
        if type(v) == 'table' then
            if rawget(v, 'Jumping') ~= nil and 
               rawget(v, 'Forward') ~= nil and 
               rawget(v, 'Crouching') ~= nil and
               type(rawget(v, 'Jumping')) == 'boolean' then
                Client.MovementState = v
                break
            end
        end
    end
    
    if not Client.MovementState then
        wait(0.5)
    else
        success = true
    end
end

if not success then
    print("Failed to find movement state")
    return
else
end

-- BHOP Settings
BHOP = false  -- Set to true to enable auto-bhop
local bhopInterval = 0.1  -- Jump every 0.1 seconds
local isSpacePressed = false
local bhopActive = false
local bhopConnection = nil

-- Direct jump function
function Client:Jump()
    if Client.MovementState then
        Client.MovementState.Jumping = true
        task.wait(0.05)
        Client.MovementState.Jumping = false
    end
end

-- Start BHOP loop
function Client:StartBHOP()
    if bhopActive then return end
    bhopActive = true
    
    bhopConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if isSpacePressed and BHOP then
            Client:Jump()
            task.wait(bhopInterval)
        end
    end)
end

-- Stop BHOP loop
function Client:StopBHOP()
    if not bhopActive then return end
    bhopActive = false
    
    if bhopConnection then
        bhopConnection:Disconnect()
        bhopConnection = nil
    end
end

-- Monitor Space key
local UserInputService = game:GetService('UserInputService')

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Space then
        isSpacePressed = true
        
        if BHOP then
            Client:StartBHOP()
        else
            Client:Jump()
        end
    end
end)
	
UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.Space then
        isSpacePressed = false
        Client:StopBHOP()
    end
end)

-- detect script maker
local targetModelName = "620136734"
local hasDetected = false

local function showNotification()
    StarterGui:SetCore("SendNotification", {
        Title = "Banjo joined you.",
        Text = "say hi to the script maker",
        Duration = 5
    })
    print("Owner Joined +271k aura")
end

local function checkForModel()
    local playerModels = workspace:FindFirstChild("Playermodels")
    if playerModels then
        local targetModel = playerModels:FindFirstChild(targetModelName)
        if targetModel and targetModel:IsA("Model") and not hasDetected then
            hasDetected = true
            showNotification()
        end
    end
end

checkForModel()

workspace.ChildAdded:Connect(function(child)
    if child.Name == "Playermodels" then
        child.ChildAdded:Connect(function(model)
            if model.Name == targetModelName and not hasDetected then
                hasDetected = true
                showNotification()
            end
        end)
    end
end)

local playerModels = workspace:FindFirstChild("Playermodels")
if playerModels then
    playerModels.ChildAdded:Connect(function(model)
        if model.Name == targetModelName and not hasDetected then
            hasDetected = true
            showNotification()
        end
    end)
end