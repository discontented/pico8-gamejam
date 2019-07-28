pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
sy = 64
finish_line = 112 -- x position of finish line

-- n is the number of lanes to draw
function draw_lanes(n)
    for x=0,16 do
        for y=0,n do
            -- draw top
            spr(race_map['lane'], 8*x, sy+8*y)  -- draws lanes
            line(8, sy, 8, sy + 8*(y+1) - 1, 7) -- starting line
            line(finish_line, sy, finish_line, sy + 8*(y+1) - 1, 7) -- finish line
        end
    end
end

function getBlock(bl_x, bl_y)
    return { 
        x = 16 * bl_x,
        y = 16 * bl_y 
    }
end