local ScoringAnimation = {}

function ScoringAnimation:animate_scale(score_node, scale, duration)
    gui.animate(score_node, gui.PROP_SCALE, vmath.vector3(scale, scale, 1), gui.EASING_INOUTQUAD, duration, 0, nil, gui.PLAYBACK_ONCE_PINGPONG)
end

return ScoringAnimation
