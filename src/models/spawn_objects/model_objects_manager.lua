local App = require('src.app')

local Config = App.config

local PackConfig = Config.spawn_objects.pack
local ZonesConfig = Config.spawn_objects.zones

local ObjectsManagerModel = {}

function ObjectsManagerModel:update_positions(objects, factory_id, min_coords, max_coords, dt)
	for i = 1, #objects do
		local obj = objects[i]
		obj.timer = obj.timer - dt
		if obj.id then
			if obj.pos.y >= max_coords.y - max_coords.y * ZonesConfig.top_padding then
				obj.speed.y = - PackConfig.gravity
			end

			obj.speed.y = obj.speed.y - PackConfig.gravity
			obj.pos.x = obj.pos.x + obj.speed.x * dt
			obj.pos.y = obj.pos.y + obj.speed.y * dt

			go.set_position(obj.pos, obj.id)

		elseif obj.timer <= 0 then
			obj:spawn(factory_id)
		end
	end
end

function ObjectsManagerModel:delete_object(obj_id, objects)
	for i = 1, #objects do
		local obj = objects[i]
		if obj and obj.id == obj_id then
			go.delete(obj_id)
			table.remove(objects, i)
		end
	end
end

function ObjectsManagerModel:delete_departed_objects(objects, min_coords)
	for i = 1, #objects do
		local obj = objects[i]
		if obj and obj.id and obj.pos.y < min_coords.y then
			go.delete(obj.id)
			table.remove(objects, i)
			if self.on_deleted_departed_object then self.on_deleted_objects_callback(obj) end
		end
	end
end

function ObjectsManagerModel:on_deleted_departed_object(callback)
	self.on_deleted_objects_callback = callback
end

return ObjectsManagerModel
