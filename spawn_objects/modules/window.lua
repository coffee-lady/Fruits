local rendercam = require('rendercam.rendercam')

local window_module = {}

function window_module.get_sizes()
    return rendercam.window.x, rendercam.window.y
end

function window_module.get_coords()
    local max_x = rendercam.window.x / 2
    local max_y = rendercam.window.y / 2
    local min_x = -max_x
    local min_y = -max_y
    return min_x, min_y, max_x, max_y
end

function window_module.get_max_x()
    return rendercam.window.x / 2
end

function window_module.get_max_y()
    return rendercam.window.y / 2
end

function window_module.get_min_x()
    return -rendercam.window.x / 2
end

function window_module.get_min_y()
    return -rendercam.window.y / 2
end

return window_module
