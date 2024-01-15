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
