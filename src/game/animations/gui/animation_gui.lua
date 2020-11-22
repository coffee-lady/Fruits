local Libs = require('src.libs.libs')
local Config = require('src.config.config')
local Constants = require('src.constants.constants')

local Models = require('src.models.models')

local GuiConst = Constants.gui

local GuiAnimation = {}

function GuiAnimation:animate_score()
    local score_node = gui.get_node(GuiConst.nodes.score)
end

return GuiAnimation
