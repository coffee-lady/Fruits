local ComponentUrls = {
    scenes = {},
    popups = {},
}

ComponentUrls.scenes.start = {
    gui_nodes = {
        button_start = 'button_start',
        best_score = 'best_score',
        slice_lemon = 'slice_lemon',
        lemon_particlefx = 'lemon_particlefx',
    }
}

ComponentUrls.scenes.game = {
    factory = '/game_scene#spawn_obj_factory',
    gui = '/game_scene#gui',
    root = 'game_scene:/game_scene',
    gui_nodes = {
        current_score = 'score',
        best_score = 'best_score',
    }
}

ComponentUrls.popups.game_end = {
    gui = '/popup_game_end#gui',
    gui_nodes = {
        button_home = 'button_home',
        button_restart = 'button_restart',
        current_score = 'current_score',
        best_score = 'best_score',
    }
}

return ComponentUrls
