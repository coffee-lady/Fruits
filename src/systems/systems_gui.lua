local GamingLivesGuiSys = require('src.systems.gaming_lives.gui_sys_gaming_lives')

local GuiSystem = {}

function GuiSystem:init()
    GamingLivesGuiSys:init()
end

function GuiSystem:update(dt)

end

function GuiSystem:on_message(message_id, message, sender)
    GamingLivesGuiSys:on_message(message_id, message, sender)
end

function GuiSystem:on_input(action_id, action)

end

return GuiSystem
