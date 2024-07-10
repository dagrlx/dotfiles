local sbar = require("sketchybar")
local opts = require("opts")

-- Configuración de Espaciadores y Separadores
sbar.add("item", opts.get_spacer(20, { position = "e" }))
sbar.add("item", opts.get_right_separator("surface", { position = "e" }))

-- Ítem de Batería
local battery = sbar.add("item", {
    position = "e",
    background = { color = opts.color.surface },
    label = {
        string = "%",
        color = opts.color.text,
        padding_left = 8,
        padding_right = 4,
    },
    update_freq = 1,
})

local battery_icon = sbar.add("item", {
    position = "e",
    icon = { string = "-", padding_right = 8 },
    background = {
        color = opts.color.pink,
        drawing = true,
    },
})

-- Separador de Batería
sbar.add("item", opts.get_left_separator("pink", { position = "e" }))

-- Actualización del Ítem de Batería
local function update_battery(env)
    sbar.exec("pmset -g batt | grep -q 'AC Power' && echo 'true' || echo 'false'", function(charging)
        local is_charging = charging == "true\n"
        if is_charging then
            battery_icon:set({ icon = { string = " " } })
        end
        sbar.exec('pmset -g batt | grep -Eo "\\d+%" | cut -d% -f1', function(percentage)
            battery:set({ label = { string = percentage .. "%" } })
            if not is_charging then
                local icon = " "
                local p = tonumber(percentage)
                if p > 79 then
                    icon = " "
                elseif p > 59 then
                    icon = " "
                elseif p > 39 then
                    icon = " "
                elseif p > 19 then
                    icon = " "
                end
                battery_icon:set({ icon = { string = icon } })
            end
        end)
    end)
end

battery:subscribe("routine", update_battery)
battery:subscribe("forced", update_battery)

-- Ítem de Medios (Puedes eliminar esto si no lo necesitas)
-- local media_icon = sbar.add("item", init_media_icon("e"))
-- local media = sbar.add("item", init_media("e"))
-- local media_sepl = sbar.add("item", opts.get_left_separator("orange", { position = "e" }))

-- Actualización de Medios (Puedes eliminar esto si no lo necesitas)
-- media:subscribe("media_change", function(env)
--     if whitelist[env.INFO.app] == true then
--         local label = env.INFO.artist .. ": " .. env.INFO.title
--         local color = opts.color.orange

--         if env.INFO.state == "playing" then
--             color = opts.color.green
--         elseif env.INFO.state == "paused" then
--             color = opts.color.yellow
--             label = "What was I listening to

