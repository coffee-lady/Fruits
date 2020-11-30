local App = require('src.app')

local Config = App.config
local Constants = App.constants

local GamingLivesConfig = Config.player.gaming_lives
local GuiMsg = Constants.messages.gui
local ComponentUrls = Constants.component_urls

local GameSceneGui = ComponentUrls.scenes.game.gui

local GamingLivesSystem = {}

function GamingLivesSystem:init()
    self.current_lives = GamingLivesConfig.max_lives
    msg.post(msg.url(GameSceneGui), GuiMsg.gaming_lives.set)
end

function GamingLivesSystem:on_deleted_departed_object(obj)
    if obj and obj.is_bomb then return end

    self:on_deleted_object()
end

function GamingLivesSystem:on_deleted_object()
    self.current_lives = self.current_lives - 1

    if self.current_lives == 0 and self.on_end_of_lives_cb then
        self.on_end_of_lives_cb()
    end

    msg.post(msg.url(GameSceneGui), GuiMsg.gaming_lives.decrease)
end

function GamingLivesSystem:on_swiped_object(obj)
    if obj.is_bomb then
        self:on_deleted_object()
    end

    if obj.is_bonus_life and self.current_lives < GamingLivesConfig.max_lives then
        self.current_lives = self.current_lives + 1
        msg.post(msg.url(GameSceneGui), GuiMsg.gaming_lives.increase)
    end
end

function GamingLivesSystem:on_end_of_lives(callback)
    if callback then
        self.on_end_of_lives_cb = callback
    end
end

return GamingLivesSystem
