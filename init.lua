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

hotkey.bind({"ctrl"}, "r", mjolnir.reload)
hotkey.bind({"ctrl"}, "f", changeFocus)
hotkey.bind({"ctrl"}, "o", minWindow)
hotkey.bind({"ctrl"}, "m", unMinWindow)
hotkey.bind({"ctrl"}, "c", launchChrome)
hotkey.bind({"ctrl"}, "a", makeLeftHalf)
hotkey.bind({"ctrl"}, "s", makeRightHalf)

hotkey.bind({"ctrl"}, "z", moveMouseLeft)

-- itunes!
hotkey.bind({"ctrl"}, "i", launchiTunes)
hotkey.bind({"ctrl"}, "p", itunes.play)
hotkey.bind({"ctrl"}, "d", itunes.displayCurrentTrack)
hotkey.bind({"ctrl"}, "n", itunes.next)
hotkey.bind({"ctrl"}, "b", itunes.previous)

hotkey.bind({"cmd", "alt", "ctrl"}, "D", frameChange)

--[[
-- put if/elses in these, possibly calls to other functions?  in order to do
-- states and/or composed commands, everything should be routed through these
-- functions.
--]]

function shift0()
    print ("placeholder")
end

function shift1()
    print ("placeholder")
end

function shift2()
    print ("placeholder")
end

function shift3()
    print ("placeholder")
end

function shift4()
    print ("placeholder")
end

function shift5()
    print ("placeholder")
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

function ctrl0()
    print ("placeholder")
end

function ctrl1()
    print ("placeholder")
end

function ctrl2()
    print ("placeholder")
end

function ctrl3()
    print ("placeholder")
end

function ctrl4()
    print ("placeholder")
end

function ctrl5()
    print ("placeholder")
end

function ctrl6()
    print ("placeholder")
end

function ctrl7()
    print ("placeholder")
end

function ctrl8()
    print ("placeholder")
end

function ctrl9()
    print ("placeholder")
end

hotkey.bind({"ctrl"}, "0", ctrl1)
hotkey.bind({"ctrl"}, "1", ctrl2)
hotkey.bind({"ctrl"}, "2", ctrl3)
hotkey.bind({"ctrl"}, "4", ctrl4)
hotkey.bind({"ctrl"}, "5", ctrl5)
hotkey.bind({"ctrl"}, "6", ctrl6)
hotkey.bind({"ctrl"}, "7", ctrl7)
hotkey.bind({"ctrl"}, "8", ctrl8)
hotkey.bind({"ctrl"}, "9", ctrl9)

hotkey.bind({"ctrl", "shift"}, "0", shift1)
hotkey.bind({"ctrl", "shift"}, "1", shift2)
hotkey.bind({"ctrl", "shift"}, "2", shift3)
hotkey.bind({"ctrl", "shift"}, "4", shift4)
hotkey.bind({"ctrl", "shift"}, "5", shift5)
hotkey.bind({"ctrl", "shift"}, "6", shift6)
hotkey.bind({"ctrl", "shift"}, "7", shift7)
hotkey.bind({"ctrl", "shift"}, "8", shift8)
hotkey.bind({"ctrl", "shift"}, "9", shift9)

