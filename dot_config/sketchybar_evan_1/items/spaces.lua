local colors = require("colors")
local icons = require("icons")

local function print_table(t)
	for k, v in pairs(t) do
		print(k, v)
	end
end
-- Function to execute a shell command and capture its output
local function exec_command(cmd)
	-- Attempt to open the command
	local handle = io.popen(cmd)

	-- Check if the handle is not nil
	if not handle then
		return nil, "Failed to open command: " .. cmd
	end

	-- Attempt to read the output
	local result = handle:read("*a")

	-- Close the handle
	handle:close()

	-- Check if the result is not nil
	if not result then
		return nil, "Failed to read output from command: " .. cmd
	end

	return result
end

-- Function to get the focused workspace
local function get_focused_workspace()
	local command = "aerospace list-workspaces --focused"
	local result = exec_command(command)
	return result:match("^%s*(.-)%s*$") -- Trim leading and trailing whitespace
end

-- Function to get the focused workspace (Obtiene las ventanas abiertas en un espacio de trabajo específico.)
local function get_windows_for_workspace(workspace)
	local command = "aerospace list-windows --workspace " .. workspace .. " | awk -F '|' '{print $2}'"
	local result = exec_command(command)
	local windows = {}
	for id in string.gmatch(result, "([^\n]+)") do
		table.insert(windows, id)
	end
	return windows
end

-- Function to get the focused workspace (Obtiene los identificadores de todos los espacios de trabajo.)
local function get_window_ids()
	local command = "aerospace list-workspaces --all"
	local result = exec_command(command)
	local workspace_ids = {}
	for id in string.gmatch(result, "([^\n]+)") do
		table.insert(workspace_ids, id)
	end
	return workspace_ids
end

local current_space = get_focused_workspace()

sbar.add("event", "aerospace_workspace_change")

local space = sbar.add("item", {
	icon = {
		string = current_space,
		padding_right = 8,
		padding_left = 8,
	},
	label = { drawing = false },
	background = {
		color = colors.bg2,
		border_color = colors.black,
		border_width = 1,
	},
	padding_left = 1,
	padding_right = 1,
	click_script = "aerospace workspace " .. current_space,
	script = "$CONFIG_DIR/helpers/aerospace.sh " .. current_space,
})

-- Double border for apple using a single item bracket
sbar.add("bracket", { space.name }, {
	background = {
		color = colors.transparent,
		height = 30,
		border_color = colors.grey,
	},
})

space:subscribe("aerospace_workspace_change", function(env)
	print_table(env)
	space:set({ icon = { string = env.FOCUSED_WORKSPACE } })
end)

local spaces_indicator = sbar.add("item", {
	padding_right = 0,
	icon = {
		padding_left = 8,
		padding_right = 9,
		color = colors.grey,
		string = icons.switch.on,
	},
	label = {
		width = 0,
		padding_left = 0,
		color = colors.bg1,
	},
	background = {
		color = colors.with_alpha(colors.grey, 0.0),
		border_color = colors.with_alpha(colors.bg1, 0.0),
	},
})

spaces_indicator:subscribe("swap_menus_and_spaces", function(env)
	local currently_on = spaces_indicator:query().icon.value == icons.switch.on
	spaces_indicator:set({
		icon = currently_on and icons.switch.off or icons.switch.on,
	})
end)

spaces_indicator:subscribe("mouse.entered", function(env)
	sbar.animate("tanh", 15, function()
		spaces_indicator:set({
			background = {
				color = { alpha = 1.0 },
				border_color = { alpha = 1.0 },
			},
			icon = { color = colors.bg1 },
		})
	end)
end)

spaces_indicator:subscribe("mouse.exited", function(env)
	sbar.animate("tanh", 15, function()
		spaces_indicator:set({
			background = {
				color = { alpha = 0.0 },
				border_color = { alpha = 0.0 },
			},
			icon = { color = colors.grey },
			label = { width = 0 },
		})
	end)
end)

spaces_indicator:subscribe("mouse.clicked", function(env)
	sbar.trigger("swap_menus_and_spaces")
end)
