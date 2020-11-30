local ZonesConfig = {
    top_padding = 0.1,
    zones = { {
        spawn_angles = { 30, 60 },
        rel_coords_start = vmath.vector3(0, 0.1, 0),
        rel_coords_end = vmath.vector3(1, 0.3, 0),
        weight = 2,
    },
    {
        spawn_angles = { 60, 120 },
        rel_coords_start = vmath.vector3(0.3, 0, 0),
        rel_coords_end = vmath.vector3(0.3, 1, 0),
        weight = 4,
    },
    {
        spawn_angles = { 120, 150 },
        rel_coords_start = vmath.vector3(1, 0.1, 0),
        rel_coords_end = vmath.vector3(0, 0.3, 0),
        weight = 2,
    }, }
}

return ZonesConfig
