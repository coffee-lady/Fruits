local ScoringAnimation = {}

function ScoringAnimation:animate_scale(score_node)
    local scale = 1.3
    local duration = 0.3
    gui.animate(score_node, gui.PROP_SCALE, vmath.vector3(scale, scale, 0), gui.EASING_INOUTQUAD, duration, 0, nil, gui.PLAYBACK_ONCE_FORWARD)
    gui.animate(score_node, gui.PROP_SCALE, vmath.vector3(scale, scale, 0), gui.EASING_INOUTQUAD, duration, 0, nil, gui.PLAYBACK_ONCE_BACKWARD)
end

return ScoringAnimation
