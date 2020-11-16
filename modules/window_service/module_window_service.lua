local rendercam = require('rendercam.rendercam')

local window_service = {
    left_bottom_coords = {},
    right_top_coords = {},
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
    -- self.left_bottom_coords = rendercam.screen_to_world_2d(0, 0, false)
    -- self.right_top_coords = rendercam.screen_to_world_2d(rendercam.window.x, rendercam.window.y, false)
    -- self.sizes = rendercam.screen_to_world_2d(rendercam.window.x, rendercam.window.y, true)

    self.left_bottom_coords.x, self.left_bottom_coords.y = -rendercam.window.x / 2, -rendercam.window.y / 2
    self.right_top_coords.x, self.right_top_coords.y = rendercam.window.x / 2, rendercam.window.y / 2
    self.sizes.x, self.sizes.y = rendercam.window.x, rendercam.window.y
end

function window_service:get_sizes()
    self:update()

    return self.sizes.x, self.sizes.y
end

function window_service:get_coords()
    self:update()

    return self.left_bottom_coords.x, self.left_bottom_coords.y, self.right_top_coords.x, self.right_top_coords.y
end

return window_service
