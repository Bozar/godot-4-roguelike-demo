class_name ZLayer


const Z_LAYER: Dictionary = {
    MainTag.GROUND: 10,
    MainTag.BUILDING: 20,
    MainTag.TRAP: 30,
    MainTag.ACTOR: 40,
    MainTag.INDICATOR: 50,
}


static func get_z_layer(main_tag: StringName) -> int:
    if Z_LAYER.has(main_tag):
        return Z_LAYER[main_tag]
    push_error("Invalid main tag: %s" % main_tag)
    return 0
