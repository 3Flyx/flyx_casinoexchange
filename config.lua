Config = {}

Config.Language = 'en' -- pl / en
Config.ChipItem = 'pokerchip'
Config.ChipPrice = 500 -- Can be a normal value (100, 200, 300...) or a random value (math.random(100, 300))
Config.ChipBuying = {
    maxChips = 200 
}

Config.Ped = {
    coords = vec4(-543.81, -609.68, 35.64, 276.88),
    model = "a_m_m_business_01",
    scenario = "WORLD_HUMAN_CLIPBOARD",
    blip = { -- set to false if you don't want blip
        sprite = 683,
        color = 0,
        scale = 0.8,
        label = "Casino Chip Exchange"
    }
}

lib.locale(Config.Language or 'en')