local MessagesConstants = {
	gui = {
		gaming_lives = {},
		scoring = {},
	},
	spawned_object = {},
	screen = {},
}

MessagesConstants.gui.scoring.set = 'set_score'

MessagesConstants.gui.gaming_lives.set = 'set_gaming_lives'
MessagesConstants.gui.gaming_lives.restore = 'restore_gaming_lives'
MessagesConstants.gui.gaming_lives.increase = 'increase_gaming_lives'
MessagesConstants.gui.gaming_lives.decrease = 'decrease_gaming_lives'

MessagesConstants.spawned_object.play_swipe_animation = 'play_swipe_animation'
MessagesConstants.spawned_object.set_play_anim = 'set_play_anim'
MessagesConstants.spawned_object.delete_swiped = 'delete_swiped_obj'

MessagesConstants.screen.on_update = 'window_update'

return MessagesConstants
