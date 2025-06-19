--- Reactor control buffer level

local tank = peripheral.wrap("back")
 
local active = false
 
while true do
    local tankInfo = tank.tanks()
    if tankInfo then
        local capacity = 1024000
        local amount = tankInfo[1].amount
        local percent = (amount / capacity) * 100
        if not active and percent <= 25 then
            active = true
            redstone.setOutput("left", true)
        elseif active and percent >= 90 then
            active = false
            redstone.setOutput("left", false)
        end
    end
    print(active)
    print(tankInfo[1].amount)
end