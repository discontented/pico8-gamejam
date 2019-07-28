pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

Racer = {}

function Racer:new(x, y, sprite)
    local o = {} -- new object
    setmetatable(o, self)
    local coordinates = self.getBlock(x, y)
    o.x = coordinates.x
    o.y = coordinates.y
    o.sprite = sprite
    o.position = 0
    o.left = true
    o.right = true
    self.__index = self
    return o
end

function Racer:getUniform()
    self.color = flr(rnd(16))

end

function drawChar()
    spr(self.sprite, self.x + self.position, self.y)
end

function Racer:setUniform()
    -- frames: 
    -- x: 18, 19, 20
    -- y: 6
    pset(x + 18, y + 6, self.color)
    for i=0,2 do
        pset(x + 18 + i, y + 6, self.color)
    end
end

-- from top right, index starts at 0
-- Divdes screen as 8 by 8
-- bl_x - block position of x 
-- bl_y - block position of y
function Racer:getBlock(bl_x, bl_y)
    local x
    local y
    return { 
        x = 16 * bl_x,
        y = 16 * bl_y 
    }
end