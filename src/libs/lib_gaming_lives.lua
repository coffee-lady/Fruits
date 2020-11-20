local Config = require('src.config.config_app')

local GamingLivesConfig = Config.player.gaming_lifes

-- todo

local GamingLivesLib = {
    max_lives = GamingLivesConfig.gaming_lifes,
    lives = self.max_lives,
    lives_gui_nodes = {}
}

function GamingLivesLib:init()
    for i = 1, max_lives do
        -- local node = gui.new_box_node(pos, size)
    end
end

return GamingLivesLib
