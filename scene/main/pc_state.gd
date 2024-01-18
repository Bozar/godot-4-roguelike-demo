class_name PcState
extends Node2D


var ammo: int:
    set(value):
        ammo = max(min(value, GameData.MAX_AMMO), GameData.MIN_AMMO)


func _ready() -> void:
    ammo = GameData.MIN_AMMO
