Config = {
	Debug = false,
	PickAmount = { min = 8, max = 12 },
	GrapeAmount = { min = 8, max = 12 },
	GrapeJuiceAmount = { min = 6, max = 10 },
	WineAmount = { min = 6, max = 10 },
	wineTimer = 180,
	Sell = {
		enabled = true,
		coords = vector3(-1487.32, -379.02, 40.16),
		zones = {
			vector2(-1485.89, -377.54),
			vector2(-1487.87, -376.12),
			vector2(-1488.95, -377.67),
			vector2(-1486.92, -379.12),
		},
		minZ = 39.60,
		maxZ = 41.20,
		prices = {
			wine = 15,
			grapejuice = 10
		}
	},
	Vineyard = {
		start = {
			coords = vector3(-1928.81, 2059.53, 140.84),
			zones = {
				vector2(-1926.19, 2059.13),
				vector2(-1925.46, 2062.16),
				vector2(-1930.47, 2063.81),
				vector2(-1931.35, 2060.37),
			},
			minZ = 140.24,
			maxZ = 141.44
		},
		wine = {
			coords = vector3(-1879.54, 2062.55, 135.92),
			zones = {
				vector2(-1873.85, 2063.01),
				vector2(-1876.35, 2059.48),
				vector2(-1883.02, 2062.11),
				vector2(-1882.03, 2064.85),
				vector2(-1880.51, 2065.44)
			},
			minZ = 135.42,
			maxZ = 136.42
		},
		grapejuice = {
			coords = vector3(828.76, 2191.16, 52.37),
			zones = {
				vector2(830.91, 2194.49),
				vector2(827.81, 2196.07),
				vector2(824.6, 2189.71),
				vector2(827.54, 2188.28),
			},
			minZ = 51.85,
			maxZ = 52.74
		}
	}
}
