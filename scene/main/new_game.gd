class_name NewGame
extends Node2D


var _ref_RandomNumber: RandomNumber
var _ref_InitWorld: InitWorld
var _ref_Sidebar: Sidebar
var _ref_Schedule: Schedule


func _ready() -> void:
    VisualEffect.set_background_color()


func _on_PlayerInput_action_pressed(input_tag: StringName) -> void:
    if input_tag == InputTag.START_GAME:
        _start_game()


func _start_game() -> void:
    # TODO: Get seed from user settings.
    # _ref_RandomNumber.set_initial_seed(0)
    _ref_RandomNumber.set_initial_seed(TransferData.rng_seed)
    _ref_InitWorld.create_world()
    _ref_Sidebar.init_gui()
    _ref_Schedule.start_first_turn()
