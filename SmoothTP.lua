local activeTP = {};
local currentTP = gui.GetValue("esp.local.thirdpersondist" )
local OnyxRef = gui.Reference("Visuals", "Local", "Camera")
local tptggle;
local OnyxFakeActivate = gui.Keybox(OnyxRef, tptggle, "Smoother TP", 6)
local function add(time, yes, ...)
    if yes then
        table.insert(activeTP, {
            ["time"] = time,
            ["delay"] = globals.RealTime() + time,
            ["tp"] = 0,
            ["y"] = true,
        })
    else
        table.insert(activeTP, {
            ["time"] = time,
            ["delay"] = globals.RealTime() + time,
            ["tp"] = gui.GetValue("esp.local.thirdpersondist" )-1,
            ["y"] = false,
        })
    end
end
local function showtp(count, player)
    if player.y then
        local nd = currentTP
        if globals.RealTime() < player.delay then
                if player.tp < nd then player.tp = player.tp + (nd - player.tp) * 0.08 end
                if player.tp > nd then player.tp = nd end
                gui.SetValue("esp.local.thirdpersondist", player.tp )
        else
            table.remove(activeTP, count)
        end
    else
        local nd = currentTP
        if (player.tp > 0) then
            if player.tp < nd then player.tp = player.tp - (nd + player.tp) * 0.02 end
            if player.tp > nd then player.tp = nd end
            gui.SetValue("esp.local.thirdpersondist", player.tp )
        else
            gui.SetValue("esp.local.thirdperson", false )
            table.remove(activeTP, count)
        end
    end
end
local function addc()
    if gui.GetValue( "esp.local.thirdperson" ) then
        add(1, false)
    else
        gui.SetValue("esp.local.thirdperson", true )
        add(1, true)
    end
    
end
callbacks.Register('Draw', function()
    if (input.IsButtonPressed(OnyxFakeActivate:GetValue())) then
    addc();
end
    for index, hittp in pairs(activeTP) do
        showtp(index, hittp)
    end
end);
