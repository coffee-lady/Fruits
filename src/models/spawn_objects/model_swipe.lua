local rendercam = require('rendercam.rendercam')
local App = require('src.app')

local Config = App.config
local Constants = App.constants
local Libs = App.libs

local CoordsLib = Libs.coords

local ObjectsManagerModel = require('src.models.spawn_objects.model_objects_manager')
local ComboSwipeModel = require('src.models.spawn_objects.model_combo_swipe')

local ObjectConfig = Config.spawn_objects.object
local SwipeConfig = Config.spawn_objects.swipe

local MsgConst = Constants.messages

local SwipeModel = {}

function SwipeModel:new()
    ComboSwipeModel:init()

    local swipe = {
        swipe_start = vmath.vector3(0, 0, 0),
        swipe_end = vmath.vector3(0, 0, 0),
        swipe_length = 0,
    }
    self.__index = self
    return setmetatable(swipe, self)
end

function SwipeModel:get_swipe_length(start_coords, end_coords)
    return Libs.coords:get_vector_length(start_coords, end_coords)
end

function SwipeModel:get_last_coords(action)
    return rendercam.screen_to_world_2d(action.screen_x, action.screen_y, false)
end

function SwipeModel:on_objects_swipe(objects, action, callback)
    if CoordsLib:get_vector_velocity(action.screen_dx, action.screen_dy) <
        SwipeConfig.min_speed then return end

    for i = 1, #objects do
        local obj = objects[i]

        if obj and obj.id then
            local is_swipe_throw_object = Libs.coords:is_point_in_circle({ x = action.screen_x, y = action.screen_y }, obj.pos, ObjectConfig.collision_object_radius)

            if is_swipe_throw_object and self.swipe_length >= SwipeConfig.min_length then
                msg.post(msg.url(obj.id), MsgConst.spawned_object.play_swipe_animation)

                ObjectsManagerModel:delete_object(obj.id, objects)
                ComboSwipeModel:on_swipe(obj)

                if self.on_swiped_object then self.on_swiped_object_callback(obj) end
            end
        end
    end
end

function SwipeModel:on_swiped_object(callback)
    self.on_swiped_object_callback = callback
end

function SwipeModel:on_combo_swipe(callback)
    ComboSwipeModel:on_combo_swipe_callback(callback)
end

function SwipeModel:on_swipe(action)
    if action.pressed then
        self.swipe_start.x, self.swipe_start.y = action.screen_x, action.screen_y
    end

    if action.released then
        self.swipe_length = 0
    end

    self.swipe_end.x, self.swipe_end.y = action.screen_x, action.screen_y

    self.swipe_length = self:get_swipe_length(self.swipe_start, self.swipe_end)
end

return SwipeModel
