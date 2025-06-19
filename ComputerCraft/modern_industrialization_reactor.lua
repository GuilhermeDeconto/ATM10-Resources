-- Reactor control based on steam buffer level

local tank = peripheral.wrap("back")
local monitor = peripheral.wrap("right")

local active = false
local redstoneSide = "left"
local capacity = 1024000

-- Monitor setup
monitor.setTextScale(0.5)

-- Function to display system status
local function displayStatus(percent, amount)
    monitor.clear()
    monitor.setCursorPos(1, 1)
    monitor.write(string.format("Reactor Active: %s", tostring(active)))
    monitor.setCursorPos(1, 3)
    monitor.write(string.format("Steam Amount: %d", amount))
    monitor.setCursorPos(1, 5)
    monitor.write(string.format("Tank Level: %.1f%%", percent))
end

-- Main loop
while true do
    local tankInfo = tank.tanks()
    if tankInfo and #tankInfo > 0 then
        local amount = tankInfo[1].amount
        local percent = (amount / capacity) * 100

        if not active and percent <= 25 then
            active = true
            redstone.setOutput(redstoneSide, true)
            displayStatus(percent, amount)
        elseif active and percent >= 90 then
            active = false
            redstone.setOutput(redstoneSide, false)
            displayStatus(percent, amount)
        end
    end

    sleep(1) -- Prevent high CPU usage
end
