-- TODO
-- - Maybe automate layouts when screens change (https://www.hammerspoon.org/docs/hs.screen.watcher.html)
-- - Eject volumes: https://www.hammerspoon.org/Spoons/EjectMenu.html
-- - Toggle wifi (replace MacOS shortcut)

local keys = {
    hyper = {"ctrl", "alt", "cmd"},
    superHyper = {"ctrl", "alt", "cmd", "shift"},
    app = {"ctrl", "alt"},
    appUpper = {"ctrl", "alt", "shift"},
}

local apps = {
    BlueMail = "BlueMail",
    code = "Visual Studio Code",
    Firefox = "Firefox Developer Edition",
    Finder = "Finder",
    GoodTask = "GoodTask",
    mail = "MailMate",
    notes = "Obsidian",
    Numbers = "Numbers",
    Signal = "Signal",
    terminal = "Ghostty",
    Telegram = "Telegram",
    WhatsApp = "WhatsApp",
}

local screens = {
    laptop = "Built-in Retina Display",
    external = "LG UltraFine",
}

-- Launching/focusing apps

local appBindings = {
    { key = "b", app = apps.BlueMail },
    { key = "c", app = apps.code },
    { key = "f", app = apps.Firefox },
    { key = "F", app = apps.Finder },
    { key = "g", app = apps.GoodTask },
    { key = "m", app = apps.mail },
    { key = "n", app = apps.notes },
    { key = "s", app = apps.Signal },
    { key = "t", app = apps.terminal },
    { key = "T", app = apps.Telegram },
    { key = "w", app = apps.WhatsApp },
}

for _, binding in ipairs(appBindings) do
    hs.hotkey.bind(string.match(binding.key, "%u") and keys.appUpper or keys.app, binding.key, binding.app, function()
        hs.application.launchOrFocus(binding.app)
    end)
end

-- Hiding/showing apps

local appSets = {
    {
        key = "f",
        description = "focus",
        visible = true,
        apps = {
            apps.code,
            apps.Firefox,
            apps.notes,
            apps.Numbers,
            apps.terminal,
        },
    },
    {
        key = "c",
        description = "communication",
        visible = true,
        apps = {
            apps.BlueMail,
            apps.GoodTask,
            apps.mail,
            apps.Signal,
            apps.Telegram,
            apps.WhatsApp,
        },
    }
}

for _, appSet in ipairs(appSets) do
    hs.hotkey.bind(keys.superHyper, appSet.key, "Toggle '" .. appSet.description .. "' apps visibility", function()
        for _, appName in ipairs(appSet.apps) do
            local app = hs.application.get(appName)
            if app then
                if appSet.visible then app:hide() else app:unhide() end
            end
        end
        appSet.visible = not appSet.visible
    end)
end

-- Moving & resizing windows

hs.window.animationDuration = 0.15

hs.loadSpoon("MiroWindowsManager")
spoon.MiroWindowsManager:bindHotkeys({
    up = {keys.hyper, "up"},
    right = {keys.hyper, "right"},
    down = {keys.hyper, "down"},
    left = {keys.hyper, "left"},
    fullscreen = {keys.hyper, "m"},
})

hs.hotkey.bind(keys.hyper, "x", "Move window center", function()
    local win = hs.window.focusedWindow()
    win:centerOnScreen()
end)

hs.hotkey.bind(keys.hyper, "n", "Move window to next screen", function()
    local win = hs.window.focusedWindow()
    win:moveToScreen(win:screen():next())
end)

function nudgeWindow(xDir, yDir)
    local win = hs.window.focusedWindow()
    local screenMode = win:screen():currentMode()
    win:move({x = xDir * screenMode.w / 10, y = yDir * screenMode.h / 10})
end

hs.hotkey.bind(keys.superHyper, "up", "Nudge window up", function() nudgeWindow(0, -1) end)
hs.hotkey.bind(keys.superHyper, "right", "Nudge window right", function() nudgeWindow(1, 0) end)
hs.hotkey.bind(keys.superHyper, "down", "Nudge window down", function() nudgeWindow(0, 1) end)
hs.hotkey.bind(keys.superHyper, "left", "Nudge window left", function() nudgeWindow(-1, 0) end)

-- Window layouts

local centerPos = {x=0.2, y=0, w=0.6, h=1}

local oneScreenLayout = {
    {apps.BlueMail, nil, screens.laptop, hs.layout.maximized, nil, nil},
    {apps.Firefox, nil, screens.laptop, hs.layout.maximized, nil, nil},
    {apps.GoodTask, nil, screens.laptop, hs.layout.maximized, nil, nil},
    {apps.mail, nil, screens.laptop, hs.layout.maximized, nil, nil},
    {apps.notes, nil, screens.laptop, hs.layout.maximized, nil, nil},
    {apps.Signal, nil, screens.laptop, hs.layout.left50, nil, nil},
    {apps.Telegram, nil, screens.laptop, hs.layout.right50, nil, nil},
    {apps.code, nil, screens.laptop, hs.layout.maximized, nil, nil},
    {apps.terminal, nil, screens.laptop, hs.layout.maximized, nil, nil},
    {apps.WhatsApp, nil, screens.laptop, hs.layout.right50, nil, nil},
}
local twoScreenLayout = {
    {apps.BlueMail, nil, screens.laptop, hs.layout.maximized, nil, nil},
    {apps.Firefox, nil, screens.external, centerPos, nil, nil},
    {apps.GoodTask, nil, screens.laptop, hs.layout.maximized, nil, nil},
    {apps.mail, nil, screens.laptop, hs.layout.maximized, nil, nil},
    {apps.notes, nil, screens.external, hs.layout.right50, nil, nil},
    {apps.Signal, nil, screens.laptop, hs.layout.left50, nil, nil},
    {apps.Telegram, nil, screens.laptop, hs.layout.right50, nil, nil},
    {apps.code, nil, screens.laptop, centerPos, nil, nil},
    {apps.terminal, nil, screens.laptop, hs.layout.maximized, nil, nil},
    {apps.WhatsApp, nil, screens.laptop, hs.layout.right50, nil, nil},
}

hs.hotkey.bind(keys.hyper, "1", "Apply one-screen layout", function()
    hs.layout.apply(oneScreenLayout)
end)
hs.hotkey.bind(keys.hyper, "2", "Apply two-screen layout", function()
    hs.layout.apply(twoScreenLayout)
end)

-- Display keybindings

hs.hotkey.alertDuration = 0
hs.alert.defaultStyle.atScreenEdge = 2
hs.alert.defaultStyle.textFont = "Comic Code Ligatures"

hs.hotkey.showHotkeys(keys.hyper, "k")
