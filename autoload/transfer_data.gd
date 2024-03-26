# class_name TransferData
extends Node2D


var rng_seed: int:
    get:
        return _rng_seed


var load_setting_file: bool:
    get:
        return _load_setting_file


var _rng_seed: int = 0
var _load_setting_file: bool = true


func set_rng_seed(value: int) -> void:
    _rng_seed = value


func set_load_setting_file(value: bool) -> void:
    _load_setting_file = value
