class_name MainRoot
extends Node2D


func _ready() -> void:
    (%InitWorld as InitWorld).create_world()
    (%PlayerInput as PlayerInput).set_process_unhandled_input(true)
