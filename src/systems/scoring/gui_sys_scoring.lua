local Libs = require('src.libs.libs')
local Config = require('src.config.config')
local Constants = require('src.constants.constants')

local Models = require('src.models.models')

local GuiMsg = Constants.messages.gui
local GuiConst = Constants.gui
local ScoringConfig = Config.player.scoring

local GuiScoringSystem = {}

function GuiScoringSystem:on_message(message_id, message, sender)
	if message_id == hash(GuiMsg.scoring.set) then
        self:animate_score(message.score)
    end
end

function GuiScoringSystem:animate_score(score_range)
    local score_node = gui.get_node(GuiConst.nodes.score)
    local prev_score = tonumber(gui.get_text(score_node))
    local new_score = prev_score + score_range
    local elapsed_time = 0

    if score_range == 0 then
        gui.set_text(score_node, 0)
        return
    end


    timer.delay(ScoringConfig.duration / score_range, true, function (self, handle, dt)
        elapsed_time = elapsed_time + dt
    
        local remaining_time = math.max(ScoringConfig.duration - elapsed_time, 0)
        local current_score = math.modf(new_score - remaining_time * score_range)
    
        gui.set_text(score_node, current_score)

        if current_score == new_score then
            timer.cancel(handle)
        end
    end)
end

return GuiScoringSystem
