class_name PlayerInput
extends Node2D


signal action_pressed(input_tag: InputTag)


enum InputMode {
    START_GAME,
    END_GAME,
    NORMAL,
}


var _ref_RandomNumber: RandomNumber

var _input_mode: int = InputMode.START_GAME


func _unhandled_input(event: InputEvent) -> void:
    match _input_mode:
        InputMode.START_GAME:
            if event.is_action_pressed(InputTag.START_GAME):
                action_pressed.emit(InputTag.START_GAME)
                _input_mode = InputMode.NORMAL
            elif _handle_quit_game_input(event):
                return
        InputMode.END_GAME:
            if event.is_action_pressed(InputTag.START_GAME):
                EndGame.reload()
            elif _handle_quit_game_input(event):
                return
            elif _handle_copy_seed_input(event):
                return
        InputMode.NORMAL:
            if _handle_quit_game_input(event):
                return
            elif _handle_copy_seed_input(event):
                return
            elif _handle_move_input(event):
                return
            elif event.is_action_pressed(InputTag.AIM):
                action_pressed.emit(InputTag.AIM)


func _on_Schedule_turn_started(sprite: Sprite2D) -> void:
    set_process_unhandled_input(sprite.is_in_group(SubTag.PC))


func _on_GameProgress_game_over(_player_win: bool) -> void:
    set_process_unhandled_input(true)
    _input_mode = InputMode.END_GAME


func _handle_move_input(event: InputEvent) -> bool:
    for i: StringName in InputTag.MOVE_INPUTS:
        if event.is_action_pressed(i):
            action_pressed.emit(i)
            return true
    return false


func _handle_quit_game_input(event: InputEvent) -> bool:
    if event.is_action_pressed(InputTag.QUIT_GAME):
        get_tree().quit()
        return true
    return false


func _handle_copy_seed_input(event: InputEvent) -> bool:
    if event.is_action_pressed(InputTag.COPY_SEED):
        DisplayServer.clipboard_set(str(_ref_RandomNumber.get_seed()))
        return true
    return false
