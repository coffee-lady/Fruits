components {
  id: "script"
  component: "/src/game/spawn_objects/factory/spawn_obj_factory.script"
  position {
    x: 0.0
    y: 0.0
    z: 0.0
  }
  rotation {
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0
  }
  properties {
    id: "factory_block"
    value: "#spawn_obj_factory"
    type: PROPERTY_TYPE_URL
  }
}
embedded_components {
  id: "spawn_obj_factory"
  type: "factory"
  data: "prototype: \"/src/game/spawn_objects/object/spawn_obj.go\"\n"
  "load_dynamically: false\n"
  ""
  position {
    x: 0.0
    y: 0.0
    z: 0.0
  }
  rotation {
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0
  }
}
