-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto-left",
	scale = 1,
})
hl.monitor({
	output = "eDP-1",
	mode = "2560x1600@60",
	position = "auto",
	scale = 1.25,
})
hl.monitor({
	output = "DP-1",
	mode = "preferred",
	position = "auto-left",
	scale = 1,
})

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal = "ghostty"
local fileManager = "dolphin"
local menu = "vicinae toggle"

local screenshot_dir = "~/Pictures/Screenshots"

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XDG_MENU_PREFIX", "arch-")
hl.env("HYPRCURSOR_SIZE", "28")
hl.env("HYPRCURSOR_THEME", "rose-pine-hyprcursor")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("AQ_DRM_DEVICES", "/dev/dri/card1:/dev/dri/card0")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

hl.on("hyprland.start", function()
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("hyprsunset")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("nm-applet & blueman-applet")
	hl.exec_cmd("udiskie --tray --notify --automount --appindicator")
	hl.exec_cmd("swaync")
	hl.exec_cmd("clipse -listen")
	hl.exec_cmd("pidof waybar || waybar")
	hl.exec_cmd("vicinae server")

	-- Opening apps silently
	hl.exec_cmd(terminal, { workspace = "3 silent" })
	hl.exec_cmd("brave", { workspace = "4 silent" })
	hl.exec_cmd("sh /home/manoj/.local/bin/monitor-watch.sh")
	hl.exec_cmd("kbuildsycoca6")
	hl.dsp.focus({ workspace = "r+1", on_current_monitor = true })
end)

hl.on("config.reloaded", function()
	hl.exec_cmd("sh /home/manoj/.local/bin/monitor-watch.sh")
	hl.exec_cmd("pidof waybar || waybar")
	hl.exec_cmd("systemctl --user restart espanso.service")
end)

hl.on("monitor.added", function()
	-- hl.exec_cmd("sh /home/manoj/.local/bin/monitor-watch.sh")
	hl.exec_cmd("pidof waybar || waybar")
	hl.exec_cmd("systemctl --user restart espanso.service")
end)

hl.on("monitor.removed", function()
	hl.exec_cmd("sh /home/manoj/.local/bin/monitor-watch.sh")
	hl.exec_cmd("pidof waybar || waybar")
	hl.exec_cmd("systemctl --user restart espanso.service")
end)

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

hl.config({
	ecosystem = {
		no_update_news = true,
		no_donation_nag = true,
		enforce_permissions = true,
	},
})

hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
hl.permission("/usr/(bin|local/bin)/hyprlock", "screencopy", "allow")
hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 0,
		gaps_out = 0,

		border_size = 2,

		col = {
			active_border = "rgba(6f6f6fff)",
			inactive_border = "rgba(00000000)",
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = true,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		rounding = 0,
		rounding_power = 1.0,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = false,
			range = 4,
			render_power = 3,
			color = 0x1a1a1aee,
		},

		blur = {
			enabled = false,
			size = 8,
			passes = 2,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = false,
	},
})

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
-- 	name = "no-gaps-wtv1",
-- 	match = { float = false, workspace = "w[tv1]" },
-- 	border_size = 0,
-- 	rounding = 0,
-- })
-- hl.window_rule({
-- 	name = "no-gaps-f1",
-- 	match = { float = false, workspace = "f[1]" },
-- 	border_size = 0,
-- 	rounding = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
	dwindle = {
		preserve_split = true, -- You probably want this
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
	master = {
		new_status = "master",
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})

----------------
----  MISC  ----
----------------

hl.config({
	group = {
		col = {
			border_active = "rgba(6f6f6fff)",
			border_inactive = "rgba(00000000)",
		},
		groupbar = {
			font_size = 12,
			font_weight_active = "bold",
			col = {
				active = "rgba(5090aaee)",
				inactive = "rgba(595959aa)",
			},
		},
	},
})

hl.config({
	misc = {
		enable_anr_dialog = false,
		force_default_wallpaper = 0, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
		vrr = 1,
		disable_watchdog_warning = true,
	},
})

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "gb",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",
		resolve_binds_by_sym = true,

		follow_mouse = 1,

		sensitivity = 0.25, -- -1.0 - 1.0, 0 means no modification.
		scroll_factor = 1.5,

		touchpad = {
			scroll_factor = 0.7,
			natural_scroll = true,
		},
	},
})

hl.gesture({
	fingers = 4,
	direction = "horizontal",
	action = "workspace",
})
hl.gesture({
	fingers = 3,
	direction = "pinch",
	action = "fullscreen",
	mode = "maximize",
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
	name = "keychron-k2",
	kb_layout = "us",
})
hl.device({
	name = "keychron-keychron-k2",
	kb_layout = "us",
})
hl.device({
	name = "keychron-keychron-k2-2",
	kb_layout = "us",
})
hl.device({
	name = "elan06fa:00-04f3:327e-touchpad",
	sensitivity = 0.2, -- -1.0 - 1.0, 0 means no modification.
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- See https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.kill()) -- old forcekillactive
hl.bind(mainMod .. " + W", hl.dsp.window.close()) -- old killactive
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("zeditor"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("codium"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("brave", { workspace = "unset" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + U", hl.dsp.layout("togglesplit")) -- dwindle
hl.bind(mainMod .. " + I", hl.dsp.layout("swapsplit")) -- dwindle
hl.bind(mainMod .. " + N", hl.dsp.layout("movetoroot"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" })) -- '1' for maximising
hl.bind(mainMod .. " + P", hl.dsp.workspace.move({ monitor = "+1" }))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.workspace.move({ monitor = "-1" }))

hl.bind("ALT + ALT_L", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"), { repeating = true }) -- old bindr

-- Group actions
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
hl.bind("ALT + TAB", hl.dsp.group.next())
hl.bind("SHIFT + ALT + TAB", hl.dsp.group.prev())
hl.bind(mainMod .. " + ALT + H", hl.dsp.window.move({ direction = "l", group_aware = true }))
hl.bind(mainMod .. " + ALT + L", hl.dsp.window.move({ direction = "r", group_aware = true }))
hl.bind(mainMod .. " + ALT + J", hl.dsp.window.move({ direction = "d", group_aware = true }))
hl.bind(mainMod .. " + ALT + K", hl.dsp.window.move({ direction = "u", group_aware = true }))

hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("hyprshot -m region -o " .. screenshot_dir))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m window"))

hl.bind(
	mainMod .. " + V",
	hl.dsp.exec_cmd(terminal .. " -e clipse", { float = true, size = { 622, 652 }, workspace = "unset" })
)

-- Move focus with mainMod + Vim keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))

-- Switch workspaces with mainMod + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i, on_current_monitor = true }))
end

-- Move to the next/prev workspace
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.focus({ workspace = "r+1", on_current_monitor = true }))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.focus({ workspace = "r-1", on_current_monitor = true }))

-- Move active window to a workspace
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = i, follow = true }))
end
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.move({ workspace = "r+1", follow = true }))
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.move({ workspace = "r-1", follow = true }))

-- Move active window without switching (silent)
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.move({ workspace = "r+1", follow = false }))
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.move({ workspace = "r-1", follow = false }))
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + ALT + S", hl.dsp.window.move({ workspace = "special:magic", follow = true }))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic", follow = false }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "r+1", on_current_monitor = true }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "r-1", on_current_monitor = true }))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	mainMod .. " + XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Toggle the internal panel (eDP-1) on/off at 165 Hz when enabling.
-- The wiki disables a monitor with disabled = true, so enabling it means
-- applying a monitor rule with disabled = false (dpms on only handles the
-- screensaver/dpms state, not a monitor removed from the layout).
hl.bind(
	mainMod .. " + ALT + P",
	hl.dsp.exec_cmd("sh /home/manoj/.config/hypr/scripts/toggle-edp1.sh"),
	{ locked = true }
)

-- Power menu binding
hl.bind(
	mainMod .. " + SHIFT + Q",
	hl.dsp.exec_cmd(
		"pidof wlogout || wlogout --margin-top 530 --margin-bottom 530 --margin-right 750 --margin-left 750"
	),
	{ locked = true }
)
hl.bind(mainMod .. " + CTRL + Q", hl.dsp.exec_cmd("loginctl lock-session"))

-- Cursor zoom with mainMod + equal/minus or keypad +/-
hl.bind(
	mainMod .. " + equal",
	hl.dsp.exec_cmd(
		"hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')"
	),
	{ repeating = true }
)
hl.bind(
	mainMod .. " + minus",
	hl.dsp.exec_cmd(
		"hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')"
	),
	{ repeating = true }
)
hl.bind(
	mainMod .. " + KP_ADD",
	hl.dsp.exec_cmd(
		"hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')"
	),
	{ repeating = true }
)
hl.bind(
	mainMod .. " + KP_SUBTRACT",
	hl.dsp.exec_cmd(
		"hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')"
	),
	{ repeating = true }
)
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor 1"))

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

-- Rules for network, bluetooth, volume and password managers
hl.window_rule({ match = { class = "^(nm-connection-editor)$" }, float = true })
hl.window_rule({ match = { class = "^(blueman-manager)$" }, float = true })
hl.window_rule({ match = { class = "^(org.pulseaudio.pavucontrol)$" }, float = true })
-- Bitwarden float
-- HACK: `title` match broken; just hope no other window uses the below class
hl.window_rule({ match = { class = "^(brave-nngceckbapebfimnlniiiahkandclblb-Default)$" }, float = true })

-- Rules for PiP
hl.window_rule({ match = { title = "^(Picture-in-picture)$" }, float = true, workspace = "unset", pin = true })

-- Fix some dragging issues with XWayland
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Float other empty-class/title windows
hl.window_rule({ match = { class = "^$", title = "^$" }, float = true, workspace = "unset", size = { 340, 652 } })

-- Layer rules
hl.layer_rule({ match = { namespace = "waybar" }, blur = true })
hl.layer_rule({ match = { namespace = "swaync-control-center" }, blur = true })
hl.layer_rule({ match = { namespace = "logout_dialog" }, blur = true })

-- Rules for apps
hl.window_rule({ match = { class = "(code)" }, workspace = "2" })
hl.window_rule({ match = { class = "(com.mitchellh.ghostty)" }, workspace = "3" })
hl.window_rule({ match = { class = "(brave-browser)" }, workspace = "4" })
hl.window_rule({ match = { class = "(brave-browser)" }, group = "set always" })
hl.window_rule({ match = { class = "(org.kde.okular)" }, group = "set always" })
hl.window_rule({ match = { class = "(obsidian)" }, workspace = "5" })

-- Workspace rules
hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true, persistent = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-1", persistent = true })
hl.workspace_rule({ workspace = "3", monitor = "DP-1", persistent = true })
hl.workspace_rule({ workspace = "4", monitor = "DP-1", persistent = true })
hl.workspace_rule({ workspace = "5", monitor = "DP-1", persistent = true })

hl.workspace_rule({ workspace = "1", monitor = "eDP-1", default = true, persistent = true })
hl.workspace_rule({ workspace = "2", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "3", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "4", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "5", monitor = "eDP-1", persistent = true })
