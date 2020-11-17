local rendercam = require('rendercam.rendercam')

local window_service = {
    start_coords = nil,
    end_coords = nil,
    sizes = {}
}

-- local function window_callback(self, event)
--     if event == window.WINDOW_EVENT_RESIZED then
--         self:update()
--     end
-- end

-- function window_service:init()
--     self:update()
--     window.set_listener(window_callback)
-- end

function window_service:update()
    -- self.start_coords = rendercam.screen_to_world_2d(0, 0, false)
    -- self.end_coords = rendercam.screen_to_world_2d(rendercam.window.x, rendercam.window.y, false)
    -- self.sizes = rendercam.screen_to_world_2d(rendercam.window.x, rendercam.window.y, true)

    -- print(self.sizes)
    local window_coords = rendercam.window
    self.start_coords = vmath.vector3(-window_coords.x / 2, -window_coords.y / 2, 0)
    self.end_coords = vmath.vector3(window_coords.x / 2, window_coords.y / 2, 0)
    self.sizes.x, self.sizes.y = window_coords.x, window_coords.y
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
