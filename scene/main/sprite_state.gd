class_name SpriteState
extends Node2D


var _palette: Dictionary = {}


func get_main_tag(sprite: Sprite2D) -> StringName:
    return (%SpriteTag as SpriteTag).get_main_tag(sprite)


func get_sub_tag(sprite: Sprite2D) -> StringName:
    return (%SpriteTag as SpriteTag).get_sub_tag(sprite)


func _on_InitWorld_sprites_created(sprites: Array[TaggedSprite]) -> void:
    # TODO: Verify palette in node `LoadSetting`.
    _palette = Palette.get_verified_palette(_palette)

    RenderingServer.set_default_clear_color(Palette.get_color(_palette,
            MainTag.BACKGROUND, true))

    for ts: TaggedSprite in sprites:
        ts.sprite.modulate = Palette.get_color(_palette, ts.main_tag, true)
        (%SpriteTag as SpriteTag).add_state(ts.sprite, ts.main_tag, ts.sub_tag)
