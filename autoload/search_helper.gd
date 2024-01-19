# class_name SearchHelper
extends Node2D


signal searching_by_tag(search_by_tag: SearchKeyword)
signal searching_by_coord_tag(search_by_coord: SearchKeyword)
signal searching_by_coord(search_by_coord: SearchKeyword)
signal searching_by_id(search_by_sprite: SearchKeyword)


func get_sprites_by_tag(main_tag: StringName, sub_tag: StringName) -> Array:
    var search: SearchKeyword = SearchKeyword.new()

    search.main_tag = main_tag
    search.sub_tag = sub_tag

    searching_by_tag.emit(search)
    return search.sprites


func get_sprite_by_coord(main_tag: StringName, coord: Vector2i,
        z_layer: int = ZLayer.get_z_layer(main_tag)) -> Sprite2D:
    var search: SearchKeyword = SearchKeyword.new()

    search.main_tag = main_tag
    search.coord = coord
    search.z_layer = z_layer

    searching_by_coord_tag.emit(search)
    return search.sprite


func get_sprites_by_coord(coord: Vector2i) -> Array:
    var search: SearchKeyword = SearchKeyword.new()

    search.coord = coord

    searching_by_coord.emit(search)
    return search.sprites


func get_main_tag(sprite: Sprite2D) -> StringName:
    var search: SearchKeyword = SearchKeyword.new()

    search.sprite = sprite

    searching_by_id.emit(search)
    return search.main_tag


func get_sub_tag(sprite: Sprite2D) -> StringName:
    var search: SearchKeyword = SearchKeyword.new()

    search.sprite = sprite

    searching_by_id.emit(search)
    return search.sub_tag


func has_sprite_at_coord(main_tag: StringName, coord: Vector2i,
        z_layer: int = ZLayer.get_z_layer(main_tag)) -> bool:
    return get_sprite_by_coord(main_tag, coord, z_layer) != null


func has_building_at_coord(coord: Vector2i,
        z_layer: int = ZLayer.get_z_layer(MainTag.BUILDING)) -> bool:
    return has_sprite_at_coord(MainTag.BUILDING, coord, z_layer)


func has_trap_at_coord(coord: Vector2i,
        z_layer: int = ZLayer.get_z_layer(MainTag.TRAP)) -> bool:
    return has_sprite_at_coord(MainTag.TRAP, coord, z_layer)


func has_actor_at_coord(coord: Vector2i,
        z_layer: int = ZLayer.get_z_layer(MainTag.ACTOR)) -> bool:
    return has_sprite_at_coord(MainTag.ACTOR, coord, z_layer)


func get_building_by_coord(coord: Vector2i,
        z_layer: int = ZLayer.get_z_layer(MainTag.BUILDING)) -> Sprite2D:
    return get_sprite_by_coord(MainTag.BUILDING, coord, z_layer)


func get_trap_by_coord(coord: Vector2i,
        z_layer: int = ZLayer.get_z_layer(MainTag.TRAP)) -> Sprite2D:
    return get_sprite_by_coord(MainTag.TRAP, coord, z_layer)


func get_actor_by_coord(coord: Vector2i,
        z_layer: int = ZLayer.get_z_layer(MainTag.ACTOR)) -> Sprite2D:
    return get_sprite_by_coord(MainTag.ACTOR, coord, z_layer)
