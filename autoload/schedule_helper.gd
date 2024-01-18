# class_name ScheduleHelper
extends Node2D


signal turn_ended()


func end_turn() -> void:
    turn_ended.emit()
