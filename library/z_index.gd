class_name ZIndex


const Z_INDEXES: Dictionary = {
    MainTag.GROUND: 10,
    MainTag.BUILDING: 20,
    MainTag.TRAP: 30,
    MainTag.ACTOR: 40,
    MainTag.INDICATOR: 50,
}


static func get_z_index(main_tag: StringName) -> int:
    if Z_INDEXES.has(main_tag):
        return Z_INDEXES[main_tag]
    push_error("Invalid main tag: %s" % main_tag)
    return 0
