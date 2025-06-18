Vatbrain = {}

local function register_sacrifice(beacon, vatbrain, manager)
  manager.get_inventory(defines.inventory.crafter_input).insert{
      name = "internal-vatbrain-item",
      count = 1,
      health = 0.5,
  }
  storage.vatbrain_deathrattles[script.register_on_object_destroyed(manager.get_inventory(defines.inventory.crafter_input)[1].item)] = {beacon = beacon, vatbrain = vatbrain, manager = manager}
end

local cartridge_tiers = {
    ["brain-food-01"] = {module = "vatbrain-1", tier = 1},
    ["brain-food-02"] = {module = "vatbrain-2", tier = 2},
    ["brain-food-03"] = {module = "vatbrain-3", tier = 3},
    ["brain-food-04"] = {module = "vatbrain-4", tier = 4},
}

py.on_event(py.events.on_init(), function()
    storage.vatbrains = storage.vatbrains or {}
    storage.vatbrain_deathrattles = storage.vatbrain_deathrattles or {}
end)

py.on_event(py.events.on_built(), function(event)
    local entity = event.entity
    if not entity.valid or entity.name ~= "vat-brain" then return end

    local beacon = entity.surface.create_entity {
        name = "hidden-beacon",
        position = entity.position,
        force = entity.force,
    }

    local manager = entity.surface.create_entity{
        name = "internal-vatbrain-manager",
        position = entity.position,
        force = entity.force
    }

    -- connect source and manager
    manager.get_wire_connector(defines.wire_connector_id.circuit_green, true).connect_to(entity.get_wire_connector(defines.wire_connector_id.circuit_green, true), false, defines.wire_origin.script)

  -- set circuit settings
    local vatbrain_behaviour = entity.get_or_create_control_behavior()
    local manager_behaviour = manager.get_or_create_control_behavior()

    vatbrain_behaviour.circuit_read_working = true
    vatbrain_behaviour.circuit_working_signal = {type = "item", name = "internal-vatbrain-item"}
    manager_behaviour.circuit_enable_disable = true
    manager_behaviour.circuit_condition = {
        comparator = "≠",
        constant = 0,
        first_signal = {
            name = "internal-vatbrain-item",
            type = "item"
        }
    }

    register_sacrifice(beacon, entity, manager)
    storage.vatbrains[entity.unit_number] = {beacon = beacon, manager = manager}
end)

py.on_event(py.events.on_destroyed(), function(event)
    local entity = event.entity
    if entity.name ~= "vat-brain" then return end

    if storage.vatbrains[entity.unit_number] then
        vatbrain_data = storage.vatbrains[entity.unit_number]
        if vatbrain_data.beacon.valid then vatbrain_data.beacon.destroy() end
        if vatbrain_data.manager.valid then vatbrain_data.manager.destroy() end
    end
end)

py.on_event(defines.events.on_object_destroyed, function(event)
  local vatbrain_data = storage.vatbrain_deathrattles[event.registration_number]
  if not vatbrain_data then return end
  local vatbrain, beacon, manager = vatbrain_data.vatbrain, vatbrain_data.beacon, vatbrain_data.manager
  storage.vatbrain_deathrattles[event.registration_number] = nil

  -- something got removed, do nothing
  if not beacon.valid or not vatbrain.valid or not manager.valid then return end
  register_sacrifice(beacon, vatbrain, manager)

  -- invert control behaviour
  local to_be_enabled = vatbrain.get_recipe() and vatbrain.status == defines.entity_status.working
  manager.get_or_create_control_behavior().circuit_condition = {
    comparator = to_be_enabled and "=" or "≠",
    constant = 0,
    first_signal = {
      name = "internal-vatbrain-item",
      type = "item"
    }
  }

  -- change the beacon state
  if to_be_enabled then
    beacon.active = true
  else
    beacon.active = false
  end
  
  -- check for recipe and cartridges
  local recipe = vatbrain.get_recipe()
  if not recipe then return end
  local cartridge = cartridge_tiers[recipe.name]
  if not cartridge then return end
  local module, module_tier = cartridge.module, cartridge.tier

  -- check if modules match, assuming they exist
  local module_slot = beacon.get_inventory(defines.inventory.beacon_modules)
  if module_slot.get_item_count() == 0 or module_slot[1].name ~= module then
    module_slot.clear()
    module_slot.insert {name = module, amount = 1}
  end
end)