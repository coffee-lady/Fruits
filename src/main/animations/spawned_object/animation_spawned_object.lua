local Libs = require('src.libs.libs')
local Config = require('src.config.config')

local ObjectConfig = Config.spawn_objects.object
local RandomLib = Libs.random

local random_arr = RandomLib.random_arr

local SpawnedObjectAnimation = {}

function SpawnedObjectAnimation:animate_scale()
	local scale = go.get('#sprite', 'scale')
	scale = scale - random_arr(ObjectConfig.d_scale_bounds) * scale
	go.animate(go.get_id(), 'scale', go.PLAYBACK_ONCE_FORWARD, scale, go.EASING_LINEAR, random_arr(ObjectConfig.scale_duration_bounds))
end

function SpawnedObjectAnimation:animate_rotation()
	local rotation_angle = math.random() >= 0.5 and 360 or -360
	go.animate(go.get_id(), 'euler.z', go.PLAYBACK_LOOP_FORWARD, rotation_angle, go.EASING_LINEAR, random_arr(ObjectConfig.rotation_duration_bounds))
end

return SpawnedObjectAnimation
