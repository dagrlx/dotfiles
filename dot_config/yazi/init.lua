-- Barra de estado actualizada usando children_add para mostrar propietario y grupo del archivo
-- Mostrar propietario y grupo del archivo
Status:children_add(function()
    local h = cx.active.current.hovered
    if h == nil or ya.target_family() ~= "unix" then
        return ui.Line {}
    end

    return ui.Line {
        ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
        ui.Span(":"),
        ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
        ui.Span(" "),
    }
end, 400, Status.RIGHT)

-- Mostrar fecha y hora de la última modificación
Status:children_add(function()
    local h = cx.active.current.hovered
    if h == nil then
        return ui.Line {}
    end

    local last_modified_time = os.date("%d-%m-%Y %H:%M:%S", h.cha.mtime)
    return ui.Line {
        ui.Span(last_modified_time):fg("cyan"),
        ui.Span(" "),
    }
end, 500, Status.RIGHT)

-- Mostrar nombre del archivo y enlace simbólico si existe
--Status:children_add(function()
--    local h = cx.active.current.hovered
--    if not h then
--        return ui.Span("")
--    end

--    local linked = ""
--    if h.link_to ~= nil then
--        linked = " -> " .. tostring(h.link_to)
--    end
--    return ui.Span(" " .. h.name .. linked)
--end, 300, Status.LEFT)
--

--This plugin provides cross-instance yank ability, which means you can yank files in one instance, and then paste them in another instance.
require("session"):setup {
	sync_yanked = true,
}

--zoxide now supports the new update_db feature, which automatically adds Yazi's CWD to zoxide when navigating
require("zoxide"):setup {
    update_db = true,
}
