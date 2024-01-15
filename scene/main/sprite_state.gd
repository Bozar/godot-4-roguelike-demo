class_name SpriteState
extends Node2D


var _palette: Dictionary = {}


@onready var _ref_SpriteTag: SpriteTag = $SpriteTag
@onready var _ref_TagRepo: TagRepo = $TagRepo
@onready var _ref_DungeonBoard: DungeonBoard = $DungeonBoard


func _on_InitWorld_sprites_created(sprites: Array[TaggedSprite]) -> void:
    # TODO: Verify palette in node `LoadSetting`.
    _palette = Palette.get_verified_palette(_palette)

    RenderingServer.set_default_clear_color(Palette.get_color(_palette,
            MainTag.BACKGROUND, true))

    for ts: TaggedSprite in sprites:
        ts.sprite.modulate = Palette.get_color(_palette, ts.main_tag, true)
        _ref_SpriteTag.add_state(ts.sprite, ts.main_tag, ts.sub_tag)

        if ts.main_tag != MainTag.INDICATOR:
            _ref_DungeonBoard.add_state(ts.sprite, ts.main_tag)


func _on_SearchHelper_searching_by_tag(search: SearchByTag) -> void:
    search.sprites = _ref_TagRepo.get_sprites_by_tag(search.main_tag,
            search.sub_tag)


func _on_SearchHelper_searching_by_coord(search: SearchByCoord) -> void:
    search.sprite = _ref_DungeonBoard.get_sprite_by_coord(search.main_tag,
            search.coord, search.z_layer)


func _on_MoveSprite_sprite_moved(sprite: Sprite2D, coord: Vector2i,
        z_layer: int) -> void:
    _move_sprite(sprite, coord, z_layer)


func _set_light_color(sprite: Sprite2D) -> void:
    var main_tag: StringName = _ref_SpriteTag.get_main_tag(sprite)
    sprite.modulate = Palette.get_color(_palette, main_tag, true)


func _set_dark_color(sprite: Sprite2D) -> void:
    var main_tag: StringName = _ref_SpriteTag.get_main_tag(sprite)
    sprite.modulate = Palette.get_color(_palette, main_tag, false)


func _move_sprite(sprite: Sprite2D, coord: Vector2i, z_layer: int) -> void:
    var main_tag: StringName = _ref_SpriteTag.get_main_tag(sprite)

    _ref_DungeonBoard.remove_state(sprite, main_tag)
    sprite.position = ConvertCoord.get_position(coord)
    sprite.z_index = z_layer
    _ref_DungeonBoard.add_state(sprite, main_tag)
