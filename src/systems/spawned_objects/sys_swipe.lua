local App = require('src.app')

local Constants = App.constants

local Models = require('src.models.models')

local SwipeModel = Models.spawn_objects.swipe

local ActionsConst = Constants.actions

local SwipeSystem = {}

function SwipeSystem:init()
    self.swipe = SwipeModel:new()
    self.game_over = false
end

function SwipeSystem:on_swiped_object(callback)
    SwipeModel:on_swiped_object(callback)
end

function SwipeSystem:on_game_over()
    self.game_over = true
end

function SwipeSystem:on_input(action_id, action, objects, callback)
    if action_id == hash(ActionsConst.click) and not self.game_over then
        self.swipe:on_swipe(action)
        self.swipe:on_objects_swipe(objects, action, callback)
    end
end

return SwipeSystem
