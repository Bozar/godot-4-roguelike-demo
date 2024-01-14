class_name PlayerInput
extends Node2D


signal pc_moved(direction: StringName)


func _ready() -> void:
    set_process_unhandled_input(false)


func _unhandled_input(event: InputEvent) -> void:
    for i: StringName in InputTag.MOVE_INPUTS:
        if event.is_action_pressed(i):
            pc_moved.emit(i)
