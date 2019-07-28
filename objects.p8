pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

left,right,up,down,fire1,fire2=0,1,2,3,4,5
black,dark_blue,dark_purple,dark_green,brown,dark_gray,light_gray,white,red,orange,yellow,green,blue,indigo,pink,peach=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15


function _init()

    myObj = {
        property = "Name"
    }

    -- function myObj:new(o, property)
    --     o = o or {}
    --     setmetatable(o, self)
    --     self.__index = self
    --     self.property = property or 0
    --     return o
    -- end

    -- Constructor style 1
    function myObj:new(property)
        local o = {} -- new object
        setmetatable(o, self)
        o.property = property
        self.__index = self
        return o
    end

    function myObj:method()
        print(self.property)
    end

    function myObj:setter(property)
        self.property = property
    end
end

function _update60()
    
end

function _draw()
    -- cls(flr(rnd(16)))
    -- print(myObj.property)
    cls(0)
    obj3 = myObj:new("new")
    obj3:setter("this")
    obj3:method()
end