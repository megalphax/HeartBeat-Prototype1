function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
  end

function newTimedEvent(time, func)
    local e = {}
    e.func = func
    e.time = time
    e.done = false

    function e:update()
        if currentTimer >= e.time then
            e.func()
            e.done = true
        end
    end

    table.insert(timedEvent, e)
end

function rgb(r, g, b)
    return r/255, g/255, b/255;
end

attack = {}

function attack.vertical_beam(time, x, sx, speed, delay)
    newTimedEvent(time - sx/speed - delay + 0.5, function() 
        effect_line_vertical_play(x, 0, sx, speed, delay, function()

             effect_beam_vertical_play(x, y, sx)
             
             if CheckCollision(
             getElement("Player").x-getElement("Player").collisionBox/2,
              getElement("Player").y-getElement("Player").collisionBox/2,
               getElement("Player").collisionBox,
                getElement("Player").collisionBox,
                 x-sx/2,
                  0,
                   sx,
                    HAUTEUR) 
             then
                game.window.close()
             end
            end)
        end)

end

gamemode = {}

function gamemode.fightMode(time)
    newTimedEvent(time, function() mm_effect.reverse = true end)
    newTimedEvent(time+1, function() getElement("Player").fightMode = true end)  
end

function gamemode.musicMode(time)
    newTimedEvent(time, function()

            getElement("Player").canMove = false
            getElement("Player").fightMode = false
            mm_effect.y = getElement("Player").y
            mm_effect.reverse = false 
            mm_effect.transition = true
            mm_effect.finishedLine = false
            mm_effect.damage = false

        end)
end