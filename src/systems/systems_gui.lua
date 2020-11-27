local GamingLivesGuiSys = require('src.systems.gaming_lives.gui_sys_gaming_lives')
local ScoringGuiSys = require('src.systems.scoring.gui_sys_scoring')

local GuiSystem = {}

function GuiSystem:init()
    GamingLivesGuiSys:init()
    ScoringGuiSys:init()
end

function GuiSystem:update(dt)

end

function GuiSystem:on_message(message_id, message, sender)
    GamingLivesGuiSys:on_message(message_id, message, sender)
    ScoringGuiSys:on_message(message_id, message, sender)
end

function GuiSystem:on_input(action_id, action)

end

return GuiSystem
