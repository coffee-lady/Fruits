local GuiService = {}

function GuiService:update_text(node_id, text)
    local node = gui.get_node(node_id)
    gui.set_text(node, text)
end

return GuiService
