components {
  id: "factory"
  component: "/spawn_objects/spawn_obj_factory/factory.script"
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
    value: "#cube_factory"
    type: PROPERTY_TYPE_URL
  }
}
embedded_components {
  id: "cube_factory"
  type: "factory"
  data: "prototype: \"/spawn_objects/spawn_obj/obj.go\"\n"
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
