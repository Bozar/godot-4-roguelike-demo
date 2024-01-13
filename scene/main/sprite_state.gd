class_name SpriteState
extends Node2D


var _palette: Dictionary = {}


func get_main_tag(sprite: Sprite2D) -> StringName:
    return ($SpriteTag as SpriteTag).get_main_tag(sprite)


func get_sub_tag(sprite: Sprite2D) -> StringName:
    return ($SpriteTag as SpriteTag).get_sub_tag(sprite)


func set_light_color(sprite: Sprite2D) -> void:
    var main_tag: StringName = get_main_tag(sprite)
    sprite.modulate = Palette.get_color(_palette, main_tag, true)


func set_dark_color(sprite: Sprite2D) -> void:
    var main_tag: StringName = get_main_tag(sprite)
    sprite.modulate = Palette.get_color(_palette, main_tag, false)


func get_sprites_by_tag(main_tag: StringName, sub_tag: StringName) -> Array:
    return ($SearchByTag as SearchByTag).get_sprites_by_tag(main_tag, sub_tag)


func get_sprite_by_coord(main_tag: StringName, coord: Vector2i,
        z_layer: int = ZLayer.get_z_layer(main_tag)) -> Sprite2D:
    return ($DungeonBoard as DungeonBoard).get_sprite_by_coord(main_tag,
            coord, z_layer)


func _on_InitWorld_sprites_created(sprites: Array[TaggedSprite]) -> void:
    # TODO: Verify palette in node `LoadSetting`.
    _palette = Palette.get_verified_palette(_palette)

    RenderingServer.set_default_clear_color(Palette.get_color(_palette,
            MainTag.BACKGROUND, true))

    for ts: TaggedSprite in sprites:
        ts.sprite.modulate = Palette.get_color(_palette, ts.main_tag, true)
        ($SpriteTag as SpriteTag).add_state(ts.sprite, ts.main_tag, ts.sub_tag)
        if ts.main_tag != MainTag.INDICATOR:
            ($DungeonBoard as DungeonBoard).add_state(ts.sprite, ts.main_tag)
