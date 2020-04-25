local activeTP = {};
local currentTP = gui.GetValue("esp.local.thirdpersondist" )
local function add(time, ...)
    table.insert(activeTP, {
        ["time"] = time,
        ["delay"] = globals.RealTime() + time,
        ["tp"] = 0,
    })
end
local function showtp(count, player)
    local nd = currentTP
    if globals.RealTime() < player.delay then
            if player.tp < nd then player.tp = player.tp + (nd - player.tp) * 0.08 end
            if player.tp > nd then player.tp = nd end
            gui.SetValue("esp.local.thirdpersondist", player.tp )
    else
            table.remove(activeTP, count)
    end
end
callbacks.Register('Draw', function()
    if (input.IsButtonPressed(gui.GetValue("esp.local.thirdpersonkey" ))) then
        add(1)
    end
    for index, hittp in pairs(activeTP) do
        showtp(index, hittp)
    end
end);
