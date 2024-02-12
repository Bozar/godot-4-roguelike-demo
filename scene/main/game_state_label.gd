class_name GameStateLabel
extends CustomLabel


const YOU_WIN: String = "You win."
const YOU_LOSE: String = "You lose."


var game_over: bool = false
var player_win: bool = false


var _ref_PcAction: PcAction


func init_label() -> void:
    _set_font_color(true)
    update_label()


func update_label() -> void:
    var ammo: String = "Ammo: %d" % [_ref_PcAction.ammo]
    var enemy: String = "Enemy: %d-%d" % [_ref_PcAction.enemy_count,
            _ref_PcAction.progress_bar]
    var end_game: String = ""

    if game_over:
        end_game = "\n\n" + (YOU_WIN if player_win else YOU_LOSE)

    text = "%s\n%s%s" % [ammo, enemy, end_game]
