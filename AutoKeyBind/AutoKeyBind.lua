local ADDON_NAME = "AutoKeyBind"
local ADDON_VERSION = "1.0"
local ADDON_AUTHOR = "Tom Cumbow"

local function BindSpecial (desiredActionName, keyCode, bindNumber)
    bindNumber = bindNumber or 4
    local layers = GetNumActionLayers()
    for layerIndex=1, layers do
        local layerName, categories = GetActionLayerInfo(layerIndex)
        for categoryIndex=1, categories do
			local categoryName, actions = GetActionLayerCategoryInfo(layerIndex, categoryIndex)
            for actionIndex=1, actions do
                local actionName, isRebindable, isHidden = GetActionInfo(layerIndex, categoryIndex, actionIndex)
                if isRebindable and actionName == desiredActionName then
                    -- LayerIndex,CategoryIndex,ActionIndex,BindIndex(1-4),KeyCode,Modx4
                    CallSecureProtected("BindKeyToAction", layerIndex, categoryIndex, actionIndex, bindNumber, keyCode, 0, 0, 0, 0)
                end
            end
        end
    end
end



local function BindDesiredKeys()
    BindSpecial("TOGGLE_GAMEPAD_MODE", 102) -- right square bracket
    BindSpecial("SHOW_HOUSING_PANEL",162,2) -- Y+B
    BindSpecial("SPECIAL_MOVE_INTERRUPT",83) -- F9
    BindSpecial("ROLL_DODGE",84) -- F10
    BindSpecial("CMX_REPORT_TOGGLE",45) -- n
    BindSpecial("DUSTMAN_JUNK",30) -- 8
    BindSpecial("RELOAD_UI_BINDING",99) -- -
    BindSpecial("RELOAD",99) -- -
end


local function OnAddonLoaded(event, name)
	if name == ADDON_NAME then
		EVENT_MANAGER:UnregisterForEvent(ADDON_NAME, event)
		zo_callLater(BindDesiredKeys, 1000)



	end
end

EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_ADD_ON_LOADED, OnAddonLoaded)
