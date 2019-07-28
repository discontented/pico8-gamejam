pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
sy = 64
starting_mark = 16
finish_line = 112 -- x position of finish line

-- n is the number of lanes to draw
function draw_lanes(n)
    for x=0,16 do
            spr(race_map['top'], 8*x, 60)
        for y=0,n do
            -- draw top
            spr(race_map['lane'], 8*x, sy+8*y)  -- draws lanes
            line(starting_mark, sy, starting_mark, sy + 8*(y+1) - 1, 7) -- starting line
            line(finish_line, sy, finish_line, sy + 8*(y+1) - 1, 7) -- finish line
        end
            spr(race_map['bottom'], 8*x, sy + 8*(n))
    end
end

function getBlock(bl_x, bl_y)
    return { 
        x = 16 * bl_x,
        y = 16 * bl_y 
    }
end

function drawUniform(runner)
    -- frames: 
    -- x: 18, 19, 20
    -- y: 6
    x = runner.x + runner.position
    x_off = 2
    y = runner.y

    y_off = {
        two = 6,
        three = 6,
        four = 5,
        five = 5,
        six = 6
    }
    
    for i=0,2 do
        if(runner.sprite == 2 or runner.sprite == 3 or runner.sprite == 6) then
            pset(x + x_off + i, y + 6, runner.color)
        elseif (runner.sprite == 4 or runner.sprite == 5) then
            pset(x + x_off + i, y + 5, runner.color)
        end
    end
end