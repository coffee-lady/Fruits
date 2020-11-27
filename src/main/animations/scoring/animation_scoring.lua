local ScoringAnimation = {}

function ScoringAnimation:animate_scale(score_node)
    gui.animate(score_node, gui.PROP_SCALE, vmath.vector3(1.3, 1.3, 0), gui.EASING_INOUTQUAD, 0.3, 0, nil, gui.PLAYBACK_ONCE_FORWARD)
    gui.animate(score_node, gui.PROP_SCALE, vmath.vector3(1.3, 1.3, 0), gui.EASING_INOUTQUAD, 0.3, 0, nil, gui.PLAYBACK_ONCE_BACKWARD)
end

return ScoringAnimation
