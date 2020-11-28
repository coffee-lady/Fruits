local transitions = require('monarch.transitions.gui')
local monarch = require('monarch.monarch')
local ScreenService = require('src.services.screen.screen')

local ScenesTransitionsService = {}

ScenesTransitionsService.transitions = {
    slide_in_right = transitions.slide_in_right,
    slide_in_left = transitions.slide_in_left,
    slide_in_top = transitions.slide_in_top,
    slide_in_bottom = transitions.slide_in_bottom,
    slide_out_right = transitions.slide_out_right,
    slide_out_left = transitions.slide_out_left,
    slide_out_top = transitions.slide_out_top,
    slide_out_bottom = transitions.slide_out_bottom,
    scale_in = transitions.scale_in,
    scale_out = transitions.scale_out,
    fade_in = transitions.fade_in,
    fade_out = transitions.fade_out,
}

function ScenesTransitionsService.init(self, node)
    self.transition = transitions.create(node)
    monarch.add_listener(msg.url())
    ScreenService:add_listener(msg.url())
end

function ScenesTransitionsService.show_in(self, transition, easing, duration, delay)
	self.transition.show_in(transition, easing, duration, delay)
end

function ScenesTransitionsService.show_out(self, transition, easing, duration, delay)
	self.transition.show_out(transition, easing, duration, delay)
end

function ScenesTransitionsService.back_in(self, transition, easing, duration, delay)
	self.transition.back_in(transition, easing, duration, delay)
end

function ScenesTransitionsService.back_out(self, transition, easing, duration, delay)
	self.transition.back_out(transition, easing, duration, delay)
end

function ScenesTransitionsService.final()
    monarch.remove_listener(msg.url())
    ScreenService:remove_listener(msg.url())
end

function ScenesTransitionsService.on_message(self, message_id, message, sender)
    self.transition.handle(message_id, message, sender)
end

return ScenesTransitionsService
