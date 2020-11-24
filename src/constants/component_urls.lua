local ComponentUrls = {
    main = {},
    scenes = {},
    popups = {},
}

ComponentUrls.main = {
    gui = 'main#gui',
}

ComponentUrls.scenes.game = {
    factory = '/spawn_objects_factory#spawn_obj_factory',
}

ComponentUrls.popups.game_end = {
    gui = '/popup_game_end#popup_game_end',
}

return ComponentUrls
