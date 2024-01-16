class_name SpriteScene


const SPRITE_SCENES: Dictionary = {
    # Ground
    SubTag.DUNGEON_FLOOR: preload("res://sprite/dungeon_floor.tscn"),


    # Building
    SubTag.WALL: preload("res://sprite/wall.tscn"),


    # Trap
    SubTag.AMMO: preload("res://sprite/ammo.tscn"),


    # Actor
    SubTag.PC: preload("res://sprite/pc.tscn"),
    SubTag.GRUNT: preload("res://sprite/grunt.tscn"),


    # Indicator
    SubTag.INDICATOR_TOP: preload("res://sprite/indicator_top.tscn"),
    SubTag.INDICATOR_BOTTOM: preload("res://sprite/indicator_bottom.tscn"),
    SubTag.INDICATOR_LEFT: preload("res://sprite/indicator_left.tscn"),
}


static func get_sprite_scene(sub_tag: StringName) -> PackedScene:
    if SPRITE_SCENES.has(sub_tag):
        return SPRITE_SCENES[sub_tag]
    push_error("Invalid sub tag: %s" % sub_tag)
    return null
