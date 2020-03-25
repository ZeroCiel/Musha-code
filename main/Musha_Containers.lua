local require = GLOBAL.require
local containers = require("containers")

local function newcontainer()
local params = {}
---pill_bottle_gourd
params.armor_mushaa =
{
        widget =
        {
            slotpos = {},
            animbank = "ui_backpack_2x4",
            animbuild = "ui_backpack_2x4",
            pos = GLOBAL.Vector3(-5, -70, 0),
            side_align_tip = 160,
        },
		 issidewidget = true,
			type = "backpack",
    }
for y = 0, 3 do
    table.insert(params.armor_mushaa.widget.slotpos, GLOBAL.Vector3(-162, -75 * y + 114, 0))
    table.insert(params.armor_mushaa.widget.slotpos, GLOBAL.Vector3(-162 + 75, -75 * y + 114, 0))
end

params.musha_armor_prototype =
{
        widget =
        {
            slotpos = {},
            animbank = "ui_backpack_2x4",
            animbuild = "ui_backpack_2x4",
            pos = GLOBAL.Vector3(-5, -70, 0),
            side_align_tip = 160,
        },
		 issidewidget = true,
			type = "backpack",
    }
for y = 0, 3 do
    table.insert(params.musha_armor_prototype.widget.slotpos, GLOBAL.Vector3(-162, -75 * y + 114, 0))
    table.insert(params.musha_armor_prototype.widget.slotpos, GLOBAL.Vector3(-162 + 75, -75 * y + 114, 0))
end

params.armor_mushab =
{
        widget =
        {
            slotpos = {},
            animbank = "ui_krampusbag_2x8",
            animbuild = "ui_krampusbag_2x8",
            pos = GLOBAL.Vector3(-5, -80, 0),
            side_align_tip = 160,
        },
		 issidewidget = true,
			type = "armor_mushab",
    }
for y = -1, 5 do
    table.insert(params.armor_mushab.widget.slotpos, GLOBAL.Vector3(-162, -75 * y + 170, 0))
    table.insert(params.armor_mushab.widget.slotpos, GLOBAL.Vector3(-162 + 75, -75 * y + 170, 0))
end

params.musha_armor_princess =
{
        widget =
        {
            slotpos = {},
            animbank = "ui_krampusbag_2x8",
            animbuild = "ui_krampusbag_2x8",
            pos = GLOBAL.Vector3(-5, -80, 0),
            side_align_tip = 160,
        },
		 issidewidget = true,
			type = "musha_armor_princess",
    }
for y = -1, 5 do
    table.insert(params.musha_armor_princess.widget.slotpos, GLOBAL.Vector3(-162, -75 * y + 170, 0))
    table.insert(params.musha_armor_princess.widget.slotpos, GLOBAL.Vector3(-162 + 75, -75 * y + 170, 0))
end

params.musha_armor_frost =
{
        widget =
        {
            slotpos = {},
            animbank = "ui_backpack_2x4",
            animbuild = "ui_backpack_2x4",
            pos = GLOBAL.Vector3(-5, -70, 0),
            side_align_tip = 160,
        },
		 issidewidget = true,
			type = "musha_armor_frost",
    }
for y = 0, 3 do
    table.insert(params.musha_armor_frost.widget.slotpos, GLOBAL.Vector3(-162, -75 * y + 114, 0))
    table.insert(params.musha_armor_frost.widget.slotpos, GLOBAL.Vector3(-162 + 75, -75 * y + 114, 0))
end

params.broken_frosthammer =
{
        widget =
        {
            slotpos = {},
            animbank = "ui_backpack_2x4",
            animbuild = "ui_backpack_2x4",
            pos = GLOBAL.Vector3(-5, -70, 0),
            side_align_tip = 160,
        },
		 issidewidget = true,
			type = "backpack",
    }
for y = 0, 3 do
    table.insert(params.broken_frosthammer.widget.slotpos, GLOBAL.Vector3(-162, -75 * y + 114, 0))
    table.insert(params.broken_frosthammer.widget.slotpos, GLOBAL.Vector3(-162 + 75, -75 * y + 114, 0))
end

params.pirateback =
{
        widget =
        {
            slotpos = {},
            animbank = "ui_krampusbag_2x8",
            animbuild = "ui_krampusbag_2x8",
            pos = GLOBAL.Vector3(-5, -80, 0),
            side_align_tip = 160,
        },
		 issidewidget = true,
			type = "pirateback",
    }
for y = -1, 5 do
    table.insert(params.pirateback.widget.slotpos, GLOBAL.Vector3(-162, -75 * y + 170, 0))
    table.insert(params.pirateback.widget.slotpos, GLOBAL.Vector3(-162 + 75, -75 * y + 170, 0))
end

--super bird
params.chester =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_chest_3x3",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
    },
    type = "chest",
}

for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(params.chester.widget.slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 80 * 2 + 80, 0))
    end
end

---pill_bottle_gourd
params.chest_yamche0 =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_chest_yamche0",
        pos = GLOBAL.Vector3(0, 150, 0),
        side_align_tip = 160,
    },
    type = "chest",
}
-- function params.chest_yamche0.itemtestfn(container, item, slot)
    -- return item:HasTag("mk_pills")
-- end
-- for y = 0, 3 do
    -- table.insert(params.chest_yamche0.widget.slotpos, Vector3(-162, -75 * y + 114, 0))
    -- table.insert(params.chest_yamche0.widget.slotpos, Vector3(-162 + 75, -75 * y + 114, 0))
-- end
for y = 1, 0, -1 do
	table.insert(params.chest_yamche0.widget.slotpos, Vector3(74*y-74*2+70, 0))
end

params.chest_yamche1 =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_chest_yamche1",
        pos = GLOBAL.Vector3(0, 150, 0),
        side_align_tip = 160,
    },
    type = "chest",
}
for y = 1, 0, -1 do
    for x = 0, 1 do
	table.insert(params.chest_yamche1.widget.slotpos, Vector3(80*x-80*2+78, 80*y-80*2+80,0))
    end
end

params.chest_yamche2 =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_chest_yamche2",
        pos = GLOBAL.Vector3(0, 180, 0),
        side_align_tip = 160,
    },
    type = "chest",
}
for y = 2, 0, -1 do
    for x = 0, 1 do
	table.insert(params.chest_yamche2.widget.slotpos, Vector3(80*x-76*2+78, 80*y-78*2+78,0))
    end
end

params.chest_yamche3 =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_chest_yamche3",
        pos = GLOBAL.Vector3(0, 180, 0),
        side_align_tip = 160,
    },
    type = "chest",
}
for y = 2, 0, -1 do
    for x = 0, 1 do
	table.insert(params.chest_yamche3.widget.slotpos, Vector3(80*x-76*2+78, 80*y-78*2+78,0))
    end
end

params.chest_yamche4 =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_chest_yamche4",
        pos = GLOBAL.Vector3(0, 180, 0),
        side_align_tip = 160,
    },
    type = "chest",
}
for y = 3, 0, -1 do
    for x = 0, 3 do
	table.insert(params.chest_yamche4.widget.slotpos, Vector3(60*x-60*2+30, 60*y-60*2+30,0))
    end
end

params.chest_yamche5 =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chester_shadow_3x4",
        animbuild = "ui_chester_shadow_3x4",
        pos = GLOBAL.Vector3(0, 180, 0),
        side_align_tip = 160,
    },
    type = "chest",
}
for y = 4, 0, -1 do
    for x = 0, 3 do
	table.insert(params.chest_yamche5.widget.slotpos, Vector3(60*x-60*2+30, 60*y-60*2+2,0))
    end
end

params.chest_yamche6 =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_chest_moon",
        pos = GLOBAL.Vector3(0, 180, 0),
        side_align_tip = 160,
    },
    type = "chest",
}
for y = 5, 0, -1 do
    for x = 0, 14 do
	table.insert(params.chest_yamche6.widget.slotpos, Vector3(60*x-60*2+-150, 60*y-60*2+10,0))
    end
end

--注册
local containers = require "containers"
for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end
local oldwidgetsetup = containers.widgetsetup
	function containers.widgetsetup(container, prefab, data,...)
		local pref = prefab or container.inst.prefab
		if pref == "chest_yamche0" or pref == "chest_yamche1" or pref == "chest_yamche2" or pref == "chest_yamche3" or pref == "chest_yamche4" or pref == "chest_yamche5" or pref == "chest_yamche6" or pref == "armor_mushaa" or pref == "musha_armor_princess" or pref == "musha_armor_frost" or pref == "broken_frosthammer" or pref == "pirateback" or pref == "chester" or pref == "musha_armor_prototype" or pref == "armor_mushab" then
			local t = params[pref]
			if t ~= nil then
				for k, v in pairs(t) do
					container[k] = v
				end
			container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
			end
		else
		return oldwidgetsetup(container, prefab, data,...)
		end
	end
end
newcontainer()