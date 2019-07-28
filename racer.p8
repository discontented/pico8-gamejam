pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
Racer = {}

function Racer:new(o, x, y, sprite)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    self.x = x
    self.y = y

    -- Sprite index
    self.sprite = sprite

    -- Current x-value position in race lane.  init to 0
    self.position = 0
    
    return o
end

-- Generates a random uniform color
function Racer:getUniform()
    self.color = flr(rnd(16))
end

-- Draws uniform
function Racer:setUniform()
    -- frames: 
    -- x: 18, 19, 20
    -- y: 6
    pset(x + 18, y + 6, self.color)
    for i=0,2 do
        pset(x + 18 + i, y + 6, self.color)
    end
end

-- Creates a sprite and draws to the screen
function Racer:drawChar()
    spr(self.sprite, self.x + self.position, self.y)
end

function Racer:updatePosition(x)
    self.position += x
end

function Racer:setSprite(sprite)
    self.sprite = sprite
end