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
    enemies = {}
    enemyPos = getBlock(0, 5)
    enemies[1] = Racer:new(nil, enemyPos.x, enemyPos.y, 2)
    enemies[2] = Racer:new(nil, enemyPos.x, enemyPos.y + 1, 2)

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
    playerPos = getBlock(0, 3)
    player = Player:new({playerPos.x, playerPos.y, 2})
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
        enemy:setSprite(frame)
        spr(enemy.sprite, enemy.x, enemy.y)
        print(player.y)
        print(enemy.y)
    end
end