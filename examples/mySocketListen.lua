local skynet = require("skynet")
local socket = require("skynet.socket")

skynet.start(function ( )
    local addr = '0.0.0.0'
    local port = 8001
    skynet.error("socket listen: "..addr..":"..port)
    local lID = socket.listen(addr, port)
    assert(lID)
    socket.start(lID, function(cID, addr)
        skynet.error("socket accepted: "..addr)
        skynet.newservice("mySocketAgent", cID, addr)
    end)
end)