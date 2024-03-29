class_name NewGame
extends Node2D


var _ref_RandomNumber: RandomNumber
var _ref_InitWorld: InitWorld
var _ref_Sidebar: Sidebar
var _ref_Schedule: Schedule
var _ref_DebugScreen: DebugScreen


func _ready() -> void:
    VisualEffect.set_background_color()


func _on_PlayerInput_action_pressed(input_tag: StringName) -> void:
    if input_tag == InputTag.START_GAME:
        _start_game()


func _start_game() -> void:
    if TransferData.load_setting_file:
        SettingFile.load()
        TransferData.set_load_setting_file(false)

    _ref_RandomNumber.set_initial_seed(TransferData.rng_seed)
    _ref_InitWorld.create_world()
    _ref_Sidebar.init_gui()
    _ref_DebugScreen.init_gui()
    _ref_Schedule.start_first_turn()
