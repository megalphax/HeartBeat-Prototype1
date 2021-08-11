newScene("Game")
newContainer("Gameplay", 0, 0, LARGEUR, HAUTEUR)
addContainer("Game", "Gameplay")

---- Player ----

newElement("Player", LARGEUR/2, 750)

getElement("Player").fightMode = false
getElement("Player").canMove = false
getElement("Player").speed = 300

getElement("Player").collisionBox = 10

getElement("Player").animation = newAnimation(game.graphics.newImage("img/player.png"), 0, 0, 160, 160, 8, 0.1)
getElement("Player").animation.size = 0.3

mm_effect = music_mode_effect_play(LARGEUR, getElement("Player").y)

getElement("Player").update = function(dt) 
    
    if getElement("Player").canMove then

        if game.keyboard.isDown("q") and getElement("Player").x > 0 then
            getElement("Player").x = getElement("Player").x - getElement("Player").speed*dt
        end

        if game.keyboard.isDown("d") and getElement("Player").x < LARGEUR then
            getElement("Player").x = getElement("Player").x + getElement("Player").speed*dt
        end

        if getElement("Player").fightMode then
            if game.keyboard.isDown("z") and getElement("Player").y > 0 then
                getElement("Player").y = getElement("Player").y - getElement("Player").speed*dt
            end
    
            if game.keyboard.isDown("s") and getElement("Player").y < HAUTEUR then
                getElement("Player").y = getElement("Player").y + getElement("Player").speed*dt
            end
        end
    end

    getElement("Player").animation.update(dt)
end

getElement("Player").draw = function() 
    if not getElement("Player").fightMode then
        game.graphics.setColor( rgb(255,255,255) )
    else
        game.graphics.setColor( rgb(255,0,0) )
    end
    --game.graphics.circle("fill", getElement("Player").x, getElement("Player").y, 10)
    getElement("Player").animation.play(getElement("Player").x, getElement("Player").y)
end

addElements("Gameplay", "Player")

---- /Player ----

---- Timer ----

newElement("Timer", LARGEUR/2, 750)

getElement("Timer").timer = 0

getElement("Timer").update = function(dt) 
    currentTimer = currentTimer + dt
end

getElement("Timer").draw = function() 
    game.graphics.setColor( rgb(255,255,255) )
    game.graphics.print(currentTimer)
end

addElements("Gameplay", "Timer")

---- /Timer ----

---- Test ----

effect_unfade_play(1)

attack.vertical_beam(2, LARGEUR/2, 50, 20, 1)

newTimedEvent(1, function() getElement("Player").canMove = true end)

attack.vertical_beam(3, LARGEUR/6*3, 50, 40, 1)

attack.vertical_beam(12, LARGEUR/6*4, 50, 40, 4)
attack.vertical_beam(12, LARGEUR/6*2, 50, 40, 4)

gamemode.fightMode(5)

gamemode.musicMode(8)

newTimedEvent(3, function() mm_effect.reverse = true end)
newTimedEvent(4, function() getElement("Player").fightMode = true end)

currentScene = getScene("Game")

---- /Test ----