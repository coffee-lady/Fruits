local App = require('src.app')

local Config = App.config

local ComboConfig = Config.spawn_objects.combo

local ComboSwipeModel = {}

function ComboSwipeModel:init()
    self.swiped_count = 0
end

function ComboSwipeModel:on_swipe(obj)
    if obj.is_bomb or obj.is_bonus_life then return end

    self.swiped_count = self.swiped_count + 1

    if self.timer then timer.cancel(self.timer) end

    self.timer = timer.delay(ComboConfig.combo_interval, false, function ()
        if self.callback and self.swiped_count > ComboConfig.min_combo_count then
            self.callback(self.swiped_count)
        end

        self.swiped_count = 0
    end)
end

function ComboSwipeModel:on_combo_swipe_callback(callback)
    self.callback = callback
end

return ComboSwipeModel
