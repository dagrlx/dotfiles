local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

-- Commands to get information about monitors and workspaces
local LIST_MONITORS = "aerospace list-monitors | awk '{print $1}'"
local LIST_WORKSPACES = "aerospace list-workspaces --monitor %s"
local LIST_APPS = "aerospace list-windows --workspace %s | awk -F'|' '{gsub(/^ *| *$/, \"\", $2); print $2}'"
local LIST_CURRENT = "aerospace list-workspaces --focused"

local spaces = {}
local workspaceToMonitorMap = {}
local cachedMonitors = {}
local cachedWorkspaces = {}

-- Debugging function
local function log(message)
	print("[DEBUG] " .. message)
end

-- Function to get the icon for an application
local function getIconForApp(appName)
	return app_icons[appName] or app_icons["default"] or "?"
end

-- Function to update workspace icons
local function updateSpaceIcons(spaceId, workspaceName)
	log("Updating icons for space: " .. spaceId)
	sbar.exec(LIST_APPS:format(workspaceName), function(appsOutput)
		if not appsOutput then
			log("No apps found for workspace: " .. workspaceName)
			return
		end

		local icon_strip = ""
		local shouldDraw = false

		for app in appsOutput:gmatch("[^\r\n]+") do
			local appName = app:match("^%s*(.-)%s*$")
			if appName and appName ~= "" then
				icon_strip = icon_strip .. " " .. getIconForApp(appName)
				shouldDraw = true
			end
		end

		if spaces[spaceId] then
			spaces[spaceId].item:set({
				label = { string = icon_strip, drawing = shouldDraw },
			})
			log("Updated icons for space: " .. spaceId)
		else
			log("Warning: Space '" .. spaceId .. "' not found for icon update.")
		end
	end)
end

-- Function to add a workspace item
local function addWorkspaceItem(workspaceName, monitorId, isSelected)
	local spaceId = "workspace_" .. workspaceName .. "_" .. monitorId
	log("Adding workspace item: " .. spaceId)

	if not spaces[spaceId] then
		local space_item = sbar.add("item", spaceId, {
			icon = {
				font = { family = settings.font.numbers },
				string = workspaceName,
				padding_left = 12,
				padding_right = 12,
				color = colors.white,
				highlight_color = colors.yellow,
			},
			label = {
				padding_right = 14,
				padding_left = 0,
				color = colors.grey,
				highlight_color = colors.yellow,
				font = "sketchybar-app-font:Regular:12.0",
				y_offset = -1,
			},
			padding_left = 2,
			padding_right = 2,
			background = {
				color = colors.bg1,
				border_width = 1,
				height = 26,
				border_color = colors.grey,
				corner_radius = 9,
			},
			click_script = "aerospace workspace " .. workspaceName,
			display = monitorId,
		})

		local space_bracket = sbar.add("bracket", { spaceId }, {
			background = {
				color = colors.transparent,
				border_color = colors.transparent,
				height = 26,
				border_width = 1,
				corner_radius = 9,
			},
		})

		space_item:subscribe("mouse.clicked", function()
			sbar.exec("aerospace workspace " .. workspaceName)
		end)

		spaces[spaceId] = { item = space_item, bracket = space_bracket }
		workspaceToMonitorMap[workspaceName] = monitorId
		log("Created new workspace item: " .. spaceId)
	end

	spaces[spaceId].item:set({
		icon = { highlight = isSelected },
		label = { highlight = isSelected },
	})
	spaces[spaceId].bracket:set({
		background = { border_color = isSelected and colors.dirty_white or colors.transparent },
	})

	updateSpaceIcons(spaceId, workspaceName)
end

-- Function to remove a workspace item
local function removeWorkspaceItem(spaceId)
	log("Removing workspace item: " .. spaceId)
	if spaces[spaceId] then
		sbar.remove(spaces[spaceId].item)
		sbar.remove(spaces[spaceId].bracket)
		spaces[spaceId] = nil

		local workspaceName = spaceId:match("workspace_(.-)_%d+")
		if workspaceName then
			workspaceToMonitorMap[workspaceName] = nil
		end
		log("Removed workspace item: " .. spaceId)
	else
		log("Warning: Attempted to remove non-existent workspace item: " .. spaceId)
	end
end

-- Safe execution function
local function safeExec(command, callback)
	log("Executing command: " .. command)
	sbar.exec(command, function(output)
		if output then
			callback(output)
		else
			log("Warning: No output from command: " .. command)
		end
	end)
end

-- Function to get the list of monitors
local function getMonitors(callback)
	safeExec(LIST_MONITORS, function(monitorsOutput)
		local monitors = {}
		for monitor in monitorsOutput:gmatch("[^\r\n]+") do
			table.insert(monitors, monitor)
		end
		log("Detected monitors: " .. table.concat(monitors, ", "))
		callback(monitors)
	end)
end

-- Function to get the focused workspace
local function getFocusedWorkspace(callback)
	safeExec(LIST_CURRENT, function(focusedWorkspaceOutput)
		local focusedWorkspace = focusedWorkspaceOutput:match("[^\r\n]+")
		log("Focused workspace: " .. (focusedWorkspace or "None"))
		callback(focusedWorkspace)
	end)
end

-- Function to get and sort workspaces by monitor
local function getWorkspacesForMonitor(monitorId, callback)
	safeExec(LIST_WORKSPACES:format(monitorId), function(workspacesOutput)
		local workspaces = {}
		for workspaceName in workspacesOutput:gmatch("[^\r\n]+") do
			table.insert(workspaces, workspaceName)
		end
		table.sort(workspaces, function(a, b)
			return a:lower() < b:lower()
		end)
		log("Workspaces for monitor " .. monitorId .. ": " .. table.concat(workspaces, ", "))
		callback(workspaces)
	end)
end

-- Function to draw workspaces
local function drawWorkspaces(monitorList, focusedWorkspace)
	log("Drawing workspaces. Focused workspace: " .. (focusedWorkspace or "None"))
	local updatedSpaces = {}

	for _, monitorId in ipairs(monitorList) do
		getWorkspacesForMonitor(monitorId, function(workspaces)
			cachedWorkspaces[monitorId] = workspaces

			for _, workspaceName in ipairs(workspaces) do
				local spaceId = "workspace_" .. workspaceName .. "_" .. monitorId
				local isSelected = workspaceName == focusedWorkspace
				addWorkspaceItem(workspaceName, monitorId, isSelected)
				updatedSpaces[spaceId] = true
			end
		end)
	end

	-- Remove obsolete workspaces
	for spaceId in pairs(spaces) do
		if not updatedSpaces[spaceId] then
			removeWorkspaceItem(spaceId)
		end
	end
end

-- Cache validation function
local function isCacheValid(monitorList, focusedWorkspace)
	if #monitorList ~= #cachedMonitors then
		log("Cache invalid: Monitor count changed")
		return false
	end

	for i, monitorId in ipairs(monitorList) do
		if monitorId ~= cachedMonitors[i] or not cachedWorkspaces[monitorId] then
			log("Cache invalid: Monitor mismatch or missing workspaces")
			return false
		end
	end

	if focusedWorkspace ~= cachedWorkspaces.focusedWorkspace then
		log("Cache invalid: Focused workspace changed")
		return false
	end

	log("Cache valid")
	return true
end

-- Main function to draw spaces
local function drawSpaces()
	log("Drawing spaces")
	getMonitors(function(monitorList)
		getFocusedWorkspace(function(focusedWorkspace)
			if not isCacheValid(monitorList, focusedWorkspace) then
				drawWorkspaces(monitorList, focusedWorkspace)
				cachedMonitors = monitorList
				cachedWorkspaces.focusedWorkspace = focusedWorkspace
			else
				log("Using cached data for drawing spaces")
			end
		end)
	end)
end

drawSpaces()

local space_window_observer = sbar.add("item", {
	drawing = false,
	updates = true,
})

space_window_observer:subscribe({ "aerospace_workspace_change", "front_app_switched", "display_change" }, function()
	log("Event triggered: workspace change, app switch, or display change")
	drawSpaces()
end)

space_window_observer:subscribe("space_windows_change", function()
	log("Event triggered: space windows change")
	getMonitors(function(monitorList)
		for _, monitorId in ipairs(monitorList) do
			getWorkspacesForMonitor(monitorId, function(workspaces)
				for _, workspaceName in ipairs(workspaces) do
					local spaceId = "workspace_" .. workspaceName .. "_" .. monitorId
					updateSpaceIcons(spaceId, workspaceName)
				end
			end)
		end
	end)
end)

-- space_window_observer:subscribe("space_windows_change", function()
-- 	log("Event triggered: space windows change")
-- 	getFocusedWorkspace(function(focusedWorkspace)
-- 		if focusedWorkspace then
-- 			local monitorId = workspaceToMonitorMap[focusedWorkspace]
-- 			if monitorId then
-- 				local spaceId = "workspace_" .. focusedWorkspace .. "_" .. monitorId
-- 				updateSpaceIcons(spaceId, focusedWorkspace)
-- 			else
-- 				log("Warning: No monitor found for focused workspace: " .. focusedWorkspace)
-- 			end
-- 		else
-- 			log("Warning: No focused workspace found")
-- 		end
-- 		--	drawSpaces()
-- 	end)
-- end)

-- Indicator for swapping menus and spaces
local spaces_indicator = sbar.add("item", {
	padding_left = -3,
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
		padding_right = 8,
		string = "Spaces",
		color = colors.bg1,
	},
	background = {
		color = colors.with_alpha(colors.grey, 0.0),
		border_color = colors.with_alpha(colors.bg1, 0.0),
	},
})

local function toggleSpacesIndicator(currently_on)
	spaces_indicator:set({
		icon = currently_on and icons.switch.off or icons.switch.on,
	})
end

spaces_indicator:subscribe("swap_menus_and_spaces", function()
	local currently_on = spaces_indicator:query().icon.value == icons.switch.on
	toggleSpacesIndicator(currently_on)
end)

local function animateSpacesIndicator(entered)
	sbar.animate("tanh", 30, function()
		spaces_indicator:set({
			background = {
				color = { alpha = entered and 1.0 or 0.0 },
				border_color = { alpha = entered and 0.5 or 0.0 },
			},
			icon = { color = entered and colors.bg1 or colors.grey },
			label = { width = entered and "dynamic" or 0 },
		})
	end)
end

spaces_indicator:subscribe("mouse.entered", function()
	animateSpacesIndicator(true)
end)
spaces_indicator:subscribe("mouse.exited", function()
	animateSpacesIndicator(false)
end)
spaces_indicator:subscribe("mouse.clicked", function()
	sbar.trigger("swap_menus_and_spaces")
end)

log("Script initialized")
