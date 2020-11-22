local SwipeSystem = require('src.systems.spawned_objects.sys_swipe')
local SpawnSystem = require('src.systems.spawned_objects.sys_spawn')

local Constants = require('src.constants.constants')
local ActionsConst = Constants.actions

local SpawnedObjectsSystem = {}

function SpawnedObjectsSystem:init()
    SpawnSystem:init()
    SwipeSystem:init()
end

function SpawnedObjectsSystem:update(screen_coords, dt)
    SpawnSystem:update(screen_coords, dt)
end

function SpawnedObjectsSystem:on_deleted_departed_objects(callback)
    SpawnSystem:on_deleted_departed_objects(callback)
end

function SpawnedObjectsSystem:on_message(message_id, message, sender)
    SpawnSystem:on_message(message_id, message, sender)
end

function SpawnedObjectsSystem:on_swiped_object(callback)
    SwipeSystem:on_swiped_object(callback)
end

function SpawnedObjectsSystem:on_input(action_id, action, swipe_callback)
    SwipeSystem:on_input(action_id, action, SpawnSystem.objects, swipe_callback)
end

return SpawnedObjectsSystem
