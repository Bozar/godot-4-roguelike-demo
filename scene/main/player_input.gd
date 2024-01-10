class_name PlayerInput
extends Node2D


func _unhandled_input(event: InputEvent) -> void:
    for i: StringName in InputTag.MOVE_INPUTS:
        if event.is_action_pressed(i):
            # TODO: Emit a signal with `InputTag`. Let another node move PC.
            _move_pc(i)


func _move_pc(direction: StringName) -> void:
    var pc: Sprite2D = get_tree().get_first_node_in_group(SubTag.PC)
    var coord: Vector2i = ConvertCoord.get_coord(pc)

    match direction:
        InputTag.MOVE_LEFT:
            coord += Vector2i.LEFT
        InputTag.MOVE_RIGHT:
            coord += Vector2i.RIGHT
        InputTag.MOVE_UP:
            coord += Vector2i.UP
        InputTag.MOVE_DOWN:
            coord += Vector2i.DOWN
    pc.position = ConvertCoord.get_position(coord)
