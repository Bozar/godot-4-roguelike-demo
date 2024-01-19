class_name PlayerInput
extends Node2D


signal action_pressed(input_tag: InputTag)


func _ready() -> void:
    set_process_unhandled_input(false)


func _unhandled_input(event: InputEvent) -> void:
    var out_input_tag: Array = []

    if _is_move_input(event, out_input_tag):
        action_pressed.emit(out_input_tag[0])
    elif event.is_action_pressed(InputTag.AIM):
        action_pressed.emit(InputTag.AIM)


func _is_move_input(event: InputEvent, out_input_tag: Array) -> bool:
    for i: StringName in InputTag.MOVE_INPUTS:
        if event.is_action_pressed(i):
            out_input_tag.push_back(i)
            return true
    return false
