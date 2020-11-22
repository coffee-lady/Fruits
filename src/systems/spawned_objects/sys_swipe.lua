local Libs = require('src.libs.libs')
local Config = require('src.config.config')
local Constants = require('src.constants.constants')
local Models = require('src.models.models')

local SwipeConfig = Config.spawn_objects.swipe

local SwipeModel = Models.spawn_objects.swipe
local ObjectsManagerModel = Models.spawn_objects.objects_manager

local ActionsConst = Constants.actions
local MsgConst = Constants.messages
local ComponentsUrls = Constants.component_urls

local SwipeSystem = {}

function SwipeSystem:init()
    self.swipe = SwipeModel:new()
end

function SwipeSystem:on_input(action_id, action, objects, callback)
    if action_id == hash(ActionsConst.click) then
        self.swipe:on_swipe(action)
        self.swipe:on_objects_swipe(objects, action, callback)
    end
end

return SwipeSystem
