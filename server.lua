local socket = require("socket")

local server = assert(socket.bind("*", 3456))
local ip, port =server:getsockname()

print("telnet to localhost on port " .. port)

while 1 do
    local client = server:accept()
    local line, err = client:receive("*l")

    if not err then
        print(line)
        --client:send(line .. "\n")
    end

end
