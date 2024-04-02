class_name WelcomeLabel
extends CustomLabel


const PATH_TO_TEXT: String = "res://user/doc/splash_screen.md"
const FAIL_SAFE_TEXT: String = "Press Space to continue."


func init_gui() -> void:
    var parsed_file: ParsedFile = FileIo.read_as_text(PATH_TO_TEXT)

    _set_font_color(true)
    if parsed_file.parse_success:
        text = parsed_file.output_text
    else:
        text = FAIL_SAFE_TEXT
