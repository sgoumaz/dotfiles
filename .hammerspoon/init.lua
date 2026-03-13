-- TODO
-- - PaperWM: filter windows/screens, consider using leader key
-- - control floating windows (e.g. center)
-- - consider using Hammerflow to use leader key for shortcuts and simplify config declaration: https://github.com/saml-dev/Hammerflow.spoon
-- - maybe automate layouts when screens change (https://www.hammerspoon.org/docs/hs.screen.watcher.html)
-- - eject volumes: https://www.hammerspoon.org/Spoons/EjectMenu.html
-- - toggle wifi (replace MacOS shortcut)

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

------------------------------------
-- Windows management (PaperWM)
------------------------------------

hs.window.animationDuration = 0.15

WM = hs.loadSpoon("PaperWM")

WM.window_gap  =  { top = 2, bottom = 3, left = 4, right = 4 }
-- PaperWM.external_bar = {top = 20, bottom = 40}
WM.window_ratios = { 1/3, 1/2, 2/3, 1 }
-- number of fingers to detect a horizontal swipe (0 to disable)
WM.swipe_fingers = 3
-- increase this number to make windows move farther when swiping
-- use a negative value to reverse swipe direction
WM.swipe_gain = 1.0

local actions = WM.actions.actions()

-- focusing windows

hs.hotkey.bind(keys.app, "left", "Focus window left", actions.focus_left)
hs.hotkey.bind(keys.app, "right", "Focus window right", actions.focus_right)
hs.hotkey.bind(keys.app, "up", "Focus window up", actions.focus_up)
hs.hotkey.bind(keys.app, "down", "Focus window down", actions.focus_down)

-- switching spaces

hs.hotkey.bind(keys.app, ",", "Focus space left", actions.switch_space_l)
hs.hotkey.bind(keys.app, ".", "Focus space right", actions.switch_space_r)
hs.hotkey.bind(keys.app, "1", "Focus space 1", actions.switch_space_1)
hs.hotkey.bind(keys.app, "2", "Focus space 2", actions.switch_space_2)
hs.hotkey.bind(keys.app, "3", "Focus space 3", actions.switch_space_3)
hs.hotkey.bind(keys.app, "4", "Focus space 4", actions.switch_space_4)
hs.hotkey.bind(keys.app, "5", "Focus space 5", actions.switch_space_5)
hs.hotkey.bind(keys.app, "6", "Focus space 6", actions.switch_space_6)
hs.hotkey.bind(keys.app, "7", "Focus space 7", actions.switch_space_7)
hs.hotkey.bind(keys.app, "8", "Focus space 8", actions.switch_space_8)
hs.hotkey.bind(keys.app, "9", "Focus space 9", actions.switch_space_9)

-- focusing displays

hs.hotkey.bind(keys.app, "-", "Focus next screen", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    local nextScreen = win:screen():next()
    if nextScreen then
        local windows = hs.window.visibleWindows()
        for _, win in ipairs(windows) do
            if win:screen():id() == nextScreen:id() and win:isStandard() then
                win:focus()
                break
            end
        end
    end
end)

-- moving focused window

hs.hotkey.bind(keys.hyper, "left", "Swap window left", actions.swap_left)
hs.hotkey.bind(keys.hyper, "right", "Swap window right", actions.swap_right)
hs.hotkey.bind(keys.hyper, "up", "Swap window up", actions.swap_up)
hs.hotkey.bind(keys.hyper, "down", "Swap window down", actions.swap_down)

hs.hotkey.bind(keys.superHyper, "left", "Slurp window into column", actions.slurp_in)
hs.hotkey.bind(keys.superHyper, "right", "Barf window out of column", actions.barf_out)

hs.hotkey.bind(keys.hyper, "1", "Move window to space 1", actions.move_window_1)
hs.hotkey.bind(keys.hyper, "2", "Move window to space 2", actions.move_window_2)
hs.hotkey.bind(keys.hyper, "3", "Move window to space 3", actions.move_window_3)
hs.hotkey.bind(keys.hyper, "4", "Move window to space 4", actions.move_window_4)
hs.hotkey.bind(keys.hyper, "5", "Move window to space 5", actions.move_window_5)
hs.hotkey.bind(keys.hyper, "6", "Move window to space 6", actions.move_window_6)
hs.hotkey.bind(keys.hyper, "7", "Move window to space 7", actions.move_window_7)
hs.hotkey.bind(keys.hyper, "8", "Move window to space 8", actions.move_window_8)
hs.hotkey.bind(keys.hyper, "9", "Move window to space 9", actions.move_window_9)

hs.hotkey.bind(keys.hyper, "-", "Move window to next screen", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    local nextScreen = win:screen():next()
    if nextScreen then
        -- if window is on a managed space and is not floating, then toggling it to floating
        -- this will retile the current space before moving the window
        if not WM.floating.isFloating(win) then
            WM.floating.toggleFloating(win)
        end

        win:moveToScreen(nextScreen, true)

        local doAddWindow = coroutine.wrap(function()
            repeat
                coroutine.yield(false)
            until win:screen() == nextScreen
            -- now we can toggle it not floating, add the window, and tile new space
            WM.floating.toggleFloating(win)
            return true
        end)

        local start_time = hs.timer.secondsSinceEpoch()
        hs.timer.doUntil(doAddWindow, function(timer)
            if hs.timer.secondsSinceEpoch() - start_time > 1 then timer:stop() end
        end, hs.window.animationDuration)
    end
end)

-- positioning/resizing windows

hs.hotkey.bind(keys.superHyper, "f", "Toggle window full screen mode", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    win:toggleZoom()
end)
hs.hotkey.bind(keys.hyper, "f", "Resize window → full width", actions.full_width)
hs.hotkey.bind(keys.hyper, "k", "Resize window: cycle width", actions.cycle_width)
hs.hotkey.bind(keys.hyper, "j", "Resize window: reverse_cycle width", actions.reverse_cycle_width)
hs.hotkey.bind(keys.hyper, "l", "Resize window: increase width", actions.increase_width)
hs.hotkey.bind(keys.hyper, "h", "Resize window: decrease width", actions.decrease_width)
hs.hotkey.bind(keys.superHyper, "k", "Resize window: cycle height", actions.cycle_height)
hs.hotkey.bind(keys.superHyper, "j", "Resize window: reverse cycle height", actions.reverse_cycle_height)

hs.hotkey.bind(keys.hyper, "s", "Split screen with left window", actions.split_screen)
hs.hotkey.bind(keys.hyper, "x", "Center window", actions.center_window)

-- window properties and related

hs.hotkey.bind(keys.hyper, "escape", "Toggle window tiling/float", actions.toggle_floating)
hs.hotkey.bind(keys.superHyper, "escape", "Raise all floating windows on top", actions.focus_floating)

WM:start()

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

hs.hotkey.showHotkeys(keys.superHyper, "f1")
