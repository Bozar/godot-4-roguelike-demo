class_name VisualEffect


static func set_light_color(sprite: Sprite2D) -> void:
    # TODO: Get palette from GameSetting node.
    var palette: Dictionary = {}
    var main_tag: StringName = SearchHelper.get_main_tag(sprite)
    sprite.modulate = Palette.get_color(palette, main_tag, true)


static func set_dark_color(sprite: Sprite2D) -> void:
    # TODO: Get palette from GameSetting node.
    var palette: Dictionary = {}
    var main_tag: StringName = SearchHelper.get_main_tag(sprite)
    sprite.modulate = Palette.get_color(palette, main_tag, false)


static func set_background_color() -> void:
    # TODO: Get palette from GameSetting node.
    var palette: Dictionary = {}
    RenderingServer.set_default_clear_color(Palette.get_color(palette,
            MainTag.BACKGROUND, true))


static func set_indicator_color() -> void:
    # TODO: Get palette from GameSetting node.
    var palette: Dictionary = {}
    var main_tag: StringName = MainTag.INDICATOR

    for i: Sprite2D in SearchHelper.get_sprites_by_tag(main_tag, ""):
        i.modulate = Palette.get_color(palette, main_tag, true)


static func switch_sprite(sprite: Sprite2D, visual_tag: StringName) -> void:
    var has_switched: bool = false

    for i: Sprite2D in sprite.get_children():
        if i.name == visual_tag:
            i.visible = true
            has_switched = true
        else:
            i.visible = false
    if not has_switched:
        push_error("Invalid visual tag: %s, %s." % [sprite, visual_tag])
