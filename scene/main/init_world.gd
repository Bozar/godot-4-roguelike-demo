class_name InitWorld
extends Node2D


func create_world() -> void:
    _set_background_color()
    # TODO:
    # 1. Use a static library script to create objects.
    # 2. Emit a signal from an autoload script to notify other nodes in the main
    # scene.
    _create_pc()
    _create_floor()


func _set_background_color() -> void:
    RenderingServer.set_default_clear_color(
            Palette.get_color({}, MainTag.BACKGROUND, true))


func _create_pc() -> void:
    var pc: PackedScene = preload("res://sprite/pc.tscn")
    var new_pc: Sprite2D
    var new_position: Vector2i = Vector2i(0, 0)

    new_pc = pc.instantiate()
    new_pc.position = ConvertCoord.get_position(new_position)
    new_pc.modulate = Palette.get_color({}, MainTag.ACTOR, true)
    new_pc.add_to_group(MainTag.ACTOR)
    new_pc.add_to_group(SubTag.PC)
    add_child(new_pc)


func _create_floor() -> void:
    var dungeon_floor: PackedScene = preload("res://sprite/dungeon_floor.tscn")
    var new_floor: Sprite2D

    for x: int in range(0, DungeonSize.MAX_X):
        for y: int in range(0, DungeonSize.MAX_Y):
            new_floor = dungeon_floor.instantiate()
            new_floor.position = ConvertCoord.get_position(Vector2i(x, y))
            new_floor.modulate = Palette.get_color({}, MainTag.GROUND, true)
            new_floor.add_to_group(MainTag.GROUND)
            new_floor.add_to_group(SubTag.DUNGEON_FLOOR)
            add_child(new_floor)
