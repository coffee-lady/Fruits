local Models = require('src.models.models')

local ScoringModel = Models.player.scoring

local ScoringSystem = {}

function ScoringSystem:init()
    self.points = {}
    self.score = 0
    self.game_over = false
    ScoringModel:set_random_points(self.points)
end

function ScoringSystem:on_swiping_object(obj)
    if self.game_over then return end

    self.score = ScoringModel:update_score(obj, self.score, self.points)
end

function ScoringSystem:on_game_over()
    self.game_over = true
    ScoringModel:zero_out()
end

return ScoringSystem
