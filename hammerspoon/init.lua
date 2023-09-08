spaces = require("hs.spaces")

hs.hotkey.bind({"ctrl"}, "space", function()
    local app = hs.application.find("kitty")

    if app == nil then
        hs.alert.show("Launching kitty")
        hs.application.launchOrFocus("kitty")
    elseif app:isFrontmost() then
        app:hide()
    else
        local win = app:mainWindow()

        local activeSpaces = spaces.activeSpaces()

        spaces.moveWindowToSpace(win:id(), spaces.activeSpaceOnScreen())
        win:focus()
    end

    app:mainWindow():moveToUnit'[100,100,0,0]'
end)
