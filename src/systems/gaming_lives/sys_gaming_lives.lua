local Libs = require('src.libs.libs')
local Config = require('src.config.config')
local Constants = require('src.constants.constants')

local GamingLivesConfig = Config.player.gaming_lives
local GuiMsg = Constants.messages.gui
local ComponentUrls = Constants.component_urls

local GamingLivesSystem = {}

function GamingLivesSystem:init()
    self.current_lives = GamingLivesConfig.max_lives
    msg.post(ComponentUrls.main_gui, GuiMsg.gaming_lives.restore)
end

function GamingLivesSystem:on_deleted_object()
    self.current_lives = self.current_lives - 1
    msg.post(ComponentUrls.main_gui, GuiMsg.gaming_lives.decrease)

    if self.current_lives == 0 then
        msg.post(ComponentUrls.main_gui, GuiMsg.gaming_lives.restore)
        self.current_lives = GamingLivesConfig.max_lives
    end
end

return GamingLivesSystem
