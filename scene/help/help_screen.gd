class_name HelpScreen
extends CustomMarginContainer


var _current_index: int = 0


@onready var _ref_KeybindingLabel: KeybindingLabel = $Keybinding/KeybindingLabel
@onready var _ref_GeneralLabel: GeneralLabel = $General/GeneralLabel
@onready var _ref_GameplayLabel: GameplayLabel = $Gameplay/GameplayLabel

@onready var _labels: Array = [
    _ref_KeybindingLabel,
    _ref_GeneralLabel,
    _ref_GameplayLabel,
]


func _ready() -> void:
    init_gui()


func init_gui() -> void:
    _ref_KeybindingLabel.init_gui()
    _ref_GeneralLabel.init_gui()
    _ref_GameplayLabel.init_gui()


func _on_PlayerInput_action_pressed(input_tag: StringName) -> void:
    match input_tag:
        InputTag.OPEN_HELP_MENU:
            visible = true
            _switch_screen(input_tag)
        InputTag.CLOSE_MENU:
            visible = false
        InputTag.NEXT_SCREEN:
            _switch_screen(input_tag)
        InputTag.PREVIOUS_SCREEN:
            _switch_screen(input_tag)
        # InputTag.MOVE_DOWN:
        #     $Keybinding.scroll_vertical += 10


func _switch_screen(input_tag: StringName) -> void:
    var move_step: int = 0
    var custom_label: CustomLabel

    match input_tag:
        InputTag.NEXT_SCREEN:
            move_step = 1
        InputTag.PREVIOUS_SCREEN:
            move_step = -1

    custom_label = _labels[_current_index]
    custom_label.visible = false
    _current_index = _get_new_index(_current_index, move_step, _labels.size())
    custom_label = _labels[_current_index]
    custom_label.visible = true


func _get_new_index(this_index: int, move_step: int, max_index: int) -> int:
    var next_index: int = this_index + move_step

    if next_index >= max_index:
        return 0
    elif next_index < 0:
        return max_index - 1
    return next_index
