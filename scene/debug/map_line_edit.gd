class_name MapLineEdit
extends CustomLineEdit


func init_gui() -> void:
    text = "%s" % TransferData.show_full_map
    placeholder_text = "Default: false"
    _set_font_color()
