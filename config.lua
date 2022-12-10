Config = {}

Config.Core = "qb-core" -- Your core name / folder
Config.Target = "qb-target" -- Your target name / folder
Config.Debug = false -- If true some prints goes to client side and console
Config.Phone = "qs-smartphone" -- Your phone | Available: "qs-smartphone" , "qb-phone", "gksphone"
Config.Selling = vector3(-330.99, -2778.9, 5.15) -- This is the location of second ped when you gona sell the wines

Config.Peds = {
	[1] = {type = 4, hash= GetHashKey("a_m_m_farmer_01"), x = -1928.67,  y = 2059.65,  z = 139.84, h = 347.88}, -- Starting the job
	[2] = {type = 4, hash= GetHashKey("a_m_m_farmer_01"), x = -330.99,  y = -2778.9,  z = 4.15, h = 88.03}, -- Selling the wines
}

Config.Zones = { -- Zones to pickup grape
    [1] = {
        zones = { 
        	vector2(-1913.6730957031, 2101.4836425781),
	  		vector2(-1907.7342529297, 2154.0473632812),
	  		vector2(-1764.4007568359, 2147.7473144531),
	  		vector2(-1857.1300048828, 2090.5693359375)
        },
    },
}

Config.Blips = {
	[1] = { Enable = true, Location = vector3(-1928.67, 2059.65, 139.84), Sprite = 266, Display = 2, Scale = 0.8, Colour = 27, Name = "Vineyard",},
	[2] = { Enable = true, Location = vector3(-1859.62, 2069.74, 141.06), Sprite = 365, Display = 2, Scale = 0.8, Colour = 27, Name = "Wash Grapes",},
	[3] = { Enable = true, Location = vector3(-1886.4, 2115.57, 133.33), Sprite = 253, Display = 2, Scale = 0.8, Colour = 27, Name = "Pick Grapes"},
}

Config.Times = {
	TakeJob = 5000, -- Time of progressbar when you are obtaining the job
	Pickup = 5000, -- Time of progressbar when you are picking up
	Crushing = 5000, -- Time of progressbar when you are crushing the grapes
	Trading = 5000, -- Time of progressbar when you are trading the grapes to wine
	Selling = 5000, -- Time of progressbar when you are selling
	Drinking = 5000, -- Time of progressbar when you drinkin wines
}

Config.Drops = {
	pickup = {min = 2, max = 4}, -- Drop when you go pickup grape 
	tread = {min = 2, max = 4}, -- Drop when you go crushing grapes
	trade = {min = 2, max = 4}, -- Drop when you trade grapes to wines
}

Config.Minigame = { -- ps-ui https://github.com/Project-Sloth/ps-ui
	NumberOfCircles = 2,
	MS = 20,
}

Config.Payment = {
	Type = "cash", -- "cash" or "bank"
	Amount = {min = 50, max = 150}, -- Each bottle of wine
}

Config.Drinks = {
	Enable = true, -- Enable player drink redwine and rosewine?
	Effects = true, -- Enable effects when drink redwine or rosewine?
	Time = 5000, -- Duration time drunk when drink wines
	MotionBlur = true, -- Enable motion blur on ped?
	Thirst = {
		Enable = true, -- Enable thirst?
		Amount = math.random(5,10) -- Amount
	},
	Health = true, -- If enable then ped receives random health
	Armour = true, -- Give armour to players when drink?
	ArmourAmount = 50, -- Amout of armour gives to player
	Timecycle = "spectator5", -- Dont touch if you dont understand this
	Stress = {
		Enable = true, -- Enable stress?
		Event = "hud:server:RelieveStress", -- Trigger of your stress | If use ps-hud or qb-hud dont touch
		Amount = { Min = 2, Max = 4 } -- Amount min and max relieve stress
	}
}


Config.Language = {
	["StartJob"] = "Start Job",
	["TradeGrapes"] = "Trade Grapes",
	["TreadGrapes"] = "Tread Grapes",
	["SellWine"] = "Sell Wine",
	["TakeJob"] = "Taking the job...",
	["Duty"] = "You're on duty! Go pick grapes!",
	["Canceled"] = "Canceled",
	["EnterZone"] = "You have entered the harvest zone!",
	["PickUp"] = "Pick up grapes...",
	["PickUpSuccess"] = "You picked a grapes!",
	["Failed"] = "Failed",
	["Crushing"] = "Crushing grapes...",
	["CrushingSuccess"] = "You got grape hull!",
	["NoGrapehull"] = "You don't have a bunch of grapes",
	["Trading"] = "Trading grapes...",
	["TradingSuccess"] = "You got some wine!",
	["TradingInfo"] = "You will receive an email with information on where you can sell the wine.",
	["NoGrape"] = "You don't have grapes",
	["Selling"] = "Selling the wine...",
	["SellingSuccess"] = "You sell your wine!",
	["NoWine"] = "You don't have wine to sell",
	["Currency"] = "$",
	["Sender"] = "Vineyard",
	["Subject"] = "Delivery",
	["Message"] = "We send you the location via GPS to sell your wine.",
	["Drinking"] = "Drinking..."
}
