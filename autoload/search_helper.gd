# class_name SearchHelper
extends Node2D


signal searching_by_tag(search_by_tag: SearchByTag)
signal searching_by_coord(search_by_coord: SearchByCoord)
signal searching_by_sprite(search_by_sprite: SearchBySprite)


func get_sprites_by_tag(main_tag: StringName, sub_tag: StringName) -> Array:
    var search: SearchByTag = SearchByTag.new(main_tag, sub_tag)
    searching_by_tag.emit(search)
    return search.sprites


func get_sprite_by_coord(main_tag: StringName, coord: Vector2i,
        z_layer: int = ZLayer.get_z_layer(main_tag)) -> Sprite2D:
    var search: SearchByCoord = SearchByCoord.new(main_tag, coord, z_layer,
            false)
    searching_by_coord.emit(search)
    if search.sprites.is_empty():
        return null
    return search.sprites[0]


func get_sprites_by_coord(coord: Vector2i) -> Array:
    var search: SearchByCoord = SearchByCoord.new("", coord, -1, true)
    searching_by_coord.emit(search)
    return search.sprites


func get_main_tag(sprite: Sprite2D) -> StringName:
    var search: SearchBySprite = SearchBySprite.new(sprite)
    searching_by_sprite.emit(search)
    return search.main_tag


func get_sub_tag(sprite: Sprite2D) -> StringName:
    var search: SearchBySprite = SearchBySprite.new(sprite)
    searching_by_sprite.emit(search)
    return search.sub_tag
