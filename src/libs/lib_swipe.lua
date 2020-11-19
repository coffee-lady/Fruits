local rendercam = require('rendercam.rendercam')
local config = require('src.config.config_app')

local object_config = config.spawn_objects.object
local swipe_config = config.spawn_objects.swipe

local SwipeLib = {
    start_coords = vmath.vector3(0, 0, 0),
    end_coords = vmath.vector3(0, 0, 0),
    current_timer = nil,
    obj_pos = nil
}

local function is_point_in_segment(point, start_coord, end_coord)
    return point >= start_coord and point <= end_coord or point <= start_coord and point >= end_coord
end

local function is_action_in_segment(action, obj_pos, radius)
    local action_pos = rendercam.screen_to_world_2d(action.screen_x, action.screen_y, false)

    if not is_point_in_segment(action_pos.x, obj_pos.x - radius, obj_pos.x + radius)
    or not is_point_in_segment(action_pos.y, obj_pos.y - radius, obj_pos.y + radius) then
        return false
    end

    return true
end

function SwipeLib:init()
    self:set_timer()
end

function SwipeLib:clear_coords()
    self.start_coords.x, self.start_coords.y = self.end_coords.x, self.end_coords.y
end

function SwipeLib:set_timer()
    self.current_timer =  timer.delay(swipe_config.max_idle_time, true, function ()
        self:clear_coords()
    end)
end

function SwipeLib:on_swipe(obj, action, callback)
    if self.start_coords.x == 0 and self.start_coords.y == 0 then
        self.start_coords.x, self.start_coords.y = action.screen_x, action.screen_y
        return
    end

    self.obj_pos = go.get_position()

    self.end_coords.x, self.end_coords.y = action.screen_x, action.screen_y

    local is_swipe_throw_object = is_action_in_segment(action, self.obj_pos, object_config.collision_object_radius)
    local swipe_length = self:get_swipe_length(self.start_coords, self.end_coords)

    if is_swipe_throw_object and swipe_length >= swipe_config.min_length then
        particlefx.play('#swipe_effect')
        particlefx.set_constant('#swipe_effect', 'splashes', 'tint', swipe_config.colors[obj.anim_to_play])
        particlefx.set_constant('#swipe_effect', 'blots', 'tint', swipe_config.colors[obj.anim_to_play])

        self:clear_coords()

        timer.cancel(self.current_timer)
        self:set_timer()

        callback()
    end
end

function SwipeLib:get_swipe_length(swipe_pos_start, swipe_pos_end)
    local dx = math.abs(swipe_pos_start.x - swipe_pos_end.x)
    local dy = math.abs(swipe_pos_start.y - swipe_pos_end.y)
	return math.sqrt(dx * dx + dy * dy)
end

return SwipeLib
