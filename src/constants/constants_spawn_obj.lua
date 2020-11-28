local SpawnObjConstants = {}

SpawnObjConstants = {
    banana = {
        class_id = 'banana',
        sprite = 'banana',
        particles_color = vmath.vector4(1, 0.82, 0.12, 1),
        weight = 3,
        is_bomb = false,
        is_bonus_life = false,
    },

    black_berry_dark = {
        class_id = 'black_berry_dark',
        sprite = 'black-berry-dark',
        particles_color = vmath.vector4(0.18, 0.09, 0.31, 1),
        weight = 3,
        is_bomb = false,
        is_bonus_life = false,
    },

    black_berry_light = {
        class_id = 'black_berry_light',
        sprite = 'black-berry-light',
        particles_color = vmath.vector4(0.4, 0, 0.5, 1),
        weight = 3,
        is_bomb = false,
        is_bonus_life = false,
    },

    black_cherry = {
        class_id = 'black_cherry',
        sprite = 'black-cherry',
        particles_color = vmath.vector4(0.4, 0, 0.5, 1),
        weight = 3,
        is_bomb = false,
        is_bonus_life = false,
    },

    coconut = {
        class_id = 'coconut',
        sprite = 'coconut',
        particles_color = vmath.vector4(0.42, 0.34, 0, 1),
        weight = 3,
        is_bomb = false,
        is_bonus_life = false,
    },

    green_apple = {
        class_id = 'green_apple',
        sprite = 'green-apple',
        particles_color = vmath.vector4(0.67, 0.78, 0.22, 1),
        weight = 3,
        is_bomb = false,
        is_bonus_life = false,
    },

    green_grape = {
        class_id = 'green_grape',
        sprite = 'green-grape',
        particles_color = vmath.vector4(0.53, 0.67, 0, 1),
        weight = 3,
        is_bomb = false,
        is_bonus_life = false,
    },

    lemon = {
        class_id = 'lemon',
        sprite = 'lemon',
        particles_color = vmath.vector4(1, 0.8, 0, 1),
        weight = 3,
        is_bomb = false,
        is_bonus_life = false,
    },

    lime = {
        class_id = 'lime',
        sprite = 'lime',
        particles_color = vmath.vector4(0.58, 0.72, 0, 1),
        weight = 3,
        is_bomb = false,
        is_bonus_life = false,
    },

    orange = {
        class_id = 'orange',
        sprite = 'orange',
        particles_color = vmath.vector4(1, 0.55, 0, 1),
        weight = 3,
        is_bomb = false,
        is_bonus_life = false,
    },

    peach = {
        class_id = 'peach',
        sprite = 'peach',
        particles_color = vmath.vector4(1, 0.63, 0.05, 1),
        weight = 3,
        is_bomb = false,
        is_bonus_life = false,
    },

    pear = {
        class_id = 'pear',
        sprite = 'pear',
        particles_color = vmath.vector4(0.63, 0.73, 0.2, 1),
        weight = 3,
        is_bomb = false,
        is_bonus_life = false,
    },

    plum = {
        class_id = 'plum',
        sprite = 'plum',
        particles_color = vmath.vector4(0.49, 0.3, 0.7, 1),
        weight = 3,
        is_bomb = false,
        is_bonus_life = false,
    },

    raspberry = {
        class_id = 'raspberry',
        sprite = 'raspberry',
        particles_color = vmath.vector4(0.59, 0, 0, 1),
        weight = 3,
        is_bomb = false,
        is_bonus_life = false,
    },

    red_apple = {
        class_id = 'red_apple',
        sprite = 'red-apple',
        particles_color = vmath.vector4(0.59, 0, 0, 1),
        weight = 3,
        is_bomb = false,
        is_bonus_life = false,
    },

    red_cherry = {
        class_id = 'red_cherry',
        sprite = 'red-cherry',
        particles_color = vmath.vector4(0.76, 0, 0, 1),
        weight = 3,
        is_bomb = false,
        is_bonus_life = false,
    },

    red_grape = {
        class_id = 'red_grape',
        sprite = 'red-grape',
        particles_color = vmath.vector4(0.68, 0.32, 0.32, 1),
        weight = 3,
        is_bomb = false,
        is_bonus_life = false,
    },

    star_fruit = {
        class_id = 'star_fruit',
        sprite = 'star-fruit',
        particles_color = vmath.vector4(1, 0.94, 0, 1),
        weight = 3,
        is_bomb = false,
        is_bonus_life = false,
    },

    strawberry = {
        class_id = 'strawberry',
        sprite = 'strawberry',
        particles_color = vmath.vector4(0.83, 0, 0, 1),
        weight = 3,
        is_bomb = false,
        is_bonus_life = false,
    },

    watermelon = {
        class_id = 'watermelon',
        sprite = 'watermelon',
        particles_color = vmath.vector4(0.26, 0.66, 0, 1),
        weight = 3,
        is_bomb = false,
        is_bonus_life = false,
    },

    bomb = {
        class_id = 'bomb',
        sprite = 'bomb',
        particles_color = 0,
        weight = 2,
        is_bomb = true,
        is_bonus_life = false,
    },

    bonus_life = {
        class_id = 'bonus_life',
        sprite = 'bonus_life',
        particles_color = 0,
        weight = 1,
        is_bomb = false,
        is_bonus_life = true,
    },

}

return SpawnObjConstants
