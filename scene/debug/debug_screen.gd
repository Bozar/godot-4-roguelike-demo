class_name DebugScreen
extends CustomMarginContainer


const GUI_NODES: Array = [
    "DebugVBox/TitleLabel",
    "DebugVBox/SettingGrid/SeedLabel",
    "DebugVBox/SettingGrid/WizardLabel",
    "DebugVBox/SettingGrid/MapLabel",
    "DebugVBox/SettingGrid/SeedLineEdit",
    "DebugVBox/SettingGrid/WizardLineEdit",
    "DebugVBox/SettingGrid/MapLineEdit",
]

const TRUE: String = "true"
const FALSE: String = "false"
const MAX_INT: int = 2 ** 32 - 1


var _is_initialized: bool = false

@onready var _ref_SeedLineEdit: CustomLineEdit = \
        $DebugVBox/SettingGrid/SeedLineEdit
@onready var _ref_WizardLineEdit: CustomLineEdit = \
        $DebugVBox/SettingGrid/WizardLineEdit
@onready var _ref_MapLineEdit: CustomLineEdit = \
        $DebugVBox/SettingGrid/MapLineEdit


func _ready() -> void:
    visible = false


# https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/warning_system.html
func init_gui() -> void:
    var custom_gui: Variant

    for i: String in GUI_NODES:
        custom_gui = get_node(i)
        @warning_ignore("UNSAFE_METHOD_ACCESS")
        custom_gui.init_gui()


# NOTE: Delete `ui_cancel` key in `Input Map`.
func _on_PlayerInput_action_pressed(input_tag: StringName) -> void:
    match input_tag:
        InputTag.CLOSE_MENU:
            visible = false
        InputTag.OPEN_DEBUG_MENU:
            if not _is_initialized:
                init_gui()
                _is_initialized = true
            _ref_SeedLineEdit.grab_focus()
            visible = true
        InputTag.REPLAY_GAME:
            _set_transfer_data(true)
        InputTag.RESTART_GAME:
            _set_transfer_data(false)


func _set_transfer_data(is_replay: bool) -> void:
    if not is_replay:
        TransferData.set_rng_seed(_get_int(_ref_SeedLineEdit.text))
    TransferData.set_wizard_mode(_get_bool(_ref_WizardLineEdit.text))
    TransferData.set_show_full_map(_get_bool(_ref_MapLineEdit.text))


func _get_int(line_edit_text: String) -> int:
    var text_to_int: int = int(line_edit_text)

    if text_to_int > MAX_INT:
        return 0
    return text_to_int


func _get_bool(line_edit_text: String) -> bool:
    var text: String = line_edit_text.strip_edges().to_lower()

    match text:
        TRUE:
            return true
        FALSE:
            return false
        _:
            return bool(int(text))
