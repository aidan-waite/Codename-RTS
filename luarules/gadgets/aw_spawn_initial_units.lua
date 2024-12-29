Spring.Echo("vvv start aw spawn initial units");

function gadget:GetInfo()
    return {
        name = "aw spawn initial units",
        desc = "handles setting up the initial units for each player",
        author = "aw",
        date = "2024",
        license = "thank you",
        layer = 1,
        enabled = true
    }
end

if gadgetHandler:IsSyncedCode() then
    Spring.Echo("vvv gadgetHandler:IsSyncedCode()");

	function gadget:RecvLuaMsg(msg, playerID)
        Spring.Echo("vvv Received message " .. msg .. " playerID:" .. playerID);

        local name, _, spec, teamID, allyTeamID = Spring.GetPlayerInfo(playerID)
        local x, y, z = Spring.GetTeamStartPosition(teamID)
        Spring.Echo("vvv teamID:" .. teamID .. " x:" .. x .. " y:" .. y .. " z:" .. z);

        if msg ~= "ready_to_start_game" then
            return false
        end

        for i=1,6 do
            Spring.CreateUnit("armbeaver", x + i * 5, y, z + i * 5, "south", teamID)
        end
	end
end
