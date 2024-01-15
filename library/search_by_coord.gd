class_name SearchByCoord


var main_tag: StringName:
    get:
        return _main_tag
var coord: Vector2i:
    get:
        return _coord
var z_layer: int:
    get:
        return _z_layer
var sprite: Sprite2D:
    get:
        return _sprite
    set(value):
        if _has_searched:
            return
        _sprite = value
        _has_searched = true


var _main_tag: StringName
var _coord: Vector2i
var _z_layer: int
var _sprite: Sprite2D
var _has_searched: bool = false


func _init(main_tag_: StringName, coord_: Vector2i, z_layer_: int) -> void:
    _main_tag = main_tag_
    _coord = coord_
    _z_layer = z_layer_
