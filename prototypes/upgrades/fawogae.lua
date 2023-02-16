local FUN = require '__pycoalprocessing__/prototypes/functions/functions'

if data then
    data:extend{
        {
            type = 'item',
            name = 'fawogae-abomination',
            icon = '__pyalienlifegraphics2__/graphics/icons/abomination.png',
            icon_size = 64,
            stack_size = 50,
            subgroup = 'py-alienlife-auog'
        },
        {
            type = 'recipe',
            name = 'full-render-fawogae-abomination',
            category = 'slaughterhouse',
            subgroup = 'py-alienlife-auog',
            ingredients = {{'fawogae-abomination', 1}},
            results = {
                {name = 'fawogae', type = 'item', amount_min = 15, amount_max = 23},
                {name = 'dirty-water-light', type = 'fluid', amount = 10},
                {'meat', 1}
            },
            enabled = false,
            icon = '__pyalienlifegraphics2__/graphics/icons/rendering-abomination.png',
            icon_size = 64,
            localised_name = {'recipe-name.full-render-fawogae-abomination'},
            energy_required = 10
        }
    }

    local victims = {'auog', 'mukmoux', 'scrondrix', 'simik', 'zungror'}
    local profit = {1, 2, 4, 6, 10}
    if not mods.pyalternativeenergy then victims[5] = 'antelope' end
    for i, recipe in pairs({
        table.deepcopy(data.raw.recipe['fawogae-1']),
        table.deepcopy(data.raw.recipe['fawogae with manure']),
        table.deepcopy(data.raw.recipe['fawogae with improved substrate']),
        table.deepcopy(data.raw.recipe['fawogae with special substrate']),
        table.deepcopy(data.raw.recipe['fawogae with growth hormone']),
    }) do
        recipe.name = recipe.name .. '-abomination'
        FUN.add_ingredient(recipe, {name = victims[i], amount = 1, type = 'item'})
        recipe.main_product = 'fawogae-abomination'
        recipe.results = {{'fawogae-abomination', profit[i]}}
        recipe.energy_required = math.ceil(recipe.energy_required * 1.5)
        data:extend{recipe}
    end

    for codex, recipe in pairs({
        ['xeno-codex'] = table.deepcopy(data.raw.recipe['fawogae-sample']),
        ['xeno-codex-mk02'] = table.deepcopy(data.raw.recipe['fawogae-mk02']),
        ['xeno-codex-mk03'] = table.deepcopy(data.raw.recipe['fawogae-mk03']),
        ['xeno-codex-mk04'] = table.deepcopy(data.raw.recipe['fawogae-mk04']),
    }) do
        recipe.name = recipe.name .. '-with-xeno-codex'
        FUN.add_ingredient(recipe, {codex, 1})
        data:extend{recipe}
    end

    local coal_fawogae = table.deepcopy(data.raw.recipe['coal-fawogae'])
    coal_fawogae.name = 'coal-fawogae-buffed'
    coal_fawogae.energy_required = coal_fawogae.energy_required * 4
    FUN.multiply_result_amount(coal_fawogae, 'raw-coal', 5)
    data:extend{coal_fawogae}

    for i, recipe in pairs({
        table.deepcopy(data.raw.recipe['fawogae-plantation-mk01']),
        table.deepcopy(data.raw.recipe['fawogae-plantation-mk02']),
        table.deepcopy(data.raw.recipe['fawogae-plantation-mk03']),
        table.deepcopy(data.raw.recipe['fawogae-plantation-mk04']),
    }) do
        recipe.name = recipe.name .. '-with-pressure-pump'
        FUN.add_ingredient(recipe, {name = 'vacuum-pump-mk0' .. i, amount = 1, type = 'item'})
        data:extend{recipe}
    end
end

return {
    affected_entities = { -- the entities that should be effected by this tech upgrade
        'fawogae-plantation-mk01',
        'fawogae-plantation-mk02',
        'fawogae-plantation-mk03',
        'fawogae-plantation-mk04',
    },
    master_tech = { -- tech that is shown in the tech tree
        name = 'fawogae-upgrade',
        icon = '__pyalienlifegraphics3__/graphics/technology/updates/u-fawogae.png',
        icon_size = 128,
        order = 'c-a',
        prerequisites = {'circuit-network', 'fawogae-mk01'},
        unit = {
            count = 500,
            ingredients = {
                {'automation-science-pack', 1},
                {'py-science-pack-1', 1},
            },
            time = 45
        }
    },
    sub_techs = {
        {
            name = 'lichen',
            icon = '__pyalienlifegraphics3__/graphics/technology/lichen.png',
            icon_size = 128,
            order = 'c-a',
            effects = { -- the effects the tech will have on the building. valid types: 'module-effects', 'unlock-recipe', 'lock-recipe', 'recipe-replacement'
                {recipe = 'full-render-fawogae-abomination', type = 'unlock-recipe'},
                {old = 'fawogae-1', new = 'fawogae-1-abomination', type = 'recipe-replacement'},
                {old = 'fawogae with manure', new = 'fawogae with manure-abomination', type = 'recipe-replacement'},
                {old = 'fawogae with improved substrate', new = 'fawogae with improved substrate-abomination', type = 'recipe-replacement'},
                {old = 'fawogae with special substrate', new = 'fawogae with special substrate-abomination', type = 'recipe-replacement'},
                {old = 'fawogae with growth hormone', new = 'fawogae with growth hormone-abomination', type = 'recipe-replacement'},
            },
        },
        {
            name = 'acidosis',
            icon = '__pyalienlifegraphics3__/graphics/technology/acidosis.png',
            icon_size = 128,
            order = 'c-a',
            effects = { -- the effects the tech will have on the building. valid types: 'module-effects', 'unlock-recipe', 'lock-recipe', 'recipe-replacement'
                {speed = 0.15, type = 'module-effects'},
                {recipe = 'xeno-codex', type = 'unlock-recipe'},
                {old = 'fawogae-sample', new = 'fawogae-sample-with-xeno-codex', type = 'recipe-replacement'},
                {old = 'fawogae-mk02', new = 'fawogae-mk02-with-xeno-codex', type = 'recipe-replacement'},
                {old = 'fawogae-mk03', new = 'fawogae-mk03-with-xeno-codex', type = 'recipe-replacement'},
                {old = 'fawogae-mk04', new = 'fawogae-mk04-with-xeno-codex', type = 'recipe-replacement'},
            }
        },
        {
            name = 'dry',
            icon = '__pyalienlifegraphics3__/graphics/technology/dry.png',
            icon_size = 128,
            order = 'c-a',
            effects = { -- the effects the tech will have on the building. valid types: 'module-effects', 'unlock-recipe', 'lock-recipe', 'recipe-replacement'
                {consumption = 3.5, type = 'module-effects'},
                {old = 'coal-fawogae', new = 'coal-fawogae-buffed', type = 'recipe-replacement'},
                {old = 'fawogae-plantation-mk01', new = 'fawogae-plantation-mk01-with-pressure-pump', type = 'recipe-replacement'},
                {old = 'fawogae-plantation-mk02', new = 'fawogae-plantation-mk02-with-pressure-pump', type = 'recipe-replacement'},
                {old = 'fawogae-plantation-mk03', new = 'fawogae-plantation-mk03-with-pressure-pump', type = 'recipe-replacement'},
                {old = 'fawogae-plantation-mk04', new = 'fawogae-plantation-mk04-with-pressure-pump', type = 'recipe-replacement'},
            }
        }
    },
    module_category = 'fawogae'
}