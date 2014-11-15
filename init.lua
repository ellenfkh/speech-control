package.path = package.path .. ";/Users/silver/dev/homebrew/Cellar/luarocks/2.2.0_1/share/lua/5.2/?.lua"
package.cpath = package.cpath .. ";/Users/silver/dev/homebrew/Cellar/luarocks/2.2.0_1/share/lua/5.2/?.so"
package.path = package.path .. ";/Users/silver/dev/homebrew/lib/lua/5.2/?.lua"
package.cpath = package.cpath .. ";/Users/silver/dev/homebrew/lib/lua/5.2/?.so"

local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"
local transform = require "mjolnir.sk.transform"
mjolnir.hotkey = require "mjolnir.hotkey"
local itunes = require "mjolnir.lb.itunes"
local screen = require "mjolnir.screen"
local cursor = require "mjolnir.jstevenson.cursor"

local mode = 0

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

-- set focused window to the left half of the screen
function makeRightHalf( )
	local win = window.focusedwindow()
	if (win == nil) then
		return
	end
	sc = screen.mainscreen()
	width = sc:frame().w/2
	height = sc:frame().h

	size = win:size()
	size.h = height
	size.w = width

	point = win:topleft()
	point.x = width
	point.y = 0
	win:setsize(size)
	win:settopleft(point)
end

-- set focused window to the right half of the screen
function makeLeftHalf( )
	local win = window.focusedwindow()
        if (win == nil) then
            return
	end
	sc = screen.mainscreen()
	width = sc:frame().w/2
	height = sc:frame().h

	size = win:size()
	size.h = height
	size.w = width

	point = win:topleft()
	point.x = 0
	point.y = 0
	win:setsize(size)
	win:settopleft(point)
end

function launchChrome()
    application.launchorfocus("Firefox")
end

function launchiTunes()
    application.launchorfocus("iTunes")
end

function launchTerminal()
    application.launchorfocus("Terminal")
end

function doCommand(comm)
    i = math.floor(tonumber(comm))

    if (i == 0) then print("got a zero. what do you want?!?!")
    elseif (i == 1) then print ("got a one. what do you want?!?!?")
    else print ("command not recognized")
    end
end

function moveMouseLeft()
	point = cursor.position()
	xpos = point.x + 10
	ypos = point.y
	cursor.warptopoint(xpos,ypos)
end

--[[
-- put if/elses in these, possibly calls to other functions?  in order to do
-- states and/or composed commands, everything should be routed through these
-- functions.
--]]


local state = 0

--[[
-- states:
--  0: default/none
--  1: manipulating windows
--  2: launching applications
--  3: scrolling
--  4: using a web browser
--]]

function ctrl0()
    --foot
    if (state == 0) then
        print("In state NONE")
        state = 1
    elseif (state == 1) then
        print("In state WINDOWS")
    elseif (state == 2) then
        print("In state LAUNCHING")
        launchiTunes()
    elseif (state == 3) then
        print("In state SCROLLING")
    elseif (state == 4) then
        print("In state BROWSER")
        os.execute("osascript type.scpt 'F'")
    else
        print("Illegal state")
    end
end

function ctrl1()
    --poke
    if (state == 0) then
        print("In state NONE")
    elseif (state == 1) then
        print("In state WINDOWS")
    elseif (state == 2) then
        print("In state LAUNCHING")
    elseif (state == 3) then
        print("In state SCROLLING")
    elseif (state == 4) then
        print("In state BROWSER")
        os.execute("osascript go.scpt")
    else
        print("Illegal state")
    end
end

function ctrl2()
    --tap
    if (state == 0) then
        print("In state NONE")
        state = 2
    elseif (state == 1) then
        print("In state WINDOWS")
        makeLeftHalf()
    elseif (state == 2) then
        print("In state LAUNCHING")
    elseif (state == 3) then
        print("In state SCROLLING")
    elseif (state == 4) then
        print("In state BROWSER")
        os.execute("osascript type.scpt '0'")
    else
        print("Illegal state")
    end
end

function ctrl3()
    --sit
    if (state == 0) then
        print("In state NONE")
        state = 3
    elseif (state == 1) then
        print("In state WINDOWS")
        makeRightHalf()
    elseif (state == 2) then
        print("In state LAUNCHING")
    elseif (state == 3) then
        print("In state SCROLLING")
    elseif (state == 4) then
        print("In state BROWSER")
        os.execute("osascript type.scpt '3'")
    else
        print("Illegal state")
    end
end

function ctrl4()
    --bop
    if (state == 0) then
        print("In state NONE")
    elseif (state == 1) then
        print("In state WINDOWS")
    elseif (state == 2) then
        print("In state LAUNCHING")
    elseif (state == 3) then
        print("In state SCROLLING")
    elseif (state == 4) then
        print("In state BROWSER")
        os.execute("osascript type.scpt '1'")
    else
        print("Illegal state")
    end
end

function ctrl5()
    --gok
    if (state == 0) then
        print("In state NONE")
        state = 4
    elseif (state == 1) then
        print("In state WINDOWS")
    elseif (state == 2) then
        print("In state LAUNCHING")
        launchTerminal()
    elseif (state == 3) then
        print("In state SCROLLING")
    elseif (state == 4) then
        print("In state BROWSER")
    else
        print("Illegal state")
    end
end

function ctrl6()
    --cat
    if (state == 0) then
        print("In state NONE")
    elseif (state == 1) then
        print("In state WINDOWS")
    elseif (state == 2) then
        print("In state LAUNCHING")
        launchChrome()
    elseif (state == 3) then
        print("In state SCROLLING")
    elseif (state == 4) then
        print("In state BROWSER")
    else
        print("Illegal state")
    end
end

function ctrl7()
    --pip
    if (state == 0) then
        print("In state NONE")
        changeFocus()
    elseif (state == 1) then
        print("In state WINDOWS")
        minimize()
    elseif (state == 2) then
        print("In state LAUNCHING")
    elseif (state == 3) then
        print("In state SCROLLING")
    elseif (state == 4) then
        print("In state BROWSER")
        os.execute("osascript type.scpt '2'")
    else
        print("Illegal state")
    end
end

function ctrl8()
    --doop
    if (state == 0) then
        print("In state NONE")
    elseif (state == 1) then
        print("In state WINDOWS")
        unminimize()
    elseif (state == 2) then
        print("In state LAUNCHING")
    elseif (state == 3) then
        print("In state SCROLLING")
    elseif (state == 4) then
        print("In state BROWSER")
    else
        print("Illegal state")
    end
end

function ctrl9()
    --back
    if (state == 0) then
        print("In state NONE")
    elseif (state == 1) then
        print("In state WINDOWS")
        state = 0
    elseif (state == 2) then
        print("In state LAUNCHING")
        state = 0
    elseif (state == 3) then
        print("In state SCROLLING")
        state = 0
    elseif (state == 4) then
        print("In state BROWSER")
        state = 0
    else
        print("Illegal state")
        state = 0
    end
end


function shift0()
    changeFocus()
end

function shift1()
	if (mode == 0) then
    	makeLeftHalf()
    else
    	makeRightHalf()
    end

end

function shift2()
    if (mode == 0) then
    	mode = 1
    else
    	mode = 0
    end
end

function shift3()
    minWindow()
end

function shift4()
    unMinWindow()
end

function shift5()
    launchChrome()
end

function shift6()
    print ("placeholder")
end

function shift7()
    print ("placeholder")
end

function shift8()
    print ("placeholder")
end

function shift9()
    print ("placeholder")
end


hotkey.bind({"ctrl", "cmd"}, "q", ctrl0) -- foot
hotkey.bind({"ctrl", "cmd"}, "w", ctrl1) -- poke
hotkey.bind({"ctrl", "cmd"}, "e", ctrl2) -- tap
hotkey.bind({"ctrl", "cmd"}, "r", ctrl3) -- sit
hotkey.bind({"ctrl", "cmd"}, "t", ctrl4) -- bop
hotkey.bind({"ctrl", "cmd"}, "y", ctrl5) -- gok
hotkey.bind({"ctrl", "cmd"}, "u", ctrl6) -- cat
hotkey.bind({"ctrl", "cmd"}, "u", ctrl7) -- pip
hotkey.bind({"ctrl", "cmd"}, "i", ctrl8) -- doop
hotkey.bind({"ctrl", "cmd"}, "o", ctrl9) -- back

hotkey.bind({"ctrl", "shift"}, "0", shift0)
hotkey.bind({"ctrl", "shift"}, "1", shift1)
hotkey.bind({"ctrl", "shift"}, "2", shift2)
hotkey.bind({"ctrl", "shift"}, "3", shift3)
hotkey.bind({"ctrl", "shift"}, "4", shift4)
hotkey.bind({"ctrl", "shift"}, "5", shift5)
hotkey.bind({"ctrl", "shift"}, "6", shift6)
hotkey.bind({"ctrl", "shift"}, "7", shift7)
hotkey.bind({"ctrl", "shift"}, "8", shift8)
hotkey.bind({"ctrl", "shift"}, "9", shift9)

