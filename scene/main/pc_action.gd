class_name PcAction
extends Node2D


var _pc: Sprite2D
var _indicator_top: Sprite2D
var _indicator_bottom: Sprite2D
var _indicator_left: Sprite2D


func _on_InitWorld_sprites_created(sprites: Array[TaggedSprite]) -> void:
    for i:TaggedSprite in sprites:
        match i.sub_tag:
            SubTag.PC:
                _pc = i.sprite
            SubTag.INDICATOR_TOP:
                _indicator_top = i.sprite
            SubTag.INDICATOR_BOTTOM:
                _indicator_bottom = i.sprite
            SubTag.INDICATOR_LEFT:
                _indicator_left = i.sprite


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
    _move_indicator(coord)


func _move_indicator(coord: Vector2i) -> void:
    _indicator_top.position.x = ConvertCoord.get_position(coord).x
    _indicator_bottom.position.x = ConvertCoord.get_position(coord).x
    _indicator_left.position.y = ConvertCoord.get_position(coord).y
