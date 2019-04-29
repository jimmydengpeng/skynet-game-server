local skynet = require("skynet")


skynet.start(function()
    skynet.error(skynet.self())
end)