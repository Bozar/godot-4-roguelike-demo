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
    var new_pc: Sprite2D = CreateSprite.create_actor(SubTag.PC, Vector2i(0, 0),
            {})
    add_child(new_pc)


func _create_floor() -> void:
    var new_floor: Sprite2D

    for x: int in range(0, DungeonSize.MAX_X):
        for y: int in range(0, DungeonSize.MAX_Y):
            new_floor = CreateSprite.create_ground(SubTag.DUNGEON_FLOOR,
                    Vector2i(x, y), {})
            add_child(new_floor)
