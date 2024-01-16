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
var sprites: Array:
    get:
        return _sprites
    set(value):
        if _has_searched:
            return
        _sprites = value
        _has_searched = true
var search_all: bool:
    get:
        return _search_all


var _main_tag: StringName
var _coord: Vector2i
var _z_layer: int
var _sprites: Array
var _has_searched: bool = false
var _search_all: bool


func _init(main_tag_: StringName, coord_: Vector2i, z_layer_: int,
        search_all_: bool) -> void:
    _main_tag = main_tag_
    _coord = coord_
    _z_layer = z_layer_
    _search_all = search_all_
