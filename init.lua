local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"
local transform = require "mjolnir.sk.transform"
mjolnir.hotkey = require "mjolnir.hotkey"
local itunes = require "mjolnir.lb.itunes"


-- move window 10 spaces
function move10 ()
    local win = window.focusedwindow()
    local f = win:frame()
    f.x = f.x + 10
    win:setframe(f)
end

-- change window frame
function frameChange ()
    local win = window.focusedwindow()
    local frame = win:frame()
    local animation_time = 0.2

    frame.w = frame.w - 40

    transform:setframe(win, frame, animation_time)
end

local wins = window.visiblewindows()

-- change window focus
function changeFocus()
    head = table.remove(wins,1)
    print(head:id())
    sizey = #wins
    print(sizey)
    head:focus()
    table.insert(wins,head)
end

-- minimize the window in focus
function minWindow()
    local win = window.focusedwindow()
    if (win == nil) then
        return
    end
    win:minimize()
end

-- unminimize a window. if you care which window, TOO FUCKING BAD
function unMinWindow()
    for i, wn in pairs(window.allwindows()) do
        if (wn:isminimized()) then
            wn:unminimize()
            break
        end
    end

end

function launchChrome()
    application.launchorfocus("Google Chrome")
end

function launchiTunes()
    application.launchorfocus("iTunes")
end

function doCommand(comm)
    i = math.floor(tonumber(comm))

    if (i == 0) then print("got a zero. what do you want?!?!")
    elseif (i == 1) then print ("got a one. what do you want?!?!?")
    else print ("command not recognized")
    end
end



mjolnir.hotkey.bind({"ctrl"}, "r", mjolnir.reload)
hotkey.bind({"ctrl"}, "f", changeFocus)
hotkey.bind({"ctrl"}, "n", minWindow)
hotkey.bind({"ctrl"}, "m", unMinWindow)
hotkey.bind({"ctrl"}, "c", launchChrome)
hotkey.bind({"ctrl"}, "i", launchiTunes)

hotkey.bind({"cmd", "alt", "ctrl"}, "D", frameChange)

-- socket-y
local socket = require("socket")

local server = assert(socket.bind("*", 3456))

while 1 do
    local client = server:accept()
    local command, err = client:receive("*l")

    if not err then
        num = tonumber(command)
        print(command)
    end
end
