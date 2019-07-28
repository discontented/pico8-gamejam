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

    -- enemies
    frame = 2      -- sprite frame.  changes as sprite moves

    -- Global variables
    -- Sprite indices
    race_map = {
        ["bottom"] = 32,
        ["lane"] = 33,
        ["top"] = 34
    }

    lanes = 6

    position = 0 -- initial starting position

    walk = 2
    right = true   -- both legs are on the ground
    left = true    -- both legs are on the ground


    --[[
    you could use the difficulty
    variable to change things
    with difficulty. example:

    obstacle_count = difficulty/5

    remember that difficulty goes
    from 1 to 15.
    ]]--

    --[[
    use rnd to make the game
    a bit different each time
    it is run!
    ]]--
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
    
    if btnp(🅾️) then
        walk = 3
        if(right)then
            right = false
            left = true -- if true then the left leg is on the ground
            position+=4
        end
    end

    if btnp(❎) then
        walk = 5
        if(left)then
            left = false
            right = true
            position+=4
        end
    end


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
    print(t)

    draw_lanes(lanes)

    local mx=mt%8 -- spr size
 
    -- Draw lane markers
  
    -- player
    start_pos = get_block(0, 4);
    create_char(walk, start_pos.x + position, start_pos.y+2)
 
    -- enemies
    enemy1 = get_block(0,5);
    create_char(frame, enemy1.x, enemy1.y+2)

end