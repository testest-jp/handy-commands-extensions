dofile("./common.lua")

dofile("./cel-tools.lua")
dofile("./layer-tools.lua")

function init(plugin)
    -- if app.version <= Version("1.2.0") then
    --   return
    -- end
    ------------------------------------------------------------------------------
    -- Cels Popup Menu
    ------------------------------------------------------------------------------
    plugin:newCommand{
        id="toLinkRightCels",
        -- title="右側のセルを全て結合",
        title="Link Right Cels",
        group="cel_popup_links",
        onclick=LinkRightCels
    }

    plugin:newCommand{
        id="toReLinkCels",
        -- title="結合を解除して再結合",
        title="UnLink & ReLink Cels",
        group="cel_popup_links",
        onclick=ReLinkCels
    }

    plugin:newCommand{
        id="toFadeOutCels",
        -- title="セルをフェードアウトさせる",
        title="Fade Out Cels",
        group="cel_popup_links",
        onclick=FadeOutCels
    }
    
    plugin:newCommand{
        id="toCopyLinkFrame",
        title="Copy Link Frame",
        group="cel_popup_links",
        onclick=CopyLinkFrame
    }
    
    plugin:newCommand{
        id="toPasteLinkFrame",
        title="Paste Link Frame",
        group="cel_popup_links",
        onclick=PasteLinkFrame
    }

    plugin:newCommand{
        id="toSmartMargeDownLayer",
        title="Smart Merge Down",
        group="layer_popup_merge",
        onclick=SmartMargeDownLayer
    }

    ------------------------------------------------------------------------------
    -- Top Menu
    ------------------------------------------------------------------------------
    plugin:newCommand{
      id="toInsertText",
      title="Insert Text",
      group="edit_insert",
      onclick=InsertText
    }
    
    plugin:newCommand{
      id="toOutLine",
      title="Outline Set",
      group="edit_insert",
      onclick=OutLine
    }
end