local Config = require('src.config.config')
local Constants = require('src.constants.constants')

local GamingLivesConfig = Config.player.gaming_lives

local GLMsg = Constants.messages.gui.gaming_lives
local GuiConst = Constants.gui

local NODE_SIZE = vmath.vector3(GamingLivesConfig.size, GamingLivesConfig.size, 0)

local GamingLivesGuiSystem = {}

function GamingLivesGuiSystem:init()
    self.lives_nodes = {}
end

function GamingLivesGuiSystem:update(dt)

end

local function create_node(pos)
    local node = gui.new_box_node(pos, NODE_SIZE)

    gui.set_texture(node, GuiConst.gaming_lives.texture)
    gui.play_flipbook(node, GuiConst.gaming_lives.anim)

    gui.set_xanchor(node, gui.ANCHOR_RIGHT)
    gui.set_yanchor(node, gui.ANCHOR_TOP)

    gui.set_enabled(node, true)
    return node
end

function GamingLivesGuiSystem:on_message(message_id, message, sender)
    local gui_width, gui_height = gui.get_width(), gui.get_height()

    if message_id == hash(GLMsg.restore) then
        local pos = vmath.vector3(0, 0, 0)
        pos.x = gui_width - gui_width * GamingLivesConfig.rel_pos_end.x 
        pos.y = gui_height - gui_height * GamingLivesConfig.rel_pos_end.y

        for i = 1, GamingLivesConfig.max_lives do
            local node = create_node(pos)
            self.lives_nodes[i] = node
            pos.x = pos.x - gui.get_size(node).x - GamingLivesConfig.rel_pos_between * gui_width
        end
    end

    if message_id == hash(GLMsg.increase) then
        local pos = gui.get_position(self.lives_nodes[#self.lives_nodes])
        self.lives_nodes[#self.lives_nodes + 1] = create_node(pos, NODE_SIZE)
    end

    if message_id == hash(GLMsg.decrease) then
        gui.delete_node(self.lives_nodes[#self.lives_nodes])
        table.remove(self.lives_nodes)
    end
end

return GamingLivesGuiSystem
