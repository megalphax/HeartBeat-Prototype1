
function newAnimation(image, x, y, sx, sy, nframe, transitionTime)
    local a = {}
    a.image = image
    a.quads = {} 
    a.currentFrame = 1
    a.frameNumber = nframe
    a.transitionTime = transitionTime
    a.timer = a.transitionTime
    a.sx = sx
    a.sy = sy
    a.size = 1
    for i = 1, nframe do
        table.insert(a.quads, love.graphics.newQuad(x+(sx*(i-1)), y, sx, sy, a.image:getDimensions()))
    end
    function a.update(dt)
        if a.transitionTime < a.timer then
            if a.currentFrame < a.frameNumber then
                a.currentFrame = a.currentFrame + 1
            else
                a.currentFrame = 1
            end
            a.timer = 0
        end
        a.timer = a.timer + dt
    end
    function a.play(x, y)
        love.graphics.draw(a.image, a.quads[a.currentFrame], x-((a.sx*a.size)/2), y-((a.sy*a.size)/2), 0, a.size)
    end
    return a;
end
