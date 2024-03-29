class_name WizardLineEdit
extends CustomLineEdit


func init_gui() -> void:
    text = "%s" % TransferData.wizard_mode
    placeholder_text = "Default: false"
    _set_font_color()
