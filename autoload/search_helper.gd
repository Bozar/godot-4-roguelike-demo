# class_name SearchHelper
extends Node2D


signal searching_by_tag(search_by_tag: SearchByTag)
signal searching_by_coord(search_by_coord: SearchByCoord)


func get_sprites_by_tag(main_tag: StringName, sub_tag: StringName) -> Array:
    var search: SearchByTag = SearchByTag.new(main_tag, sub_tag)
    searching_by_tag.emit(search)
    return search.sprites


func get_sprite_by_coord(main_tag: StringName, coord: Vector2i,
        z_layer: int = ZLayer.get_z_layer(main_tag)) -> Sprite2D:
    var search: SearchByCoord = SearchByCoord.new(main_tag, coord, z_layer)
    searching_by_coord.emit(search)
    return search.sprite
