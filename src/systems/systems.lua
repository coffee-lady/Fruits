local Libs = require('src.libs.libs')
local Constants = require('src.constants.constants')
local Services = require('src.services.services')

local ScenesService = Services.scenes
local ScenesConst = Constants.scenes

local MsgConst = Constants.messages
local ScreenLib = Libs.screen

local SpawnObjectsSys = require('src.systems.spawned_objects.spawned_objects')
local ScoringSys = require('src.systems.scoring.sys_scoring')
local GamingLivesSys = require('src.systems.gaming_lives.sys_gaming_lives')

local Systems = {}

Systems.initialized = false

function Systems:init()
    ScreenLib:init(function ()
        SpawnObjectsSys:init()
        self.initialized = true
    end)
    ScoringSys:init()
    GamingLivesSys:init()

    SpawnObjectsSys:on_swiped_object(function (obj)
        ScoringSys:on_swiping_object(obj)
    end)

    SpawnObjectsSys:on_deleted_departed_objects(function ()
        GamingLivesSys:on_deleted_object()
    end)

    GamingLivesSys:on_end_of_lives(function ()
        ScoringSys:on_game_over()
        SpawnObjectsSys:on_game_over(function ()
            ScenesService:open_popup(ScenesConst.popups.game_end, ScoringSys.score)
        end)
    end)
end

function Systems:update(dt)
    if not self.initialized then return end

    SpawnObjectsSys:update({ ScreenLib:get_coords() }, dt)
end

function Systems:on_message(message_id, message, sender)
    if message_id == hash(MsgConst.screen.on_update) then
        ScreenLib:on_resize()
    end

    SpawnObjectsSys:on_message(message_id, message, sender)
end

function Systems:on_input(action_id, action)
    SpawnObjectsSys:on_input(action_id, action)
end

return Systems
