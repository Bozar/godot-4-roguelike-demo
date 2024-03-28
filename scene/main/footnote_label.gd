class_name FootnoteLabel
extends CustomLabel


const VERSION: String = "1.2.3"
const HELP: String = "Help: C"
const DEBUG: String = "Debug: V"


var _ref_RandomNumber: RandomNumber


func init_label() -> void:
    _set_font_color(false)
    text = "%s\n%s\n%s\n%s" % [_get_version(), HELP, DEBUG, _get_seed()]


func _get_version() -> String:
    return VERSION


func _get_seed() -> String:
    var str_seed: String = "%d" % _ref_RandomNumber.get_seed()
    var seed_length: int = str_seed.length()
    var head: String = str_seed.substr(0, 3)
    var body: String = ("-" + str_seed.substr(3, 3)) if seed_length > 2 else ""
    var tail: String = ("-" + str_seed.substr(6)) if seed_length > 5 else ""

    return "%s%s%s" % [head, body, tail]
