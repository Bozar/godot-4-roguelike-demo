# class_name RandomNumberHelper
extends Node2D


signal searching_random_number(search: SearchKeyword)


func get_seed() -> int:
    return _get_random_number().get_seed()


func get_int(min_int: int, max_int: int) -> int:
    return _get_random_number().get_int(min_int, max_int)


func get_percent_chance(chance: int) -> bool:
    return _get_random_number().get_percent_chance(chance)


func _get_random_number() -> RandomNumber:
    var search: SearchKeyword = SearchKeyword.new()
    searching_random_number.emit(search)
    return search.random_number
