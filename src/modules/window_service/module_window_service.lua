local rendercam = require('rendercam.rendercam')

local window_service = {
    start_coords = nil,
    end_coords = nil,
    sizes = {}
}

function window_service:update()
    self.start_coords = rendercam.screen_to_world_2d(0, 0, false)
    self.end_coords = rendercam.screen_to_world_2d(rendercam.window.x, rendercam.window.y, false)
    self.sizes = rendercam.screen_to_world_2d(rendercam.window.x, rendercam.window.y, true)
end

function window_service:get_sizes()
    self:update()

    return self.sizes.x, self.sizes.y
end

function window_service:get_coords()
    self:update()

    return self.start_coords.x, self.start_coords.y, self.end_coords.x, self.end_coords.y
end

return window_service
