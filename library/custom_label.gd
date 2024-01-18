class_name CustomLabel
extends Label


func _ready() -> void:
    text = ""


func init_label() -> void:
    pass


func update_label() -> void:
    pass


func _set_font_color(is_light_color: bool) -> void:
    # TODO: Get palette from GameSetting node.
    var palette: Dictionary = {}
    add_theme_color_override("font_color", Palette.get_color(palette,
            MainTag.GUI_TEXT, is_light_color))
