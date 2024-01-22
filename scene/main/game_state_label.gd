class_name GameStateLabel
extends CustomLabel


func init_label() -> void:
    _set_font_color(true)
    update_label()


func update_label() -> void:
    var ammo: String = "Ammo: %d" % [PcActionHelper.ammo]
    var enemy: String = "Enemy: %d-%d" % [PcActionHelper.enemy_count,
            PcActionHelper.progress_bar]

    text = "%s\n%s" % [ammo, enemy]
