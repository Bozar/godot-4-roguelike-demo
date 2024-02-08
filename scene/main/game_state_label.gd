class_name GameStateLabel
extends CustomLabel


var _ref_PcAction: PcAction


func init_label() -> void:
    _set_font_color(true)
    update_label()


func update_label() -> void:
    var ammo: String = "Ammo: %d" % [_ref_PcAction.ammo]
    var enemy: String = "Enemy: %d-%d" % [_ref_PcAction.enemy_count,
            _ref_PcAction.progress_bar]

    text = "%s\n%s" % [ammo, enemy]
