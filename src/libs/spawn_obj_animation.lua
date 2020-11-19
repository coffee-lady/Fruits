local config = require('src.config.config_app')
local random_service = require('src.modules.random_service.random_service')

local object_config = config.spawn_objects.object

local random_arr = random_service.random_arr

local AnimationLib = {}

function AnimationLib:animate_scale()
	local scale = go.get('#sprite', 'scale')
	scale = scale - random_arr(object_config.d_scale_bounds) * scale
	go.animate(go.get_id(), 'scale', go.PLAYBACK_ONCE_FORWARD, scale, go.EASING_LINEAR, random_arr(object_config.scale_duration_bounds))
end

function AnimationLib:animate_rotation()
	local rotation_angle = math.random() >= 0.5 and 360 or -360
	go.animate(go.get_id(), 'euler.z', go.PLAYBACK_LOOP_FORWARD, rotation_angle, go.EASING_LINEAR, random_arr(object_config.rotation_duration_bounds))
end

return AnimationLib
