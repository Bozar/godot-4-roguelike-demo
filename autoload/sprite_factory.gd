# class_name SpriteFactory
extends Node2D


signal sprite_created(tagged_sprite: TaggedSprite)


func create_sprite(main_tag: StringName, sub_tag: StringName, coord: Vector2i) \
        -> TaggedSprite:
    var tagged_sprite: TaggedSprite = CreateSprite.create(main_tag, sub_tag,
            coord)
    sprite_created.emit(tagged_sprite)
    return tagged_sprite
