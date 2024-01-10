class_name Palette


const BACKGROUND_YELLOW: String = "#FDF6E3"

# https://coolors.co/f8f9fa-e9ecef-dee2e6-ced4da-adb5bd-6c757d-495057-343a40-212529
const BACKGROUND_BLACK: String = "#212529"
const GREY: String = "#6C757D"
const DARK_GREY: String = "#343A40"
const LIGHT_GREY: String = "#ADB5BD"

# https://coolors.co/d8f3dc-b7e4c7-95d5b2-74c69d-52b788-40916c-2d6a4f-1b4332-081c15
const GREEN: String = "#52B788"
const DARK_GREEN: String = "#2D6A4F"

# https://coolors.co/f8b945-dc8a14-b9690b-854e19-a03401
const ORANGE: String = "#F8B945"
const DARK_ORANGE: String = "#854E19"

const DEBUG: String = "#FE4A49"


const DEFAULT_PALETTE: Dictionary = {
    MainTag.BACKGROUND: [BACKGROUND_YELLOW, BACKGROUND_YELLOW],
    MainTag.GUI_TEXT: [LIGHT_GREY, GREY],

    MainTag.GROUND: [GREY, DARK_GREY],
    MainTag.TRAP: [ORANGE, DARK_ORANGE],
    MainTag.BUILDING: [GREY, DARK_GREY],
    MainTag.ACTOR: [GREEN, DARK_GREEN],
    MainTag.INDICATOR: [GREY, GREY],
}


# If `palette` has a vaild key, its value is assumed to be valid.
static func get_color(palette: Dictionary, main_tag: StringName,
        is_light_color: bool) -> String:
    var colors: Array = palette.get(main_tag, DEFAULT_PALETTE[main_tag])
    if is_light_color:
        return colors[0]
    return colors[1]
