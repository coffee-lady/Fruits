local Models = require('src.models.models')

local ScoringModel = Models.player.scoring

local ScoringSystem = {}

function ScoringSystem:init()
    self.points = {}
    self.score = 0
    ScoringModel:set_random_points(self.points)
end

function ScoringSystem:on_swiping_object(obj)
    self.score = ScoringModel:update_score(obj, self.score, self.points)
end

function ScoringSystem:zero_out()
    self.score = 0
    ScoringModel:zero_out()
end

return ScoringSystem
