return {
	armamb = {
		activatewhenbuilt = false,
		buildangle = 8192,
		buildpic = "ARMAMB.DDS",
		buildtime = 27000,
		canrepeat = false,
		cloakcost = 24,
		collisionvolumeoffsets = "0 0 0",
		collisionvolumescales = "60 30 60",
		collisionvolumetype = "CylY",
		corpse = "DEAD",
		damagemodifier = 0.25,
		energycost = 17000,
		explodeas = "smallBuildingexplosiongeneric",
		footprintx = 4,
		footprintz = 4,
		health = 4000,
		idleautoheal = 5,
		idletime = 1800,
		maxacc = 0,
		maxdec = 0,
		maxslope = 10,
		maxwaterdepth = 0,
		metalcost = 2500,
		mincloakdistance = 70,
		nochasecategory = "MOBILE",
		objectname = "Units/ARMAMB.s3o",
		onoffable = true,
		script = "Units/ARMAMB.cob",
		seismicsignature = 0,
		selfdestructas = "smallBuildingExplosionGenericSelfd",
		sightdistance = 442,
		usepiececollisionvolumes = 1,
		yardmap = "oooooooooooooooo",
		customparams = {
			buildinggrounddecaldecayspeed = 30,
			buildinggrounddecalsizex = 5,
			buildinggrounddecalsizey = 5,
			buildinggrounddecaltype = "decals/armamb_aoplane.dds",
			model_author = "Beherith",
			normaltex = "unittextures/Arm_normal.dds",
			onoffname = "trajectory",
			removewait = true,
			subfolder = "ArmBuildings/LandDefenceOffence",
			techlevel = 2,
			unitgroup = "weapon",
			usebuildinggrounddecal = true,
		},
		featuredefs = {
			dead = {
				blocking = true,
				category = "corpses",
				collisionvolumeoffsets = "-0.544998168945 2.61108398441e-05 -0.5",
				collisionvolumescales = "60 30 60",
				collisionvolumetype = "cylY",
				damage = 2160,
				featuredead = "HEAP",
				footprintx = 3,
				footprintz = 3,
				height = 20,
				metal = 1522,
				object = "Units/armamb_dead.s3o",
				reclaimable = true,
			},
			heap = {
				blocking = false,
				category = "heaps",
				collisionvolumescales = "55.0 4.0 6.0",
				collisionvolumetype = "cylY",
				damage = 540,
				footprintx = 3,
				footprintz = 3,
				height = 4,
				metal = 244,
				object = "Units/arm3X3B.s3o",
				reclaimable = true,
				resurrectable = 0,
			},
		},
		sfxtypes = {
			explosiongenerators = {
				[1] = "custom:barrelshot-larger",
			},
			pieceexplosiongenerators = {
				[1] = "deathceg2",
				[2] = "deathceg3",
				[3] = "deathceg4",
			},
		},
		sounds = {
			canceldestruct = "cancel2",
			cloak = "kloak1",
			uncloak = "kloak1un",
			underattack = "warning1",
			cant = {
				[1] = "cantdo4",
			},
			count = {
				[1] = "count6",
				[2] = "count5",
				[3] = "count4",
				[4] = "count3",
				[5] = "count2",
				[6] = "count1",
			},
			ok = {
				[1] = "twrturn3",
			},
			select = {
				[1] = "twrturn3",
			},
		},
		weapondefs = {
			armamb_gun = {
				accuracy = 400,
				areaofeffect = 152,
				avoidfeature = false,
				cegtag = "arty-heavy",
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.4,
				explosiongenerator = "custom:genericshellexplosion-medium-aoe",
				gravityaffected = "true",
				impulsefactor = 0.5,
				name = "Pop-up heavy  long range g2g plasna cannon",
				noselfdamage = true,
				predictboost = 0.2,
				range = 1380,
				reloadtime = 1.8,
				soundhit = "xplomed2",
				soundhitwet = "splslrg",
				soundstart = "cannhvy5",
				turret = true,
				weapontype = "Cannon",
				weaponvelocity = 450,
				damage = {
					default = 350,
					subs = 150,
					vtol = 90,
				},
				customparams = {
					exclude_preaim = true
				}
			},
			armamb_gun_high = {
				accuracy = 400,
				areaofeffect = 224,
				avoidfeature = false,
				cegtag = "arty-huge",
				craterareaofeffect = 224,
				craterboost = 0.0492,
				cratermult = 0.0492,
				edgeeffectiveness = 0.65,
				explosiongenerator = "custom:genericshellexplosion-large-bomb",
				gravityaffected = "true",
				hightrajectory = 1,
				impulsefactor = 2,
				name = "Pop-up high-trajectory heavy  long range AoE g2g plasma cannon",
				noselfdamage = true,
				proximitypriority = -1,
				range = 1380,
				reloadtime = 7,
				soundhit = "xplolrg4",
				soundhitwet = "splslrg",
				soundstart = "cannhvy6",
				turret = true,
				weapontype = "Cannon",
				weaponvelocity = 440,
				damage = {
					default = 850,
					subs = 150,
					vtol = 90,
				},
				customparams = {
					exclude_preaim = true
				}
			},
		},
		weapons = {
			[1] = {
				badtargetcategory = "VTOL GROUNDSCOUT",
				def = "ARMAMB_GUN",
				maindir = "0 1 0",
				maxangledif = 230,
				onlytargetcategory = "SURFACE",
			},
			[2] = {
				badtargetcategory = "VTOL GROUNDSCOUT",
				def = "ARMAMB_GUN_HIGH",
				onlytargetcategory = "SURFACE",
			},
		},
	},
}
