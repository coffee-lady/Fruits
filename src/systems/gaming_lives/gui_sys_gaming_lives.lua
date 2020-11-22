local Constants = require('src.constants.constants')
local Models = require('src.models.models')

local GamingLivesGuiModel = Models.player.gaming_lives_gui

local GLMsg = Constants.messages.gui.gaming_lives

local GamingLivesGuiSystem = {}

function GamingLivesGuiSystem:init()
    self.manager = GamingLivesGuiModel:new()
end

function GamingLivesGuiSystem:on_message(message_id, message, sender)
    if message_id == hash(GLMsg.set) then
        self.manager:set()
    end

    if message_id == hash(GLMsg.restore) then
        self.manager:restore()
    end

    if message_id == hash(GLMsg.increase) then
        self.manager:increase()
    end

    if message_id == hash(GLMsg.decrease) then
        self.manager:decrease()
    end
end

return GamingLivesGuiSystem
