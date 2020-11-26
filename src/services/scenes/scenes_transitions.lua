local Constants = require('src.constants.constants')
local transitions = require('monarch.transitions.gui')

local MsgConst = Constants.messages

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

function ScenesTransitionsService.on_message(self, message_id, message, sender)
    self.transition.handle(message_id, message, sender)

    if message_id == hash(MsgConst.screen.on_update) then
        print(message.width, message.height)
		self.transition.window_resized(message.width, message.height)
	end
end

return ScenesTransitionsService
