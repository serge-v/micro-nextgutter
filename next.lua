VERSION = "2.0.0"

local micro = import("micro")
local config = import("micro/config")
local buffer = import("micro/buffer")

function init()
	config.MakeCommand("jump-next-gutter", nextGutter, config.NoComplete)
end

local last = 0

function nextGutter(bp)
    if #bp.Buf.Messages == 0 then
        last = 0
        return
    end

    local next = 0
    
    for i = 1,#bp.Buf.Messages do
        local line = bp.Buf.Messages[i].Start.Y
        if line > last then
            next = line
            break
        end
    end

    if next == 0 then
        next = bp.Buf.Messages[1].Start.Y
    end

    local loc = buffer.Loc(0, next)
    local c = bp.Cursor
    c:GotoLoc(loc)
    bp:Relocate()
    last = next
end
