local rendercam = require('rendercam.rendercam')

local CoordsLib = {}

function CoordsLib:is_point_in_segment(point, start_coord, end_coord)
    return point >= start_coord and point <= end_coord or point <= start_coord and point >= end_coord
end

function CoordsLib:is_point_in_circle(point, circle_coords, radius)
    point = rendercam.screen_to_world_2d(point.x, point.y, false)

    local is_in_seg_x = self:is_point_in_segment(point.x, circle_coords.x - radius, circle_coords.x + radius)
    local is_in_seg_y = self:is_point_in_segment(point.y, circle_coords.y - radius, circle_coords.y + radius)

    if is_in_seg_x and is_in_seg_y then
        return true
    end

    return false
end

function CoordsLib:set_padd_start(padding, min, max)
    return min + padding * (max - min)
end

function CoordsLib:set_padd_end(padding, min, max)
    return max - padding * (max - min)
end

function CoordsLib:get_vector_length(start_coords, end_coords)
    local dx = math.abs(start_coords.x - end_coords.x)
    local dy = math.abs(start_coords.y - end_coords.y)
	return math.sqrt(dx * dx + dy * dy)
end

function CoordsLib:get_vector_velocity(x, y)
	return math.sqrt(x * x + y * y)
end

return CoordsLib
