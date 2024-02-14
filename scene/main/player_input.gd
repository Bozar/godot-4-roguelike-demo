class_name PlayerInput
extends Node2D


signal action_pressed(input_tag: InputTag)


var _ref_NewGame: NewGame

var _is_new_game: bool = true
var _is_game_over: bool = false


func _ready() -> void:
    set_process_unhandled_input(true)


func _unhandled_input(event: InputEvent) -> void:
    var out_input_tag: Array = []

    if _is_new_game:
        if event.is_action_pressed(InputTag.START_GAME):
            _ref_NewGame.start_game()
            _is_new_game = false
    elif _is_game_over:
        if event.is_action_pressed(InputTag.START_GAME):
            EndGame.reload()
    elif _is_move_input(event, out_input_tag):
        action_pressed.emit(out_input_tag[0])
    elif event.is_action_pressed(InputTag.AIM):
        action_pressed.emit(InputTag.AIM)


func _on_Schedule_turn_started(sprite: Sprite2D) -> void:
    set_process_unhandled_input(sprite.is_in_group(SubTag.PC))


func _on_GameProgress_game_over(_player_win: bool) -> void:
    set_process_unhandled_input(true)
    _is_game_over = true


func _is_move_input(event: InputEvent, out_input_tag: Array) -> bool:
    for i: StringName in InputTag.MOVE_INPUTS:
        if event.is_action_pressed(i):
            out_input_tag.push_back(i)
            return true
    return false
