-- autohide.lua
local handle = io.popen("yabai -m query --spaces --space")
local result = handle:read("*a")
handle:close()

local space = result and result:match('"is-visible":%s*(%w+)') or "false"
local has_windows = result and result:match('"windows":%s*%[(.-)%]') or ""

local isVisible = space == "true"
local hasWindows = #has_windows > 0

if isVisible and hasWindows then
    os.execute("sketchybar --bar hidden=true")
else
    os.execute("sketchybar --bar hidden=false")
end

