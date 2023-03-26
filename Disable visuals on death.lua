callbacks.Register('FireGameEvent', function(e)
	local en = e:GetName();
	if(en ~= "player_spawn" and en ~= "player_death") then return end;

	local localPlayer = entities.GetLocalPlayer();

	if(localPlayer == nil) then return end;

	local userIndex = client.GetPlayerIndexByUserID(e:GetInt('userid'));
	local localPlayerIndex = localPlayer:GetIndex();

	if(userIndex ~= localPlayerIndex) then return end;

	local isalive;

	isalive = (en == "player_spawn");

-- Change this or add as you wish
	--gui.SetValue("esp.chams.enabled", isalive);
	--gui.SetValue("esp.overlay.enemy.box", (isalive and 1 or 0));
	gui.SetValue("esp.world.outofview", (isalive and 1 or 0));
	gui.SetValue("esp.chams.enemy.visible", (isalive and 2 or 0));
	gui.SetValue("esp.chams.enemy.occluded", (isalive and 2 or 0));

-- Stop here

end);

client.AllowListener("player_spawn");
client.AllowListener("player_death");
