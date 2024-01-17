class_name SpriteState
extends Node2D


var _indicators: Dictionary = {}


@onready var _ref_SpriteTag: SpriteTag = $SpriteTag
@onready var _ref_DungeonBoard: DungeonBoard = $DungeonBoard


func _ready() -> void:
    _ref_SpriteTag._is_valid_sprite = _is_valid_sprite
    _ref_DungeonBoard._is_valid_sprite = _is_valid_sprite


func _on_SpriteFactory_sprite_created(sprites: Array[TaggedSprite]) -> void:
    for ts: TaggedSprite in sprites:
        _ref_SpriteTag.add_state(ts.sprite, ts.main_tag, ts.sub_tag)
        if ts.main_tag == MainTag.INDICATOR:
            _indicators[ts.sub_tag] = ts.sprite
        else:
            _ref_DungeonBoard.add_state(ts.sprite, ts.main_tag)

        # TODO: Set color in PcFov node.
        VisualEffect.set_light_color(ts.sprite)


func _on_SearchHelper_searching_by_tag(search: SearchKeyword) -> void:
    search.sprites = _ref_SpriteTag.get_sprites_by_tag(search.main_tag,
            search.sub_tag)
    search.search_is_completed()


func _on_SearchHelper_searching_by_coord(search: SearchKeyword) -> void:
    search.sprites = _ref_DungeonBoard.get_sprites_by_coord(search.coord)
    search.search_is_completed()


func _on_SearchHelper_searching_by_coord_tag(search: SearchKeyword) -> void:
    search.sprite = _ref_DungeonBoard.get_sprite_by_coord(search.main_tag,
            search.coord, search.z_layer)
    search.search_is_completed()


func _on_SearchHelper_searching_by_sprite(search: SearchKeyword) -> void:
    search.main_tag = _ref_SpriteTag.get_main_tag(search.sprite)
    search.sub_tag = _ref_SpriteTag.get_sub_tag(search.sprite)
    search.search_is_completed()


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
