class_name DungeonBoard
extends Node2D


const HASHED_MAIN_TAGS: Dictionary = {
    MainTag.GROUND: 1,
    MainTag.BUILDING: 2,
    MainTag.TRAP: 3,
    MainTag.ACTOR: 4,
}
const INDICATOR_AXES: Dictionary = {
    SubTag.INDICATOR_TOP: &"x",
    SubTag.INDICATOR_BOTTOM: &"x",
    SubTag.INDICATOR_LEFT: &"y",
}


# {
#    hashed_coord_1: {hashed_sprite_1: sprite_1, ...},
# ...
# }
var _dungeon_sprites: Dictionary = {}
var _is_valid_sprite: Callable


func add_state(sprite: Sprite2D, main_tag: StringName) -> void:
    var coord: Vector2i = ConvertCoord.get_coord(sprite)
    var z_layer: int = sprite.z_index
    var hashed_coord: int = _hash_coord(coord)
    var hashed_sprite: int = _hash_sprite(main_tag, z_layer)
    var sprites: Dictionary

    if _dungeon_sprites.has(hashed_coord):
        sprites = _dungeon_sprites[hashed_coord]
        if sprites.has(hashed_sprite):
            push_error("Hash collide: %d-%d, %s." %
                    [hashed_coord, hashed_sprite, sprite.name])
            return
    else:
        _dungeon_sprites[hashed_coord] = {}
    _dungeon_sprites[hashed_coord][hashed_sprite] = sprite
    _set_visibility(coord)


func remove_state(sprite: Sprite2D, main_tag: StringName) -> void:
    var coord: Vector2i = ConvertCoord.get_coord(sprite)
    var z_layer: int = sprite.z_index
    var hashed_coord: int = _hash_coord(coord)
    var hashed_sprite: int = _hash_sprite(main_tag, z_layer)
    var sprites: Dictionary = _dungeon_sprites.get(hashed_coord, {})

    if not sprites.erase(hashed_sprite):
        push_warning("Sprite not hashed: %d-%d, %s." %
                [hashed_coord, hashed_sprite, sprite.name])
    _set_visibility(coord)


func get_sprite_by_coord(main_tag: StringName, coord: Vector2i,
        z_layer: int = ZLayer.get_z_layer(main_tag)) -> Sprite2D:
    for i: Sprite2D in get_sprites_by_coord(coord):
        if i.is_in_group(main_tag) and (i.z_index == z_layer):
            return i
    return null


func get_sprites_by_coord(coord: Vector2i) -> Array:
    var hashed_coord: int = _hash_coord(coord)
    var sprites: Dictionary = _dungeon_sprites.get(hashed_coord, {})

    if sprites.is_empty():
        return []
    return sprites.values().filter(_is_valid_sprite)


func move_sprite(sprite: Sprite2D, main_tag: StringName, coord: Vector2i,
        z_layer: int) -> void:
    remove_state(sprite, main_tag)
    sprite.position = ConvertCoord.get_position(coord)
    sprite.z_index = z_layer
    add_state(sprite, main_tag)


func swap_sprite(this_sprite: Sprite2D, that_sprite: Sprite2D,
        main_tag: StringName) -> void:
    var this_coord: Vector2i = ConvertCoord.get_coord(this_sprite)
    var this_layer: int = this_sprite.z_index
    var that_coord: Vector2i = ConvertCoord.get_coord(that_sprite)
    var that_layer: int = that_sprite.z_index

    move_sprite(this_sprite, main_tag, that_coord, 0)
    move_sprite(that_sprite, main_tag, this_coord, this_layer)
    move_sprite(this_sprite, main_tag, that_coord, that_layer)


func move_indicator(coord: Vector2i, indicators: Dictionary) -> void:
    var sprite: Sprite2D
    var axis: StringName

    for i: StringName in INDICATOR_AXES:
        if not indicators.has(i):
            continue
        sprite = indicators[i]
        axis = INDICATOR_AXES[i]
        sprite.position[axis] = ConvertCoord.get_position(coord)[axis]


# YY-XX: coord.y - coord.x
func _hash_coord(coord: Vector2i) -> int:
    return floor(coord.x + coord.y * pow(10, 2))


# M-ZZ: hashed_main_tag - z_layer
func _hash_sprite(main_tag: StringName, z_layer: int) -> int:
    if not HASHED_MAIN_TAGS.has(main_tag):
        push_error("Invalid main_tag: %s" % main_tag)
        return -1

    var hashed_main_tag: int = HASHED_MAIN_TAGS[main_tag]
    return floor(z_layer + hashed_main_tag * pow(10, 2))


func _set_visibility(coord: Vector2i) -> void:
    var sprites: Array = get_sprites_by_coord(coord)
    var sprite: Sprite2D

    sprites.sort_custom(_sort_by_layer)
    for i: int in range(0, sprites.size()):
        sprite = sprites[i]
        sprite.visible = (i == sprites.size() - 1)


func _sort_by_layer(this_sprite: Sprite2D, that_sprite: Sprite2D) -> bool:
    return this_sprite.z_index < that_sprite.z_index

