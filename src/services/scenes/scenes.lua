local monarch = require('monarch.monarch')

local ScenesService = {}

ScenesService.messages = {
    TRANSITION_IN_STARTED = monarch.SCREEN_TRANSITION_IN_STARTED,
    TRANSITION_IN_FINISHED = monarch.SCREEN_TRANSITION_IN_FINISHED,
    TRANSITION_OUT_STARTED = monarch.SCREEN_TRANSITION_OUT_STARTED,
    TRANSITION_OUT_FINISHED = monarch.SCREEN_TRANSITION_OUT_FINISHED,
}

function ScenesService.init()
	msg.post("#", "init_monarch")
end

function ScenesService.on_init(message_id, callback)
	if message_id == hash('init_monarch') then
		if callback then callback() end
	end
end

function ScenesService.switch_to_scene(scene_id, scene_data, reload, callback)
    monarch.show(scene_id, {
        clear = true,
        reload = reload and reload or false,
        sequential = true,
    }, scene_data, function()
        if callback then callback() end
    end)
end

function ScenesService.back_to_prev_scene(scene_data, callback)
    monarch.back(scene_data, function()
        if callback then callback() end
    end)
end

function ScenesService.open_popup(popup_id, popup_data, callback)
    monarch.show(popup_id, {
        clear = true,
        sequential = true,
    }, popup_data, function()
        if callback then callback() end
    end)
end

function ScenesService.close_popup(popup_id, callback)
    monarch.unload(popup_id, function()
        if callback then callback() end
    end)
end

function ScenesService.get_scene_data(screen_id)
    return monarch.data(screen_id)
end

function ScenesService.add_listener(screen_id)
    monarch.add_listener(screen_id)
end

return ScenesService
