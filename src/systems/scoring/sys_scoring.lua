local Models = require('src.models.models')
local Services = require('src.services.services')

local DataService = Services.data
local ScoringModel = Models.player.scoring

local ScoringSystem = {}

function ScoringSystem:init()
    self.points = {}
    self.score = 0
    self.game_over = false
    ScoringModel:set_random_points(self.points)
end

function ScoringSystem:on_swiping_object(obj)
    if self.game_over or obj.is_bomb or obj.is_bonus_life then return end
    self.score = ScoringModel:update_score(obj, self.score, self.points)
end

function ScoringSystem:on_game_over()
    self.game_over = true

    local app_data = DataService:get_all()

    if not app_data or not app_data.game or app_data.game and self.score > app_data.game.best_score then
        DataService:save({
            game = {
                best_score = self.score
            }
        })
    end
end

return ScoringSystem
