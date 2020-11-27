local Config = require('src.config.config')
local Constants = require('src.constants.constants')

local GuiMsg = Constants.messages.gui
local SpawnObjConstants = Constants.spawn_obj
local ComponentsUrls = Constants.component_urls

local GameSceneGui = ComponentsUrls.scenes.game.gui

local ObjectConfig = Config.spawn_objects.object

local ScoringModel = {}

function ScoringModel:set_random_points(points)
    local objects = SpawnObjConstants

    for _, obj  in pairs(objects) do
        points[obj.class_id] = math.random(ObjectConfig.score_bounds[1], ObjectConfig.score_bounds[2])
    end
end

function ScoringModel:update_score(obj, score, points)
    local new_score = score + points[obj.class_id]
    msg.post(msg.url(GameSceneGui), GuiMsg.scoring.set, { prev_score = score, new_score = new_score })
    return new_score
end

function ScoringModel:zero_out()
    msg.post(msg.url(GameSceneGui), GuiMsg.scoring.set, { new_score = 0 })
end

return ScoringModel
