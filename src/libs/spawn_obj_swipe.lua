local rendercam = require('rendercam.rendercam')
local config = require('src.config.config_app')

local object_config = config.spawn_objects.object
local swipe_config = config.spawn_objects.swipe

local SwipeLib = {
    start_coords = nil,
    end_coords = nil,
}

local function is_point_in_segment(point, start_coord, end_coord)
    return point >= start_coord and point <= end_coord or point <= start_coord and point >= end_coord
end

local function is_obj_in_segment(obj_pos, radius, start_coords, end_coords)
    for _, key in pairs({ 'x', 'y' }) do
        if not is_point_in_segment(obj_pos[key] + radius, start_coords[key], end_coords[key])
            and not is_point_in_segment(obj_pos[key] - radius, start_coords[key], end_coords[key]) then
            return false
        end
    end
    return true
end

function SwipeLib:is_swipe_throw_object(obj_pos, swipe_pos_start, swipe_pos_end)
	swipe_pos_start = rendercam.screen_to_world_2d(swipe_pos_start.x, swipe_pos_start.y, false)
    swipe_pos_end = rendercam.screen_to_world_2d(swipe_pos_end.x, swipe_pos_end.y, false)

    return is_obj_in_segment(obj_pos, object_config.collision_object_radius, swipe_pos_start, swipe_pos_end)
end

function SwipeLib:get_swipe_length(swipe_pos_start, swipe_pos_end)
    local dx = math.abs(swipe_pos_start.x - swipe_pos_end.x)
    local dy = math.abs(swipe_pos_start.y - swipe_pos_end.y)
	return math.sqrt(dx * dx + dy * dy)
end

function SwipeLib:on_swipe(obj, action, callback)
    if not self.start_coords then
        self.start_coords = vmath.vector3(action.x, action.y, 0)
    else
        self.end_coords = vmath.vector3(action.x, action.y, 0)
        local obj_pos = go.get_position()
        local is_swipe_throw_object = self:is_swipe_throw_object(obj_pos, self.start_coords, self.end_coords)
        local swipe_length = self:get_swipe_length(self.start_coords, self.end_coords)

        if is_swipe_throw_object and swipe_length >= swipe_config.min_length then
            particlefx.play('#swipe_effect')
            particlefx.set_constant('#swipe_effect', 'splashes', 'tint', swipe_config.colors[obj.anim_to_play])
            particlefx.set_constant('#swipe_effect', 'blots', 'tint', swipe_config.colors[obj.anim_to_play])

            callback()
        end

        if swipe_length >= swipe_config.max_length then
            self.start_coords = nil
        end
    end
    if action.released then
        self.start_coords = nil
    end
end

return SwipeLib
