local wezterm = require("wezterm")

local process_icons = require("icons")

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
	config:set_strict_mode(false)
end
local function get_proc_title(pane)
	return (pane.title or pane:get_foreground_process_name()):gsub("^%s+", ""):gsub("%s+$", ""):match("[^/]+$")
end

local act = wezterm.action

config = {
	font = wezterm.font_with_fallback({
		"JetBrainsMono Nerd Font",
		"Hack Nerd Font",
		"Symbols Nerd Font",
		-- "Maple Mono",
		-- "Monaspace Radon",
		"Fusion Kai G",
	}),
	front_end = "WebGpu",
	webgpu_power_preference = "HighPerformance",
	color_scheme = "catppuccin-macchiato",
	animation_fps = 30,
	max_fps = 60,
	font_size = 12.0,
	underline_thickness = 1,
	underline_position = -2.0,
	allow_square_glyphs_to_overflow_width = "Never",
	-- colors = { background = "#26283f" },
	window_padding = {
		top = 0,
		bottom = 0,
		left = 0,
		right = 0,
	},
	inactive_pane_hsb = {
		saturation = 1.0,
		brightness = 1.0,
	},
	enable_tab_bar = true,
	window_decorations = "RESIZE",
	-- hide_tab_bar_if_only_one_tab = true,
	window_background_opacity = 0.9,
	text_background_opacity = 0.5,
	macos_window_background_blur = 30
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = false,
	tab_max_width = 30,
	--enable_kitty_keyboard = true,
	warn_about_missing_glyphs = false,
	window_frame = {
		font = wezterm.font({ family = "Monaspace Radon", weight = "Bold" }),
		font_size = 13.0,
		border_left_width = "0.0cell",
		border_right_width = "0.0cell",
		border_bottom_height = "0.10cell",
		border_bottom_color = "#1a1b26",
		border_top_height = "0.0cell",
	},
	launch_menu = {},
	mouse_bindings = {
		{
			event = {
				Down = { streak = 1, button = "Right" },
			},
			mods = "NONE",
			action = wezterm.action_callback(function(window, pane)
				local has_selection = window:get_selection_text_for_pane(pane) ~= ""
				if has_selection then
					window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
					window:perform_action(act.ClearSelection, pane)
				else
					window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
				end
			end),
		},
	},
}

config.bypass_mouse_reporting_modifiers = "SHIFT"

enable_clipboard_integration = true

--Activa la barra de desplazamiento
config.enable_scroll_bar = true

config.colors = {
  -- El color del "thumb" de la barra de desplazamiento; la parte que representa el viewport actual
  scrollbar_thumb = '#ff9452', --#D3D3D3',
  -- Puedes cambiar los colores aquí según prefieras
}

-- Colocando left y right en true permite que al presionar optio+ñ genere la ~ 
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true


wezterm.on("format-tab-title", function(tab, _tabs, _panes, _config, hover, _max_width)
	local has_unseen_output = false
	for _, pane in ipairs(tab.panes) do
		if pane.has_unseen_output then
			has_unseen_output = true
			break
		end
	end
	local proc_title = get_proc_title(tab.active_pane)

	local icon
	if process_icons[proc_title] ~= nil then
		icon = wezterm.format({
			{ Text = " " },
			process_icons[proc_title],
			{ Text = " " },
		})
	else
		icon = wezterm.format({
			{ Text = string.format(" %s", proc_title) },
		})
	end
	local title = {}
	if hover then
		table.insert(title, {
			Background = { Color = "#2a2e36" },
		})
	else
		table.insert(title, {
			Background = { Color = "#1a1b26" },
		})
	end
	if has_unseen_output then
		table.insert(title, {
			Foreground = { Color = "#fffac2" },
		})
	elseif tab.is_active then
		table.insert(title, {
			Foreground = { Color = "#5de4c7" },
		})
	else
		table.insert(title, {
			Foreground = { Color = "#9196c2" },
		})
	end
	table.insert(title, {
		Text = icon,
	})
	table.insert(title, {
		Foreground = {
			Color = "#9196c2",
		},
	})
	if tab.tab_title == "" then
		table.insert(title, {
			Text = proc_title or "",
		})
	else
		table.insert(title, {
			Text = tab.tab_title,
		})
	end
	table.insert(title, {
		Text = " ",
	})
	return title
end)

wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Foreground = { Color = "#9196c2" } },
		{
			Text = (function()
				if pane:get_user_vars().IS_NVIM == "true" then
					return ""
				else
					return ""
				end
			end)(),
		},
		{ Text = wezterm.strftime("%l:%M %p") },
	}))
end)


-- wezterm.on("new-tab-button-click", function(window, pane, button, _default_action)
-- 	if button == "Left" then
-- 		window:perform_action(sesh.create.action, pane)
-- 		return false
-- 	end
-- end)

-- wezterm.on("window-focus-changed", function(window)
-- 	we["WEZTERM_TAB"] = window:active_tab():tab_id()
-- end)
--

config.keys = {
  {
    key = 't',
    mods = 'CMD|SHIFT',
    action = act.ShowTabNavigator,
  },
  {
    key = 'R',
    mods = 'CMD|SHIFT',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, _, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
  {
    key = ',',
    mods = 'CMD',
    action = act.SpawnCommandInNewTab {
      cwd = os.getenv('WEZTERM_CONFIG_DIR'),
      set_environment_variables = {
        TERM = 'screen-256color',
      },
      args = {
        '/etc/profiles/per-user/dgarciar/bin/nvim',
        os.getenv('WEZTERM_CONFIG_FILE'),
      },
    },
  },
  -- other keys
}

--Para diferenciar que pane esta activo
--config.inactive_pane_hsb = {
--  saturation = 0.2,
--  brightness = 0.5,
--}

return config

