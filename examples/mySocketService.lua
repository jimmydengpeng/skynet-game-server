local skynet = require("skynet")
local socket = require("skynet.socket")

--echo
function echo(cID, addr)
    socket.start(cID) --socket listen 有连接接入时
    while true do
        local str = socket.read(cID)
        if str then
	    local name =skynet.address(skynet.self())
            skynet.error(name.." Received: "..str)
            socket.write(cID, string.upper(str))
        else
            socket.close(cID)
            skynet.error(addr.." disconnected")
            return
        end
    end
end

function accept(cID, addr)
    skynet.error("socket accepted: "..addr)
    skynet.fork(echo, cID, addr) -- 开新的协程
end

skynet.start(function()
    local addr = '0.0.0.0'
    local port = 8001
    skynet.error('my socket service listen: '..addr..' : '..port)
    local lID = socket.listen(addr, port) -- listen 返回 id 供 start 使用
    assert(lID, "socket listen error")
    socket.start(lID, accept) -- start 会向 accept 传入接入连接的id以及ip地址
end)
