local skynet = require("skynet")
local socket = require("skynet.socket")


function echo (cID, addr)
    socket.start(cID)
    while true do
        local str = socket.read(cID)
        if str then
            skynet.error("received: "..str)
            socket.write(cID, string.upper( str ))
        else 
            skynet.close(cID)
            skynet.error(addr.."disconnected")
            return
        end
    end
end

local cID, addr = ...
cID = tonumber(cID)

skynet.start(function (  )
    skynet.fork(function
        echo(cID, addr)
        skynet.exit()
    end)
end)