local rendercam = require('rendercam.rendercam')
local Libs = require('src.libs.libs')
local Config = require('src.config.config')
local Constants = require('src.constants.constants')

local ObjectConfig = Config.spawn_objects.object
local SwipeConfig = Config.spawn_objects.swipe

local MsgConst = Constants.messages

local ObjectsManagerModel = require('src.models.spawn_objects.model_objects_manager')

local SwipeModel = {}

function SwipeModel:new()
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
    for i = 1, #objects do
        local obj = objects[i]

        if obj and obj.id then
            local is_swipe_throw_object = Libs.coords:is_point_in_circle(action, obj.pos, ObjectConfig.collision_object_radius)

            if is_swipe_throw_object and self.swipe_length >= SwipeConfig.min_length then
                msg.post(msg.url(obj.id), MsgConst.spawned_object.play_swipe_animation)
                ObjectsManagerModel:delete_object(obj.id, objects)

                if callback then callback(obj) end
            end
        end
    end
end

function SwipeModel:on_swipe(action)
    if action.pressed then
        self.swipe_start.x, self.swipe_start.y = action.screen_x, action.screen_y
    end

    if action.released then
        self.swipe_length = 0
    end

    self.swipe_end.x, self.swipe_end.y = action.screen_x, action.screen_y

    if self.swipe_length > SwipeConfig.max_length then
        local delta_coord = math.sqrt(SwipeConfig.delta_length)
        self.swipe_start.x = self.swipe_end.x - delta_coord
        self.swipe_start.y = self.swipe_end.y - delta_coord
    end

    self.swipe_length = self:get_swipe_length(self.swipe_start, self.swipe_end)
end

return SwipeModel
