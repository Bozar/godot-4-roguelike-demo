class_name GeneralLabel
extends CustomLabel


func _ready() -> void:
    text = ""


func init_gui() -> void:
    _set_font_color(true)
    text = "general"
    visible = false


func update_gui() -> void:
    pass


func _set_font_color(is_light_color: bool) -> void:
    # var palette: Dictionary = {}
    var palette: Dictionary = TransferData.palette
    add_theme_color_override("font_color", Palette.get_color(palette,
            MainTag.GUI_TEXT, is_light_color))
