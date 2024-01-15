class_name SearchBySprite


var main_tag: StringName:
    get:
        return _main_tag
    set(value):
        if _has_main_tag:
            return
        _main_tag = value
        _has_main_tag = true
var sub_tag: StringName:
    get:
        return _sub_tag
    set(value):
        if _has_sub_tag:
            return
        _sub_tag = value
        _has_sub_tag = true
var sprite: Sprite2D:
    get:
        return _sprite


var _main_tag: StringName
var _sub_tag: StringName
var _sprite: Sprite2D
var _has_main_tag: bool = false
var _has_sub_tag: bool = false


func _init(sprite_: Sprite2D) -> void:
    _sprite = sprite_
