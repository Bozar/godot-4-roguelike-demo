class_name PlayerInput
extends Node2D


func _ready() -> void:
    set_process_unhandled_input(false)


func _unhandled_input(event: InputEvent) -> void:
    for i: StringName in InputTag.MOVE_INPUTS:
        if event.is_action_pressed(i):
            # TODO: Emit a signal with `InputTag`. Let another node move PC.
            _move_pc(i)


func _move_pc(direction: StringName) -> void:
    # TODO: Turn SpriteState into a normal node.
    var pc: Sprite2D = (%SpriteState as SpriteState).get_sprites_by_tag("",
            SubTag.PC)[0]
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
