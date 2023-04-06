--[[
    Initial game configuring
]]
function love.conf(t)
    t.title = "Pong"        -- Title of the game
    t.version = "11.4"      -- LÖVE 2D version that is being used
    t.console = true        -- Opens console window, useful for debugging
    t.window.width = 1280   -- Window width in pixels
    t.window.height = 720   -- Window height in pixels
    t.fullscreen = false    -- Disable fullscreen functionality
    t.resizable = false     -- Disable resizable game window
    t.vsync = 1             -- Enable vertical sync
end