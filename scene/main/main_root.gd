class_name MainRoot
extends Node2D


func _ready() -> void:
    RenderingServer.set_default_clear_color(
            Palette.get_color({}, MainTag.BACKGROUND, true))
    _create_pc()
    _create_floor()


func _create_pc() -> void:
    # var pc: Sprite2D = preload("res://sprite/pc.tscn").instantiate()
    var pc: PackedScene = preload("res://sprite/pc.tscn")
    var new_pc: Sprite2D
    var new_position: Vector2i = Vector2i(0, 0)

    for i: String in [Palette.get_color({}, MainTag.ACTOR, true)]:
    # for i: StringName in PALETTE.keys():
        new_pc = pc.instantiate()
        new_pc.position = ConvertCoord.get_position(new_position)
        new_pc.modulate = i
        # new_pc.modulate = PALETTE[i]
        new_pc.add_to_group(MainTag.ACTOR)
        new_pc.add_to_group(SubTag.PC)
        add_child(new_pc)
        # print(_get_coord_from_sprite(new_pc))
        new_position.x += 1


func _create_floor() -> void:
    var dungeon_floor: PackedScene = preload("res://sprite/dungeon_floor.tscn")
    var new_floor: Sprite2D

    for x: int in range(0, DungeonSize.MAX_X):
        for y: int in range(0, DungeonSize.MAX_Y):
            new_floor = dungeon_floor.instantiate()
            new_floor.position = ConvertCoord.get_position(Vector2i(x, y))
            # new_floor.modulate = PALETTE["DEBUG"]
            new_floor.modulate = Palette.get_color({}, MainTag.GROUND, true)
            new_floor.add_to_group(MainTag.GROUND)
            new_floor.add_to_group(SubTag.DUNGEON_FLOOR)
            add_child(new_floor)
