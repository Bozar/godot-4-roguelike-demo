# class_name PcActionHelper
extends Node2D


signal searching_pc_action(search: SearchKeyword)


var ammo: int:
    get:
        var pc_action: PcAction = _get_pc_action()
        return pc_action.ammo
    set(value):
        var pc_action: PcAction = _get_pc_action()
        pc_action.ammo = value


func _get_pc_action() -> PcAction:
    var search: SearchKeyword = SearchKeyword.new()
    searching_pc_action.emit(search)
    return search.pc_action
