local App = require('src.app')

local Constants = App.constants
local Services = App.services

local Animations = require('src.main.scenes.game_scene.animations.animations')
local Animation = Animations.scoring

local DataService = Services.data

local GuiMsg = Constants.messages.gui
local SceneConst = Constants.component_urls.scenes.game

local GuiScoringSystem = {}

function GuiScoringSystem:init()
    local app_data = DataService:get_all()

    self.best_score_node = gui.get_node(SceneConst.gui_nodes.best_score)
    self.best_score = app_data.game and app_data.game.best_score or 0
    self.score_node = gui.get_node(SceneConst.gui_nodes.current_score)

    Animation:init(self.best_score_node, self.score_node, self.best_score)

    gui.set_text(self.best_score_node, 'Best: ' .. self.best_score)
    gui.set_text(self.score_node, 0)
end

function GuiScoringSystem:on_message(message_id, message, sender)
	if message_id == hash(GuiMsg.scoring.set) then
        Animation:animate_scoring(message.new_score, message.is_combo)

        if message.obj then
            Animation:animate_scoring_above_obj(message.obj, message.new_score - message.prev_score)
        end
    end
end

return GuiScoringSystem
