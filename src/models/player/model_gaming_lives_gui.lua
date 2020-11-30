local App = require('src.app')
local Config = App.config
local Constants = App.constants

local GamingLivesConfig = Config.player.gaming_lives

local GuiConst = Constants.gui

local NODE_SIZE = vmath.vector3(GamingLivesConfig.size, GamingLivesConfig.size, 0)
local ANIM_FULL = GuiConst.gaming_lives.anim_full
local ANIM_EMPTY = GuiConst.gaming_lives.anim_empty

local GamingLivesGuiModel = {}

function GamingLivesGuiModel:new()
    local data = {
        lives_nodes = {},
        full_lives = GamingLivesConfig.max_lives,
        gui_width = gui.get_width(),
        gui_height = gui.get_height(),
    }

    self.__index = self
    return setmetatable(data, self)
end

function GamingLivesGuiModel:create_node(pos)
    local node = gui.new_box_node(pos, NODE_SIZE)

    gui.set_texture(node, GuiConst.gaming_lives.texture)
    gui.play_flipbook(node, ANIM_FULL)

    gui.set_xanchor(node, gui.ANCHOR_RIGHT)
    gui.set_yanchor(node, gui.ANCHOR_TOP)

    return node
end

function GamingLivesGuiModel:restore()
    for i = self.full_lives + 1, GamingLivesConfig.max_lives do
        gui.play_flipbook(self.lives_nodes[i], ANIM_FULL)
    end
    self.full_lives = GamingLivesConfig.max_lives
end

function GamingLivesGuiModel:set()
    local pos = vmath.vector3(0, 0, 0)
    pos.x = self.gui_width - self.gui_width * GamingLivesConfig.rel_pos_end.x 
    pos.y = self.gui_height - self.gui_height * GamingLivesConfig.rel_pos_end.y

    for i = 1, GamingLivesConfig.max_lives do
        local node = self:create_node(pos)
        self.lives_nodes[i] = node
        pos.x = pos.x - gui.get_size(node).x - GamingLivesConfig.rel_pos_between * self.gui_width
    end
end

function GamingLivesGuiModel:increase()
    self.full_lives = self.full_lives + 1
    gui.play_flipbook(self.lives_nodes[self.full_lives], ANIM_FULL)
end

function GamingLivesGuiModel:decrease()
    if self.full_lives <= 0 then return end

    gui.play_flipbook(self.lives_nodes[self.full_lives], ANIM_EMPTY)
    self.full_lives = self.full_lives - 1
end

return GamingLivesGuiModel
