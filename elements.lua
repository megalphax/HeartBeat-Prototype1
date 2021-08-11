Elements = {}

function newElement(pName, pX, pY)
    local e={}

    e.name = pName
    e.x = pX
    e.y = pY
    e.isActive = true
    e.elements = {}

    table.insert(Elements, e)
end

function getElement(pName)
    for i = 1, #Elements do
        if Elements[i].name == pName then
            return Elements[i];
        end
    end
end 