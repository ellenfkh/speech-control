function doCommand(comm)
    i = math.floor(tonumber(comm))

    if (i == 0) then print("got a zero. what do you want?!?!")
    elseif (i == 1) then print ("got a one. what do you want?!?!?")
    else print ("command not recognized")
    end
end


-- socket-y stuff
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
