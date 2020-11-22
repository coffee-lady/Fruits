local rendercam = require('rendercam.rendercam')

local ScreenLib = {
    start_coords = nil,
    end_coords = nil,
    sizes = {},
    update_delay = 0.05
}

function ScreenLib:init(callback)
    self.url = msg.url()
    rendercam.add_window_listener(self.url)

    timer.delay(self.update_delay, false, function ()
        self:update()
        if callback then
            callback()
        end
    end)
end

function ScreenLib:on_resize(callback)
    timer.delay(self.update_delay, false, function ()
        self:update()
        if callback then
            callback()
        end
    end)
end

function ScreenLib:update()
    self.start_coords = rendercam.screen_to_world_2d(0, 0, false)
    self.end_coords = rendercam.screen_to_world_2d(rendercam.window.x, rendercam.window.y, false)
    self.sizes = rendercam.screen_to_world_2d(rendercam.window.x, rendercam.window.y, true)
end

function ScreenLib:get_sizes()
    return self.sizes.x
end

function ScreenLib:get_coords()
    return self.start_coords, self.end_coords
end

return ScreenLib
