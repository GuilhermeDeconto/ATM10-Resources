--- Export all fluids from ender tanks into interface

local tankKeyword = "tank"
local target = "ae2:interface_1"

local monitor = peripheral.wrap("monitor_0")
local allPeripherals = peripheral.getNames()
local tanks = {}

-- Collect all tank peripherals by name
for _, name in ipairs(allPeripherals) do
  if name:lower():find(tankKeyword) then
    table.insert(tanks, name)
  end
end

local totalTanks = #tanks
local barLength = 30  -- Set a fixed width for the progress bar

-- Prepare monitor
monitor.setTextScale(0.5)
monitor.clear()

-- Main loop
while true do
  for i, tankName in ipairs(tanks) do
    local tank = peripheral.wrap(tankName)

    tank.pushFluid(target)

    -- Draw progress bar
    local percent = i / totalTanks
    local filled = math.floor(percent * barLength)
    local empty = barLength - filled

    monitor.clear()
    monitor.setCursorPos(1, 1)
    monitor.write("Processing Tanks")
    monitor.setCursorPos(1, 3)
    monitor.write("[" .. string.rep("#", filled) .. string.rep("-", empty) .. "]")
    monitor.setCursorPos(1, 4)
    monitor.write(string.format("Tank %d of %d", i, totalTanks))

    sleep(0.1)
  end
end