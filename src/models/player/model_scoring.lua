local Libs = require('src.libs.libs')
local Config = require('src.config.config')
local Constants = require('src.constants.constants')

local GuiMsg = Constants.messages.gui
local SpawnObjConstants = Constants.spawn_obj
local ComponentsUrls = Constants.component_urls

local ObjectConfig = Config.spawn_objects.object

local ScoringModel = {}

function ScoringModel:set_random_points(points)
    local sprites_ids = SpawnObjConstants.sprites_ids
    for i = 1, #sprites_ids do
        points[sprites_ids[i]] = math.random(ObjectConfig.score_bounds[1], ObjectConfig.score_bounds[2])
    end
end

function ScoringModel:update_score(obj, score, points)
    score = score + points[obj.anim_to_play]
    msg.post(msg.url(ComponentsUrls.main.gui), GuiMsg.scoring.set, { score = score })
    return score
end

function ScoringModel:zero_out()
    msg.post(msg.url(ComponentsUrls.main.gui), GuiMsg.scoring.set, { score = 0 })
end

return ScoringModel
