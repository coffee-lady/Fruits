local Config = require('src.config.config')
local Constants = require('src.constants.constants')
local Services = require('src.services.services')
local Animations = require('src.main.animations.animations')

local DataService = Services.data

local ScoringAnimation = Animations.scoring

local GuiMsg = Constants.messages.gui
local SceneConst = Constants.component_urls.scenes.game
local GuiScoringAnimConf = Config.gui.scenes.game.score_animation

local ScoringConfig = Config.player.scoring

local GuiScoringSystem = {}

function GuiScoringSystem:init()
    local app_data = DataService:get_all()
    self.best_score_node = gui.get_node(SceneConst.gui_nodes.best_score)
    self.best_score = app_data.game and app_data.game.best_score or 0
    self.score_node = gui.get_node(SceneConst.gui_nodes.current_score)

    gui.set_text(self.best_score_node, 'Best: ' .. self.best_score)
end

function GuiScoringSystem:on_message(message_id, message, sender)
	if message_id == hash(GuiMsg.scoring.set) then
        self:animate_score(message.new_score)
    end
end

function GuiScoringSystem:animate_score(new_score)
    local prev_score = tonumber(gui.get_text(self.score_node))
    local score_range = new_score - prev_score
    local elapsed_time = 0

    if score_range == 0 then
        gui.set_text(self.score_node, 0)
        return
    end

    timer.delay(ScoringConfig.duration / score_range, true, function (_, handle, dt)
        elapsed_time = elapsed_time + dt

        local remaining_time = math.max((ScoringConfig.duration - elapsed_time) / ScoringConfig.duration, 0)
        local current_score = math.modf(new_score - remaining_time * score_range)

        if current_score > self.best_score then
            self.best_score = current_score
            gui.set_text(self.best_score_node, 'Best: ' .. self.best_score)
        end

        gui.set_text(self.score_node, current_score)

        if current_score == new_score then
            timer.cancel(handle)
            ScoringAnimation:animate_scale(self.score_node, GuiScoringAnimConf.scale, GuiScoringAnimConf.duration)
        end
    end)
end

return GuiScoringSystem
