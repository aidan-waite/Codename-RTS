return {
	corah = {
		acceleration = 0.096,
		airsightdistance = 800,
		brakerate = 0.336,
		buildcostenergy = 4700,
		buildcostmetal = 250,
		buildpic = "CORAH.DDS",
		buildtime = 3650,
		canmove = true,
		category = "ALL HOVER MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
		collisionvolumeoffsets = "0 -1 0",
		collisionvolumescales = "28 16 28",
		collisionvolumetype = "CylY",
		corpse = "DEAD",
		description = "Anti-Air Hovercraft",
		energymake = 2.6,
		energyuse = 2.6,
		explodeas = "smallexplosiongeneric",
		footprintx = 3,
		footprintz = 3,
		idleautoheal = 5,
		idletime = 1800,
		maxdamage = 1008,
		maxslope = 16,
		maxvelocity = 3.34,
		maxwaterdepth = 0,
		movementclass = "HOVER3",
		name = "Slinger",
		nochasecategory = "ALL",
		objectname = "CORAH",
		seismicsignature = 0,
		selfdestructas = "smallexplosiongeneric",
		sightdistance = 509,
		sonardistance = 350,
		turninplace = 0,
		turninplaceanglelimit = 140,
		turninplacespeedlimit = 2.2044,
		turnrate = 470,
		customparams = {
			
		},
		featuredefs = {
			dead = {
				blocking = false,
				category = "corpses",
				collisionvolumeoffsets = "2.10999298096 0.00491292724609 -0.668823242188",
				collisionvolumescales = "29.5848236084 21.4446258545 33.5151977539",
				collisionvolumetype = "Box",
				damage = 605,
				description = "Slinger Wreckage",
				energy = 0,
				featuredead = "HEAP",
				footprintx = 3,
				footprintz = 3,
				height = 20,
				hitdensity = 100,
				metal = 154,
				object = "CORAH_DEAD",
				reclaimable = true,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
			},
			heap = {
				blocking = false,
				category = "heaps",
				damage = 303,
				description = "Slinger Heap",
				energy = 0,
				footprintx = 3,
				footprintz = 3,
				height = 4,
				hitdensity = 100,
				metal = 62,
				object = "3X3B",
                collisionvolumescales = "55.0 4.0 6.0",
                collisionvolumetype = "cylY",
				reclaimable = true,
				resurrectable = 0,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
			},
		},
		sfxtypes = { 
 			pieceExplosionGenerators = { 
				"deathceg2",
				"deathceg3",
			},
		},
		sounds = {
			canceldestruct = "cancel2",
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
				[1] = "hovmdok2",
			},
			select = {
				[1] = "hovmdsl2",
			},
		},
		weapondefs = {
			bogus_missile = {
				areaofeffect = 48,
				avoidfeature = false,
				canattackground = false,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				impulseboost = 0,
				impulsefactor = 0,
				metalpershot = 0,
				name = "Missiles",
				range = 800,
				reloadtime = 0.5,
				soundhitwet = "splshbig",
				soundhitwetvolume = 0.5,
				startvelocity = 450,
				tolerance = 9000,
				turnrate = 33000,
				turret = true,
				weaponacceleration = 101,
				weapontimer = 0.1,
				weapontype = "Cannon",
				weaponvelocity = 650,
				damage = {
					default = 0,
				},
			},
			coreah_weapon = {
				areaofeffect = 48,
				avoidfeature = false,
				burst = 3,
				burstrate = 0.2,
				canattackground = false,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				cegTag = "missiletrailaa",
				explosiongenerator = "custom:genericshellexplosion-small-aa",
				firestarter = 70,
				flighttime = 1.75,
				impulseboost = 0.123,
				impulsefactor = 0.123,
				metalpershot = 0,
				model = "missile",
				name = "Missiles",
				noselfdamage = true,
				range = 720,
				reloadtime = 2.2,
				smoketrail = false,
				soundhit = "xplomed2",
				soundhitwet = "splshbig",
				soundhitwetvolume = 0.5,
				soundstart = "rockhvy2",
				startvelocity = 320,
				texture2 = "coresmoketrail",
				tolerance = 10000,
				tracks = true,
				turnrate = 63000,
				turret = true,
				weaponacceleration = 250,
				weapontimer = 5,
				weapontype = "MissileLauncher",
				weaponvelocity = 800,
				damage = {
					bombers = 62,
					fighters = 62,
					vtol = 62,
				},
			},
		},
		weapons = {
			[1] = {
				badtargetcategory = "LIGHTAIRSCOUT",
				def = "BOGUS_MISSILE",
				onlytargetcategory = "VTOL",
			},
			[2] = {
				badtargetcategory = "LIGHTAIRSCOUT",
				def = "COREAH_WEAPON",
				onlytargetcategory = "VTOL",
			},
		},
	},
}
