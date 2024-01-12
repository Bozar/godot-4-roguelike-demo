class_name CreateSprite


static func create(main_tag: StringName, sub_tag: StringName, coord: Vector2i,
        offset: Vector2i = Vector2i(0, 0)) -> TaggedSprite:
    var packed_sprite: PackedScene = SpriteScene.get_sprite_scene(sub_tag)
    var new_sprite: Sprite2D

    if packed_sprite == null:
        return null
    new_sprite = packed_sprite.instantiate()

    new_sprite.add_to_group(main_tag)
    new_sprite.add_to_group(sub_tag)
    new_sprite.position = ConvertCoord.get_position(coord, offset)

    new_sprite.z_index = ZIndex.get_z_index(main_tag)
    new_sprite.modulate = Palette.get_color(main_tag, true)

    return TaggedSprite.new(new_sprite, main_tag, sub_tag)


static func create_ground(sub_tag: StringName, coord: Vector2i) -> TaggedSprite:
    return create(MainTag.GROUND, sub_tag, coord)


static func create_actor(sub_tag: StringName, coord: Vector2i) -> TaggedSprite:
    return create(MainTag.ACTOR, sub_tag, coord)
