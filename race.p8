pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
-- picoware template cart
-- the picoware team

function _init()
    -- these are required!
    name="gamejam game"
    made_by="@random_disconnect"
    oneliner="move your legs ⬅️➡️"

    -- add a personal touch ◆
    outer_frame_color=0
    inner_frame_color=7

    --[[
    set status variable to inform
    master cart about outcome:

    status="won" / status="lost"
    ]]--
    status="lost"

    t=0
    mt=0

    --[[
    Enemies
    ]]--
    offset = 8

    enemy1 = {
        x = getBlock(0, 5).x,
        y = getBlock(1, 5).y,
        sprite = 2,
        position = 0,
        color = flr(rnd(16))
    }
    enemy2 = {
        x = getBlock(0, 6).x,
        y = getBlock(1, 6).y,
        sprite = 2,
        position = 0,
        color = flr(rnd(16))
    }
    enemies = {}
    
    add(enemies, enemy1)
    add(enemies, enemy2)
    
    -- Global variables
    -- Sprite indices
    race_map = {
        ["bottom"] = 32,
        ["lane"] = 33,
        ["top"] = 34
    }

    -- color_1 = flr(rnd(16)) random bg colors
    -- color_2 = flr(rnd(16))
    lanes = 6

    --[[
    Player
    ]]--
    player = {
        x = getBlock(0,4).x + offset,
        y = getBlock(1,4).y,
        sprite = 2,
        position = 0,
        left = true,
        right = true,
        speed = 5
    }
end

function _update60()
    --[[
    dt is time delta, scaled
    with difficulty, provided by
    the master cart
    ]]--
    local dt=dt or 1/60
    
    --[[
    use dt for all diff.dependent
    actions, and 1/60 otherwise
    ]]--
    t+=dt
    mt=t
    
    --[[
        animation magic
    ]]--
    
    frame=2+flr(5*(2*t%1))

    for enemy in all(enemies) do
        enemy.speed = rnd(60)*dt
    end

    --[[
    use transition_done to check
    for on-screen collisions etc;
    this flag is set to true when
    the screen transition is over
    and the game is fully drawn
    on the screen
    ]]--
    if not transition_done then
        return
    end
 
    update_player(dt)
end

function update_player(dt)
    -- jelpi wins
    if (status=="won") return
    
    if btnp(⬅️) then
        player.sprite = 6
        if(player.left)then
            player.left = false
            player.right = true
            player.position+= player.speed
        end
    end

    if btnp(➡️) then
        player.sprite = 3
        if(player.right)then
            player.right = false
            player.left = true -- if true then the left leg is on the ground
            player.position += player.speed
        end
    end
    print(player.x)

    a = player.position >= finish_line
    b = enemy1.position <= finish_line
    c = enemy2.position <= finish_line
    if (a and b and c) then
        status = "won"
        print("You"..status)
    end
end

function _draw()
    cls(0)

    -- Draw Background

    color_flag = 1
    
    for i=0,16 do
        for j=0,8 do
            
            if (color_flag == 1) then
                rectfill(i*8, j*8, i*8+8, j*8+8, 0)
            else
                rectfill(i*8, j*8, i*8+8, j*8+8, 7)
            end
            color_flag *= -1
        end
    end

    -- Draw lane markers

    draw_lanes(lanes)

    local mx=mt%8 -- spr size
 
    -- player
    spr(player.sprite, player.x + player.position, player.y)

    -- enemies
    for enemy in all(enemies) do
        enemy.sprite = frame
        enemy.position += enemy.speed
        spr(enemy.sprite, enemy.x + enemy.position, enemy.y)
        drawUniform(enemy)
    end
end