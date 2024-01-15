class_name SpriteState
extends Node2D


@onready var _ref_SpriteTag: SpriteTag = $SpriteTag
@onready var _ref_DungeonBoard: DungeonBoard = $DungeonBoard


func _on_SpriteFactory_sprite_created(sprites: Array[TaggedSprite]) -> void:
    for ts: TaggedSprite in sprites:
        _ref_SpriteTag.add_state(ts.sprite, ts.main_tag, ts.sub_tag)
        if ts.main_tag != MainTag.INDICATOR:
            _ref_DungeonBoard.add_state(ts.sprite, ts.main_tag)

        # TODO: Set color in PcFov node.
        VisualEffect.set_light_color(ts.sprite)


func _on_SearchHelper_searching_by_tag(search: SearchByTag) -> void:
    search.sprites = _ref_SpriteTag.get_sprites_by_tag(search.main_tag,
            search.sub_tag)


func _on_SearchHelper_searching_by_coord(search: SearchByCoord) -> void:
    search.sprite = _ref_DungeonBoard.get_sprite_by_coord(search.main_tag,
            search.coord, search.z_layer)


func _on_SearchHelper_searching_by_sprite(search: SearchBySprite) -> void:
    search.main_tag = _ref_SpriteTag.get_main_tag(search.sprite)
    search.sub_tag = _ref_SpriteTag.get_sub_tag(search.sprite)


func _on_MoveSprite_sprite_moved(sprite: Sprite2D, coord: Vector2i,
        z_layer: int) -> void:
    var main_tag: StringName = _ref_SpriteTag.get_main_tag(sprite)
    _ref_DungeonBoard.move_sprite(sprite, main_tag, coord, z_layer)


func _on_MoveSprite_sprite_swapped(this_sprite: Sprite2D,
        that_sprite: Sprite2D) -> void:
    var this_main_tag: StringName = _ref_SpriteTag.get_main_tag(this_sprite)
    var that_main_tag: StringName = _ref_SpriteTag.get_main_tag(that_sprite)

    if this_main_tag != that_main_tag:
        push_error("Main tags do not match: %s, %s." %
                [this_main_tag, that_main_tag])
        return
    _ref_DungeonBoard.swap_sprite(this_sprite, that_sprite, this_main_tag)
