# class_name SpriteFactory
extends Node2D


signal sprite_created(tagged_sprites: Array[TaggedSprite])
signal sprite_removed(tagged_sprites: Array[TaggedSprite])


func create_sprite(main_tag: StringName, sub_tag: StringName, coord: Vector2i) \
        -> TaggedSprite:
    var tagged_sprite: TaggedSprite = CreateSprite.create(main_tag, sub_tag,
            coord)
    sprite_created.emit([tagged_sprite])
    return tagged_sprite


func create_sprites(tagged_sprites: Array[TaggedSprite]) -> void:
    sprite_created.emit(tagged_sprites)


func remove_sprite(sprite: Sprite2D) -> void:
    remove_sprites([sprite])


func remove_sprites(sprites: Array[Sprite2D]) -> void:
    sprite_removed.emit(sprites)
