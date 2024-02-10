class_name FovHelper


static func is_in_sight(coord: Vector2i, fov_map: Dictionary) -> bool:
    if Map2D.is_in_map(fov_map, coord):
        return fov_map[coord.x][coord.y]
    return false


static func set_color(coord: Vector2i, fov_map: Dictionary) -> void:
    if FovHelper.is_in_sight(coord, fov_map):
        for i: Sprite2D in SpriteStateHelper.get_sprites_by_coord(coord):
            VisualEffect.set_light_color(i)
    else:
        for i: Sprite2D in SpriteStateHelper.get_sprites_by_coord(coord):
            VisualEffect.set_dark_color(i)


static func set_visibility(coord: Vector2i, fov_map: Dictionary,
        memory_map: Dictionary, memory_tags: Array) -> void:
    var column: Array = memory_map[coord.x]
    var sprites: Array = SpriteStateHelper.get_sprites_by_coord(coord)
    var sprite: Sprite2D

    sprites.sort_custom(FovHelper._sort_by_z_index)
    if FovHelper.is_in_sight(coord, fov_map):
        column[coord.y] = true
        for i: Sprite2D in sprites:
            VisualEffect.set_light_color(i)
            VisualEffect.set_visibility(i, false)
        sprite = sprites.pop_back()
        VisualEffect.set_visibility(sprite, true)
    else:
        for i: Sprite2D in sprites:
            VisualEffect.set_visibility(i, false)
        if column[coord.y]:
            while true:
                sprite = sprites.pop_back()
                if (sprite == null) or FovHelper._match_tag(sprite,
                        memory_tags):
                    break
            if sprite != null:
                VisualEffect.set_dark_color(sprite)
                VisualEffect.set_visibility(sprite, true)


static func _match_tag(sprite: Sprite2D, tags: Array) -> bool:
    for i: StringName in tags:
        if sprite.is_in_group(i):
            return true
    return false


static func _sort_by_z_index(this: Sprite2D, that: Sprite2D) -> bool:
    return this.z_index < that.z_index
