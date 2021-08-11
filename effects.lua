lst_effects = {}

function effect_heartbeat_play(x, y)
    local e = {}
    e.x = x
    e.y = y
    e.alpha = 1
    e.roundness = 0
    e.speed = 100
    e.isActive = true

    function e.update(dt)
        e.roundness = e.roundness + dt * e.speed
        e.alpha = e.alpha - dt * e.speed / 45

        if e.alpha <= 0 then
            e.isActive = false
        end
    end

    function e.draw()
        love.graphics.setColor( 1, 1, 1, e.alpha )
        game.graphics.circle("fill", e.x, e.y, e.roundness)
    end

    table.insert(lst_effects, e)
end

function effect_note_play(x, y, speed)
    local e = {}
    e.x = x
    e.y = y
    e.alpha = 1
    e.roundness = 0
    e.speed = 100
    e.isActive = true

    function e.update(dt)
        e.roundness = e.roundness + dt * e.speed
        e.alpha = e.alpha - dt * e.speed / 45

        if e.alpha <= 0 then
            e.isActive = false
        end
    end

    function e.draw()
        love.graphics.setColor( 1, 1, 1, e.alpha )
        game.graphics.circle("fill", e.x, e.y, e.roundness)
    end

    table.insert(lst_effects, e)
end


function effect_beam_vertical_play(x, y, size)
    local e = {}
    e.x = x
    e.y = y
    e.alpha = 1
    e.size = size
    e.speed = 80
    e.isActive = true

    function e.update(dt)
        e.size = e.size + dt * e.speed
        e.alpha = e.alpha - dt * e.speed / 45

        if e.alpha <= 0 then
            e.isActive = false
        end
    end

    function e.draw()
        love.graphics.setColor( 139, 0, 0, e.alpha )
        game.graphics.rectangle("fill", e.x-e.size/2, 0, e.size, HAUTEUR)
    end

    table.insert(lst_effects, e)
end

function effect_unfade_play(speed)
    local e = {}
    e.alpha = 1
    e.speed = speed
    e.isActive = true

    function e.update(dt)
        e.alpha = e.alpha - dt * e.speed

        if e.alpha <= 0 then
            e.isActive = false
        end
    end

    function e.draw()
        love.graphics.setColor( 0, 0, 0, e.alpha )
        game.graphics.rectangle("fill", 0, 0, LARGEUR, HAUTEUR)
    end

    table.insert(lst_effects, e)
end


function effect_line_vertical_play(x, y, size, speed, delay, event)
    local e = {}
    e.x1 = x
    e.x2 = x
    e.alpha = 0
    e.size = size
    e.speed = speed
    e.isActive = true
    e.delay = delay

    function e.update(dt)

        if e.x1 <= x+size/2 then 
            e.x1 = e.x1 + dt * e.speed
        end
        if e.x2 >= x-size/2 then
            e.x2 = e.x2 - dt * e.speed
        end

        e.alpha = (e.x1-x)/(e.size/2)

        if e.alpha >= 1 then
            e.delay = e.delay - dt
            if e.delay <= 0 then
            e.isActive = false
            event()
            end
        end
    end

    function e.draw()
        love.graphics.setColor( 139, 0, 0, e.alpha )
        game.graphics.line(e.x1, 0, e.x1, HAUTEUR)
        game.graphics.line(e.x2, 0, e.x2, HAUTEUR)
    end

    table.insert(lst_effects, e)
end

function damage_effect_play(x, y)
    local e = {}

    e.texture = love.graphics.newImage("img/fragment.png")
    e.parts = {}

    e.parts[1] = {}
    e.parts[1].x = x+10
    e.parts[1].y = y-10

    e.parts[2] = {}
    e.parts[2].x = x+30
    e.parts[2].y = y-10

    e.parts[3] = {}
    e.parts[3].x = x+10
    e.parts[3].y = y+20

    e.parts[4] = {}
    e.parts[4].x = x+30
    e.parts[4].y = y+20


    e.alpha = 1
    e.speed = 80
    e.isActive = true

    function e.update(dt)

        e.parts[1].x = e.parts[1].x - e.speed * dt
        e.parts[1].y = e.parts[1].y - e.speed * dt

        e.parts[2].x = e.parts[2].x + e.speed * dt
        e.parts[2].y = e.parts[2].y - e.speed * dt

        e.parts[3].x = e.parts[3].x - e.speed * dt
        e.parts[3].y = e.parts[3].y + e.speed * dt

        e.parts[4].x = e.parts[4].x + e.speed * dt
        e.parts[4].y = e.parts[4].y + e.speed * dt

        e.alpha = e.alpha - dt*3

        if e.alpha <= 0 then
            e.isActive = false
        end

    end

    function e.draw()
        love.graphics.setColor( 1, 1, 1, e.alpha )
        game.graphics.draw(e.texture, e.parts[1].x - e.texture:getPixelHeight()/2, e.parts[1].y - e.texture:getPixelWidth()/2, 320, 0.3)
        game.graphics.draw(e.texture, e.parts[2].x - e.texture:getPixelHeight()/2, e.parts[2].y - e.texture:getPixelWidth()/2, 120, 0.3)
        game.graphics.draw(e.texture, e.parts[3].x - e.texture:getPixelHeight()/2, e.parts[3].y - e.texture:getPixelWidth()/2, 280, 0.3)
        game.graphics.draw(e.texture, e.parts[4].x - e.texture:getPixelHeight()/2, e.parts[4].y - e.texture:getPixelWidth()/2, 210, 0.3)
    end

    table.insert(lst_effects, e)
end

function music_mode_effect_play(x, y)
    local e = {}
    e.startY = y
    e.x = x
    e.x2 = x
    e.y = y
    e.alpha = 1
    e.speed = 1000
    e.isActive = true
    e.reverse = false
    e.transition = false
    e.finishedLine = false

    e.damage = false

    function e.update(dt)

        if e.transition and e.finishedLine then
            if e.y < e.startY then
                e.y = e.y + e.speed/1.5*dt
            elseif e.y > e.startY + 3 then
                e.y = e.y - e.speed/1.5*dt
            end

            if e.y > e.startY and e.y < e.startY + e.speed*dt then
                e.y = e.startY
                e.transition = false
                getElement("Player").canMove = true
            end
            getElement("Player").y = e.y
        end

        if not e.reverse then
            if e.x2 >= 0 then
                e.x2 = e.x2 - dt * e.speed
            else
                e.finishedLine = true
            end
        else
            if e.x2 <= LARGEUR then
                e.x2 = e.x2 + dt * e.speed
            end
        end

        if e.damage == false and e.x2<= getElement("Player").x then
            e.damage = true
            damage_effect_play(getElement("Player").x, getElement("Player").y)
        end

        if e.alpha <= 0 then
            e.isActive = false
        end
    end

    function e.draw()
        love.graphics.setColor( 1, 1, 1, e.alpha )
        game.graphics.line(e.x, e.y-5, e.x2, e.y-5)
    end

    table.insert(lst_effects, e)

    return e
end

function effects_update(dt)
    for i=1, #lst_effects do
        if lst_effects[i] ~= nil then
            lst_effects[i].update(dt)
        
            if lst_effects[i].isActive == false then
                table.remove(lst_effects, i)
            end
        end
    end
end

function effects_draw()
    for i=1, #lst_effects do
        if lst_effects[i] ~= nil then
            lst_effects[i].draw()
        end
    end
end
