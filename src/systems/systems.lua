local App = require('src.app')

local Constants = App.constants
local Services = App.services

local ScenesService = Services.scenes

local PopupUrl = Constants.component_urls.popups.game_end.url

local DataService = Services.data

local ScreenService = Services.screen

local SpawnObjectsSys = require('src.systems.spawned_objects.spawned_objects')
local ScoringSys = require('src.systems.scoring.sys_scoring')
local GamingLivesSys = require('src.systems.gaming_lives.sys_gaming_lives')

local Systems = {}

Systems.initialized = false

function Systems:init()
    SpawnObjectsSys:init()
    ScoringSys:init()
    GamingLivesSys:init()

    SpawnObjectsSys:on_deleted_departed_object(function (obj)
        GamingLivesSys:on_deleted_departed_object(obj)
    end)

    GamingLivesSys:on_end_of_lives(function ()
        ScoringSys:on_game_over()
        SpawnObjectsSys:on_game_over(function ()
            local app_data = DataService:get_all()
            ScenesService.open_popup(PopupUrl, {
                score = ScoringSys.score,
                best_score = app_data.game.best_score
            })
        end)
    end)

    SpawnObjectsSys:on_swiped_object(function (obj)
        ScoringSys:on_swiping_object(obj)
        GamingLivesSys:on_swiped_object(obj)
    end)
end

function Systems:update(dt)
    SpawnObjectsSys:update({ ScreenService:get_coords() }, dt)
end

function Systems:on_message(message_id, message, sender)
    SpawnObjectsSys:on_message(message_id, message, sender)
end

function Systems:on_input(action_id, action)
    SpawnObjectsSys:on_input(action_id, action)
end

return Systems
