class_name SeedLineEdit
extends CustomLineEdit


func init_gui() -> void:
    text = "%s" % TransferData.rng_seed
    placeholder_text = "Default: 0"
    _set_font_color()
