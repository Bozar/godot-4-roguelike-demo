class_name DebugScreen
extends CustomMarginContainer


const LABEL_NODES: Array = [
    "DebugVBox/TitleLabel",
    "DebugVBox/SettingGrid/SeedLabel",
    "DebugVBox/SettingGrid/WizardLabel",
    "DebugVBox/SettingGrid/MapLabel",
]

var _is_initialized: bool = false


func _ready() -> void:
    visible = false


func init_gui() -> void:
    var custom_label: CustomLabel

    for i: String in LABEL_NODES:
        custom_label = get_node(i)
        custom_label.init_label()


func _on_PlayerInput_action_pressed(input_tag: StringName) -> void:
    match input_tag:
        InputTag.CLOSE_MENU:
            visible = false
        InputTag.OPEN_DEBUG_MENU:
            if not _is_initialized:
                init_gui()
                _is_initialized = true
            visible = true
