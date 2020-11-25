local Config = require('src.config.config')
local Constants = require('src.constants.constants')

local GamingLivesConfig = Config.player.gaming_lives
local GuiMsg = Constants.messages.gui
local ComponentUrls = Constants.component_urls

local GameSceneGui = ComponentUrls.scenes.game.gui

local GamingLivesSystem = {}

function GamingLivesSystem:init()
    self.current_lives = GamingLivesConfig.max_lives
    msg.post(msg.url(GameSceneGui), GuiMsg.gaming_lives.set)
end

function GamingLivesSystem:on_deleted_object()
    self.current_lives = self.current_lives - 1

    if self.current_lives == 0 and self.on_end_of_lives_cb then
        self.on_end_of_lives_cb()
    end

    msg.post(msg.url(GameSceneGui), GuiMsg.gaming_lives.decrease)
end

function GamingLivesSystem:on_end_of_lives(callback)
    if callback then
        self.on_end_of_lives_cb = callback
    end
end

return GamingLivesSystem
