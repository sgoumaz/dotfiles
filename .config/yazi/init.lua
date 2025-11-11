-- TODO:
-- - Use time_string() in file info (<tab>) (or make longer version)
-- - Make owner() function and use it in status and file info
-- - Recycle bin (plugin): https://github.com/uhs-robert/recycle-bin.yazi
-- - Show git status (plugin): https://github.com/yazi-rs/plugins/tree/main/vcs-files.yazi

-- HELPER FUNCTIONS

-- Better time formatting
local function time_string(time)
	local time = math.floor(time or 0)
    local date = os.date("*t", time)
	if time == 0 then
		return ""
	elseif os.date("%Y", time) == os.date("%Y") then
		return string.format("%2d %s %02d:%02d", date.day, os.date("%b", time), date.hour, date.min)
	else
        return ui.Line { ui.Span(string.format("%2d %s", date.day, os.date("%b", time))):dim(), string.format(" %d ", date.year) }
	end
end

-- Owner
local function owner()
	local h = cx.active.current.hovered
	if not h or not h.cha.uid or not h.cha.gid then
		return ui.Span("")
	end

	local user = ya.user_name(h.cha.uid) or h.cha.uid
	local group = ya.group_name(h.cha.gid) or h.cha.gid

	return ui.Line(string.format("%s:%s ", user, group))
end

-- CUSTOMISE LINE MODE

-- Show size and modified time
function Linemode:size_and_mtime()
	local size = self._file:size()
    local size_s
    if size then
		size_s = ya.readable_size(size)
	else
		local folder = cx.active:history(self._file.url)
		size_s = folder and ui.Line { ui.Span("󰙅"):dim(), tostring(#folder.files) } or ""
	end

	local time_s = time_string(self._file.cha.mtime)

	return ui.Line { size_s, "  ", time_s }
end

-- CUSTOMISE STATUS BAR

-- Show full file name
function Status:name()
	local h = self._tab.current.hovered
	if not h then
		return ui.Line({})
	end

	return ui.Line(" " .. tostring(h.url))
end
Status:children_remove(2, Status.LEFT) -- size
Status:children_remove(5, Status.RIGHT) -- percentage
-- Show owner
Status:children_add(function()
	local h = cx.active.current.hovered
	if not h or ya.target_family() ~= "unix" then
		return ""
	end

	return ui.Line {
		" ",
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("yellow"),
		ui.Span(":"):dim(),
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("yellow"),
		" ",
	}
end, 1100, Status.RIGHT)
-- Show symlink
Status:children_add(function(self)
	local h = self._current.hovered
	if h and h.link_to then
		return " -> " .. tostring(h.link_to)
	else
		return ""
	end
end, 3300, Status.LEFT)

-- PLUGINS

require("full-border"):setup()
