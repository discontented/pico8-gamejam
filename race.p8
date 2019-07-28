pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
-- picoware template cart
-- the picoware team

function _init()
    -- these are required!
    name="gamejam game"
    made_by="@random_disconnect"
    oneliner="race!!"

    -- add a personal touch ◆
    outer_frame_color=9
    inner_frame_color=12

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
    enemy1 = {
        x = getBlock(0, 5).x,
        y = getBlock(0, 5).y,
        sprite = 2,
        position = 0,
        uniform = flr(rnd(16))
    }
    enemy2 = {
        x = getBlock(0, 6).x,
        y = getBlock(0, 6).y,
        sprite = 2,
        position = 0,
        uniform = flr(rnd(16))
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

    lanes = 6

    --[[
    Player
    ]]--
    player = {
        x = getBlock(0,4).x,
        y = getBlock(0,4).y,
        sprite = 2,
        position = 0,
        left = true,
        right = true
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

    if btnp(❎) then
        player.sprite = 6
        if(player.left)then
            player.left = false
            player.right = true
            player.position+=4
        end
    end

    if btnp(🅾️) then
        player.sprite = 3
        if(player.right)then
            player.right = false
            player.left = true -- if true then the left leg is on the ground
            player.position+=4
        end
    end
end

function _draw()
    cls(1)

    draw_lanes(lanes)

    local mx=mt%8 -- spr size
 
    -- Draw lane markers
  
    -- player
    spr(player.sprite, player.x, player.y)
 
    -- enemies
    for enemy in all(enemies) do
        enemy.sprite = frame
        spr(enemy.sprite, enemy.x, enemy.y)
    end
end