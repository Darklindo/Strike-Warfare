-- ========================================================
-- MERGE A BLACK HOLE - PRO AUTOMATION (V8.0)
-- ========================================================

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "MBH PRO 🌌", HidePremium = true, SaveConfig = true, ConfigFolder = "MBH_Pro", IntroText = "Zenith Automation"})

-- Serviços
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Configurações
local Config = {
    AutoMerge = false,
    AutoBuy = false,
    AutoCollect = false,
    AutoLaunch = false,
    Running = true
}

-- Scanner de Remotes Inteligente
local Remotes = {}
local function ScanRemotes()
    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            local n = v.Name:lower()
            if n:find("merge") or n:find("combine") then Remotes.Merge = v
            elseif n:find("buy") or n:find("purchase") then Remotes.Buy = v
            elseif n:find("collect") or n:find("claim") or n:find("cash") then Remotes.Collect = v
            elseif n:find("launch") or n:find("attack") then Remotes.Launch = v
            end
        end
    end
end
ScanRemotes()

-- UI
local Tab = Window:MakeTab({Name = "Automação", Icon = "rbxassetid://4483345998"})

Tab:AddToggle({
    Name = "Auto Merge (Remotes)",
    Default = false,
    Callback = function(v) Config.AutoMerge = v end
})

Tab:AddToggle({
    Name = "Auto Buy (Melhor Item)",
    Default = false,
    Callback = function(v) Config.AutoBuy = v end
})

Tab:AddToggle({
    Name = "Auto Collect Cash",
    Default = false,
    Callback = function(v) Config.AutoCollect = v end
})

Tab:AddToggle({
    Name = "Auto Launch Attack",
    Default = false,
    Callback = function(v) Config.AutoLaunch = v end
})

-- Loops de Automação
task.spawn(function()
    while Config.Running do
        if Config.AutoMerge and Remotes.Merge then
            pcall(function() Remotes.Merge:FireServer() end)
        end
        if Config.AutoBuy and Remotes.Buy then
            pcall(function() Remotes.Buy:FireServer() end)
        end
        if Config.AutoCollect and Remotes.Collect then
            pcall(function() Remotes.Collect:FireServer() end)
        end
        if Config.AutoLaunch and Remotes.Launch then
            pcall(function() Remotes.Launch:FireServer("Solar Core") end)
        end
        task.wait(0.5)
    end
end)

-- Anti-AFK
local VirtualUser = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

OrionLib:Init()
print("MBH PRO V8.0 Carregado com Sucesso!")
