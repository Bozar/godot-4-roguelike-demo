# class_name SpriteFactory
extends Node2D


signal sprite_created(tagged_sprites: Array[TaggedSprite])
signal sprite_removed(tagged_sprites: Array[TaggedSprite])


func create_sprite(main_tag: StringName, sub_tag: StringName, coord: Vector2i) \
        -> void:
    create_sprites([CreateSprite.create(main_tag, sub_tag, coord)])


func create_sprites(tagged_sprites: Array[TaggedSprite]) -> void:
    sprite_created.emit(tagged_sprites)


func remove_sprite(sprite: Sprite2D) -> void:
    remove_sprites([sprite])


func remove_sprites(sprites: Array[Sprite2D]) -> void:
    sprite_removed.emit(sprites)


func create_actor(sub_tag: StringName, coord: Vector2i) -> void:
    create_sprite(MainTag.ACTOR, sub_tag, coord)


func create_trap(sub_tag: StringName, coord: Vector2i) -> void:
    create_sprite(MainTag.TRAP, sub_tag, coord)
