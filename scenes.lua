Scenes = {}

function newScene(pName)
    local s={}

    s.name = pName
    s.isActive = true
    s.containers = {}

    function s.update(dt)
        for i=1, #s.containers do
            s.containers[i].update(dt)
        end
    end

    function s.draw()
        for i=1, #s.containers do
            s.containers[i].draw()
        end
    end

    table.insert(Scenes, s)
end

function getScene(pName)
    for i = 1, #Scenes do
        if Scenes[i].name == pName then
            return Scenes[i];
        end
    end
end 

function addContainer(pName, pContainer)
    for i = 1, #Scenes do
        if Scenes[i].name == pName then
            table.insert(Scenes[i].containers, getContainer(pContainer))
        end
    end
end 