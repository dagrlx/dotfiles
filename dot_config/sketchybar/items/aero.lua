local colors = require("colors")
local settings = require("settings")
local sbar = require("sketchybar")

local LIST_ALL = "aerospace list-workspaces --all"
local LIST_CURRENT = "aerospace list-workspaces --focused"
local spaces = {}

-- Function for adding the workspace-Items in Sketchybar
local function addWorkspaceItem(workspaceName)
    local spaceId = "workspace_" .. workspaceName
    spaces[spaceId] = sbar.add("item", spaceId, {
        label = {
            string = workspaceName,
            padding_right = 10,
            color = colors.grey,
            highlight_color = colors.blue, -- Highlight-Colour for selected work area
        },
        padding_right = 2,
        padding_left = 2,
        background = {
            color = colors.bg1,
            height = 26,
            border_color = colors.grey,
            border_width = 1,
            drawing = "on",
        },
        click_script = "aerospace workspace " .. workspaceName,
    })
    
    -- Workspace change-Event abonnieren
    spaces[spaceId]:subscribe("aerospace_workspace_change", function(env)
        -- Rufe 'sbar.exec' mit dem 'LIST_CURRENT'-Befehl auf, um den fokussierten Arbeitsbereich zu identifizieren
        sbar.exec(LIST_CURRENT, function(focusedWorkspaceOutput)
            local focusedWorkspaceName = focusedWorkspaceOutput:match("[^\r\n]+")
            -- Iterate through all workspaces-Items
            for sid, space in pairs(spaces) do
                -- Make sure that spaces[spaceId] exists
                if space ~= nil then
                    local isSelected = sid == "workspace_" .. focusedWorkspaceName
                    -- Set highlights accordingly
                    space:set({
                        label = { highlight = isSelected },
                        background = { border_color = isSelected and colors.blue or colors.bg2 }
                    })
                else
                    print("Error: Item '" .. sid .. "' not found.")
                end
            end
        end)
    end)
end

-- First add all workspaces
sbar.exec(LIST_ALL, function(workspacesOutput)
    for workspaceName in workspacesOutput:gmatch("[^\r\n]+") do
        addWorkspaceItem(workspaceName)
    end
    
    -- Update the focus after adding all workspaces
    sbar.exec(LIST_CURRENT, function(focusedWorkspaceOutput)
        local focusedWorkspaceName = focusedWorkspaceOutput:match("[^\r\n]+")
        for sid, space in pairs(spaces) do
            local isSelected = sid == "workspace_" .. focusedWorkspaceName
            space:set({
                updates = "on",
                label = { highlight = isSelected },
                background = { border_color = isSelected and colors.blue or colors.bg2 }
            })
        end
    end)
end)
