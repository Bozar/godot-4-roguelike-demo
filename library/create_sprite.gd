class_name CreateSprite


static func create(main_tag: StringName, sub_tag: StringName, coord: Vector2i,
        offset: Vector2i) -> Sprite2D:
    var packed_sprite: PackedScene = SpriteScene.get_sprite_scene(sub_tag)
    var new_sprite: Sprite2D

    if packed_sprite == null:
        return
    new_sprite = packed_sprite.instantiate()

    new_sprite.add_to_group(main_tag)
    new_sprite.add_to_group(sub_tag)
    new_sprite.position = ConvertCoord.get_position(coord, offset)

    new_sprite.z_index = ZIndex.get_z_index(main_tag)
    new_sprite.modulate = Palette.get_color(main_tag, true)

    return new_sprite


static func create_ground(sub_tag: StringName, coord: Vector2i) -> Sprite2D:
    return create(MainTag.GROUND, sub_tag, coord, Vector2i(0, 0))


static func create_actor(sub_tag: StringName, coord: Vector2i) -> Sprite2D:
    return create(MainTag.ACTOR, sub_tag, coord, Vector2i(0, 0))
