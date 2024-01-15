class_name SearchByTag


var main_tag: StringName:
    get:
        return _main_tag
var sub_tag: StringName:
    get:
        return _sub_tag
var sprites: Array:
    get:
        return _sprites
    set(value):
        if _has_searched:
            return
        _sprites = value
        _has_searched = true


var _main_tag: StringName
var _sub_tag: StringName
var _sprites: Array
var _has_searched: bool = false


func _init(main_tag_: StringName, sub_tag_: StringName) -> void:
    _main_tag = main_tag_
    _sub_tag = sub_tag_
