local ADDON_NAME = "AutoKeyBind"
local ADDON_VERSION = "1.0"
local ADDON_AUTHOR = "Tom Cumbow"

local function BindSpecial (desiredActionName, keyCode)
    local layers = GetNumActionLayers()
    for layerIndex=1, layers do
        local layerName, categories = GetActionLayerInfo(layerIndex)
        for categoryIndex=1, categories do
			local categoryName, actions = GetActionLayerCategoryInfo(layerIndex, categoryIndex)
            for actionIndex=1, actions do
                local actionName, isRebindable, isHidden = GetActionInfo(layerIndex, categoryIndex, actionIndex)
                if isRebindable and actionName == desiredActionName then
                    -- LayerIndex,CategoryIndex,ActionIndex,BindIndex(1-4),KeyCode,Modx4
                    CallSecureProtected("BindKeyToAction", layerIndex, categoryIndex, actionIndex, 4, keyCode, 0, 0, 0, 0)
                end
            end
        end
    end
end



local function BindDesiredKeys()
    -- BindSpecial("TOGGLE_GAMEPAD_MODE", 103) -- Backslash
    BindSpecial("ROLL_DODGE",83) -- F10
end


local function OnAddonLoaded(event, name)
	if name == ADDON_NAME then
		EVENT_MANAGER:UnregisterForEvent(ADDON_NAME, event)
		zo_callLater(BindDesiredKeys, 1000)



	end
end

EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_ADD_ON_LOADED, OnAddonLoaded)
