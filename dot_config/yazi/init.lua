function Status:owner()
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
end

-- Show user and hostname in top bar
function Header:host()
	if ya.target_family() ~= "unix" then
		return ui.Line {}
	end
	return ui.Line { ui.Span(ya.user_name() .. "@" .. ya.host_name()):fg("lightgreen"):bold(true), ui.Span(":") }
end

function Header:render(area)
	self.area = area

	local right = ui.Line { self:count(), self:tabs() }
	local left = ui.Line {
    self:host(),
    self:cwd(math.max(0, area.w - right:width())):fg("blue"),
    ui.Span("/"):fg("blue"):bold(true),
    ui.Span(tostring(cx.active.current.hovered.name)):fg("white"):bold(true),
  }
	return {
		ui.Paragraph(area, { left }),
		ui.Paragraph(area, { right }):align(ui.Paragraph.RIGHT),
	}
end

-- Show symlink path in status bar
function Status:name()
	local h = cx.active.current.hovered
	if not h then
		return ui.Span("")
	end

 	local linked = ""
 	if h.link_to ~= nil then
 		linked = " -> " .. tostring(h.link_to)
 	end
 	return ui.Span(" " .. h.name .. linked)
end

-- Remove file size from status bar
function Status:render(area)
	self.area = area

	local left = ui.Line { self:mode(), self:name() }
	local right = ui.Line { self:permissions(), self:position() }
	return {
		ui.Paragraph(area, { left }),
		ui.Paragraph(area, { right }):align(ui.Paragraph.RIGHT),
		table.unpack(Progress:render(area, right:width())),
	}
end


--This plugin provides cross-instance yank ability, which means you can yank files in one instance, and then paste them in another instance.
require("session"):setup {
	sync_yanked = true,
}

--zoxide now supports the new update_db feature, which automatically adds Yazi's CWD to zoxide when navigating
require("zoxide"):setup {
    update_db = true,
}


