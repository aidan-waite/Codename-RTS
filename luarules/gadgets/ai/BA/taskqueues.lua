--[[
 Task Queues! -- Author: Damgam
]]--

math.randomseed( os.time() )
math.random(); math.random(); math.random()




-- Locals
----------------------------------------------------------------------
-- c = current, s = storage, p = pull(?), i = income, e = expense (Ctrl C Ctrl V into functions)
--
--
----------------------------------------------------------------------
-- for example ------------- UDC(ai.id, UDN.cormex.id) ---------------
local UDC = Spring.GetTeamUnitDefCount
local UDN = UnitDefNames
----------------------------------------------------------------------

local possibilities = {} -- Possibilities[builderName][tableName] = {unit1, unit2, unit3,...,unitN} -> Register "attackers", "scouts"... and other premade unitTables for everykind of lab to generate lists of possible buildoptions
shard_include('attackers')
shard_include('scouts')
shard_include('builders')
shard_include('defenses')

local unitoptions = {}
local skip = {action = "nexttask"}
local assistaround = { action = "fightrelative", position = {x = 0, y = 0, z = 0} }
local patrolaround = { action = "patrolrelative", position = {x = 100, y = 0, z = 100} }

function CanBuild(tqb, ai, unit, name)
	local ID = UnitDefNames[name] and UnitDefNames[name].id or 0
	for k, v in pairs (UnitDefs[UnitDefNames[unit:Name()].id].buildOptions) do
		if v == ID then
			return true
		end
	end
	return false
end

function ResourceCheck(tqb, ai, unit, name)
	local defs = UnitDefs[UnitDefNames[name].id]
	if timetostore(ai, "metal", defs.metalCost) < (defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed) and timetostore(ai, "energy", defs.energyCost) < (defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed) then
		return name
	else
		return nil
	end		
end

function Builder(tqb, ai, unit)
	possibilities[unit:Name()] = possibilities[unit:Name()] or {}
	if not possibilities[unit:Name()]["builder"] then
		possibilities[unit:Name()]["builder"] = {}
		local ct = 0
		for i, unitName in pairs (builderlist) do	
			if CanBuild(tqb, ai, unit, unitName) then
				possibilities[unit:Name()]["builder"][ct + 1] = unitName
				ct = ct + 1
			end
		end
	end
	if possibilities[unit:Name()]["builder"][1] then
		local unitName = AllowCon(tqb, ai, unit, possibilities[unit:Name()]["builder"][1])
		if unitName then
			unitName = ResourceCheck(tqb, ai, unit, unitName)
			if unitName then
				return unitName
			else
				return skip
			end
		else
			return skip
		end
	else
		return skip
	end
end

function Helper(tqb, ai, unit)
	possibilities[unit:Name()] = possibilities[unit:Name()] or {}
	if not possibilities[unit:Name()]["helper"] then
		possibilities[unit:Name()]["helper"] = {}
		local ct = 0
		for i, unitName in pairs (helperlist) do
			if CanBuild(tqb, ai, unit, unitName) then
				possibilities[unit:Name()]["helper"][ct + 1] = unitName
				ct = ct + 1
			end
		end
	end
	if possibilities[unit:Name()]["helper"][1] then
		local unitName = AllowCon(tqb, ai, unit, possibilities[unit:Name()]["helper"][1])
		if unitName then
			unitName = ResourceCheck(tqb, ai, unit, unitName)
			if unitName then
				return unitName
			else
				return skip
			end
		else
			return skip
		end
	else
		return skip
	end
end

function Raider(tqb, ai, unit)
	possibilities[unit:Name()] = possibilities[unit:Name()] or {}
	if not possibilities[unit:Name()]["raider"] then
		possibilities[unit:Name()]["raider"] = {}
		local ct = 0
		for i, unitName in pairs (raiderlist) do
			if CanBuild(tqb, ai, unit, unitName) then
				possibilities[unit:Name()]["raider"][ct + 1] = unitName
				ct = ct + 1
			end
		end
	end
	if possibilities[unit:Name()]["raider"][1] then
		local list = {}
		local count = 0
		for ct, unitName in pairs(possibilities[unit:Name()]["raider"]) do
			local defs = UnitDefs[UnitDefNames[unitName].id]
			if timetostore(ai, "metal", defs.metalCost) < (defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed)*ai.t1priorityrate and timetostore(ai, "energy", defs.energyCost) < (defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed)*ai.t1priorityrate then
				count = count + 1
				list[count] = unitName
			end
		end
		if list[1] then
			return FindBest(list, ai)
		else
			return skip
		end
	else
		return skip
	end
end

function Skirmisher(tqb, ai, unit)
	possibilities[unit:Name()] = possibilities[unit:Name()] or {}
	if not possibilities[unit:Name()]["skirmisher"] then
		possibilities[unit:Name()]["skirmisher"] = {}
		local ct = 0
		for i, unitName in pairs (skirmisherlist) do
			if CanBuild(tqb, ai, unit, unitName) then
				possibilities[unit:Name()]["skirmisher"][ct + 1] = unitName
				ct = ct + 1
			end
		end
	end
	if possibilities[unit:Name()]["skirmisher"][1] then
		local list = {}
		local count = 0
		for ct, unitName in pairs(possibilities[unit:Name()]["skirmisher"]) do
			local defs = UnitDefs[UnitDefNames[unitName].id]
			if timetostore(ai, "metal", defs.metalCost) < (defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed)*ai.t1priorityrate and timetostore(ai, "energy", defs.energyCost) < (defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed)*ai.t1priorityrate then
				count = count + 1
				list[count] = unitName
			end
		end
		if list[1] then
			return FindBest(list, ai)
		else
			return skip
		end
	else
		return skip
	end
end

function Artillery(tqb, ai, unit)
	possibilities[unit:Name()] = possibilities[unit:Name()] or {}
	if not possibilities[unit:Name()]["artillery"] then
		possibilities[unit:Name()]["artillery"] = {}
		local ct = 0
		for i, unitName in pairs (artillerylist) do
			if CanBuild(tqb, ai, unit, unitName) then
				possibilities[unit:Name()]["artillery"][ct + 1] = unitName
				ct = ct + 1
			end
		end
	end
	if possibilities[unit:Name()]["artillery"][1] then
		local list = {}
		local count = 0
		for ct, unitName in pairs(possibilities[unit:Name()]["artillery"]) do
			local defs = UnitDefs[UnitDefNames[unitName].id]
			if timetostore(ai, "metal", defs.metalCost) < (defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed)*ai.t1priorityrate and timetostore(ai, "energy", defs.energyCost) < (defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed)*ai.t1priorityrate then
				count = count + 1
				list[count] = unitName
			end
		end
		if list[1] then
			return FindBest(list, ai)
		else
			return skip
		end
	else
		return skip
	end
end

function Scout(tqb, ai, unit)
	possibilities[unit:Name()] = possibilities[unit:Name()] or {}
	if not possibilities[unit:Name()]["scouts"] then
		possibilities[unit:Name()]["scouts"] = {}
		local ct = 0
		for i, unitName in pairs (scoutslist) do
			if CanBuild(tqb, ai, unit, unitName) then
				possibilities[unit:Name()]["scouts"][ct + 1] = unitName
				ct = ct + 1
			end
		end
	end
	if possibilities[unit:Name()]["scouts"][1] then
		local list = {}
		local count = 0
		for ct, unitName in pairs(possibilities[unit:Name()]["scouts"]) do
			local defs = UnitDefs[UnitDefNames[unitName].id]
			if timetostore(ai, "metal", defs.metalCost) < (defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed)*ai.t1priorityrate and timetostore(ai, "energy", defs.energyCost) < (defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed)*ai.t1priorityrate then
				count = count + 1
				list[count] = unitName
			end
		end
		if list[1] then
			return FindBest(list, ai)
		else
			return skip
		end
	else
		return skip
	end
end

function Bomber(tqb, ai, unit)
	possibilities[unit:Name()] = possibilities[unit:Name()] or {}
	if not possibilities[unit:Name()]["bomber"] then
		possibilities[unit:Name()]["bomber"] = {}
		local ct = 0
		for i, unitName in pairs (bomberlist) do
			if CanBuild(tqb, ai, unit, unitName) then
				possibilities[unit:Name()]["bomber"][ct + 1] = unitName
				ct = ct + 1
			end
		end
	end
	if possibilities[unit:Name()]["bomber"][1] then
		local list = {}
		local count = 0
		for ct, unitName in pairs(possibilities[unit:Name()]["bomber"]) do
			local defs = UnitDefs[UnitDefNames[unitName].id]
			if timetostore(ai, "metal", defs.metalCost) < (defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed)*ai.t1priorityrate and timetostore(ai, "energy", defs.energyCost) < (defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed)*ai.t1priorityrate then
				count = count + 1
				list[count] = unitName
			end
		end
		if list[1] then
			return FindBest(list, ai)
		else
			return skip
		end
	else
		return skip
	end
end

function Fighter(tqb, ai, unit)
	possibilities[unit:Name()] = possibilities[unit:Name()] or {}
	if not possibilities[unit:Name()]["fighter"] then
		possibilities[unit:Name()]["fighter"] = {}
		local ct = 0
		for i, unitName in pairs (fighterlist) do
			if CanBuild(tqb, ai, unit, unitName) then
				possibilities[unit:Name()]["fighter"][ct + 1] = unitName
				ct = ct + 1
			end
		end
	end
	if possibilities[unit:Name()]["fighter"][1] then
		local list = {}
		local count = 0
		for ct, unitName in pairs(possibilities[unit:Name()]["fighter"]) do
			local defs = UnitDefs[UnitDefNames[unitName].id]
			if timetostore(ai, "metal", defs.metalCost) < (defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed)*ai.t1priorityrate and timetostore(ai, "energy", defs.energyCost) < (defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed)*ai.t1priorityrate then
				count = count + 1
				list[count] = unitName
			end
		end
		if list[1] then
			return FindBest(list, ai)
		else
			return skip
		end
	else
		return skip
	end
end

function ShortDefense(tqb, ai, unit)
	possibilities[unit:Name()] = possibilities[unit:Name()] or {}
	if not possibilities[unit:Name()]["shortdef"] then
		possibilities[unit:Name()]["shortdef"] = {}
		local ct = 0
		for i, unitName in pairs (shortrangelist) do
			if CanBuild(tqb, ai, unit, unitName) then
				possibilities[unit:Name()]["shortdef"][ct + 1] = unitName
				ct = ct + 1
			end
		end
	end
	if possibilities[unit:Name()]["shortdef"][1] then
		local list = {}
		local count = 0
		for ct, unitName in pairs(possibilities[unit:Name()]["shortdef"]) do
			local defs = UnitDefs[UnitDefNames[unitName].id]
			if timetostore(ai, "metal", defs.metalCost) < (defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed)*ai.t1priorityrate and timetostore(ai, "energy", defs.energyCost) < (defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed)*ai.t1priorityrate then
				count = count + 1
				list[count] = unitName
			end
		end
		if list[1] then
			return FindBest(list, ai)
		else
			return skip
		end
	else
		return skip
	end
end

function MediumDefense(tqb, ai, unit)
	possibilities[unit:Name()] = possibilities[unit:Name()] or {}
	if not possibilities[unit:Name()]["mediumdef"] then
		possibilities[unit:Name()]["mediumdef"] = {}
		local ct = 0
		for i, unitName in pairs (mediumrangelist) do
			if CanBuild(tqb, ai, unit, unitName) then
				possibilities[unit:Name()]["mediumdef"][ct + 1] = unitName
				ct = ct + 1
			end
		end
	end
	if possibilities[unit:Name()]["mediumdef"][1] then
		local list = {}
		local count = 0
		for ct, unitName in pairs(possibilities[unit:Name()]["mediumdef"]) do
			local defs = UnitDefs[UnitDefNames[unitName].id]
			if timetostore(ai, "metal", defs.metalCost) < (defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed)*ai.t1priorityrate and timetostore(ai, "energy", defs.energyCost) < (defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed)*ai.t1priorityrate then
				count = count + 1
				list[count] = unitName
			end
		end
		if list[1] then
			return FindBest(list, ai)
		else
			return skip
		end
	else
		return skip
	end
end

function LongDefense(tqb, ai, unit)
	possibilities[unit:Name()] = possibilities[unit:Name()] or {}
	if not possibilities[unit:Name()]["longdef"] then
		possibilities[unit:Name()]["longdef"] = {}
		local ct = 0
		for i, unitName in pairs (longrangelist) do
			if CanBuild(tqb, ai, unit, unitName) then
				possibilities[unit:Name()]["longdef"][ct + 1] = unitName
				ct = ct + 1
			end
		end
	end
	if possibilities[unit:Name()]["longdef"][1] then
		local list = {}
		local count = 0
		for ct, unitName in pairs(possibilities[unit:Name()]["longdef"]) do
			local defs = UnitDefs[UnitDefNames[unitName].id]
			if timetostore(ai, "metal", defs.metalCost) < (defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed)*ai.t1priorityrate and timetostore(ai, "energy", defs.energyCost) < (defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed)*ai.t1priorityrate then
				count = count + 1
				list[count] = unitName
			end
		end
		if list[1] then
			return FindBest(list, ai)
		else
			return skip
		end
	else
		return skip
	end
end

function Epic(tqb, ai, unit)
	possibilities[unit:Name()] = possibilities[unit:Name()] or {}
	if not possibilities[unit:Name()]["epicdef"] then
		possibilities[unit:Name()]["epicdef"] = {}
		local ct = 0
		for i, unitName in pairs (epiclist) do
			if CanBuild(tqb, ai, unit, unitName) then
				possibilities[unit:Name()]["epicdef"][ct + 1] = unitName
				ct = ct + 1
			end
		end
	end
	if possibilities[unit:Name()]["epicdef"][1] then
		local list = {}
		local count = 0
		for ct, unitName in pairs(possibilities[unit:Name()]["epicdef"]) do
			local defs = UnitDefs[UnitDefNames[unitName].id]
			if timetostore(ai, "metal", defs.metalCost) < (defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed)*ai.t1priorityrate and timetostore(ai, "energy", defs.energyCost) < (defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed)*ai.t1priorityrate then
				count = count + 1
				list[count] = unitName
			end
		end
		if list[1] then
			return FindBest(list, ai)
		else
			return skip
		end
	else
		return skip
	end
end

function AADefense(tqb, ai, unit)
	possibilities[unit:Name()] = possibilities[unit:Name()] or {}
	if not possibilities[unit:Name()]["aadef"] then
		possibilities[unit:Name()]["aadef"] = {}
		local ct = 0
		for i, unitName in pairs (antiairlist) do
			if CanBuild(tqb, ai, unit, unitName) then
				possibilities[unit:Name()]["aadef"][ct + 1] = unitName
				ct = ct + 1
			end
		end
	end
	if possibilities[unit:Name()]["aadef"][1] then
		local list = {}
		local count = 0
		for ct, unitName in pairs(possibilities[unit:Name()]["aadef"]) do
			local defs = UnitDefs[UnitDefNames[unitName].id]
			if timetostore(ai, "metal", defs.metalCost) < (defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed)*ai.t1priorityrate and timetostore(ai, "energy", defs.energyCost) < (defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed)*ai.t1priorityrate then
				count = count + 1
				list[count] = unitName
			end
		end
		if list[1] then
			return FindBest(list, ai)
		else
			return skip
		end
	else
		return skip
	end
end

--------------------------------------------------------------------------------------------
--------------------------------------- Main Functions -------------------------------------
--------------------------------------------------------------------------------------------

---- RESOURCES RELATED ----
function curstorperc(ai, resource) -- Returns % of storage for resource in real time
	local r = ai.aimodehandler.resources[resource]
	local c, s, p, i, e = r.c, r.s, r.p, r.i, r.e
	return ((c / s) * 100)
end

function timetostore(ai, resource, amount) -- Returns time to gather necessary resource amount in real time
	local r = ai.aimodehandler.resources[resource]
	local c, s, p, i, e = r.c, r.s, r.p, r.i, r.e
	local income = (i-e > 0 and i-e) or 0.00001
	return (amount-c)/(income)
end

function income(ai, resource) -- Returns income of resource in realtime
	local r = ai.aimodehandler.resources[resource]
	local c, s, p, i, e = r.c, r.s, r.p, r.i, r.e
	return i
end

function storabletime(ai, resource)
	local r = ai.aimodehandler.resources[resource]
	local c, s, p, i, e = r.c, r.s, r.p, r.i, r.e
	return s/i
end

function realincome(ai, resource)
	local r = ai.aimodehandler.resources[resource]
	local c, s, p, i, e = r.c, r.s, r.p, r.i, r.e
	return i-e
end

---- TECHTREE RELATED ----
function KbotOrVeh()
	local veh = 0
	local kbot = 0
	-- mapsize
	mapsize = Game.mapX * Game.mapY
	local randomnumber = math.random(1,mapsize+1)
	if randomnumber >= 100 then
		veh = veh + 1
	else
		kbot = kbot + 1
	end
	-- windAvg
	local avgWind = (Game.windMin + Game.windMax)/2
	randomnumber = math.random(0, math.floor(avgWind + 1))
	if randomnumber >= 5 then
		veh = veh + 1
	else
		kbot = kbot + 1
	end
	-- numberPlayers
	local teamList = Spring.GetTeamList()
	local nTeams = #teamList
	randomnumber = math.random(1, nTeams+1)
	if randomnumber <= 6 then
		veh = veh + 1
	else
		kbot = kbot + 1
	end
	-- Height diffs
	local min, max = Spring.GetGroundExtremes()
	local diff = max-min
	randomnumber = math.random(1, math.floor(diff+1))
	if randomnumber <= 100 then
		veh = veh + 1
	else
		kbot = kbot + 1
	end
	if kbot > veh then 
		return 'kbot'
	elseif veh > kbot then
		return 'veh'
	elseif math.random(1,2) == 2 then
		return 'veh'
	else
		return 'kbot'
	end
end

-- Useful Unit Counts

function RequestedAction(tqb, ai, unit)
	return ai.requestshandler:GetRequestedTask(unit)
end

function GetAdvancedLabs(tqb,ai,unit)
	local list = {
	UDN.armalab.id,
	UDN.coralab.id,
	UDN.armavp.id,
	UDN.coravp.id,
	UDN.armaap.id,
	UDN.coraap.id,	
	UDN.armasy.id,
	UDN.corasy.id,
	}
	local units = Spring.GetTeamUnitsByDefs(ai.id, list)
	return #units
end

function GetLabs(tqb,ai,unit)
	local list = {
	UDN.armlab.id,
	UDN.corlab.id,
	UDN.armvp.id,
	UDN.corvp.id,
	UDN.armap.id,
	UDN.corap.id,	
	UDN.armsy.id,
	UDN.corsy.id,
	}
	local units = Spring.GetTeamUnitsByDefs(ai.id, list)
	return #units
end

function GetType(tqb,ai,unit,list)
	local units = Spring.GetTeamUnitsByDefs(ai.id, list)
	return #units
end

function AllowConT1(tqb,ai,unit,name)
	local udid = UDN[name].id
	local sametypecon = Spring.GetTeamUnitsByDefs(ai.id, udid)
	local list = {
	UDN.armcv.id,
	UDN.corcv.id,
	UDN.armca.id,
	UDN.corca.id,
	UDN.armck.id,
	UDN.corck.id,	
	UDN.armch.id,
	UDN.corch.id,
	UDN.armcs.id,
	UDN.corcs.id,
	UDN.armcsa.id,
	UDN.corcsa.id,
	UDN.armbeaver.id,
	UDN.cormuskrat.id,
	}
	local allt1cons = Spring.GetTeamUnitsByDefs(ai.id, list)
	return (((#sametypecon < 1) or (#allt1cons < 10)) and name) or nil
end

function AllowConT2(tqb,ai,unit,name)
	local udid = UDN[name].id
	local sametypecon = Spring.GetTeamUnitsByDefs(ai.id, udid)
	local list = {
	UDN.armacv.id,
	UDN.coracv.id,
	UDN.armaca.id,
	UDN.coraca.id,
	UDN.armack.id,
	UDN.corack.id,	
	UDN.armacsub.id,
	UDN.coracsub.id,
	}
	local allt2cons = Spring.GetTeamUnitsByDefs(ai.id, list)
	return (((#sametypecon < 1) or (#allt2cons < 10)) and name) or nil
end

function AllowEngineer(tqb,ai,unit,name)
	local udid = UDN[name].id
	local sametypecon = Spring.GetTeamUnitsByDefs(ai.id, udid)
	local list = {
	UDN.armconsul.id,	
	UDN.corfast.id,
	UDN.armfark.id,
	}
	local allengineers = Spring.GetTeamUnitsByDefs(ai.id, list)
	return (((#sametypecon < 1) or (#allengineers < 10)) and name) or nil
end

function AllowCon(tqb,ai,unit,name)
	if string.find(name, "ac") then
		return AllowConT2(tqb, ai, unit, name)
	elseif name == "armconsul" or name == "armfark" or name == "corfast" then
		return AllowEngineer(tqb, ai, unit, name)
	elseif name ~= 'armrectr' or name ~= "cornecro" then
		return AllowConT1(tqb, ai, unit, name)
	else
		return name
	end
end
	
function GetFinishedAdvancedLabs(tqb,ai,unit)
	local list = {
	UDN.armalab.id,
	UDN.coralab.id,
	UDN.armavp.id,
	UDN.coravp.id,
	UDN.armaap.id,
	UDN.coraap.id,	
	UDN.armasy.id,
	UDN.corasy.id,
	}
	local units = Spring.GetTeamUnitsByDefs(ai.id, list)
	local count = 0
	for ct, unitID in pairs (units) do
		local _,_,_,_,bp = Spring.GetUnitHealth(unitID)
		if bp == 1 then
			count = count + 1
		end
	end
	return count
end

function GetPlannedAdvancedLabs(tqb, ai, unit)
	local list = {
	UDN.armalab.id,
	UDN.coralab.id,
	UDN.armavp.id,
	UDN.coravp.id,
	UDN.armaap.id,
	UDN.coraap.id,	
	UDN.armasy.id,
	UDN.corasy.id,
	}
	local total = 0
	for ct, unitDefID in pairs(list) do
		local planned = ai.newplacementhandler:GetExistingPlansByUnitDefID(unitDefID)
		for planID, plan in pairs(planned) do
			total = total + 1
		end
	end
	return total
end

function GetPlannedLabs(tqb, ai, unit)
	local list = {
	UDN.armalab.id,
	UDN.coralab.id,
	UDN.armavp.id,
	UDN.coravp.id,
	UDN.armaap.id,
	UDN.coraap.id,	
	UDN.armasy.id,
	UDN.corasy.id,
	UDN.armvp.id,
	UDN.corvp.id,
	UDN.armap.id,
	UDN.corap.id,
	UDN.armlab.id,
	UDN.corlab.id,
	UDN.armshltx.id,
	UDN.corgant.id,
	}
	local total = 0
	for ct, unitDefID in pairs(list) do
		local planned = ai.newplacementhandler:GetExistingPlansByUnitDefID(unitDefID)
		for planID, plan in pairs(planned) do
			total = total + 1
		end
	end
	return total
end

function GetPlannedType(tqb, ai, unit,list)
	local total = 0
	for ct, unitDefID in pairs(list) do
		local planned = ai.newplacementhandler:GetExistingPlansByUnitDefID(unitDefID)
		for planID, plan in pairs(planned) do
			total = total + 1
		end
	end
	return total
end

function GetPlannedAndUnfinishedAdvancedLabs(tqb,ai,unit)
	local list = {
	UDN.armalab.id,
	UDN.coralab.id,
	UDN.armavp.id,
	UDN.coravp.id,
	UDN.armaap.id,
	UDN.coraap.id,	
	UDN.armasy.id,
	UDN.corasy.id,
	}
	local count = 0
	for ct, unitDefID in pairs(list) do
		count = count + UUDC(UnitDefs[unitDefID].name, ai.id)
	end
	count = count + GetPlannedAdvancedLabs(tqb, ai, unit)
	return count
end

function GetPlannedAndUnfinishedType(tqb,ai,unit,list)
	local count = 0
	for ct, unitDefID in pairs(list) do
		count = count + UUDC(UnitDefs[unitDefID].name, ai.id)
	end
	count = count + GetPlannedType(tqb, ai, unit,list)
	return count
end

function GetPlannedAndUnfinishedLabs(tqb,ai,unit)
	local list = {
	UDN.armalab.id,
	UDN.coralab.id,
	UDN.armavp.id,
	UDN.coravp.id,
	UDN.armaap.id,
	UDN.coraap.id,	
	UDN.armasy.id,
	UDN.corasy.id,
	UDN.armvp.id,
	UDN.corvp.id,
	UDN.armap.id,
	UDN.corap.id,
	UDN.armlab.id,
	UDN.corlab.id,
	UDN.armshltx.id,
	UDN.corgant.id,
	}
	local count = 0
	for ct, unitDefID in pairs(list) do
		count = count + UUDC(UnitDefs[unitDefID].name, ai.id)
	end
	count = count + GetPlannedLabs(tqb, ai, unit)
	return count
end

function AllAdvancedLabs(tqb, ai, unit)
	return GetAdvancedLabs(tqb,ai,unit) + GetPlannedAdvancedLabs(tqb, ai, unit)
end

function AllLabs(tqb, ai, unit)
	return GetLabs(tqb,ai,unit) + GetPlannedLabs(tqb, ai, unit)
end

function AllType(tqb, ai, unit, list)
	return GetType(tqb,ai,unit,list) + GetPlannedType(tqb, ai, unit, list)
end

function UUDC(unitName, teamID) -- Unfinished UnitDef Count
	local count = 0
	if UnitDefNames[unitName] then
		local tableUnits = Spring.GetTeamUnitsByDefs(teamID, UnitDefNames[unitName].id)
		for k, v in pairs(tableUnits) do
			local _,_,_,_,bp = Spring.GetUnitHealth(v)
			if bp < 1 then
				count = count + 1
			end
		end
	end
	return count
end

--- OTHERS

function FindBest(unitoptions,ai)
	if unitoptions and unitoptions[1] then
		local effect = {}
		local randomization = 1
		local randomunit = {}
		for n, unitName in pairs(unitoptions) do
			local cost = UnitDefs[UnitDefNames[unitName].id].energyCost / 60 + UnitDefs[UnitDefNames[unitName].id].metalCost
			local avgkilled_cost = GG.AiHelpers.UnitInfo(ai.id, UnitDefNames[unitName].id) and GG.AiHelpers.UnitInfo(ai.id, UnitDefNames[unitName].id).avgkilled_cost or 200 --start at 200 so that costly units aren't made from the start
			effect[unitName] = math.max(math.floor((avgkilled_cost/cost)^4*10),1)
			for i = randomization, randomization + effect[unitName] do
				randomunit[i] = unitName
			end
			randomization = randomization + effect[unitName]
		end
		if randomization < 1 then
			return skip
		end
		return randomunit[math.random(1,randomization)]	
	else
		return unitoptions[math.random(1,#unitoptions)]
	end
end


-- COMMON QUEUES --

lab = {
	Builder,
	Scout,
	Builder,
	Scout,
	Raider,
	Raider,
	Raider,
	Helper,
	Raider,
	Skirmisher,
	Skirmisher,
	Helper,
	Skirmisher,
	Artillery,
	Builder,
}

airlab = {
	Builder,
	Scout,
	Builder,
	Scout,
	Fighter,
	Fighter,
	Bomber,
	Helper,
	Bomber,
	Bomber,
	Fighter,
	Helper,
	Fighter,
	Fighter,
	Builder,
}

--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--------------------------------------- Core Functions -------------------------------------
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

function CorWindOrSolar(tqb, ai, unit)
    local _,_,_,curWind = Spring.GetWind()
    local avgWind = (Game.windMin + Game.windMax)/2
	if ai and ai.id then
		if not (UDC(ai.id, UDN.armfus.id) + UDC(ai.id, UDN.corfus.id) > 1) then
			if curWind > 7 then
				return "corwin"
			else
				if income(ai, "energy") > 200 and income(ai, "metal") > 15 and (UUDC("armadvsol", ai.id) + UUDC("coradvsol", ai.id)) < 2 then
					return "coradvsol"
				else
					return "corsolar"
				end
			end
		else
			return skip	
		end
	else
		return "corsolar"
	end
end

function CorNanoT(tqb, ai, unit)
	if timetostore(ai, "energy", 5000) < 40 and timetostore(ai, "metal", 300) < 40 and UDC(ai.id, UDN.armnanotc.id) + UDC(ai.id, UDN.cornanotc.id) < income(ai, "energy")/150 then
		return "cornanotc"
	else
		return skip
	end
end

function CorEnT1( tqb, ai, unit )	
	local countEstore = UDC(ai.id, UDN.corestor.id) + UDC(ai.id, UDN.armestor.id)
	if (income(ai, "energy") < ai.aimodehandler.eincomelimiterpretech2) and realincome(ai, "energy") < 0 and curstorperc(ai, "energy") < 80 then
        return (CorWindOrSolar(tqb, ai, unit))
	elseif (income(ai, "energy") < ai.aimodehandler.eincomelimiterposttech2) and realincome(ai, "energy") < 0 and curstorperc(ai, "energy") < 80 and GetFinishedAdvancedLabs(tqb, ai, unit) >= 1 then
		return (CorWindOrSolar(tqb, ai, unit))
    elseif Spring.GetTeamRulesParam(ai.id, "mmCapacity") < income(ai, "energy") and curstorperc(ai, "energy") > 30 then
        return "cormakr"
	elseif storabletime(ai, "energy") < 8 and curstorperc(ai, "energy") > 80 then
		return "corestor"
	elseif storabletime(ai, "metal") < 8 or curstorperc(ai, "metal") > 90 then
		return "cormstor"
	else
		return skip
	end
end

function CorEnT2( tqb, ai, unit )
	--if storabletime(ai, "energy") < 10 and not (GetPlannedAndUnfinishedType(tqb,ai,unit, {UDN.coruwadves.id, UDN.armuwadves.id }) > 0) then
		--return "coruwadves"
	--elseif storabletime(ai, "metal") < 5 and not (GetPlannedAndUnfinishedType(tqb,ai,unit, {UDN.coruwadvms.id, UDN.armuwadvms.id }) > 0)then
		--return "coruwadvms"
	if income(ai, "energy") > 6000 and income(ai, "metal") > 100 and Spring.GetTeamRulesParam(ai.id, "mmCapacity") > income(ai, "energy")-3000 and income(ai, "energy") < ((math.max((Spring.GetGameSeconds() / 60) - 5, 1)/6) ^ 2) * 1000 and unit:Name() == "coracv" then
       	if GG.AiHelpers.NanoTC.GetClosestNanoTC(unit.id) then
			local x, y, z = GG.AiHelpers.NanoTC.GetClosestNanoTC(unit.id)
			return {action = "corafus", pos = {x = x, y = y, z = z}}
		else
			return "corafus"
		end
	elseif income(ai, "energy") > ai.aimodehandler.mintecheincome and income(ai, "metal") > ai.aimodehandler.mintechmincome and Spring.GetTeamRulesParam(ai.id, "mmCapacity") > income(ai, "energy")-1200 and income(ai, "energy") < ((math.max((Spring.GetGameSeconds() / 60) - 5, 1)/6) ^ 2) * 1000 then
       	if GG.AiHelpers.NanoTC.GetClosestNanoTC(unit.id) then
			local x, y, z = GG.AiHelpers.NanoTC.GetClosestNanoTC(unit.id)
			return {action = "corfus", pos = {x = x, y = y, z = z}}
		else
			return "corfus"
		end
	elseif income(ai, "energy") > 6000 and income(ai, "metal") > 100 and (UUDC("armafus",ai.id) + UUDC("corafus",ai.id)) < 2 and Spring.GetTeamRulesParam(ai.id, "mmCapacity") > income(ai, "energy")-3000 and timetostore(ai, "metal", UnitDefs[UnitDefNames["corafus"].id].metalCost) < 240 and unit:Name() == "coracv" then
       	if GG.AiHelpers.NanoTC.GetClosestNanoTC(unit.id) then
			local x, y, z = GG.AiHelpers.NanoTC.GetClosestNanoTC(unit.id)
			return {action = "corafus", pos = {x = x, y = y, z = z}}
		else
			return "corafus"
		end
	elseif income(ai, "energy") > ai.aimodehandler.mintecheincome and income(ai, "metal") > ai.aimodehandler.mintechmincome and (UUDC("armfus",ai.id) + UUDC("corfus",ai.id)) < 2 and Spring.GetTeamRulesParam(ai.id, "mmCapacity") > income(ai, "energy")-1200 and timetostore(ai, "metal", UnitDefs[UnitDefNames["corfus"].id].metalCost) < 120 then
       	if GG.AiHelpers.NanoTC.GetClosestNanoTC(unit.id) then
			local x, y, z = GG.AiHelpers.NanoTC.GetClosestNanoTC(unit.id)
			return {action = "corfus", pos = {x = x, y = y, z = z}}
		else
			return "corfus"
		end
    elseif Spring.GetTeamRulesParam(ai.id, "mmCapacity") < income(ai, "energy") then
       	if GG.AiHelpers.NanoTC.GetClosestNanoTC(unit.id) then
			local x, y, z = GG.AiHelpers.NanoTC.GetClosestNanoTC(unit.id)
			return {action = "cormmkr", pos = {x = x, y = y, z = z}}
		else
			return "cormmkr"
		end
	else
		return skip
	end
end

function CorMexT1( tqb, ai, unit )
	local hasTech2 = (UDC(ai.id, UDN.armack.id) + UDC(ai.id, UDN.armacv.id) +UDC(ai.id, UDN.armaca.id) +UDC(ai.id, UDN.corack.id) +UDC(ai.id, UDN.coracv.id) +UDC(ai.id, UDN.coraca.id)) >= ai.aimodehandler.mint2countpauset1
	if hasTech2 then
		return skip
	end
	return "cormex"
end

function CorStarterLabT1(tqb, ai, unit)
	if ai.aimodehandler.t2rusht1reclaim == true and AllAdvancedLabs(tqb, ai, unit) > 0 then return RequestedAction(tqb,ai,unit) end
	local countStarterFacs = UDC(ai.id, UDN.corvp.id) + UDC(ai.id, UDN.corlab.id) + UDC(ai.id, UDN.corap.id)
	if countStarterFacs < 1 then
		local labtype = KbotOrVeh()
		if labtype == "kbot" then
			return "corlab"
		else
			return "corvp"
		end
	else
		return skip
	end
end

function CorTech(tqb, ai, unit)
	if AllAdvancedLabs(tqb, ai, unit) == 0 then
		if (income(ai, "metal") > ai.aimodehandler.mintechmincome and (income(ai, "energy") > ai.aimodehandler.mintecheincome)) or (timetostore(ai, "metal", 2500) < 75 and timetostore(ai, "energy", 8000) < 25) then
			if unit:Name() == "corck" then
				local pos = unit:GetPosition()
				ai.requestshandler:AddRequest(false, {action = "command", params = {cmdID = CMD.FIGHT, cmdParams = {pos.x, pos.y, pos.z}, cmdOptions = {"shift"}}}, true)
				ai.firstT2 = true
				return "coralab"
			elseif unit:Name() == "corcv" then
				local pos = unit:GetPosition()
				ai.requestshandler:AddRequest(false, {action = "command", params = {cmdID = CMD.FIGHT, cmdParams = {pos.x, pos.y, pos.z}, cmdOptions = {"shift"}}}, true)
				ai.firstT2 = true
				return "coravp"
			else 
				return skip
			end
		else
			return skip
		end
	else
		return skip
	end
end

function CorExpandRandomLab(tqb, ai, unit)
	local labtype = ai.aimodehandler:CorExpandRandomLab(tqb,ai,unit)
	if UnitDefNames[labtype] then
		local defs = UnitDefs[UnitDefNames[labtype].id]
		if timetostore(ai, "metal", defs.metalCost) < defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed and timetostore(ai, "energy", defs.energyCost) < defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed and GetPlannedAndUnfinishedLabs(tqb, ai, unit) == 0  and AllAdvancedLabs(tqb,ai,unit) > 0 then
			labtype = labtype
		else
			labtype = skip
		end
	else
		labtype = skip
	end
	if labtype == skip then
		return labtype
	elseif GG.AiHelpers.NanoTC.GetClosestNanoTC(unit.id) then
		local x, y, z = GG.AiHelpers.NanoTC.GetClosestNanoTC(unit.id)
		return {action = labtype, pos = {x = x, y = y, z = z}}
	else
		return labtype
	end
end

function CorFirstT2Mexes(tqb, ai, unit)
	if not ai.firstt2mexes then
		ai.firstt2mexes = 1
		return "cormoho"
	elseif ai.firstt2mexes and ai.firstt2mexes <= 3 then
		ai.firstt2mexes = ai.firstt2mexes + 1
		return "cormoho"
	else
		return skip
	end
end

function CorFirstT1Mexes(tqb, ai, unit)
	if not ai.firstt1mexes then
		ai.firstt1mexes = 1
		return "cormex"
	elseif ai.firstt1mexes and ai.firstt1mexes <= 3 then
		ai.firstt1mexes = ai.firstt1mexes + 1
		return "cormex"
	else
		return skip
	end
end

function CorThirdMex(tqb, ai, unit)
	if income(ai, "metal") < 5.5 then
		return 'cormex'
	else
		return skip
	end
end

function CorGeo(tqb,ai,unit)
	if income(ai, "metal") < 20 then
		return skip
	else
		return "corgeo"
	end
end

function CorRad(tqb,ai,unit)
	local hasTech2 = (UDC(ai.id, UDN.armack.id) + UDC(ai.id, UDN.armacv.id) +UDC(ai.id, UDN.armaca.id) +UDC(ai.id, UDN.corack.id) +UDC(ai.id, UDN.coracv.id) +UDC(ai.id, UDN.coraca.id)) >= ai.aimodehandler.mint2countpauset1
	if hasTech2 then
		return skip
	end
	local pos = unit:GetPosition()
	for ct, unitID in pairs (Spring.GetUnitsInCylinder(pos.x, pos.z, UnitDefs[UDN.armrad.id].radarRadius, ai.id)) do
		local defID = Spring.GetUnitDefID(unitID)
		if defID == UDN.armrad.id or defID == UDN.corrad.id then
			return skip
		end
	end
	for ct, unitID in pairs (Spring.GetUnitsInCylinder(pos.x, pos.z, UnitDefs[UDN.armarad.id].radarRadius, ai.id)) do
		local defID = Spring.GetUnitDefID(unitID)
		if defID == UDN.armarad.id or defID == UDN.corarad.id then
			return skip
		end
	end
	return "corrad"
end

function CorProtection(tqb,ai,unit)
	if Spring.GetGameSeconds() > 1500 then
		local protype = (math.random(1,2) == 1) and "corgate" or "corfmd"
		if AllType(tqb, ai, unit, {UDN[protype].id}) < 1 then
			return protype
		end
		local defs = UnitDefs[UnitDefNames[protype].id]
		if timetostore(ai, "metal", defs.metalCost) < defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed and timetostore(ai, "energy", defs.energyCost) < defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed then
			return protype
		end
	end
	return skip
end

function CorARad(tqb,ai,unit)
	local pos = unit:GetPosition()
	for ct, unitID in pairs (Spring.GetUnitsInCylinder(pos.x, pos.z, UnitDefs[UDN.armarad.id].radarRadius, ai.id)) do
		local defID = Spring.GetUnitDefID(unitID)
		if defID == UDN.armarad.id or defID == UDN.corarad.id or defID == UDN.corrad.id or defID == UDN.armrad.id then
			return skip
		end
	end
	return "corarad"
end
--------------------------------------------------------------------------------------------
----------------------------------------- CoreTasks ----------------------------------------
--------------------------------------------------------------------------------------------

local corcommanderfirst = {
	CorMexT1,
	CorMexT1,
	CorThirdMex,
	CorWindOrSolar,
	CorWindOrSolar,
	CorStarterLabT1,
	CorWindOrSolar,
	CorWindOrSolar,
	ShortDefense,
	CorRad,
}

local cort1eco = {
	CorEnT1,
	CorNanoT,
	CorTech,
	CorEnT1,
	CorNanoT,
	CorTech,
	CorEnT1,
	CorNanoT,
	CorTech,
	CorNanoT,
	CorTech,
}

local cort1expand = {
	CorNanoT,
	CorExpandRandomLab,
	CorMexT1,
	CorExpandRandomLab,
	ShortDefense,
	CorMexT1,
	CorExpandRandomLab,
	assistaround,
	MediumDefense,
	CorRad,
	CorExpandRandomLab,
	CorGeo,
	ShortDefense,
	AADefense,
	assistaround,
	CorNanoT,
	CorExpandRandomLab,
	assistaround,
	CorNanoT,
}

local cort2eco = {
	CorEnT2,
	CorEnT2,
	CorEnT2,
	CorExpandRandomLab,
	CorProtection,
	CorEnT2,
	CorEnT2,
	CorEnT2,
	CorExpandRandomLab,
	Epic,
}

local cort2expand = {
	"cormoho",
	ShortDefense,
	"cormoho",
	MediumDefense,
	CorExpandRandomLab,
	"cormoho",
	CorARad,
	CorExpandRandomLab,
	AADefense,
	assistaround,
	Epic,
	LongDefense,
}

assistqueuepostt2arm = {
	ArmNanoT,
	ArmExpandRandomLab,
	ArmNanoT,
	RequestedAction,
}

assistqueuepostt2core = {
	CorNanoT,
	CorExpandRandomLab,
	CorNanoT,
	RequestedAction,
}

assistqueue = {
	assistaround,
	RequestedAction,
}

corassistqueue = {
	assistaround,
	RequestedAction,
	CorExpandRandomLab,
}

armassistqueue = {
	assistaround,
	RequestedAction,
	ArmExpandRandomLab,
}

assistqueuepatrol = {
	patrolaround,
}

assistqueuefreaker = {
	CorNanoT,
	assistaround,	
	RequestedAction,
}

assistqueueconsul = {
	ArmNanoT,
	assistaround,	
	RequestedAction,
}

-------------------
-- Arm Functions --
-------------------

function ArmWindOrSolar(tqb, ai, unit)
    local _,_,_,curWind = Spring.GetWind()
    local avgWind = (Game.windMin + Game.windMax)/2
	if ai and ai.id then
		if not (UDC(ai.id, UDN.armfus.id) + UDC(ai.id, UDN.corfus.id) > 1) then
			if curWind > 7 then
				return "armwin"
			else
				
				
				if income(ai, "energy") > 200 and income(ai, "metal") > 15 and (UUDC("armadvsol", ai.id) + UUDC("coradvsol", ai.id)) < 2 then
					return "armadvsol"
				else
					return "armsolar"
				end
			end
		else
			return skip	
		end
	else
		return "armsolar"
	end
end

function ArmNanoT(tqb, ai, unit)
	if timetostore(ai, "energy", 5000) < 40 and timetostore(ai, "metal", 300) < 40 and UDC(ai.id, UDN.armnanotc.id) + UDC(ai.id, UDN.cornanotc.id) < income(ai, "energy")/150 then
		return "armnanotc"
	else
		return skip
	end
end

function ArmEnT1( tqb, ai, unit)
	local countEstore = UDC(ai.id, UDN.corestor.id) + UDC(ai.id, UDN.armestor.id)
	if (income(ai, "energy") < ai.aimodehandler.eincomelimiterpretech2) and realincome(ai, "energy") < 0 and curstorperc(ai, "energy") < 80 then
		return (ArmWindOrSolar(tqb, ai, unit))
	elseif (income(ai, "energy") < ai.aimodehandler.eincomelimiterposttech2) and realincome(ai, "energy") < 0 and curstorperc(ai, "energy") < 80 and GetFinishedAdvancedLabs(tqb, ai, unit) >= 1 then
		return (ArmWindOrSolar(tqb, ai, unit))
	elseif Spring.GetTeamRulesParam(ai.id, "mmCapacity") < income(ai, "energy") and curstorperc(ai, "energy") > 30 then
		return "armmakr"
	elseif storabletime(ai, "energy") < 8 and curstorperc(ai, "energy") > 80 then
		return "armestor"
	elseif storabletime(ai, "metal") < 8 or curstorperc(ai, "metal") > 90 then
		return "armmstor"
	else
		return skip
	end
end

function ArmEnT2( tqb, ai, unit )
	--if storabletime(ai, "energy") < 10 and not (GetPlannedAndUnfinishedType(tqb,ai,unit, {UDN.coruwadves.id, UDN.armuwadves.id }) > 0)then
		--return "armuwadves"
	--elseif storabletime(ai, "metal") < 5 and not (GetPlannedAndUnfinishedType(tqb,ai,unit, {UDN.coruwadvms.id, UDN.armuwadvms.id }) > 0)then
		--return "armuwadvms"
	if income(ai, "energy") > 6000 and income(ai, "metal") > 100 and Spring.GetTeamRulesParam(ai.id, "mmCapacity") > income(ai, "energy")-3000 and income(ai, "energy") < ((math.max((Spring.GetGameSeconds() / 60) - 5, 1)/6) ^ 2) * 1000 and unit:Name() == "armacv" then
       	if GG.AiHelpers.NanoTC.GetClosestNanoTC(unit.id) then
			local x, y, z = GG.AiHelpers.NanoTC.GetClosestNanoTC(unit.id)
			return {action = "armafus", pos = {x = x, y = y, z = z}}
		else
			return "armafus"
		end
	elseif income(ai, "energy") > ai.aimodehandler.mintecheincome and income(ai, "metal") > ai.aimodehandler.mintechmincome and Spring.GetTeamRulesParam(ai.id, "mmCapacity") > income(ai, "energy")-1200 and income(ai, "energy") < ((math.max((Spring.GetGameSeconds() / 60) - 5, 1)/6) ^ 2) * 1000 then
       	if GG.AiHelpers.NanoTC.GetClosestNanoTC(unit.id) then
			local x, y, z = GG.AiHelpers.NanoTC.GetClosestNanoTC(unit.id)
			return {action = "armfus", pos = {x = x, y = y, z = z}}
		else
			return "armfus"
		end
	elseif income(ai, "energy") > 6000 and income(ai, "metal") > 100 and (UUDC("armafus",ai.id) + UUDC("corafus",ai.id)) < 2 and Spring.GetTeamRulesParam(ai.id, "mmCapacity") > income(ai, "energy")-3000 and timetostore(ai, "metal", UnitDefs[UnitDefNames["armafus"].id].metalCost) < 240 and unit:Name() == "armacv" then
       	if GG.AiHelpers.NanoTC.GetClosestNanoTC(unit.id) then
			local x, y, z = GG.AiHelpers.NanoTC.GetClosestNanoTC(unit.id)
			return {action = "armafus", pos = {x = x, y = y, z = z}}
		else
			return "armafus"
		end
    elseif Spring.GetTeamRulesParam(ai.id, "mmCapacity") < income(ai, "energy") then
       	if GG.AiHelpers.NanoTC.GetClosestNanoTC(unit.id) then
			local x, y, z = GG.AiHelpers.NanoTC.GetClosestNanoTC(unit.id)
			return {action = "armmmkr", pos = {x = x, y = y, z = z}}
		else
			return "armmmkr"
		end
	else
		return skip
	end
end

function ArmMexT1( tqb, ai, unit )
	local hasTech2 = (UDC(ai.id, UDN.armack.id) + UDC(ai.id, UDN.armacv.id) +UDC(ai.id, UDN.armaca.id) +UDC(ai.id, UDN.corack.id) +UDC(ai.id, UDN.coracv.id) +UDC(ai.id, UDN.coraca.id)) >= ai.aimodehandler.mint2countpauset1
	if hasTech2 then
		return skip
	end
	return "armmex"
end

function ArmStarterLabT1(tqb, ai, unit)
	if ai.aimodehandler.t2rusht1reclaim == true and AllAdvancedLabs(tqb, ai, unit) > 0 then return RequestedAction(tqb, ai, unit) end
	local countStarterFacs = UDC(ai.id, UDN.armvp.id) + UDC(ai.id, UDN.armlab.id) + UDC(ai.id, UDN.armap.id)
	if countStarterFacs < 1 then
		local labtype = KbotOrVeh()
		if labtype == "kbot" then
			return "armlab"
		else
			return "armvp"
		end
	else
		return skip
	end
end

function ArmTech(tqb, ai, unit)
	if AllAdvancedLabs(tqb, ai, unit) == 0 then
		if (income(ai, "metal") > ai.aimodehandler.mintechmincome and (income(ai, "energy") > ai.aimodehandler.mintecheincome)) or (timetostore(ai, "metal", 2500) < 75 and timetostore(ai, "energy", 8000) < 25) then
			if unit:Name() == "armck" then
				local pos = unit:GetPosition()
				ai.requestshandler:AddRequest(false, {action = "command", params = {cmdID = CMD.FIGHT, cmdParams = {pos.x, pos.y, pos.z}, cmdOptions = {"shift"}}}, true)
				ai.firstT2 = true
				return "armalab"
			elseif unit:Name() == "armcv" then
				local pos = unit:GetPosition()
				ai.requestshandler:AddRequest(false, {action = "command", params = {cmdID = CMD.FIGHT, cmdParams = {pos.x, pos.y, pos.z}, cmdOptions = {"shift"}}}, true)
				ai.firstT2 = true
				return "armavp"
			else 
				return skip
			end
		else
			return skip
		end
	else
		return skip	
	end
end

function ArmExpandRandomLab(tqb, ai, unit)
	local labtype = ai.aimodehandler:ArmExpandRandomLab(tqb,ai,unit)
	if UnitDefNames[labtype] then
		local defs = UnitDefs[UnitDefNames[labtype].id]
		if timetostore(ai, "metal", defs.metalCost) < defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed and timetostore(ai, "energy", defs.energyCost) < defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed and GetPlannedAndUnfinishedLabs(tqb, ai, unit) == 0 and AllAdvancedLabs(tqb,ai,unit) > 0 then
			labtype = labtype
		else
			labtype = skip
		end
	else
		labtype = skip
	end
	if labtype == skip then
		return labtype
	elseif GG.AiHelpers.NanoTC.GetClosestNanoTC(unit.id) then
		local x, y, z = GG.AiHelpers.NanoTC.GetClosestNanoTC(unit.id)
		return {action = labtype, pos = {x = x, y = y, z = z}}
	else
		return labtype
	end
end

function ArmFirstT2Mexes(tqb, ai, unit)
	if not ai.firstt2mexes then
		ai.firstt2mexes = 1
		return "armmoho"
	elseif ai.firstt2mexes and ai.firstt2mexes <= 3 then
		ai.firstt2mexes = ai.firstt2mexes + 1
		return "armmoho"
	else
		return skip
	end
end

function ArmFirstT1Mexes(tqb, ai, unit)
	if not ai.firstt1mexes then
		ai.firstt1mexes = 1
		return "armmex"
	elseif ai.firstt1mexes and ai.firstt1mexes <= 3 then
		ai.firstt1mexes = ai.firstt1mexes + 1
		return "armmex"
	else
		return skip
	end
end

function ArmThirdMex(tqb, ai, unit)
	if income(ai, "metal") < 5.5 then
		return 'armmex'
	else
		return ArmWindOrSolar(tqb,ai,unit)
	end
end

function ArmGeo(tqb,ai,unit)
	if income(ai, "metal") < 20 then
		return skip
	else
		return "armgeo"
	end
end

function ArmRad(tqb,ai,unit)
	local hasTech2 = (UDC(ai.id, UDN.armack.id) + UDC(ai.id, UDN.armacv.id) +UDC(ai.id, UDN.armaca.id) +UDC(ai.id, UDN.corack.id) +UDC(ai.id, UDN.coracv.id) +UDC(ai.id, UDN.coraca.id)) >= ai.aimodehandler.mint2countpauset1
	if hasTech2 then
		return skip
	end
	local pos = unit:GetPosition()
	for ct, unitID in pairs (Spring.GetUnitsInCylinder(pos.x, pos.z, UnitDefs[UDN.armrad.id].radarRadius, ai.id)) do
		local defID = Spring.GetUnitDefID(unitID)
		if defID == UDN.armrad.id or defID == UDN.corrad.id then
			return skip
		end
	end
	for ct, unitID in pairs (Spring.GetUnitsInCylinder(pos.x, pos.z, UnitDefs[UDN.armarad.id].radarRadius, ai.id)) do
		local defID = Spring.GetUnitDefID(unitID)
		if defID == UDN.armarad.id or defID == UDN.corarad.id then
			return skip
		end
	end
	return "armrad"
end

function ArmARad(tqb,ai,unit)
	local pos = unit:GetPosition()
	for ct, unitID in pairs (Spring.GetUnitsInCylinder(pos.x, pos.z, UnitDefs[UDN.armarad.id].radarRadius, ai.id)) do
		local defID = Spring.GetUnitDefID(unitID)
		if defID == UDN.armarad.id or defID == UDN.corarad.id or defID == UDN.armrad.id or defID == UDN.corrad.id then
			return skip
		end
	end
	return "armarad"
end

function ArmProtection(tqb,ai,unit)
	if Spring.GetGameSeconds() > 1500 then
		local protype = (math.random(1,2) == 1) and "armgate" or "armamd"
		if AllType(tqb, ai, unit, {UDN[protype].id}) < 1 then
			return protype
		end
		local defs = UnitDefs[UnitDefNames[protype].id]
		if timetostore(ai, "metal", defs.metalCost) < defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed and timetostore(ai, "energy", defs.energyCost) < defs.buildTime/UnitDefs[UnitDefNames[unit:Name()].id].buildSpeed then
			return protype
		end
	end
	return skip
end

--------------
-- ArmTasks --
--------------

local armcommanderfirst = {
	ArmMexT1,
	ArmMexT1,
	ArmThirdMex,
	ArmWindOrSolar,
	ArmWindOrSolar,
	ArmStarterLabT1,
	ArmWindOrSolar,
	ArmWindOrSolar,
	ShortDefense,
	ArmRad,
}

local armt1eco = {
	ArmEnT1,
	ArmNanoT,
	ArmTech,
	ArmEnT1,
	ArmNanoT,
	ArmTech,
	ArmEnT1,
	ArmNanoT,
	ArmTech,
	ArmNanoT,
	ArmTech,
}

local armt1expand = {
	ArmNanoT,
	ArmExpandRandomLab,
	ArmMexT1,
	ArmExpandRandomLab,
	ShortDefense,
	ArmMexT1,
	ArmExpandRandomLab,
	assistaround,
	MediumDefense,
	ArmRad,
	ArmExpandRandomLab,
	ArmGeo,
	assistaround,
	ArmNanoT,
	ArmExpandRandomLab,
	ShortDefense,
	AADefense,
	assistaround,
	ArmNanoT,
}

local armt2eco = {
	ArmEnT2,
	ArmEnT2,
	ArmEnT2,
	ArmExpandRandomLab,
	ArmProtection,
	ArmEnT2,
	ArmEnT2,
	ArmEnT2,
	ArmExpandRandomLab,
	Epic,
}

local armt2expand = {
	"armmoho",
	ShortDefense,
	"armmoho",
	ArmExpandRandomLab,
	MediumDefense,
	"armmoho",
	ArmARad,
	ArmExpandRandomLab,
	AADefense,
	assistaround,
	Epic,
	LongDefense,
}


------------------
-- QueuePickers --
------------------

local function corcommander(tqb, ai, unit)
	ai.t1priorityrate = ai.t1priorityrate or ai.aimodehandler.t1ratepret2
	local countBasicFacs = UDC(ai.id, UDN.corvp.id) + UDC(ai.id, UDN.corlab.id) + UDC(ai.id, UDN.corap.id) + UDC(ai.id, UDN.corhp.id)
	if AllLabs(tqb,ai,unit) > 0 then
		return corassistqueue
	elseif ai.engineerfirst then
		return {CorStarterLabT1}
	else
		ai.engineerfirst = true
		return corcommanderfirst
	end
end

local function armcommander(tqb, ai, unit)
	ai.t1priorityrate = ai.t1priorityrate or ai.aimodehandler.t1ratepret2
	local countBasicFacs = UDC(ai.id, UDN.armvp.id) + UDC(ai.id, UDN.armlab.id) + UDC(ai.id, UDN.armap.id) + UDC(ai.id, UDN.armhp.id)
	if AllLabs(tqb,ai,unit) > 0 then
		return armassistqueue
	elseif ai.engineerfirst then
		return {ArmStarterLabT1}
	else
		ai.engineerfirst = true
		return armcommanderfirst
	end
end

local function armt1con(tqb, ai, unit)
	local hasTech2 = (UDC(ai.id, UDN.armack.id) + UDC(ai.id, UDN.armacv.id) +UDC(ai.id, UDN.armaca.id) +UDC(ai.id, UDN.corack.id) +UDC(ai.id, UDN.coracv.id) +UDC(ai.id, UDN.coraca.id)) >= ai.aimodehandler.mint2countpauset1
	if not unit.mode then
		ai.t1concounter = (ai.t1concounter or 0) + 1
		if ai.t1concounter%10 == 8 or ai.t1concounter%10 == 9 then
			unit.mode = "assist"
		elseif ai.t1concounter%10 == 1 or ai.t1concounter%10 == 3 or ai.t1concounter%10 == 4 or ai.t1concounter%10 == 5 or ai.t1concounter%10 == 7 or ai.t1concounter%10 == 0 then
			unit.mode = "expand"
		else
			unit.mode = "eco"
		end
	end
	if unit.mode == "eco" then
		if (income(ai, "energy") < ai.aimodehandler.eincomelimiterpretech2 or AllAdvancedLabs(tqb, ai, unit) < 1) then
			ai.t1priorityrate = ai.aimodehandler.t1ratepret2
			return armt1eco
		else
		ai.t1priorityrate = ai.aimodehandler.t1ratepostt2
			return armt1expand
		end
	elseif unit.mode == "expand" and (not hasTech2) then
		return armt1expand
	elseif GetFinishedAdvancedLabs(tqb,ai,unit) >= 1 then
		return assistqueuepostt2arm	
	else
		return armassistqueue
	end
	return armassistqueue
end

local function cort1con(tqb, ai, unit)
	local hasTech2 = (UDC(ai.id, UDN.armack.id) + UDC(ai.id, UDN.armacv.id) +UDC(ai.id, UDN.armaca.id) +UDC(ai.id, UDN.corack.id) +UDC(ai.id, UDN.coracv.id) +UDC(ai.id, UDN.coraca.id)) >= ai.aimodehandler.mint2countpauset1
	if not unit.mode then
		ai.t1concounter = (ai.t1concounter or 0) + 1
		if ai.t1concounter%10 == 8 or ai.t1concounter%10 == 9 then
			unit.mode = "assist"
		elseif ai.t1concounter%10 == 1 or ai.t1concounter%10 == 3 or ai.t1concounter%10 == 4 or ai.t1concounter%10 == 5 or ai.t1concounter%10 == 7 or ai.t1concounter%10 == 0 then
			unit.mode = "expand"
		else
			unit.mode = "eco"
		end
	end
	if unit.mode == "eco" then
		if (income(ai, "energy") < ai.aimodehandler.eincomelimiterpretech2 or AllAdvancedLabs(tqb, ai, unit) < 1) then
			ai.t1priorityrate = ai.aimodehandler.t1ratepret2
			return cort1eco
		else
			ai.t1priorityrate = ai.aimodehandler.t1ratepostt2
			return cort1expand
		end
	elseif unit.mode == "expand" and (not hasTech2) then
		return cort1expand
	elseif GetFinishedAdvancedLabs(tqb,ai,unit) >= 1 then
		return assistqueuepostt2core
	else
		return corassistqueue
	end
	return corassistqueue
end

local function armt2con(tqb, ai, unit)
	if not unit.mode then
		ai.t2concounter = (ai.t2concounter or 0) + 1
		if ai.t2concounter%10 == 8 or ai.t2concounter%10 == 9 then
			unit.mode = "assist"
		elseif ai.t2concounter%10 == 1 or ai.t2concounter%10 == 2 or ai.t2concounter%10 == 4 or ai.t2concounter%10 == 5 or ai.t2concounter%10 == 7 or ai.t2concounter%10 == 0 then
			unit.mode = "expand"
		else
			unit.mode = "eco"
		end
	end
	if unit.mode == "eco" then
		return armt2eco
	elseif unit.mode == "expand" then
		return armt2expand
	else
		return armassistqueue
	end
	return armassistqueue
end

local function cort2con(tqb, ai, unit)
	if not unit.mode then
		ai.t2concounter = (ai.t2concounter or 0) + 1
		if ai.t2concounter%10 == 8 or ai.t2concounter%10 == 9 then
			unit.mode = "assist"
		elseif ai.t2concounter%10 == 1 or ai.t2concounter%10 == 2 or ai.t2concounter%10 == 4 or ai.t2concounter%10 == 5 or ai.t2concounter%10 == 7 or ai.t2concounter%10 == 0 then
			unit.mode = "expand"
		else
			unit.mode = "eco"
		end
	end
	if unit.mode == "eco" then
		return cort2eco
	elseif unit.mode == "expand" then
		return cort2expand
	else
		return corassistqueue
	end
	return corassistqueue
end

--------------------------------------------------------------------------------------------
---------------------------------------- TASKQUEUES ----------------------------------------
--------------------------------------------------------------------------------------------

taskqueues = {
	---CORE
	--constructors
	corcom = corcommander,
	corck = cort1con,
	corcv = cort1con,
	corca = cort1con,
	corch = cort1con,
	cornanotc = assistqueuepatrol,
	corack = cort2con,
	coracv = cort2con,
	coraca = cort2con,
	-- ASSIST
	corfast = assistqueuefreaker,
	--factories
	corlab = lab,
	corvp = lab,
	corap = airlab,
	coralab = lab,
	coravp = lab,
	coraap = airlab,
	corhp = lab,
	corgant = lab,

	---ARM
	--constructors
	armcom = armcommander,
	armck = armt1con,
	armcv = armt1con,
	armca = armt1con,
	armch = armt1con,
	armnanotc = assistqueuepatrol,
	armack = armt2con,
	armacv = armt2con,
	armaca = armt2con,
	--ASSIST
	armconsul = assistqueueconsul,
	armfark = assistqueuepatrol,
	--factories
	armlab = lab,
	armvp = lab,
	armap = airlab,
	armalab = lab,
	armavp = lab,
	armaap = airlab,
	armhp = lab,
	armshltx = lab,
}
