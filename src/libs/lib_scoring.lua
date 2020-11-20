local Config = require('src.config.config_app')
local Constants = require('src.constants.constants')

local GuiMsg = Constants.messages.gui
local ObjectConfig = Config.spawn_objects.object
local SpawnObjConstants = Constants.spawn_obj

local ScoringLib = {
    score = 0,
    points = {},
}

function ScoringLib:init()
    local sprites_ids = SpawnObjConstants.sprites_ids 
    for i = 1, #sprites_ids do
        self.points[sprites_ids[i]] = math.random(ObjectConfig.score_bounds[1], ObjectConfig.score_bounds[2])
    end
end

function ScoringLib:update_score(sprite_id)
    self.score = self.score + self.points[sprite_id]
    msg.post(msg.url('main#gui'), GuiMsg.set_score, { score = self.score })
end

return ScoringLib
