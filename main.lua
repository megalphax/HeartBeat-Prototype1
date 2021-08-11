currentTimer = 0
timedEvent = {}

game = love
require('functions')
require('containers')
require('scenes')
require('elements')
require('effects')
require('animations')

LARGEUR = 400
HAUTEUR = 800

require('game')

function game.load()
    game.mouse.setVisible(false)
    game.window.setMode(LARGEUR, HAUTEUR)
end

function game.update(dt)

    for i = 1, #timedEvent do
        if timedEvent[i] ~= nil then
            timedEvent[i]:update()
            if timedEvent[i].done == true then
                table.remove(timedEvent, i)
            end
        end
    end

    currentScene.update(dt)
    effects_update(dt)
end

function game.draw()

    game.graphics.setBackgroundColor(12/255, 11/255, 29/255)
    game.graphics.setColor(232/255,231/255,234/255, 1)

    currentScene.draw()
    effects_draw()
end

function game.keypressed(key)
    if key == "space" then
        effect_heartbeat_play(getElement("Player").x, getElement("Player").y, 70)
    end
end

function game.mousepressed(x, y, key)
        if key == 1 then
            effect_heartbeat_play(x, y, 70)
        elseif key == 2 then
            damage_effect_play(x, y)
        elseif key == 3 then
            if getElement("Player").fightMode then
                gamemode.musicMode(0)
            else
                gamemode.fightMode(0)
            end
        end
end