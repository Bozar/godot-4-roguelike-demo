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

const FOCUS_NODE: String = "DebugVBox/SettingGrid/SeedLineEdit"


var _is_initialized: bool = false


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
            (get_node(FOCUS_NODE) as LineEdit).grab_focus()
            visible = true
