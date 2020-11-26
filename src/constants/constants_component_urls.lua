local ComponentUrls = {
    scenes = {},
    popups = {},
}

ComponentUrls.scenes.start = {
    gui_nodes = {
        button_start = 'button_start',
        best_score = 'best_score',
    }
}

ComponentUrls.scenes.game = {
    factory = '/game_scene#spawn_obj_factory',
    gui = '/game_scene#gui',
    root = 'game_scene:/game_scene',
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
