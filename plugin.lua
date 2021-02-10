data = 0
name = ""

debug = "hi"

function draw()
    imgui.Begin("Memory 2")

    state.IsWindowHovered = imgui.IsWindowHovered()

    _, data = imgui.InputInt("Data", data)
    _, name = imgui.InputText("Name", name, 69)

    if imgui.Button("Load") then
        data = LoadFromLayer(name)
    end

    imgui.SameLine()
    if imgui.Button("Save") then
        SaveInLayer(name, data)
    end

    imgui.Text(debug)

    imgui.End()
end

function SaveInLayer(name, data)
    local data_layer = FindLayerThatStartsWith(name .. ": ")

    if data_layer then
        actions.RenameLayer(data_layer, name .. ": " .. data)
    else
        data_layer = utils.CreateEditorLayer(name .. ": " .. data)
        actions.CreateLayer(data_layer)
    end
end

function LoadFromLayer(name)
    local data_layer = FindLayerThatStartsWith(name .. ": ")

    if data_layer then
        return tonumber(data_layer.Name:sub(#name + 3, #data_layer.Name))
    end
end

function FindLayerThatStartsWith(str)
    for _, layer in pairs(map.EditorLayers) do
        if StartsWith(layer.Name, str) then
            return layer
        end
    end
end

--http://lua-users.org/wiki/StringRecipes
function StartsWith(str, start)
   return str:sub(1, #start) == start
end