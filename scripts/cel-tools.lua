
function LinkRightCels()
    local sprite = app.activeSprite
    local cel = app.activeCel
    local layer = app.activeLayer

    local frameNumbers = {}
    local sframe = cel.frameNumber
    local eframe = sprite.frames[#sprite.frames].frameNumber

    for f = sframe, eframe do
        frameNumbers[#frameNumbers+1] = f
    end

    app.range.layers = {layer}
    app.range.frames = frameNumbers
    app.command.LinkCels()
    app.activeCel = cel
end

function ReLinkCels()
    app.transaction(
        function ()
            app.command.UnlinkCel()
            app.command.LinkCels()
        end
    )
end

function FadeOutCels()
    app.transaction(
        function ()
            app.command.UnlinkCel()
            local layers = app.range.layers
            local frames = app.range.frames

            local step = 255/(#frames+1)
            local i = 1
            for i=1,#frames do
                local frame = frames[i]
                for j=1,#layers do
                    local layer = layers[j]
                    local cel = layer:cel(frame.frameNumber)
                    cel.opacity = 255 - step * i
                end
                i = i+1
            end
        end
    )
end

local copied_link_frame = nil

function _GetLinkCelFrame(cel, sprite)
    local groups = {cel.frame.frameNumber}
    local celdata = cel.data
    local layer = cel.layer

    cel.data = "同じリンク"
    
    for i= 1, #sprite.frames do
        local cel = layer:cel(i)
        if cel ~= nil then
            if cel.data == "同じリンク" then
                groups[#groups+1] = i
            end
        end
    end
    
    cel.data = celdata
    return groups
end

function CopyLinkFrame()
    copied_link_frame = nil
    app.transaction(
        function ()
            copied_link_frame = _GetLinkCelFrame(app.activeCel, app.activeSprite)
        end
    )
end

function PasteLinkFrame()
    if copied_link_frame == nil then
        return
    end
    local target_frames = table.shallow_copy(copied_link_frame)
    for i, f in ipairs(app.range.frames) do
        target_frames[#target_frames+1] = f.frameNumber
    end
    app.transaction(
        function ()
            app.range.frames = target_frames
            app.command.LinkCels{}
        end
    )
    copied_link_frame = nil
end


function OutLine()
    app.transaction(
    function()
    local sprite = app.activeSprite
    local cel = app.activeCel
    SelectColor(cel, sprite)
    app.command.ModifySelection{
        modifier="expand",
        quantity=1,
        brush="square"
    }
    FillEmpty(cel, sprite)
    end)
end