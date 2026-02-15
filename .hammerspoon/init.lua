-- TODO
-- - Use Hammerflow to use leader key for shortcuts and simplify config declaration: https://github.com/saml-dev/Hammerflow.spoon
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
    code = "VSCodium",
    Finder = "Finder",
    mail = "MailMate",
    notes = "Obsidian",
    Numbers = "Numbers",
    Orion = "Orion",
    Signal = "Signal",
    terminal = "Ghostty",
    WhatsApp = "WhatsApp",
    www = "Zen",
}

local screens = {
    laptop = "Built-in Retina Display",
    external = "LG UltraFine",
}

-- Launching/focusing apps

local appBindings = {
    { key = "c", app = apps.code },
    { key = "F", app = apps.Finder },
    { key = "m", app = apps.mail },
    { key = "n", app = apps.notes },
    { key = "N", app = apps.Numbers },
    { key = "o", app = apps.Orion },
    { key = "s", app = apps.Signal },
    { key = "t", app = apps.terminal },
    { key = "w", app = apps.www },
    { key = "W", app = apps.WhatsApp },
}

for _, binding in ipairs(appBindings) do
    hs.hotkey.bind(string.match(binding.key, "%u") and keys.appUpper or keys.app, binding.key, binding.app, function()
        local focusedWin = hs.window.focusedWindow()
        local focusedApp = focusedWin:application()
        local focusedName = focusedApp:name()
        -- HACK: fix VS Code name issue (name on disk and app name differ)
        if focusedName == "Code" then focusedName = apps.code end
        if focusedName == binding.app then
            -- app is focused already ⇒ cycle through its windows
            local appWindows = focusedApp:visibleWindows()
            for i, win in ipairs(appWindows) do
                if win == focusedWin then
                    appWindows[i % #appWindows + 1]:focus()
                    break
                end
            end
        else
            -- app is not focused
            hs.application.launchOrFocus(binding.app)
        end
    end)
end

-- Hiding/showing apps, TODO: cleanup

local appSets = {
    {
        key = "f",
        description = "focus",
        visible = true,
        apps = {
            apps.code,
            apps.www,
            apps.notes,
            apps.Numbers,
            apps.Orion,
            apps.terminal,
        },
    },
    {
        key = "c",
        description = "communication",
        visible = true,
        apps = {
            apps.mail,
            apps.Signal,
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

------------------------------------
-- Moving & resizing windows (Yabai)
------------------------------------

hs.window.animationDuration = 0.15

local function yabai(args, callbackFn)
    local yabai_task = hs.task.new('/opt/homebrew/bin/yabai', function(exitCode, stdOut, stdErr)
        -- print('stdout: '.. stdOut, 'stderr: ' .. stdErr)
        if type(callbackFn) == 'function' then
            callbackFn(exitCode, stdOut, stdErr)
        elseif exitCode ~= 0 then
            hs.alert.show('Yabai error (' .. exitCode .. '): ' .. stdErr)
        end
    end, args)
    yabai_task:start()
end

-- window focus

hs.hotkey.bind(keys.app, "left", "Focus window west", function()
    yabai({ '-m', 'window', '--focus', 'west' })
end)

hs.hotkey.bind(keys.app, "right", "Focus window east", function()
    yabai({ '-m', 'window', '--focus', 'east' })
end)

hs.hotkey.bind(keys.app, "up", "Focus window north", function()
    yabai({ '-m', 'window', '--focus', 'north' })
end)

hs.hotkey.bind(keys.app, "down", "Focus window south", function()
    yabai({ '-m', 'window', '--focus', 'south' })
end)

hs.hotkey.bind(keys.appUpper, "up", "Focus previous window in tree", function()
    yabai({ '-m', 'window', '--focus', 'prev' })
end)

hs.hotkey.bind(keys.appUpper, "down", "Focus next window in tree", function()
    yabai({ '-m', 'window', '--focus', 'next' })
end)

-- controlling spaces require disabling system integrity protection ⇒ doing it via MacOS shortcuts
-- hs.hotkey.bind(keys.app, ",", "Focus previous space", function()
--     yabai({ '-m', 'space', '--focus', 'prev' })
-- end)
-- hs.hotkey.bind(keys.app, ".", "Focus next space", function()
--     yabai({ '-m', 'space', '--focus', 'next' })
-- end)

hs.hotkey.bind(keys.app, "-", "Focus next display", function()
    yabai({ '-m', 'display', '--focus', 'next' }, function(exitCode)
        if exitCode == 1 then
            yabai({ '-m', 'display', '--focus', 'prev' })
        end
    end)
end)

-- window position

hs.hotkey.bind(keys.hyper, "left", "Swap window west", function()
    yabai({ '-m', 'window', '--swap', 'west' })
end)

hs.hotkey.bind(keys.hyper, "right", "Swap window east", function()
    yabai({ '-m', 'window', '--swap', 'east' })
end)

hs.hotkey.bind(keys.hyper, "up", "Swap window north", function()
    yabai({ '-m', 'window', '--swap', 'north' })
end)

hs.hotkey.bind(keys.hyper, "down", "Swap window south", function()
    yabai({ '-m', 'window', '--swap', 'south' })
end)

hs.hotkey.bind(keys.superHyper, "left", "Warp window west", function()
    yabai({ '-m', 'window', '--warp', 'west' })
end)

hs.hotkey.bind(keys.superHyper, "right", "Warp window east", function()
    yabai({ '-m', 'window', '--warp', 'east' })
end)

hs.hotkey.bind(keys.superHyper, "up", "Warp window north", function()
    yabai({ '-m', 'window', '--warp', 'north' })
end)

hs.hotkey.bind(keys.superHyper, "down", "Warp window south", function()
    yabai({ '-m', 'window', '--warp', 'south' })
end)

-- moving windows across spaces require disabling system integrity protection ⇒ forget it for now
-- hs.hotkey.bind(keys.hyper, ",", "Move window to previous space", function()
--     yabai({ '-m', 'window', '--space', 'prev' })
-- end)
-- hs.hotkey.bind(keys.hyper, ".", "Move window to next space", function()
--     yabai({ '-m', 'window', '--space', 'next' })
-- end)

hs.hotkey.bind(keys.hyper, "-", "Move window to next display", function()
    yabai({ '-m', 'window', '--display', 'next', '--focus' }, function(exitCode)
        if exitCode == 1 then
            yabai({ '-m', 'window', '--display', 'prev', '--focus' })
        end
    end)
end)

hs.hotkey.bind(keys.hyper, "m", "Toggle fullscreen", function()
    yabai({ '-m', 'window', '--toggle', 'zoom-fullscreen' })
end)

hs.hotkey.bind(keys.superHyper, "m", "Toggle native fullscreen", function()
    yabai({ '-m', 'window', '--toggle', 'native-fullscreen' })
end)

hs.hotkey.bind(keys.hyper, "tab", "Toggle window tiling direction", function()
    yabai({ '-m', 'window', '--toggle', 'split' })
end)

hs.hotkey.bind(keys.superHyper, "tab", "Rotate window tree 90° clockwise", function()
    yabai({ '-m', 'space', '--rotate', '270' })
end)

hs.hotkey.bind(keys.hyper, "x", "Balance out space occupied by all windows", function()
    yabai({ '-m', 'space', '--balance' })
end)

-- window properties

hs.hotkey.bind(keys.hyper, "f", "Toggle window tiling/float", function()
    yabai({ '-m', 'window', '--toggle', 'float' })
end)


-- TODO from here:
-- - control floating windows: center…
-- - grow windows H/V

-- Window layouts TODO: update with Yabai rules

-- local centerPos = {x=0.2, y=0, w=0.6, h=1}

-- local oneScreenLayout = {
--     {apps.Firefox, nil, screens.laptop, hs.layout.maximized, nil, nil},
--     {apps.mail, nil, screens.laptop, hs.layout.maximized, nil, nil},
--     {apps.notes, nil, screens.laptop, hs.layout.maximized, nil, nil},
--     {apps.Orion, nil, screens.laptop, hs.layout.maximized, nil, nil},
--     {apps.Signal, nil, screens.laptop, hs.layout.left50, nil, nil},
--     {apps.code, nil, screens.laptop, hs.layout.maximized, nil, nil},
--     {apps.terminal, nil, screens.laptop, hs.layout.maximized, nil, nil},
--     {apps.WhatsApp, nil, screens.laptop, hs.layout.right50, nil, nil},
-- }
-- local twoScreenLayout = {
--     {apps.Firefox, nil, screens.external, centerPos, nil, nil},
--     {apps.mail, nil, screens.laptop, hs.layout.maximized, nil, nil},
--     {apps.notes, nil, screens.external, hs.layout.right50, nil, nil},
--     {apps.Orion, nil, screens.external, centerPos, nil, nil},
--     {apps.Signal, nil, screens.laptop, hs.layout.left50, nil, nil},
--     {apps.code, nil, screens.laptop, centerPos, nil, nil},
--     {apps.terminal, nil, screens.laptop, hs.layout.maximized, nil, nil},
--     {apps.WhatsApp, nil, screens.laptop, hs.layout.right50, nil, nil},
-- }

-- hs.hotkey.bind(keys.hyper, "1", "Apply one-screen layout", function()
--     hs.layout.apply(oneScreenLayout)
-- end)
-- hs.hotkey.bind(keys.hyper, "2", "Apply two-screen layout", function()
--     hs.layout.apply(twoScreenLayout)
-- end)

hs.hotkey.bind(keys.hyper, "i", "Show current window/app info", function()
    local app = hs.application.frontmostApplication():title()
    local win = hs.window.focusedWindow():title()
    hs.alert.show("Window title: " .. win .. "\n" .. "Application name: " .. app)
end)

-- Display keybindings

hs.hotkey.alertDuration = 0
hs.alert.defaultStyle.atScreenEdge = 2
hs.alert.defaultStyle.textSize = 18
hs.alert.defaultStyle.strokeColor = { white = 1, alpha = 0.75 }
hs.alert.defaultStyle.strokeWidth = 2
hs.alert.defaultStyle.radius = 5

hs.hotkey.showHotkeys(keys.hyper, "k")
