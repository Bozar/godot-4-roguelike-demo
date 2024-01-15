class_name DungeonBoard
extends Node2D


const HASHED_MAIN_TAGS: Dictionary = {
    MainTag.GROUND: 0,
    MainTag.BUILDING: 1,
    MainTag.TRAP: 2,
    MainTag.ACTOR: 3,
}


var _hashed_sprites: Dictionary = {}


func add_state(sprite: Sprite2D, main_tag: StringName) -> void:
    var hash_value: int = _hash_sprite(sprite, main_tag)

    if _hashed_sprites.has(hash_value):
        push_error("Hash collide: %d, %s." % [hash_value, sprite.name])
        return
    _hashed_sprites[hash_value] = sprite


func remove_state(sprite: Sprite2D, main_tag: StringName) -> void:
    var hash_value: int = _hash_sprite(sprite, main_tag)

    if not _hashed_sprites.erase(hash_value):
        push_warning("Sprite not hashed: %d, %s." % [hash_value, sprite.name])


func get_sprite_by_coord(main_tag: StringName, coord: Vector2i,
        z_layer: int = ZLayer.get_z_layer(main_tag)) -> Sprite2D:
    var hash_value: int = _get_hash_value(main_tag, coord, z_layer)
    var sprite: Sprite2D = _hashed_sprites.get(hash_value, null)

    if (sprite != null) and (not sprite.is_queued_for_deletion()):
        return sprite
    return null


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


func _hash_sprite(sprite: Sprite2D, main_tag: StringName) -> int:
    if not HASHED_MAIN_TAGS.has(main_tag):
        push_error("Invalid main_tag: %s" % main_tag)
        return -1

    var coord: Vector2i = ConvertCoord.get_coord(sprite)
    var z_layer: int = sprite.z_index
    return _get_hash_value(main_tag, coord, z_layer)


# M-ZZ-YY-XX: hashed_main_tag - z_layer - coord.y - coord.x
func _get_hash_value(main_tag: StringName, coord: Vector2i, z_layer: int) \
        -> int:
    var hashed_main_tag: int = HASHED_MAIN_TAGS[main_tag]
    return floor(coord.x + coord.y * pow(10, 2) + z_layer * pow(10, 4) \
            + hashed_main_tag * pow(10, 6))
