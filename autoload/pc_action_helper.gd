# class_name PcActionHelper
extends Node2D


signal searching_pc_action(search: SearchKeyword)


var ammo: int:
    get:
        return _get_pc_action().ammo
    set(value):
        _get_pc_action().ammo = value


var enemy_count: int:
    get:
        return _get_pc_action().enemy_count


var progress_bar: int:
    get:
        return _get_pc_action().progress_bar


func _get_pc_action() -> PcAction:
    var search: SearchKeyword = SearchKeyword.new()
    searching_pc_action.emit(search)
    return search.pc_action
