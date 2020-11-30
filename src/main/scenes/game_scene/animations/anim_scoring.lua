local App = require('src.app')

local Config = App.config
local Services = App.services

local ScoringAnimConf = Config.gui.scenes.game.score_animation

local LabelAnim = ScoringAnimConf.label
local LabelAboveObjAnim = ScoringAnimConf.label_above_obj

local coords = Services.screen:get_sizes()
local center_coords = coords / 2

local ScoringAnimations = {}

function ScoringAnimations:init(best_score_node, score_node, best_score)
    self.best_score_node = best_score_node
    self.score_node = score_node
    self.best_score = best_score
    self.is_score_label_animating = false
end

function ScoringAnimations:animate_scale_label(node)
    if self.is_score_label_animating then return end

    self.is_score_label_animating = true

    gui.animate(node, gui.PROP_SCALE, LabelAnim.scale, gui.EASING_INCUBIC, LabelAnim.duration, 0, function ()
        self.is_score_label_animating = false
    end, gui.PLAYBACK_ONCE_PINGPONG)
end

function ScoringAnimations:animate_scale_label_above_obj(node)
    gui.animate(node, gui.PROP_SCALE, LabelAboveObjAnim.scale,
                gui.EASING_INQUART, LabelAboveObjAnim.duration, 0, nil,
                gui.PLAYBACK_ONCE_BACKWARD)
end

function ScoringAnimations:animate_label_above_obj_color(node)
    gui.animate(node, gui.PROP_COLOR, LabelAboveObjAnim.color,
                gui.EASING_INQUART, LabelAboveObjAnim.duration, 0, nil,
                gui.PLAYBACK_ONCE_FORWARD)
end

function ScoringAnimations:animate_scoring(new_score, is_combo)
    local prev_score = tonumber(gui.get_text(self.score_node))
    local score_range = new_score - prev_score
    local elapsed_time = 0

    if is_combo then
        local combo_node = gui.new_text_node(center_coords, 'Combo! +' .. score_range)
        gui.set_scale(combo_node, ScoringAnimConf.combo.font_scale)

        local rot_min, rot_max = ScoringAnimConf.combo.rotation_bounds[1], ScoringAnimConf.combo.rotation_bounds[2]
        gui.set_rotation(combo_node, vmath.vector4(0, 0, math.random(rot_min, rot_max), 0))

        gui.animate(combo_node, gui.PROP_COLOR, ScoringAnimConf.combo.color, gui.EASING_INCUBIC, ScoringAnimConf.combo.duration, 0, nil, gui.PLAYBACK_LOOP_FORWARD)

        timer.delay(ScoringAnimConf.combo.duration, false, function ()
            gui.delete_node(combo_node)
        end)
    end

    if score_range == 0 then
        gui.set_text(self.score_node, 0)
        return
    end

    timer.delay(LabelAnim.duration / score_range, true, function (_, handle, dt)
        elapsed_time = elapsed_time + dt

        local remaining_time = math.max((LabelAnim.duration - elapsed_time) / LabelAnim.duration, 0)
        local current_score = math.modf(new_score - remaining_time * score_range)

        if current_score > self.best_score then
            self.best_score = current_score
            gui.set_text(self.best_score_node, 'Best: ' .. self.best_score)
        end

        gui.set_text(self.score_node, current_score)

        if current_score == new_score then
            timer.cancel(handle)
            self:animate_scale_label(self.score_node)
        end
    end)
end

function ScoringAnimations:animate_scoring_above_obj(obj, score_range)
    local pos = obj.pos

    local text_node = gui.new_text_node(pos, '+' .. score_range)

    local rot_min, rot_max = LabelAboveObjAnim.rotation_bounds[1], LabelAboveObjAnim.rotation_bounds[2]
    gui.set_rotation(text_node, vmath.vector4(0, 0, math.random(rot_min, rot_max), 0))

    gui.set_scale(text_node, LabelAboveObjAnim.font_scale)

    self:animate_label_above_obj_color(text_node)
    self:animate_scale_label_above_obj(text_node)

    timer.delay(LabelAboveObjAnim.duration, false, function ()
        gui.delete_node(text_node)
    end)
end

return ScoringAnimations
