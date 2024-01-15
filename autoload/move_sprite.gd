# class_name MoveSprite
extends Node2D


signal sprite_moved(sprite: Sprite2D, coord: Vector2i, z_layer: int)
signal sprite_swapped(this_sprite: Sprite2D, that_sprite: Sprite2D)


func move(sprite: Sprite2D, coord: Vector2i, z_layer: int = sprite.z_index) \
        -> void:
    sprite_moved.emit(sprite, coord, z_layer)


func swap(this_sprite: Sprite2D, that_sprite: Sprite2D) -> void:
    sprite_swapped.emit(this_sprite, that_sprite)
