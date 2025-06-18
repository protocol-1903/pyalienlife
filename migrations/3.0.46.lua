-- new vatbrain logic
storage.vatbrain_deathrattles = {}

for index, vatbrain_data in pairs(storage.vatbrains) do
  local beacon = vatbrain_data.beacon
  local vatbrain = vatbrain_data.vatbrain
  storage[index] = nil

  local manager = vatbrain.surface.create_entity{
    name = "internal-vatbrain-manager",
    position = vatbrain.position,
    force = vatbrain.force
  }

  -- connect source and manager
  manager.get_wire_connector(defines.wire_connector_id.circuit_green, true).connect_to(vatbrain.get_wire_connector(defines.wire_connector_id.circuit_green, true), false, defines.wire_origin.script)

-- set circuit settings
  local vatbrain_behaviour = vatbrain.get_or_create_control_behavior()
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

  manager.get_inventory(defines.inventory.crafter_input).insert{
      name = "internal-vatbrain-item",
      count = 1,
      health = 0.5,
  }
  storage.vatbrain_deathrattles[script.register_on_object_destroyed(manager.get_inventory(defines.inventory.crafter_input)[1].item)] = {beacon = beacon, vatbrain = vatbrain, manager = manager}

  storage.vatbrains[vatbrain.unit_number] = {beacon = beacon, manager = manager}
end