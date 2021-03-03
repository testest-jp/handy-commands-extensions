function _SetNewGroups(groups)
    for i,v in pairs(groups) do
        app.range.frames = v
        app.command.LinkCels{}
    end
end

function _ExtractNewLinkGroups(from_layer, to_layer, sprite)
    local groups = {}
    for i= 1, #sprite.frames do
        local from_cel = from_layer:cel(i)
        local to_cel = to_layer:cel(i)
        local index = ""
        if from_cel == nil and to_cel == nil then
         -- 何もしない
        else
            if to_cel == nil then
                index = from_cel.data .. "-"
            elseif from_cel == nil then
                index = "-" .. to_cel.data
            else
                index = from_cel.data .. "-" .. to_cel.data
            end
    
            if groups[index] == nil then
                groups[index] = {}
            end
    
            groups[index][#groups[index] + 1] = i
        end
    end
    return groups
end

function _SetLinkCelIndex(layer, sprite)
    local groups = {}
    for i= 1, #sprite.frames do
        local cel = layer:cel(i)
        if cel ~= nil then
            local index = tonumber(cel.data)
            -- Indexが割り当てられていないセルのみ新規に割り当てる
            if index == nil or groups[index] == nil then
                groups[#groups + 1] = cel.data
                index = #groups
                cel.data = tostring(index)
            end
        end
    end
    return groups
end

function SmartMargeDownLayer()
    local sprite = app.activeSprite
    local from_layer = app.activeLayer

    local stackIndex = from_layer.stackIndex
    
    if stackIndex - 1 <= 0 then
        app.alert("マージ先のレイヤがありません")
        return
    end

    local to_layer = from_layer.parent.layers[stackIndex-1]
    app.transaction(function ()
        local from_groups = _SetLinkCelIndex(from_layer, sprite)
        local to_groups = _SetLinkCelIndex(to_layer, sprite)
        local new_groups = _ExtractNewLinkGroups(from_layer, to_layer, sprite)
        app.command.MergeDownLayer{}
        app.range.layers = {to_layer}
        _SetNewGroups(new_groups)
    end)
end