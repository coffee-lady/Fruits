local Constants = require('src.constants.constants')
local Models = require('src.models.models')

local SwipeModel = Models.spawn_objects.swipe

local ActionsConst = Constants.actions

local SwipeSystem = {}

function SwipeSystem:init()
    self.swipe = SwipeModel:new()
end

function SwipeSystem:on_swiped_object(callback)
    SwipeModel:on_swiped_object(callback)
end

function SwipeSystem:on_input(action_id, action, objects, callback)
    if action_id == hash(ActionsConst.click) then
        self.swipe:on_swipe(action)
        self.swipe:on_objects_swipe(objects, action, callback)
    end
end

return SwipeSystem
