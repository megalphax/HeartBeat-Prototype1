Containers = {}

function newContainer(pName, pX, pY)
    local c={}

    c.name = pName
    c.x = pX
    c.y = pY
    c.isActive = true
    c.elements = {}

    function c.update(dt)
        for i=1, #c.elements do
            if c.elements[i].update(dt) ~= nil then
                c.elements[i].update(dt)
            end
        end
    end

    function c.draw()
        for i=1, #c.elements do
            if c.elements[i].draw() ~= nil then
                c.elements[i].draw()
            end
        end
    end

    table.insert(Containers, c)
end

function getContainer(pName)
    for i = 1, #Containers do
        if Containers[i].name == pName then
            return Containers[i];
        end
    end
end 

function addElements(pName, pElement)
    for i = 1, #Containers do
        if Containers[i].name == pName then
            table.insert(Containers[i].elements, getElement(pElement))
        end
    end
end 