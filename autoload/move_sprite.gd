# class_name MoveSprite
extends Node2D


signal sprite_moved(sprite: Sprite2D, coord: Vector2i, z_layer: int)


func move(sprite: Sprite2D, coord: Vector2i, z_layer: int = sprite.z_index) \
        -> void:
    sprite_moved.emit(sprite, coord, z_layer)


func swap(this_sprite: Sprite2D, that_sprite: Sprite2D) -> void:
    var this_coord: Vector2i = ConvertCoord.get_coord(this_sprite)
    var this_layer: int = this_sprite.z_index
    var that_coord: Vector2i = ConvertCoord.get_coord(that_sprite)
    var that_layer: int = that_sprite.z_index

    move(this_sprite, that_coord, 0)
    move(that_sprite, this_coord, this_layer)
    move(this_sprite, that_coord, that_layer)
