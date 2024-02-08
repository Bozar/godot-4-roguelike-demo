class_name SearchKeyword


var main_tag: StringName:
    set(value):
        if _search_is_completed:
            return
        main_tag = value
var sub_tag: StringName:
    set(value):
        if _search_is_completed:
            return
        sub_tag = value
var coord: Vector2i:
    set(value):
        if _search_is_completed:
            return
        coord = value
var z_layer: int:
    set(value):
        if _search_is_completed:
            return
        z_layer = value
var sprite: Sprite2D:
    set(value):
        if _search_is_completed:
            return
        sprite = value
var sprites: Array:
    set(value):
        if _search_is_completed:
            return
        sprites = value


var _search_is_completed: bool = false


func search_is_completed() -> void:
    _search_is_completed = true
