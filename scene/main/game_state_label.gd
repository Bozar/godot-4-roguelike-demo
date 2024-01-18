class_name GameStateLabel
extends CustomLabel


func init_label() -> void:
    _set_font_color(true)
    update_label()


func update_label() -> void:
    var ammo: String = "Ammo: %d" % [PcActionHelper.ammo]
    var enemy: String = "Enemy: %d" % [0]

    text = "%s\n%s" % [ammo, enemy]
