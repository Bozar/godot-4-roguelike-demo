# class_name PcStateHelper
extends Node2D


signal searching_pc_state(search: SearchKeyword)


var ammo: int:
    get:
        var pc_state: PcState = _get_pc_state()
        return pc_state.ammo
    set(value):
        var pc_state: PcState = _get_pc_state()
        pc_state.ammo = value


func _get_pc_state() -> PcState:
    var search: SearchKeyword = SearchKeyword.new()
    searching_pc_state.emit(search)
    return search.pc_state
