pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
Player = Racer:new()

function Player:new(o)
    o = o or Racer:new(o)
    setmetatable(o, self)
    self.__index = self
    
    -- left leg status
    self.left = true

    -- right leg status
    self.right = true
    return o
end

function Player:moveLeft()
    if btnp(🅾️) then
        self.sprite = 3
        if(self.right)then
            self.right = false
            self.left = true -- if true then the left leg is on the ground
            position+=4
        end
    end
end

function Player:moveRight()
    if btnp(❎) then
        self.sprite = 5
        if(self.left)then
            self.left = false
            self.right = true
            position+=4
        end
    end
end