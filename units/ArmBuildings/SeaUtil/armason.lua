return {
	armason = {
		activatewhenbuilt = true,
		buildangle = 8192,
		buildpic = "ARMASON.DDS",
		buildtime = 6150,
		canattack = false,
		canrepeat = false,
		corpse = "DEAD",
		energycost = 2600,
		explodeas = "mediumBuildingexplosiongeneric-uw",
		footprintx = 4,
		footprintz = 4,
		health = 2350,
		idleautoheal = 5,
		idletime = 1800,
		maxacc = 0,
		maxdec = 0,
		maxslope = 10,
		metalcost = 170,
		minwaterdepth = 24,
		objectname = "Units/ARMASON.s3o",
		onoffable = false,
		script = "Units/ARMASON.cob",
		seismicsignature = 0,
		selfdestructas = "mediumBuildingExplosionGenericSelfd-uw",
		sightdistance = 215,
		sonardistance = 1600,
		yardmap = "yooy oooo oooo yooy",
		customparams = {
			buildinggrounddecaldecayspeed = 30,
			buildinggrounddecalsizex = 6,
			buildinggrounddecalsizey = 6,
			buildinggrounddecaltype = "decals/armason_aoplane.dds",
			model_author = "FireStorm",
			normaltex = "unittextures/Arm_normal.dds",
			removestop = true,
			removewait = true,
			subfolder = "ArmBuildings/SeaUtil",
			techlevel = 2,
			unitgroup = "util",
			usebuildinggrounddecal = true,
		},
		featuredefs = {
			dead = {
				blocking = false,
				category = "corpses",
				collisionvolumeoffsets = "-2.53617095947 -6.10351563068e-07 -2.30155944824",
				collisionvolumescales = "30.2144622803 57.7799987793 23.5352478027",
				collisionvolumetype = "Box",
				damage = 1272,
				footprintx = 4,
				footprintz = 4,
				height = 40,
				metal = 106,
				object = "Units/armason_dead.s3o",
				reclaimable = true,
			},
		},
		sfxtypes = {
			pieceexplosiongenerators = {
				[1] = "deathceg2",
				[2] = "deathceg3",
				[3] = "deathceg4",
			},
		},
		sounds = {
			activate = "cmd-on",
			canceldestruct = "cancel2",
			deactivate = "cmd-off",
			underattack = "warning1",
			count = {
				[1] = "count6",
				[2] = "count5",
				[3] = "count4",
				[4] = "count3",
				[5] = "count2",
				[6] = "count1",
			},
			select = {
				[1] = "sonar1",
			},
		},
	},
}
