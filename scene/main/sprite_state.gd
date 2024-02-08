class_name SpriteState
extends Node2D


var _indicators: Dictionary = {}


@onready var _ref_SpriteTag: SpriteTag = $SpriteTag
@onready var _ref_DungeonBoard: DungeonBoard = $DungeonBoard


func _ready() -> void:
    _ref_SpriteTag._is_valid_sprite = _is_valid_sprite
    _ref_DungeonBoard._is_valid_sprite = _is_valid_sprite


func get_sprites_by_tag(main_tag: StringName, sub_tag: StringName) -> Array:
    return _ref_SpriteTag.get_sprites_by_tag(main_tag, sub_tag)


func get_sprite_by_coord(main_tag: StringName, coord: Vector2i, z_layer: int) \
        -> Sprite2D:
    return _ref_DungeonBoard.get_sprite_by_coord(main_tag, coord, z_layer)


func get_sprites_by_coord(coord: Vector2i) -> Array:
    return _ref_DungeonBoard.get_sprites_by_coord(coord)


func get_main_tag(sprite: Sprite2D) -> StringName:
    return _ref_SpriteTag.get_main_tag(sprite)


func get_sub_tag(sprite: Sprite2D) -> StringName:
    return _ref_SpriteTag.get_sub_tag(sprite)


func _on_SpriteFactory_sprite_created(sprites: Array[TaggedSprite]) -> void:
    for ts: TaggedSprite in sprites:
        _ref_SpriteTag.add_state(ts.sprite, ts.main_tag, ts.sub_tag)
        if ts.main_tag == MainTag.INDICATOR:
            _indicators[ts.sub_tag] = ts.sprite
        else:
            _ref_DungeonBoard.add_state(ts.sprite, ts.main_tag)

        # TODO: Set color in PcFov node.
        VisualEffect.set_light_color(ts.sprite)


func _on_SpriteFactory_sprite_removed(sprites: Array[Sprite2D]) -> void:
    var main_tag: StringName

    for i: Sprite2D in sprites:
        main_tag = _ref_SpriteTag.get_main_tag(i)

        _ref_SpriteTag.remove_state(i)
        _ref_DungeonBoard.remove_state(i, main_tag)


func _on_MoveSprite_sprite_moved(sprite: Sprite2D, coord: Vector2i,
        z_layer: int) -> void:
    var main_tag: StringName = _ref_SpriteTag.get_main_tag(sprite)
    _ref_DungeonBoard.move_sprite(sprite, main_tag, coord, z_layer)
    if sprite.is_in_group(SubTag.PC):
        _ref_DungeonBoard.move_indicator(coord, _indicators)


func _on_MoveSprite_sprite_swapped(this_sprite: Sprite2D,
        that_sprite: Sprite2D) -> void:
    var this_main_tag: StringName = _ref_SpriteTag.get_main_tag(this_sprite)
    var that_main_tag: StringName = _ref_SpriteTag.get_main_tag(that_sprite)

    if this_main_tag != that_main_tag:
        push_error("Main tags do not match: %s, %s." %
                [this_main_tag, that_main_tag])
        return

    _ref_DungeonBoard.swap_sprite(this_sprite, that_sprite, this_main_tag)
    for i: Sprite2D in [this_sprite, that_sprite]:
        if i.is_in_group(SubTag.PC):
            _ref_DungeonBoard.move_indicator(ConvertCoord.get_coord(i),
                    _indicators)


func _is_valid_sprite(sprite: Sprite2D) -> bool:
    return not sprite.is_queued_for_deletion()
