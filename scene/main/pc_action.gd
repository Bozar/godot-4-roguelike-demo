class_name PcAction
extends Node2D


var _pc: Sprite2D


func _on_InitWorld_sprites_created(sprites: Array[TaggedSprite]) -> void:
    for i:TaggedSprite in sprites:
        if i.sub_tag == SubTag.PC:
            _pc = i.sprite
            break


func _on_PlayerInput_pc_moved(direction: StringName) -> void:
    var coord: Vector2i = ConvertCoord.get_coord(_pc)

    match direction:
        InputTag.MOVE_LEFT:
            coord += Vector2i.LEFT
        InputTag.MOVE_RIGHT:
            coord += Vector2i.RIGHT
        InputTag.MOVE_UP:
            coord += Vector2i.UP
        InputTag.MOVE_DOWN:
            coord += Vector2i.DOWN
    MoveSprite.move(_pc, coord)
