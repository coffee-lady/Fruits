local Libs = require('src.libs.libs')
local Constants = require('src.constants.constants')

local MsgConst = Constants.messages
local ScreenLib = Libs.screen

local SpawnObjectsSys = require('src.systems.spawned_objects.spawned_objects')
local ScoringSys = require('src.systems.scoring.sys_scoring')
local GamingLivesSystem = require('src.systems.gaming_lives.sys_gaming_lives')

local Systems = {}

local initialized = false

function Systems:init()
    ScreenLib:init(function ()
        SpawnObjectsSys:init()
        initialized = true
    end)
    ScoringSys:init()
    GamingLivesSystem:init()
end

function Systems:update(dt)
    if not initialized then return end

    SpawnObjectsSys:update({ ScreenLib:get_coords() }, dt, function ()
        GamingLivesSystem:on_deleted_object()
    end)
end

function Systems:on_message(message_id, message, sender)
    if message_id == hash(MsgConst.screen.on_update) then
        ScreenLib:on_resize()
    end

    SpawnObjectsSys:on_message(message_id, message, sender)
end

function Systems:on_input(action_id, action)
    SpawnObjectsSys:on_input(action_id, action, function (obj)
        ScoringSys:on_swiping_object(obj)
    end)
end

return Systems
