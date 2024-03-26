class_name PlayerInput
extends Node2D


signal action_pressed(input_tag: InputTag)


enum InputMode {
    START_GAME,
    END_GAME,
    NORMAL,
}


var _input_mode: int = InputMode.START_GAME


func _unhandled_input(event: InputEvent) -> void:
    match _input_mode:
        InputMode.START_GAME:
            if _is_start_game(event, _input_mode):
                return
            elif _is_quit_game(event):
                return
        InputMode.END_GAME:
            if _is_start_game(event, _input_mode):
                return
            elif _is_quit_game(event):
                return
            elif _is_copy_seed(event):
                return
            elif _is_restart_game(event):
                return
            elif _is_replay_game(event):
                return
        InputMode.NORMAL:
            if _is_quit_game(event):
                return
            elif _is_copy_seed(event):
                return
            elif _is_move_inputs(event):
                return
            elif _is_aim(event):
                return
            elif _is_restart_game(event):
                return
            elif _is_replay_game(event):
                return


func _on_Schedule_turn_started(sprite: Sprite2D) -> void:
    set_process_unhandled_input(sprite.is_in_group(SubTag.PC))


func _on_GameProgress_game_over(_player_win: bool) -> void:
    set_process_unhandled_input(true)
    _input_mode = InputMode.END_GAME


func _is_move_inputs(event: InputEvent) -> bool:
    for i: StringName in InputTag.MOVE_INPUTS:
        if event.is_action_pressed(i):
            action_pressed.emit(i)
            return true
    return false


func _is_start_game(event: InputEvent, input_mode: int) -> bool:
    if event.is_action_pressed(InputTag.START_GAME):
        match input_mode:
            InputMode.START_GAME:
                action_pressed.emit(InputTag.START_GAME)
                _input_mode = InputMode.NORMAL
                return true
            InputMode.END_GAME:
                EndGame.reload()
                return true
    return false


func _is_quit_game(event: InputEvent) -> bool:
    if event.is_action_pressed(InputTag.QUIT_GAME):
        EndGame.quit()
        return true
    return false


func _is_copy_seed(event: InputEvent) -> bool:
    if event.is_action_pressed(InputTag.COPY_SEED):
        action_pressed.emit(InputTag.COPY_SEED)
        return true
    return false


func _is_aim(event: InputEvent) -> bool:
    if event.is_action_pressed(InputTag.AIM):
        action_pressed.emit(InputTag.AIM)
        return true
    return false


func _is_restart_game(event: InputEvent) -> bool:
    if event.is_action_pressed(InputTag.RESTART_GAME):
        _set_transfer_data(false)
        EndGame.reload()
        return true
    return false


func _is_replay_game(event: InputEvent) -> bool:
    if event.is_action_pressed(InputTag.REPLAY_GAME):
        _set_transfer_data(true)
        EndGame.reload()
        return true
    return false


func _set_transfer_data(is_replay: bool) -> void:
    if is_replay:
        action_pressed.emit(InputTag.REPLAY_GAME)
    else:
        action_pressed.emit(InputTag.RESTART_GAME)
